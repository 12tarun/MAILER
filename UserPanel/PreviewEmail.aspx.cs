using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserPanel_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoggedIn"] == null)
        {
            Response.Redirect("~/UserPanel/Registration.aspx");
        }

        if (!IsPostBack)
        {
            string body = "";
            string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SqlCommand getTemplateFilePath = new SqlCommand("select filePath from tblTemplates where templateId='" + Convert.ToInt32(Session["templateId"]) + "'", con);
                string templateFilePath = getTemplateFilePath.ExecuteScalar().ToString();
                using (StreamReader reader = new StreamReader(Server.MapPath(templateFilePath)))
                {
                    body = reader.ReadToEnd();
                    body = body.Replace("{RecipientName}", Session["recipientName"].ToString());
                    body = body.Replace("{body}", Session["body"].ToString());
                }
                emailPreview.InnerHtml = body;
                int sentMailId = Convert.ToInt32(Session["sentMailId"]);
                DataTable table = new DataTable();
                table.Columns.Add("FileName");
                table.Columns.Add("FileSize");
                SqlCommand checkAttachments = new SqlCommand("select count(*) from tblFileAttachments where sentMailId='"+sentMailId+"'",con);
                int temp =Convert.ToInt32(checkAttachments.ExecuteScalar());
                if(temp>0)
                {
                    SqlCommand getFileAttachment = new SqlCommand("select * from tblFileAttachments where sentMailId='"+sentMailId+"'", con);
                    using (SqlDataReader dr = getFileAttachment.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            DataRow row = table.NewRow();
                            row["FileName"] = dr["fileName"];
                            row["FileSize"] = dr["fileSize"];
                            table.Rows.Add(row);
                        }
                        
                    }
                    grdFileAttachments.DataSource = table;
                    grdFileAttachments.DataBind();
                }
            }
        }
    }
}