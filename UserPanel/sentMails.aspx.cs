using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserPanel_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoggedIn"] == null) Response.Redirect("~/UserPanel/Registration.aspx");
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            con.Open();
            string recipientNames = "";
            SqlCommand getMailsInfo = new SqlCommand("select * from tblSentMails where userId='" + Convert.ToInt32(Session["LoggedIn"]) + "'",con);
            SqlDataReader drMailInfo = getMailsInfo.ExecuteReader();
            DataTable table = new DataTable();
            table.Columns.Add("Subject");
            table.Columns.Add("Body");
            table.Columns.Add("Recipients");
            table.Columns.Add("Template");
            table.Columns.Add("Date");
            while (drMailInfo.Read())
            {
                recipientNames = "";
                using (SqlConnection con2 = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
                {
                    con2.Open();
                    SqlCommand getRecipientsName = new SqlCommand("select recipientId from tblMailRecipient  where sentMailId='" + Convert.ToInt32(drMailInfo["sentMailId"]) + "'", con2);
                    SqlDataReader dr2 = getRecipientsName.ExecuteReader();
                    while (dr2.Read())
                    {
                        
                        using(SqlConnection con3 = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
                        {
                            con3.Open();
                            SqlCommand getRecipientName = new SqlCommand("select name from tblRecipients where recipientId='"+Convert.ToInt32(dr2["recipientId"])+"'",con3);
                            recipientNames += getRecipientName.ExecuteScalar().ToString();
                            recipientNames += ",";
                        }
                    }
                }
                string templateName;
                using (SqlConnection con3 = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
                {
                    con3.Open();
                    SqlCommand getTempalteName = new SqlCommand("select displayName from tblTemplates where templateId='" + Convert.ToInt32(drMailInfo["templateId"]) +"'", con3);
                     templateName = getTempalteName.ExecuteScalar().ToString();
                }
                    DataRow dataRow = table.NewRow();
                dataRow["Body"] = drMailInfo["body"].ToString();
                dataRow["Subject"] = drMailInfo["subject"].ToString();
                dataRow["Recipients"] = recipientNames;
                dataRow["Date"] = drMailInfo["sendDate"].ToString();
                dataRow["Template"] = templateName;
                table.Rows.Add(dataRow);
            }
            DataTable reversedDt = new DataTable();
            reversedDt = table.Clone();
            for (var row = table.Rows.Count - 1; row >= 0; row--)
                reversedDt.ImportRow(table.Rows[row]);
            gvMails.DataSource = reversedDt;
            gvMails.DataBind();
        }
    }
}