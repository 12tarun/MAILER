using System;
using System.Collections;
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
        if (Session["LoggedIn"] == null) Response.Redirect("~/UserPanel/Registration.aspx");
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
            {
                con.Open();
                ArrayList categories = new ArrayList();
                
                DataTable table = new DataTable();
                table.Columns.Add("Name");
                table.Columns.Add("Email");
                table.Columns.Add("Category");
                SqlCommand getcategories = new SqlCommand("select categoryId from tblCategory where userId='" +Convert.ToInt32(Session["LoggedIn"]) + "' ", con);
                using (SqlDataReader rdCategoryID = getcategories.ExecuteReader())
                {
                    while (rdCategoryID.Read())
                    {
                        categories.Add(rdCategoryID["categoryId"]);
                    }
                }
                foreach (int categoyID in categories)
                {
                    SqlCommand getCategoryName = new SqlCommand("select categoryName from tblCategory where categoryId='" + categoyID + "'", con);
                    string categoryName = getCategoryName.ExecuteScalar().ToString();
                    SqlCommand getRecipientsInfo = new SqlCommand("select name,email from tblRecipients where categoryId='" + categoyID + "'", con);
                    using (SqlDataReader rdrRecipients = getRecipientsInfo.ExecuteReader())
                    {
                        while (rdrRecipients.Read())
                        {
                            DataRow dataRow = table.NewRow();
                            dataRow["Name"] = rdrRecipients["name"];
                            dataRow["Email"] = rdrRecipients["email"];
                            dataRow["Category"] = categoryName;
                            table.Rows.Add(dataRow);
                        }
                    }

                }
                
                grdView.DataSource = table;
                grdView.DataBind();


            }
        }
}