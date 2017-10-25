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

public partial class Registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
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
                    cmd.Parameters.AddWithValue("@Fullname", tbxFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Username", tbxUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", hashedPass);
                    cmd.Parameters.AddWithValue("@Email", tbxEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Verification", 0);
                    cmd.Connection = con;
                    con.Open();
                    userId = Convert.ToInt32(cmd.ExecuteScalar());
                }
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