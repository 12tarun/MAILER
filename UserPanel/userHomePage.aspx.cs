using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
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
        else
        {
            //adding data to the drop down list in input category name.
            string userID = Session["LoggedIn"].ToString();
            string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                SqlCommand com = new SqlCommand("SELECT categoryName,categoryId FROM tblCategory WHERE userId='" + userID + "'", con);
                con.Open();
                ddlCategoryName.DataSource = com.ExecuteReader();
                ddlCategoryName.DataTextField = "categoryName";
                ddlCategoryName.DataValueField = "categoryId";
                ddlCategoryName.DataBind();
            }
        }
    }

    protected void btnCategoryAdder_Click(object sender, EventArgs e)
    {
        Page.Validate("Category");
        if (!Page.IsValid)
            return;

        //Whether to insert category or not is decided here.

        int userId = Convert.ToInt32(Session["LoggedIn"]);
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {     
            SqlCommand checkCategory = new SqlCommand("select count(*) from tblCategory where categoryName='" + tbxCategoryName.Text.Trim() + "' and userID='" + userId + "'", con);
            con.Open();
            int temp = Convert.ToInt32(checkCategory.ExecuteScalar());
            if (temp == 1)
            {
                lblCategoryAlreadyAdded.Visible = true;
            }
            else
            {
                SqlCommand insertCategory = new SqlCommand("INSERT INTO tblCategory(userId,categoryName) VALUES(@userId,@categoryName)", con);
                insertCategory.Parameters.AddWithValue("@userId", userId);
                insertCategory.Parameters.AddWithValue("@categoryName", tbxCategoryName.Text.Trim());
                insertCategory.ExecuteNonQuery();
                Response.Redirect("~/UserPanel/userHomePage.aspx");
            }
        }
    }

    protected void btnRecipientAdd_Click(object sender, EventArgs e)
    {
        Page.Validate("Recipient");
        if (!Page.IsValid)
            return;

        //Whether a recipient can be added or not is decided here.

        lblCategoryName.Visible = false;
        lblCategoryAlreadyAdded.Visible = false;
        int temp = 0;
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT count(*) FROM tblRecipients WHERE email ='" + tbxRecipientEmail.Text.Trim() + "'and categoryId='" + Convert.ToInt32(ddlCategoryName.SelectedItem.Value) + "'"))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    temp = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();
                }
            }
            if (temp != 0)
            {
                lblEmailAlreadyExists.Visible = true;
            }
            else
            {
                con.Open();
                SqlCommand insertRecipientInfo = new SqlCommand("INSERT INTO tblRecipients(name,email,categoryId) VALUES(@name,@email,@categoryId)", con);
                insertRecipientInfo.Parameters.AddWithValue("@name", tbxRecipientName.Text.Trim());
                insertRecipientInfo.Parameters.AddWithValue("@email", tbxRecipientEmail.Text.Trim());
                insertRecipientInfo.Parameters.AddWithValue("@categoryId", ddlCategoryName.SelectedItem.Value);
                insertRecipientInfo.ExecuteNonQuery();
                tbxRecipientEmail.Text = tbxRecipientName.Text = "";
                tbxRecipientEmail.Text = tbxRecipientName.Text = "";
                lblEmailAlreadyExists.Visible = false;
            }
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["LoggedIn"] = null;
        Response.Redirect("~/appHomepage.aspx");
    }
}