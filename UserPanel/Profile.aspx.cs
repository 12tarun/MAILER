using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserPanel_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["LoggedIn"]==null)
        {
            Response.Redirect("~/UserPanel/Registration.aspx");
        }
        else
        {
            if(!IsPostBack)
            {
                tbxEditFullName.Visible = false;
                btnEnterFullName.Visible = false;
                lblWrongExtension.Visible = false;
                tbxEditUsername.Visible = false;
                lblInvalidUsername.Visible = false;
            }

            string fullName = "";
            int userId = Convert.ToInt32(Session["LoggedIn"]);
            string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT fullname FROM tblUsers WHERE UserId ='" + userId + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        con.Open();
                        fullName = cmd.ExecuteScalar().ToString();
                    }
                }
                lblEditFullName.Text = fullName;
            }

            int c = 0;
            string imageDataString = "";
            string constr2 = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr2))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT DPdata FROM tblUsers WHERE UserId = '" + userId + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
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
            if (c == 1)
            {
                imgEditProfilePicture.ImageUrl = "data:Image/png;base64," + imageDataString;
            }

            string username = "";
            string constr3 = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr3))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT username FROM tblUsers WHERE UserId ='" + userId + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        con.Open();
                        username = cmd.ExecuteScalar().ToString();
                    }
                }
                lblEditUsername.Text = username;
            }
        }
    }

    protected void btnEditFullName_Click(object sender, EventArgs e)
    {
        tbxEditFullName.Visible = true;
        btnEnterFullName.Visible = true;
    }

    protected void btnEnterFullName_Click(object sender, EventArgs e)
    {
        Page.Validate("editFullName");
        if (!Page.IsValid)
            return;

        int userId = Convert.ToInt32(Session["LoggedIn"]);
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("UPDATE tblUsers SET fullname = @fullname WHERE UserId ='" + userId + "'"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@fullname", tbxEditFullName.Text.Trim());
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
        Response.Redirect("~/UserPanel/Profile.aspx");
    }

    protected void btnDP_Click(object sender, EventArgs e)
    {
        int userId = Convert.ToInt32(Session["LoggedIn"]);

        HttpPostedFile postedFile = fileUploadDP.PostedFile;
        string fileName = Path.GetFileName(postedFile.FileName);
        string fileExtension = Path.GetExtension(fileName);
        int fileSize = postedFile.ContentLength;

        if ((fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".png") && fileUploadDP.HasFile == true)
        {
            lblWrongExtension.Visible = false;

            Stream stream = postedFile.InputStream;
            BinaryReader binaryReader = new BinaryReader(stream);
            byte[] bytes = binaryReader.ReadBytes((int)stream.Length);

            string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE tblUsers SET DPname = @ImageName , DPsize = @ImageSize , DPdata = @ImageData WHERE userId='" + userId + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@ImageName", fileName);
                        cmd.Parameters.AddWithValue("ImageSize", fileSize);
                        cmd.Parameters.AddWithValue("@ImageData", bytes);
                        cmd.Connection = con;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }
            }
            Response.Redirect("~/UserPanel/Profile.aspx");
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage(' Only .jpg or .png is acceptable.', 'Error','profilepicAlert');", true);
        }
    }

    protected void btnEditUsername_Click(object sender, EventArgs e)
    {
        tbxEditUsername.Visible = true;
        lblInvalidUsername.Visible = false;

        Page.Validate("editUsername");
        if (!Page.IsValid)
            return;

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            int userId = Convert.ToInt32(Session["LoggedIn"]);
            con.Open();
            SqlCommand checkUsername = new SqlCommand("select count(*) from tblUsers where username='" + tbxEditUsername.Text.Trim() + "'", con);
            int temp = Convert.ToInt32(checkUsername.ExecuteScalar().ToString());
            if (temp >= 1)
            {
                lblInvalidUsername.Visible = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Username already exists.', 'Error','usernameAlert');", true);
            }
            else
            {
                lblInvalidUsername.Visible = false;
                string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
                using (SqlConnection con2 = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand("UPDATE tblUsers SET username = @username WHERE userId='" + userId + "'"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@username", tbxEditUsername.Text.Trim());
                            cmd.Connection = con2;
                            con2.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                Response.Redirect("~/UserPanel/Profile.aspx");
            }
        }
    }
}