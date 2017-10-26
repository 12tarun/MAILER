using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.Net.Mail;
using System.Net;

public partial class Registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

        DateTime dtCreate;
        int userId = 0;
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT createdDate,userId FROM tblUsers WHERE verification ='" + 0 + "'"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        dtCreate = (DateTime)(rdr["createdDate"]);
                        userId = Convert.ToInt32(rdr["userId"]);
                        deleteExpiredRegistrations(dtCreate,userId);
                    }
                }
            }
        }
    }

    private void deleteExpiredRegistrations(DateTime dtCreate,int userId)
    {
        DateTime dtNow = DateTime.Now;
        DateTime dtExp = dtCreate.AddDays(1);
        if (dtNow > dtExp)
        {
            string constr3 = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr3))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM tblUsers WHERE UserId ='" + userId + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int userId = 0;
        string hashedPass = getHash(tbxPassword.Text.Trim());
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("Insert_User"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Fullname", tbxFullname.Text.Trim());
                    cmd.Parameters.AddWithValue("@Username", tbxUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", hashedPass);
                    cmd.Parameters.AddWithValue("@Email", tbxEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Verification", 0);
                    cmd.Connection = con;
                    con.Open();
                    userId = Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            string message = string.Empty;
            message = "Registration successful! Activation email has been sent.";
            SendActivationEmail(userId);
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + message + "');", true);
        }
    }

    private static string getHash(string text)
    {
        using (var sha256 = SHA256.Create())
        {
            var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(text));
            return BitConverter.ToString(hashedBytes).Replace("-", "").ToLower();
        }
    }

    private void SendActivationEmail(int userId)
    {
        int c = 0;
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        string activationCode = Guid.NewGuid().ToString();
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("UPDATE tblUsers SET activationCode = @ActivationCode WHERE UserId ='" + userId + "'"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@ActivationCode", activationCode);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }
        using (MailMessage mm = new MailMessage("tarunrocks122@gmail.com", tbxEmail.Text.Trim()))
        {
            mm.Subject = "Account Activation";
            string body = "Hello " + tbxFullname.Text.Trim() + ",";
            body += "<br /><br />Please click the following link to activate your account";
            body += "<br /><a href = http://localhost:58317/UserPanel/Activation.aspx?activationCode=" + activationCode + ">Click here to activate your account.</a>";
            body += "<br /><br />Thanks";
            body += "<br/><br>NOTE: Link expires after 24 hours.";
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
            c = 1;
        }

        if(c!=1)
        {
            string constr3 = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr3))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM tblUsers WHERE UserId ='" + userId + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }
            }
        }
    }

    protected void tbxUsername_TextChanged(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            con.Open();
            SqlCommand checkUsername = new SqlCommand("select count(*) from tblUsers where username='" + tbxUsername.Text.Trim() + "'", con);
            int temp = Convert.ToInt32(checkUsername.ExecuteScalar().ToString());
            if (temp == 1)
            {
                btnSubmit.Enabled = false;
                lblInvalidUsername.Visible = true;
                lblInvalidUsername.Text = "Username is already used.";
            }
            else
            {
                btnSubmit.Enabled = true;
                lblInvalidUsername.Visible = false;
            }
        }
    }

    protected void tbxEmail_TextChanged(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            con.Open();
            SqlCommand checkEmail = new SqlCommand("select count(*) from tblUsers where emailId='" + tbxEmail.Text.Trim() + "'", con);
            int temp = Convert.ToInt32(checkEmail.ExecuteScalar().ToString());
            if (temp == 1)
            {
                btnSubmit.Enabled = false;
                lblInvalidEmail.Visible = true;
                lblInvalidEmail.Text = "EmailId is already used.";
            }
            else
            {
                btnSubmit.Enabled = true;
                lblInvalidEmail.Visible = false;
            }
        }
    }
}