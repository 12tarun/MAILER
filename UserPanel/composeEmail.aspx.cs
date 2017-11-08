using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
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
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
            {
                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter("select displayName,templateId from tblTemplates where userId='5' or userId='" + Convert.ToInt32(Session["LoggedIn"]) + "'", con))
                {
                    DataSet ds2 = new DataSet();
                    da.Fill(ds2);
                    rbTemplates.DataSource = ds2;
                    rbTemplates.DataTextField = "displayName";
                    rbTemplates.DataValueField = "templateId";
                    rbTemplates.DataBind();
                }
            }
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
            {
                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter("select categoryName,categoryId from tblCategory where userId='" + Convert.ToInt32(Session["LoggedIn"]) + "'", con))
                {
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    rptrCategory.DataSource = ds;
                    rptrCategory.DataBind();
                }
            }
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
            {
                con.Open();
                foreach (RepeaterItem i in rptrCategory.Items)
                {
                    CheckBox cbCategory = (CheckBox)i.FindControl("cbCategory");
                    Repeater rptrRecipient = (Repeater)i.FindControl("rptrRecipient");
                    int userId = Convert.ToInt32(Session["LoggedIn"].ToString());
                    SqlCommand getCategoryId = new SqlCommand("select categoryId from tblCategory where userId='" + userId + "' and categoryName='" + cbCategory.Text + "'", con);
                    int categoryId = Convert.ToInt32(getCategoryId.ExecuteScalar());
                    using (SqlDataAdapter da = new SqlDataAdapter("select name,email,recipientId from tblRecipients where categoryId='" + categoryId + "'", con))
                    {
                        DataSet ds1 = new DataSet();
                        da.Fill(ds1);
                        rptrRecipient.DataSource = ds1;
                        rptrRecipient.DataBind();
                    }
                }
            }
            foreach (ListItem item in rbTemplates.Items)
            {
                if (rbTemplates.Text=="noDesignTemplate")
                    item.Selected = true;
            }
        }

    }

    protected void cbCategory_CheckedChanged(object sender, EventArgs e)
    {
        foreach (RepeaterItem i in rptrCategory.Items)
        {
            CheckBox cbCategory = (CheckBox)i.FindControl("cbCategory");
            if (!cbCategory.Checked) cbSelectAll.Checked = false;
            Repeater rptrRecipeint = (Repeater)i.FindControl("rptrRecipient");
            foreach (RepeaterItem j in rptrRecipeint.Items)
            {
                CheckBox cbRecipient = (CheckBox)j.FindControl("cbRecipient");
                cbRecipient.Checked = cbCategory.Checked;
            }
        }
    }

    protected void cbSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (RepeaterItem i in rptrCategory.Items)
        {
            CheckBox cbCategory = (CheckBox)i.FindControl("cbCategory");
            cbCategory.Checked = cbSelectAll.Checked;
            Repeater rptrRecipient = (Repeater)i.FindControl("rptrRecipient");
            foreach (RepeaterItem j in rptrRecipient.Items)
            {
                CheckBox cbRecipient = (CheckBox)j.FindControl("cbRecipient");
                cbRecipient.Checked = cbSelectAll.Checked;
            }
        }
    }

    protected void cbRecipient_CheckedChanged(object sender, EventArgs e)
    {
        foreach (RepeaterItem i in rptrCategory.Items)
        {
            CheckBox cbCategory = (CheckBox)i.FindControl("cbCategory");
            Repeater rptrRecipient = (Repeater)i.FindControl("rptrRecipient");
            foreach (RepeaterItem j in rptrRecipient.Items)
            {
                CheckBox cbRecipient = (CheckBox)j.FindControl("cbRecipient");
                if (!cbRecipient.Checked)
                {
                    cbSelectAll.Checked = false;
                    cbCategory.Checked = false;
                }
            }
        }
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {

        Page.Validate("mailCredentials");
        if (!Page.IsValid)
            return;
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            con.Open();
            string mailSubject;
            if (tbxMailSubject.Text == "") mailSubject = "(no subject)";
            else mailSubject = tbxMailSubject.Text;
            SqlCommand saveEmail = new SqlCommand("spSaveMail", con);
            saveEmail.CommandType = CommandType.StoredProcedure;
            saveEmail.Parameters.AddWithValue("@body", tbxMailBody.Text);
            saveEmail.Parameters.AddWithValue("@templateId", rbTemplates.SelectedItem.Value);
            saveEmail.Parameters.AddWithValue("@userId", Convert.ToInt32(Session["LoggedIn"]));
            saveEmail.Parameters.AddWithValue("@subject", mailSubject);
            int sentMailId = Convert.ToInt32(saveEmail.ExecuteScalar());

            try
            {
                foreach (RepeaterItem i in rptrCategory.Items)
                {
                    Repeater rptrRecipient = (Repeater)i.FindControl("rptrRecipient");
                    foreach (RepeaterItem j in rptrRecipient.Items)
                    {
                        HiddenField hfRecipientID = (HiddenField)j.FindControl("hfRecipientId");
                        CheckBox cbRecipient = (CheckBox)j.FindControl("cbRecipient");
                        if (cbRecipient.Checked)
                        {
                            SqlCommand saveRecipientId = new SqlCommand("insert into tblMailRecipient(sentMailId,recipientId) values(@sentMailId,@recipientId)", con);
                            saveRecipientId.Parameters.AddWithValue("@sentMailId", sentMailId);
                            saveRecipientId.Parameters.AddWithValue("@recipientId", hfRecipientID.Value);
                            saveRecipientId.ExecuteNonQuery();
                            sendEmail(Convert.ToInt32(hfRecipientID.Value));
                        }
                    }
                }
                lblMailStatus.Text = "All the emails were sent successfully!";
                tbxMailBody.Text = "";
            }
            catch(Exception ex)
            {
                lblMailStatus.Text = "Wrong Password!";
                SqlCommand deleteMailRecipient = new SqlCommand("delete from tblMailRecipient where sentMailId='"+sentMailId+"'",con);
                deleteMailRecipient.ExecuteNonQuery();
                SqlCommand deleteMail = new SqlCommand("delete from tblSentMails where sentMailId='"+sentMailId+"'",con);
                deleteMail.ExecuteNonQuery();
            }
        }
    }
    public void sendEmail(int recipientId)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            con.Open();
            string body = "";
            SqlCommand getRecipientname = new SqlCommand("select name from tblRecipients where recipientId='" + recipientId + "'", con);
            string recipientName = getRecipientname.ExecuteScalar().ToString();
            SqlCommand getRecipientEmail = new SqlCommand("select email from tblRecipients where recipientId='" + recipientId + "'", con);
            string recipientEmail = getRecipientEmail.ExecuteScalar().ToString();
            SqlCommand getUserEmail = new SqlCommand("select emailId from tblUSers where userId='" + Convert.ToInt32(Session["LoggedIn"]) + "'", con);
            string userEmail = getUserEmail.ExecuteScalar().ToString();
            SqlCommand getTemplateFilePath = new SqlCommand("select filePath from tblTemplates where templateId='" + rbTemplates.SelectedItem.Value + "'", con);
            string templateFilePath = getTemplateFilePath.ExecuteScalar().ToString();
            using (StreamReader reader = new StreamReader(Server.MapPath(templateFilePath)))
            {
                body = reader.ReadToEnd();
                body = body.Replace("{RecipientName}", recipientName);
                body = body.Replace("{body}", tbxMailBody.Text);
            }

            con.Close();
            con.Open();
            string enteredPassword = tbxPassword.Text;
            using (MailMessage mail = new MailMessage(userEmail, recipientEmail))
            {
                mail.Subject = tbxMailSubject.Text;
                mail.Body = body;
                mail.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential(userEmail, enteredPassword);
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mail);
            }
        }
    }



    protected void rbTemplates_SelectedIndexChanged(object sender, EventArgs e)
    {
        string filePath,body;
        
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            con.Open();
            SqlCommand getTemplatePath = new SqlCommand("select filePath from tblTemplates where templateId='"+rbTemplates.SelectedItem.Value+"'",con);
             filePath = getTemplatePath.ExecuteScalar().ToString();
        }
        using (StreamReader reader = new StreamReader(Server.MapPath(filePath)))
        {
            body = reader.ReadToEnd();
            
        }
        this.I1.Src =filePath;
        
        //templatePrevie.Text = body;
        //    HtmlControl frame1 = (HtmlControl)this.FindControl("I1");
        //frame1.Attributes.Add("src",Server.MapPath(filePath));
    }
}
