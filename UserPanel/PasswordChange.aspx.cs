using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserPanel_PasswordChange : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        if(Session["EmailToChangePassword"] == null)
        {
            Response.Write("Link is already used or invalid access.Get link again if password forgotten.");
            tbxConfirmNewPassword.Visible = false;
            tbxNewPassword.Visible = false;
            btnPasswordChanged.Visible = false;
        }
    }

    protected void btnPasswordChanged_Click(object sender, EventArgs e)
    {
        if (Session["EmailToChangePassword"] != null)
        {
            string emailId = Session["EmailToChangePassword"].ToString();
            string hashedNewPass = getNewHash(tbxNewPassword.Text.Trim());
            string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE tblUsers SET password = @password WHERE emailId ='" + emailId + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@password", hashedNewPass);
                        cmd.Connection = con;
                        con.Open();
                        cmd.ExecuteScalar();
                    }
                }
            }
            lblNewPassword.Visible = true;
        }

        Session["EmailToChangePassword"] = null;
    }

    private static string getNewHash(string text)
    {
        using (var sha256 = SHA256.Create())
        {
            var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(text));
            return BitConverter.ToString(hashedBytes).Replace("-", "").ToLower();
        }
    }
}