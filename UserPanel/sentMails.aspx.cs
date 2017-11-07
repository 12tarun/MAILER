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
           /*   con.Open();
              string recipientName = "";
              SqlCommand getMailsInfo = new SqlCommand("select * from tblSentMails where userId='" + Convert.ToInt32(Session["LoggedIn"]) + "'", con);
              SqlDataReader drMailInfo = getMailsInfo.ExecuteReader();
              DataTable table = new DataTable();
              table.Columns.Add("Recipient");
              table.Columns.Add("Subject");
              table.Columns.Add("Body");
              table.Columns.Add("Date");
              while (drMailInfo.Read())
              {
                  recipientName = "";
                  using (SqlConnection con2 = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
                  {
                      con2.Open();
                      SqlCommand getRecipientsName = new SqlCommand("select recipientId from tblMailRecipient  where sentMailId='" + Convert.ToInt32(drMailInfo["sentMailId"]) + "'", con2);
                      SqlDataReader dr2 = getRecipientsName.ExecuteReader();
                      while (dr2.Read())
                      {
                          using (SqlConnection con3 = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
                          {
                              con3.Open();
                              SqlCommand getRecipientName = new SqlCommand("select name from tblRecipients where recipientId='" + Convert.ToInt32(dr2["recipientId"]) + "'", con3);
                              recipientName = getRecipientName.ExecuteScalar().ToString();
                              DataRow dataRow = table.NewRow();
                              dataRow["Body"] = drMailInfo["body"].ToString();
                              dataRow["Subject"] = drMailInfo["subject"].ToString();
                              dataRow["Recipient"] = recipientName;
                              dataRow["Date"] = drMailInfo["sendDate"].ToString();
                              table.Rows.Add(dataRow);
                          }
                      }
                  }
              } */
             


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

  /*      try
        {
            switch(e.Row.RowType)
            {
                case DataControlRowType.Header:
                    break;
                case DataControlRowType.DataRow:
                    Session["recipientName"]= e.Row.Cells[0].Text;
                    Session["body"] = e.Row.Cells[3].Text;
                    Session["templateId"] = e.Row.Cells[4].Text;
                    e.Row.Attributes["onclick"] = "window.location.href='EmailPreview.aspx'";
              
                    break;
            }
        }
        catch
        {
            throw;
        }

    */


    }

     /* protected void gvMails_SelectedIndexChanged(object sender, EventArgs e)
       {
           int index = gvMails.SelectedIndex;
           Session["recipientName"] = (gvMails.Rows[index].Cells[0].Text).ToString();
           Session["body"] = (gvMails.Rows[index].Cells[3].Text).ToString();
           Session["templateId"] = (gvMails.Rows[index].Cells[4].Text).ToString();
       } */

    /*  protected void btnPreview_Click(object sender, EventArgs e)
      {
          int index = gvMails.SelectedIndex;
          Session["recipientName"] = (gvMails.Rows[index].Cells[0].Text).ToString();
          Session["body"] = (gvMails.Rows[index].Cells[3].Text).ToString();
          Session["templateId"] = (gvMails.Rows[index].Cells[4].Text).ToString();
      } */


    protected void lnkBtnPreview_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
       // int i = Convert.ToInt32(row.RowIndex);

        Label lblRecipientValue = (Label)row.FindControl("lblRecipient");
        Label lblBodyValue = (Label)row.FindControl("lblBody");
        Label lblTemplateIdValue = (Label)row.FindControl("lblTemplateId");

        Session["recipientName"] = lblRecipientValue.Text.ToString();
        Session["body"] = lblBodyValue.Text.ToString();
        Session["templateId"] = (lblTemplateIdValue.Text.ToString());

        Response.Redirect("~/UserPanel/EmailPreview.aspx");
    }

 /*   protected void gvMails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandName=="preview")
        {
            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int index = (int)gvMails.DataKeys[row.RowIndex].Value;
            Session["recipientName"] = (gvMails.Rows[index].Cells[0].Text).ToString();
            Session["body"] = (gvMails.Rows[index].Cells[3].Text).ToString();
            Session["templateId"] = (gvMails.Rows[index].Cells[4].Text).ToString();
        }
    } */
}