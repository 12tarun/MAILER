using System;
using System.Collections.Generic;
using System.Configuration;
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
            if (!IsPostBack)
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
                lblCategoryAdder.Visible = false;
            }
            else
            {
                SqlCommand insertCategory = new SqlCommand("INSERT INTO tblCategory(userId,categoryName) VALUES(@userId,@categoryName)", con);
                insertCategory.Parameters.AddWithValue("@userId", userId);
                insertCategory.Parameters.AddWithValue("@categoryName", tbxCategoryName.Text.Trim());
                insertCategory.ExecuteNonQuery();
                lblCategoryAdder.Visible = true;
                lblCategoryAlreadyAdded.Visible = false;
            }
        }
    }

    //yaha se padhna hai
    protected void tbxRecipientEmail_TextChanged(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            int temp = 0;
            con.Open();
            using (SqlConnection con2 = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
            {
                con2.Open();
                SqlCommand getCategories = new SqlCommand("select categoryId from tblCategory where userId='" + Convert.ToInt32(Session["LoggedIn"]) + "'", con2);
                using (SqlDataReader rdCategoryID = getCategories.ExecuteReader())
                {
                    while (rdCategoryID.Read())
                    {
                        SqlCommand checkEmail = new SqlCommand("select count(*) from tblRecipients where categoryId='" + rdCategoryID["categoryId"] + "' and email='" + tbxRecipientEmail.Text + "'", con);
                        temp = Convert.ToInt32(checkEmail.ExecuteScalar());
                        if (temp == 1)
                        {
                            lblInvalidEmail.Text = "Email already registered";
                            btnRecipientAdder.Enabled = false;
                            break;
                        }
                        else
                        {
                            lblInvalidEmail.Text = null;
                            btnRecipientAdder.Enabled = true;
                        }
                    }
                    if (temp == 1) btnRecipientAdder.Enabled = false;
                }
            }
        }
    }

    protected void btnRecipientAdder_Click1(object sender, EventArgs e)
    {
        Page.Validate("Recipient");
        if (!Page.IsValid)
            return;

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            con.Open();
            SqlCommand insertRecipientInfo = new SqlCommand("insert into tblRecipients(name,email,categoryId) values(@name,@email,@CategoryId)", con);
            insertRecipientInfo.Parameters.AddWithValue("@name", tbxRecipientName.Text);
            insertRecipientInfo.Parameters.AddWithValue("@email", tbxRecipientEmail.Text);
            insertRecipientInfo.Parameters.AddWithValue("@CategoryId", ddlCategoryName.SelectedItem.Value);
            insertRecipientInfo.ExecuteNonQuery();
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Recipient Added Succesfuly');", true);
            tbxRecipientEmail.Text = tbxRecipientName.Text = "";
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["LoggedIn"] = null;
        Response.Redirect("~/appHomepage.aspx");
    }
}