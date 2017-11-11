using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserPanel_userPanel : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string username = "";
            string imageDataString = "";
            int userID = Convert.ToInt32(Session["LoggedIn"]);
            int c = 0;
            string constr2 = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr2))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT DPdata, username FROM tblUsers WHERE UserId = '" + userID + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            username = reader["Username"].ToString();
                            if (reader["DPdata"].ToString() != "")
                            {
                                c = 1;
                                byte[] imagedata = (byte[])reader["DPdata"];
                                imageDataString = Convert.ToBase64String(imagedata);
                            }
                        }
                    }
                }
            }
            lblUsername.Text += username;
            if (c == 1)
            {
                imgDP.ImageUrl = "data:Image/png;base64," + imageDataString;
            }
        }
    }

        protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["LoggedIn"] = null;
        Response.Redirect("~/UserPanel/Registration.aspx");
    }
}
