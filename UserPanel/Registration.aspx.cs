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

        if (Session["LoggedIn"] != null)
        {
            Response.Redirect("~/UserPanel/composeEmail.aspx");
        }
        else
        {

            if (!IsPostBack)
            {
                fillCaptcha();
                Session["LoggedIn"] = null;
                Session["UsernameAlreadyExists"] = false;
                Session["EmailAlreadyExists"] = false;
            }

            if (!IsPostBack)
            {
                lblWarning.Visible = false;

            }

            DateTime dtCreate;
            int userId = 0;
            string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT recipientId FROM tblMailRecipient WHERE sentMailId ='" + 0 + "'"))
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
                            deleteExpiredRegistrations(dtCreate, userId);
                        }
                    }
                }
            }
        }
    }

    void fillCaptcha()
    {
        try
        {
            Random random = new Random();
            string combination = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            StringBuilder captcha = new StringBuilder();
            for (int i = 0; i < 6; i++)
            {
                captcha.Append(combination[random.Next(combination.Length)]);
                Session["captcha"] = captcha.ToString();
                imgCaptcha.ImageUrl = "GenerateCaptcha.aspx?" + DateTime.Now.Ticks.ToString();
            }
        }
        catch
        {
            throw;
        }

    }

    private void deleteExpiredRegistrations(DateTime dtCreate, int userId)
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

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        Page.Validate("register");
        if (!Page.IsValid)
            return;

        int userId = 0;


        string captcha = Session["captcha"].ToString();
        if (captcha != tbxCaptcha.Text.Trim() || tbxCaptcha.Text == "")
        {
            lblIncorrectCaptcha.Visible = true;
            lblIncorrectCaptcha.Text = "Invalid Captcha Code";
        }
        else
        {
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
                string Message = string.Empty;
                Message = " Registration successful! Activation email has been sent to your registered email id.";
                SendActivationEmail(userId);
                tbxFullname.Text = tbxUsername.Text = tbxPassword.Text = tbxComfirmPassword.Text = tbxEmail.Text = tbxCaptcha.Text = "";
                lblIncorrectCaptcha.Visible = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "', 'Success','registrationStatusAlert');", true);

                fillCaptcha();
            }
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
            body += "<br /><a href = http://localhost:56617/UserPanel/Activation.aspx?activationCode=" + activationCode + ">Click here to activate your account.</a>";
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
                btnRegister.Enabled = false;
                lblInvalidUsername.Visible = true;
                lblInvalidUsername.Text = "Username is already used.";
                Session["UsernameAlreadyExists"] = true;
            }
            else
            {
                Session["UsernameAlreadyExists"] = false;
                if ((bool)Session["EmailAlreadyExists"] == false)
                {
                    btnRegister.Enabled = true;
                }
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
                btnRegister.Enabled = false;
                lblInvalidEmail.Visible = true;
                lblInvalidEmail.Text = "EmailId is already used.";
                Session["EmailAlreadyExists"] = true;
            }
            else
            {
                Session["EmailAlreadyExists"] = false;
                if ((bool)Session["UsernameAlreadyExists"] == false)
                {
                    btnRegister.Enabled = true;
                }
                lblInvalidEmail.Visible = false;
            }
        }
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        fillCaptcha();
        string password = tbxPassword.Text;
        tbxPassword.Attributes.Add("value", password);
        string confirmPassword = tbxComfirmPassword.Text;
        tbxComfirmPassword.Attributes.Add("value", tbxComfirmPassword.Text);
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

        Page.Validate("login");
        if (!Page.IsValid)
            return;
        if (Session["LoggedIn"] != null) Response.Redirect("~/UserPanel/composeEmail.aspx");
        else
        {

            int userId = 0;
            string hashedLoginPass = getHash(tbxLoginPassword.Text.Trim());
            string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("Validate_User"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@EmailId", tbxLoginEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", hashedLoginPass);
                    cmd.Connection = con;
                    con.Open();
                    userId = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();
                }
                string Message;
                switch (userId)
                {
                    case -1:
                        Message = " EmailId and/or password is incorrect.";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "', 'Error','loginStatusAlert');", true);

                        break;
                    case -2:
                        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage(' Account not activated. Click on activation link sent to your registered email id within 24hrs to activate your account.', 'Error','loginStatusAlert');", true);

                        break;
                    default:
                        Session["LoggedIn"] = userId;
                        Response.Redirect("~/UserPanel/composeEmail.aspx");
                        break;
                }
            }
        }
    }

    protected void LnkBtnForgotPassword_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/UserPanel/EmailForPasswordChange.aspx");
    }
}