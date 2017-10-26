using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserPanel_Activation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string activationCode = Request["activationCode"];
        DateTime dtCreate;
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT createdDate FROM tblUsers WHERE activationCode ='" + activationCode + "'"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    dtCreate = (DateTime)(cmd.ExecuteScalar());
                }
            }
        }

        DateTime dtNow = DateTime.Now;
        DateTime dtExp = dtCreate.AddDays(1);
        if (dtNow > dtExp)
        {
            Response.Write("Page has expired!");
        }
        else
        {
            string constr2 = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr2))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE tblUsers SET verification = @Verification WHERE activationCode ='" + activationCode + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@Verification", 1);
                        cmd.Connection = con;
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        con.Close();
                        if (rowsAffected == 1)
                        {
                            ltMessage.Text = "Activation successful!";
                        }
                        else
                        {
                            ltMessage.Text = "Invalid Activation code!";
                        }
                    }
                }
            }
        }
    }
}