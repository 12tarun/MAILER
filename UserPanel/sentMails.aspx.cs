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
                                recipientName = getRecipientName.ExecuteScalar().ToString();

                                DataRow dr = dt.NewRow();
                                dr["Recipient"] = recipientName;
                                dr["sentMailId"] = rdr["sentMailId"];
                                dr["Subject"] = rdr["subject"];
                                dr["Body"] = rdr["body"];
                                dr["templateId"] = rdr["templateId"];
                                dr["Date"] = rdr["sendDate"];

                                dt.Rows.Add(dr);
                            }
                        }
                    }
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

    protected void gvMails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[4].Visible = false;
    }

    protected void lnkBtnPreview_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;

        Label lblRecipientValue = (Label)row.FindControl("lblRecipient");
        Label lblBodyValue = (Label)row.FindControl("lblBody");
        Label lblTemplateIdValue = (Label)row.FindControl("lblTemplateId");

        Session["recipientName"] = lblRecipientValue.Text.ToString();
        Session["body"] = lblBodyValue.Text.ToString();
        Session["templateId"] = lblTemplateIdValue.Text.ToString();

        Response.Redirect("~/UserPanel/PreviewEmail.aspx");
    }
}