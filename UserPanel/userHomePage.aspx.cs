using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Excel = Microsoft.Office.Interop.Excel;
using MAILER;

public partial class UserPanel_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FileUploadExcel.Attributes["onchange"] = "CheckFile(this)";

        if (Session["LoggedIn"] == null)
        {
            Response.Redirect("~/UserPanel/Registration.aspx");
        }
        else
        {
            //adding data to the drop down list in input category name.
            if (!IsPostBack)
            {
                bindDataToDropdown();
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
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Category Already Registered', 'Error','categoryAdderStatus');", true);
            }
            else
            {
                SqlCommand insertCategory = new SqlCommand("INSERT INTO tblCategory(userId,categoryName) VALUES(@userId,@categoryName)", con);
                insertCategory.Parameters.AddWithValue("@userId", userId);
                insertCategory.Parameters.AddWithValue("@categoryName", tbxCategoryName.Text.Trim());
                insertCategory.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Category Added Succesfuly','Success','categoryAdderStatus');", true);
                bindDataToDropdown();
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

                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Email Already Registered','Error','recipientAdderStatus');", true);
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
                ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Recipient Added Succesfuly','Success','recipientAdderStatus');", true);
            }
        }
    }



    //Uploading recipients through MS-Excel Sheet

    protected void btnUploadExcel_Click(object sender, EventArgs e)
    {
        int userId = Convert.ToInt32(Session["LoggedIn"]);

        string cs = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        string excelfile = FileUploadExcel.PostedFile.FileName;

        if (excelfile.EndsWith("xls") || excelfile.EndsWith("xlsx"))
        {
            lblWrongExcel.Visible = false;

            string path = Server.MapPath("~/UploadedExcel/" + excelfile);
            if (File.Exists(path))
            {
                File.Delete(path);
            }
            FileUploadExcel.SaveAs(path);

            string categoryName = "";
            for (int j = 0; j < excelfile.Length; j++)
            {
                if (excelfile[j] == '.')
                {
                    break;
                }
                else
                {
                    categoryName = categoryName + excelfile[j];
                }
            }

            int temp = 0;
            int categoryId = 0;
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT count(*) FROM tblCategory WHERE categoryName ='" + categoryName + "' and userID='" + userId + "'"))
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
                if (temp == 1)
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT categoryId FROM tblCategory WHERE categoryName ='" + categoryName + "'"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Connection = con;
                            con.Open();
                            categoryId = Convert.ToInt32(cmd.ExecuteScalar());
                            con.Close();
                        }
                    }
                }
                else
                {

                    string query = "INSERT INTO tblCategory(userId, categoryName) VALUES(@userId,@categoryName)";
                    using (SqlConnection connect = new SqlConnection(cs))
                    {
                        using (SqlCommand cmd = new SqlCommand(query))
                        {
                            cmd.Connection = connect;
                            connect.Open();
                            cmd.Parameters.AddWithValue("@userId", userId);
                            cmd.Parameters.AddWithValue("@categoryName", categoryName);
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand("SELECT categoryId FROM tblCategory WHERE categoryName ='" + categoryName + "'"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Connection = con;
                            con.Open();
                            categoryId = Convert.ToInt32(cmd.ExecuteScalar());
                            con.Close();
                        }
                    }
                }
            }

            Excel.Application application = new Excel.Application();
            Excel.Workbook workbook = application.Workbooks.Open(path);
            Excel.Worksheet worksheet = (Microsoft.Office.Interop.Excel.Worksheet)workbook.ActiveSheet;
            Excel.Range range = worksheet.UsedRange;
            int rowCount = range.Rows.Count;
            int colCount = range.Columns.Count;

            {
                List<tblRecipients> datacheckUpload = new List<tblRecipients>();
                for (int row = 2; row <= rowCount; row++)
                {
                    if (((Excel.Range)range.Cells[row, 1]).Text.ToString() != "")
                    {
                        datacheckUpload.Add(new tblRecipients
                        {
                            name = ((Excel.Range)range.Cells[row, 1]).Text.ToString(),
                            email = ((Excel.Range)range.Cells[row, 2]).Text.ToString(),
                        });
                    }
                    else
                    {
                        goto here;
                    }
                }
                here:
                foreach (var item in datacheckUpload)
                {
                    if (item.name != "")
                    {
                        int exist = 0;
                        using (SqlConnection con = new SqlConnection(cs))
                        {
                            using (SqlCommand cmd = new SqlCommand("SELECT count(*) FROM tblRecipients WHERE email ='" + item.email + "'and categoryId ='" + categoryId + "'"))
                            {
                                using (SqlDataAdapter sda = new SqlDataAdapter())
                                {
                                    cmd.CommandType = CommandType.Text;
                                    cmd.Connection = con;
                                    con.Open();
                                    exist = Convert.ToInt32(cmd.ExecuteScalar());
                                    con.Close();
                                }
                            }
                            if (exist != 1)
                            {
                                string query = "INSERT INTO tblRecipients(categoryId, name, email) VALUES(@categoryId,@name,@email)";
                                using (SqlConnection connect = new SqlConnection(cs))
                                {
                                    using (SqlCommand cmd = new SqlCommand(query))
                                    {
                                        cmd.Connection = connect;
                                        connect.Open();
                                        cmd.Parameters.AddWithValue("@categoryId", categoryId);
                                        cmd.Parameters.AddWithValue("@name", item.name);
                                        cmd.Parameters.AddWithValue("@email", item.email);
                                        cmd.ExecuteNonQuery();
                                    }
                                }
                            }
                        }
                    }
                }
                workbook.Close(true, null, null);
                Marshal.ReleaseComObject(worksheet);
                Marshal.ReleaseComObject(workbook);
                Marshal.ReleaseComObject(application);
            }
            bindDataToDropdown();
            ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Excel File Uploaded Succesfuly','Success','excelFileUploadStatus');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Only .xls, xlsx file is acceptable','Error','excelFileUploadStatus');", true);
        }
    }

    protected void btnTemplateUpload_Click(object sender, EventArgs e)
    {
        if (FileUploadTemplate.HasFile)
        {
            string fileExtension = System.IO.Path.GetExtension(FileUploadTemplate.FileName);
            if (fileExtension.ToLower() != ".html") ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Please select a HTML file only','Error','templateStatus');", true);
            else
            {
                Boolean bodyPlaceHolder;
                int fileSize = FileUploadTemplate.PostedFile.ContentLength;
                if (fileSize >= 2097152) ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('FileSize Exceeded maximum size','Error','templateStatus');", true);
                else
                {
                    string templateBody, templateFilePath = HttpContext.Current.Request.PhysicalApplicationPath + FileUploadTemplate.FileName;
                    using (StreamReader reader = new StreamReader(FileUploadTemplate.PostedFile.InputStream))
                    {
                        templateBody = reader.ReadToEnd(); bodyPlaceHolder = templateBody.Contains("{body}");

                    }
                    if (bodyPlaceHolder)
                    {
                        string filePath = "~/htmlTemplates/" + FileUploadTemplate.FileName;

                        FileUploadTemplate.SaveAs(Server.MapPath(filePath));
                        ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('File Uploaded Succesfuly','Success','templateStatus');", true);
                        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
                        {
                            con.Open();
                            SqlCommand saveTemplate = new SqlCommand("insert into tblTemplates(displayName,userId,filePath) values(@displayName,@userId,@filePath)", con);
                            saveTemplate.Parameters.AddWithValue("@displayName", FileUploadTemplate.FileName.Replace(".html", ""));
                            saveTemplate.Parameters.AddWithValue("@userId", Convert.ToInt32(Session["LoggedIn"]));
                            saveTemplate.Parameters.AddWithValue("@filePath", filePath);
                            saveTemplate.ExecuteNonQuery();
                            using (StreamWriter sw = File.AppendText(Server.MapPath(filePath)))
                            {
                                sw.WriteLine(templateBody);
                            }
                        }
                    }
                    else ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Uploaded  file does not contain the required placeholder {body}','Error','templateStatus');", true);
                }
            }

        }
        else ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('Please select a template','Error','templateStatus');", true);

    }
    protected void bindDataToDropdown()
    {
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
