using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
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

        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM tblSentMails WHERE  userId='" + Convert.ToInt32(Session["LoggedIn"]) + "'", con))
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("Recipient");
                dt.Columns.Add("sentMailId");
                dt.Columns.Add("Subject");
                dt.Columns.Add("Body");
                dt.Columns.Add("templateId");
                dt.Columns.Add("Date");

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    DataRow dr = dt.NewRow();
                    string recipientName = "";
                    using (SqlConnection con2 = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
                    {
                        con2.Open();
                        SqlCommand getRecipientsName = new SqlCommand("select recipientId from tblMailRecipient  where sentMailId='" + Convert.ToInt32(rdr["sentMailId"]) + "'", con2);
                        SqlDataReader rdr2 = getRecipientsName.ExecuteReader();
       
                        while (rdr2.Read())
                        {
                            using (SqlConnection con3 = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
                            {
                                con3.Open();
                                SqlCommand getRecipientName = new SqlCommand("select name from tblRecipients where recipientId='" + Convert.ToInt32(rdr2["recipientId"]) + "'", con3);
                                recipientName += getRecipientName.ExecuteScalar().ToString() + ",";
                            }
                        }
                    }
                    string body = rdr["body"].ToString();
                 //   string subject = rdr["subject"].ToString();
                    int bodyLength = body.IndexOf("\n", 0) + 1;
                   // int subjectLength = subject.IndexOf("\n", 0) + 1;
                    if ( body.IndexOf("\n", 0) != -1)
                    {
                        body = body.Substring(0,bodyLength);
                    }
                    if(body.Length >= 50 )
                    {
                        body = body.Substring(0, 50);
                    }
                    //if (subject.IndexOf("\n", 0) != -1)
                    //{
                    //    subject = subject.Substring(0, subjectLength);
                    //}
                    //if(subject.Length >= 20)
                    //{
                    //    subject = subject.Substring(0, 20);
                    //}

                    dr["sentMailId"] = rdr["sentMailId"];
                    dr["Subject"] = rdr["subject"];
                    dr["Body"] = body;
                    dr["templateId"] = rdr["templateId"];
                    dr["Date"] = rdr["sendDate"];
                    string replace = recipientName;
                    StringBuilder sb = new StringBuilder(replace);
                    sb[replace.Length - 1] = ' ';
                    string newString = sb.ToString();
                    recipientName = newString;
                    dr["Recipient"] = recipientName;
                    dt.Rows.Add(dr);
                }

                DataTable reversedDt = new DataTable();
                reversedDt = dt.Clone();
                for (var row = dt.Rows.Count - 1; row >= 0; row--)
                {
                    reversedDt.ImportRow(dt.Rows[row]);
                }

                gvMails.DataSource = reversedDt;
                gvMails.DataBind();
            }
        }
    }

    protected void lnkBtnPreview_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;

        Label lblRecipientValue = (Label)row.FindControl("lblRecipient");
        Label lblSubject = (Label)row.FindControl("lblSubject");       
        Label lblTemplateIdValue = (Label)row.FindControl("lblTemplateId");
        Label lblSentMailId = (Label)row.FindControl("lblSentMailId");
        Session["sentMailId"] = lblSentMailId.Text;

        Session["recipientName"] = lblRecipientValue.Text.ToString();
        Session["subject"] = lblSubject.Text.ToString();
        Session["templateId"] = lblTemplateIdValue.Text.ToString();

        Response.Redirect("~/UserPanel/PreviewEmail.aspx");
    }

    protected void gvMails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMails.PageIndex = e.NewPageIndex;
        gvMails.DataBind();
    }
}