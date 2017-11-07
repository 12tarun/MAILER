using System;
using System.Collections.Generic;
using System.Configuration;
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
            }
        }
    }
}