using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ID"] == null) Response.Redirect("../appHomePage.aspx");
        else
        {
            if (!IsPostBack)
            {
                //adding the data to the drop down list
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
                {
                    string userID = Session["ID"].ToString();
                    SqlCommand com = new SqlCommand("select categoryName,categoryId from tblCategory where userId='" + userID + "'", con);
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
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            con.Open();
            string message;
            SqlCommand checkCategory = new SqlCommand("select count(*) from tblCategory where categoryName='" + tbxCategoryName.Text + "' and userID='" + Convert.ToInt32(Session["ID"]) + "'", con);
            int temp = Convert.ToInt32(checkCategory.ExecuteScalar());
            if (temp == 1)
            {
                message = "category already registered";
            }
            else
            {
                SqlCommand insertCategory = new SqlCommand("insert into tblCategory(userId,categoryName) values(@userID,@categoryName)", con);
                insertCategory.Parameters.AddWithValue("@userId", Convert.ToInt32(Session["ID"]));
                insertCategory.Parameters.AddWithValue("@categoryName", tbxCategoryName.Text);
                insertCategory.ExecuteNonQuery();
                message = "Category Added Succesfuly";
            }
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + message + "');", true);

        }
    }
    
    protected void tbxRecipientEmail_TextChanged(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            int temp=0;
            con.Open();
            using (SqlConnection con2 = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
            {
                con2.Open();
                SqlCommand getCategories = new SqlCommand("select categoryId from tblCategory where userId='" + Convert.ToInt32(Session["ID"]) + "'", con2);
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
        Session["ID"] = null;
        Response.Redirect("~/appHomepage.aspx");
    }
}
