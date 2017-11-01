using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;

public partial class UserPanel_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnTemplateUpload_Click(object sender, EventArgs e)
    {
        if (FileUploadTemplate.HasFile)
        {
            string fileExtension = System.IO.Path.GetExtension(FileUploadTemplate.FileName);
            if (fileExtension.ToLower() != ".html") lblStatus.Text = "Please select a html file";
            else
            {
                Boolean bodyPlaceHolder, namePlaceHolder;
                int fileSize = FileUploadTemplate.PostedFile.ContentLength;
                if (fileSize >= 2097152) lblStatus.Text = "Maximum File Size (2MB) Exceeded";
                else
                {
                    string templateBody, templateFilePath = HttpContext.Current.Request.PhysicalApplicationPath + FileUploadTemplate.FileName;
                    using (StreamReader reader = new StreamReader(FileUploadTemplate.PostedFile.InputStream))
                    {
                        templateBody = reader.ReadToEnd();
                        bodyPlaceHolder = templateBody.Contains("{body}");
                        namePlaceHolder = templateBody.Contains("{RecipientName}");
                    }

                    //bodyPlaceHolder = FileUploadTemplate.PostedFile.InputStream.ToString().Contains("{body}");
                    //namePlaceHolder = FileUploadTemplate.PostedFile.InputStream.ToString().Contains("{RecipientName}");
                    if (bodyPlaceHolder == true && namePlaceHolder == true)
                    {
                        string filePath = "~/htmlTemplates/" + FileUploadTemplate.FileName;

                        FileUploadTemplate.SaveAs(Server.MapPath(filePath));
                        lblStatus.Text = "File Uploaded Succedsfully";
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
                    else lblStatus.Text = "Uploaded File does not contain the required placeholders({body} and{RecipientName})";
                }
            }

        }
        else lblStatus.Text = "Please select a template";

    }
}