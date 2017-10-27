using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserPanel_EmailForPasswordChange : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
    }

    protected void btnForgotPassword_Click(object sender, EventArgs e)
    {
        int accountExists = 0;
        Session["EmailToChangePassword"] = tbxForgotPassword.Text.Trim();
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT count(*) FROM tblUsers WHERE emailId ='" + tbxForgotPassword.Text.Trim() + "'"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    accountExists = Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        if (accountExists == 0)
        {
            lblNoAccount.Visible = true;
        }
        else
        {
            using (MailMessage mm = new MailMessage("tarunrocks122@gmail.com", tbxForgotPassword.Text.Trim()))
            {
                mm.Subject = "Forgot Password";
                string body = "Hi,";
                body += "<br /><a href = http://localhost:58317/UserPanel/PasswordChange.aspx >Click here to change your password.</a>";
                body += "<br /><br />Thanks";
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("tarunrocks122@gmail.com", "sunshine<3.");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
            }
            lblNoAccount.Visible = false;
            tbxForgotPassword.Text = "";
        }
    }
}