using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserPanel_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["LoggedIn"] == null) Response.Redirect("~/UserPanel/Registration.aspx");
            else
            {
                this.BindGrid();
            }
        }
    }
    protected void grdView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Text = Regex.Replace(e.Row.Cells[0].Text, tbxSearch.Text.Trim(), delegate (Match match)
            {
                return string.Format("<span style = 'background-color:#FFA727;color:#000'>{0}</span>", match.Value);
            }, RegexOptions.IgnoreCase);
        }
    }

    protected void grdView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdView.PageIndex = e.NewPageIndex;
        this.BindGrid();
    }

    private void BindGrid()
    {
        int recipientCount = 0;
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            con.Open();

            ArrayList categories = new ArrayList();
            DataTable table = new DataTable();
            table.Columns.Add("Name");
            table.Columns.Add("Email");
            table.Columns.Add("Category");
            SqlCommand getCategories = new SqlCommand("select categoryId from tblCategory where userId='" + Convert.ToInt32(Session["LoggedIn"]) + "'", con);
            using (SqlDataReader drCategoryId = getCategories.ExecuteReader())
            {
                while (drCategoryId.Read())
                    categories.Add(drCategoryId["categoryId"]);
            }
            foreach (int categoryId in categories)
            {
                SqlCommand getCategoryName = new SqlCommand("select categoryName from tblCategory where categoryId='" + categoryId + "'", con);
                string categoryName = getCategoryName.ExecuteScalar().ToString();
                SqlCommand getRecipientsInfo = new SqlCommand("SELECT * FROM tblRecipients WHERE name LIKE '%' + @recipientName + '%' and categoryId='" + categoryId + "'", con);
                getRecipientsInfo.Parameters.AddWithValue("@recipientName", tbxSearch.Text);
                using (SqlDataReader drRecipients = getRecipientsInfo.ExecuteReader())
                {
                    while (drRecipients.Read())
                    {
                        DataRow datarow = table.NewRow();
                        datarow["Name"] = drRecipients["name"];
                        datarow["Email"] = drRecipients["email"];
                        datarow["Category"] = categoryName;
                        table.Rows.Add(datarow);
                        recipientCount++;

                    }
                }
            }
            grdView.DataSource = table;
            grdView.DataBind();
            if(recipientCount==0) ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('No items matched your search','Info','recipeintSearchStatus');", true);
        }


    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        this.BindGrid();
    }

    protected void tbxSearch_TextChanged(object sender, EventArgs e)
    {
        if (tbxSearch.Text == "")
            this.BindGrid();
    }
}
