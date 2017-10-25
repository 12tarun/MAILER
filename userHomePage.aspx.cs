using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default :  System.Web.UI.Page
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
            SqlCommand checkCategory = new SqlCommand("select count(*) from tblCategory where categoryName='"+tbxCategoryName.Text+"' and userId='"+Convert.ToInt32(Session["ID"])+"'",con);
            int temp = Convert.ToInt32( checkCategory.ExecuteScalar());
            if(temp==1)
            {
                message = "category already registered";
            }
            else
            {
                SqlCommand insertCategory = new SqlCommand("insert into tblCategory(userId,categoryName) values(@userID,@categoryName)", con);
                insertCategory.Parameters.AddWithValue("@userID",Convert.ToInt32(Session["ID"]));
                insertCategory.Parameters.AddWithValue("@categoryName",tbxCategoryName.Text);
                insertCategory.ExecuteNonQuery();
                message = "Category Added Succesfuly";
            }
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + message + "');", true);

        }
    }


    protected void btnRecipientAdder_Click(object sender, EventArgs e)
    {
        Page.Validate("Recipient");
        if (!Page.IsValid)
            return;
    }
}