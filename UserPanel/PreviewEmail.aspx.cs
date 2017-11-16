using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
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

        if (!IsPostBack)
        {
            lblSubject.Text = Session["subject"].ToString();

            int sentMailId = Convert.ToInt32(Session["sentMailId"]);
            string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                string mailRecipientId=string.Empty;
                con.Open();
                using (SqlCommand cmd3 = new SqlCommand("SELECT recipientId FROM tblMailRecipient WHERE sentMailId ='" + sentMailId + "'", con))

                {
                    using (SqlDataAdapter da = new SqlDataAdapter())
                    {
                        mailRecipientId += "select * from tblRecipients where recipientId='";
                        SqlDataReader rdr = cmd3.ExecuteReader();
                        while (rdr.Read())
                        {

                            mailRecipientId += rdr["recipientId"].ToString();
                            mailRecipientId += "'" + " or" +" recipientId="+"'" ;
                        }

                        mailRecipientId=mailRecipientId.Substring(0,mailRecipientId.Length-16);
                    }
                    using (SqlConnection con2 = new SqlConnection(constr))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(mailRecipientId, con2))
                        {

                            DataSet ds = new DataSet();
                            da.Fill(ds);
                            rptrMailRecipientName.DataSource = ds;
                            rptrMailRecipientName.DataBind();
                        }
                    }
                }
            }


            //using (SqlConnection con2 = new SqlConnection(constr))
            //{
            //    using (SqlCommand cmd = new SqlCommand("SELECT recipientId FROM tblMailRecipient WHERE sentMailId ='" + sentMailId + "'"))
            //    {
            //        using (SqlDataAdapter sda = new SqlDataAdapter())
            //        {
            //            cmd.CommandType = CommandType.Text;
            //            cmd.Connection = con2;
            //            con2.Open();
            //            SqlDataReader rdr = cmd.ExecuteReader();
            //            while (rdr.Read())
            //            {
            //                using (SqlConnection con3 = new SqlConnection(constr))
            //                {
            //                    con3.Open();
            //                    SqlCommand cmd2 = new SqlCommand("SELECT email FROM tblRecipients WHERE recipientId ='" + Convert.ToInt32(rdr["recipientId"]) + "'", con3);
            //                    lblMailRecipient.Text += cmd2.ExecuteScalar().ToString() + ",";
            //                }
            //            }

            //            string replace = lblMailRecipient.Text;
            //            StringBuilder sb = new StringBuilder(replace);
            //            sb[replace.Length - 1] = ' ';
            //            string newString = sb.ToString();
            //            string sort = newString;
            //            sort = SortCommaSeparatedString(sort);
            //            lblMailRecipient.Text = sort;
            //        }
            //    }

                string body = "";


            string constr2 = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr2))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT body FROM tblSentMails WHERE sentMailId ='" + Convert.ToInt32(Session["sentMailId"]) + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        con.Open();
                        SqlDataReader rdr = cmd.ExecuteReader();
                        while (rdr.Read())
                        {
                            body = rdr["body"].ToString();
                            Session["body"] = body;
                        }
                    }
                }
            }

            using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand getTemplateFilePath = new SqlCommand("select filePath from tblTemplates where templateId='" + Convert.ToInt32(Session["templateId"]) + "'", con);
                    string templateFilePath = getTemplateFilePath.ExecuteScalar().ToString();
                    using (StreamReader reader = new StreamReader(Server.MapPath(templateFilePath)))
                    {
                        body = reader.ReadToEnd();
                     //   body = body.Replace("{RecipientName}", Session["recipientName"].ToString());
                          body = body.Replace("{body}", Session["body"].ToString());
                    }
                    emailPreview.InnerHtml = body;

                    DataTable table = new DataTable();
                    table.Columns.Add("FileName");
                    table.Columns.Add("FileSize");
                    SqlCommand checkAttachments = new SqlCommand("select count(*) from tblFileAttachments where sentMailId='" + sentMailId + "'", con);
                    int temp = Convert.ToInt32(checkAttachments.ExecuteScalar());
                    if (temp > 0)
                    {
                        SqlCommand getFileAttachment = new SqlCommand("select * from tblFileAttachments where sentMailId='" + sentMailId + "'", con);
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
    

    //public string SortCommaSeparatedString(string name)
    //{
    //    string[] stringArray = name.Split(',');
    //    Array.Sort(stringArray);
    //    string returnValue = "";
    //    for (int i = stringArray.GetLowerBound(0); i <= stringArray.GetUpperBound(0); i++)
    //    {
    //        returnValue = returnValue + stringArray[i] + ",";
    //    }
    //    return returnValue.Remove(returnValue.Length - 1, 1);
    //}
}