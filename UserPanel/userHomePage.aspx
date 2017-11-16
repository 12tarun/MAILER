<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" ValidateRequest="false"  AutoEventWireup="true" CodeFile="userHomePage.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../CSS/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <div class="container-fluid child-page">
        <div class="container content txt-style">
            <script type="text/javascript">
                function CheckFile(fileUpload) {
                    if (fileUpload.value != '') {
                        document.getElementById("<%=btnUploadExcel.ClientID%>").click();
                    }
                }
            </script>
            <div class="container rec-container txt-style">
                <div class="justify-content-center">
                    <i style="font-size: 50px" class="fa fa-users" aria-hidden="true"></i>
                    <br>
                    <h1>SETTINGS</h1>
                </div>
                <div>
                    <h3>Add Category</h3>
                    <div class="form">
                        <asp:Label runat="server" ID="lblCategoryName" Visible="false" Text="Category Name"></asp:Label>
                        <asp:TextBox ValidationGroup="Category" runat="server" ID="tbxCategoryName" placeholder="Enter Category Name"></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator Display="Dynamic" ValidationGroup="Category" runat="server" ID="RFVCategoryName" ControlToValidate="tbxCategoryName" ErrorMessage="Category name required" ForeColor="Red"></asp:RequiredFieldValidator>
                    
                    <div>
                        <asp:Button class="btnstyle" runat="server" ID="btnCategoryAdder" Text="Submit" OnClick="btnCategoryAdder_Click" />
                    </div>

                    <div>
                        <asp:Label ID="lblCategoryAlreadyAdded" runat="server" Text="Category already added!" ForeColor="Red" Visible="false"></asp:Label>
                    </div>
                  </div>
               <div id="categoryAdderStatus" style="padding-top:20px"></div>
                
                <br />
                <div>
                    <h3>Add Recipient</h3>
                    <div class="form">
                        <asp:Label runat="server" Visiblity="false" ID="lblRecipientCategory" Text="Choose Category name"></asp:Label>
                        <asp:DropDownList ID="ddlCategoryName" ValidationGroup="Recipient" runat="server"></asp:DropDownList>
                    </div>
                    <div class="form">
                        <asp:Label Visible="false" ID="lblRecipeintName" runat="server" Text="Recipient Name"></asp:Label>
                        <asp:TextBox ID="tbxRecipientName" ValidationGroup="Recipient" runat="server" placeholder="Enter Recipient Name"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" Display="Dynamic" ValidationGroup="Recipient" ID="RFValidatorRecipientName" ControlToValidate="tbxRecipientName" ErrorMessage="Recipient name required" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form">
                        <asp:Label Visible="false" ID="lblRecipientEmail" runat="server" Text="Recipient Email"></asp:Label>
                        <asp:TextBox ID="tbxRecipientEmail" runat="server" ValidationGroup="Recipient" placeholder="Enter Recipient Email"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" runat="server" ID="RFValidatorRecipientEmail" ValidationGroup="Recipient" ControlToValidate="tbxRecipientEmail" ErrorMessage="Recipient email required" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator Display="Dynamic" ID="REValidatorRecipientEmail" ValidationGroup="Recipient" runat="server" ControlToValidate="tbxRecipientEmail" ForeColor="Red" ErrorMessage="Invalid email id" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"></asp:RegularExpressionValidator>
                    </div>
                    <asp:Label ID="lblEmailAlreadyExists" Text="Email already exists in this category" Visible="false" ForeColor="Red" runat="server"></asp:Label>
                    <asp:Button class="btnstyle" ID="btnRecipientAdd" runat="server" OnClick="btnRecipientAdd_Click" Text="Add" />
                </div>
                <div id="recipientAdderStatus" style="padding-top:20px"></div>
                <br />
                <div>
                    <h4>Add recipients through MS-Excel</h4>
                    <div class="form">
                        <asp:Label Visible="false" ID="lblSelectExcel" runat="server" Text="Select File:"></asp:Label>
                    </div>
                    <asp:FileUpload ID="FileUploadExcel" Style="justify-content: center" runat="server" />
                    <asp:Button ID="btnUploadExcel" class="btnstyle" runat="server" Text="Upload" OnClick="btnUploadExcel_Click" />
                    <asp:Label ID="lblWrongExcel" Text="Only .xls, xlsx file is acceptable" Visible="false" ForeColor="Red" runat="server"></asp:Label>
                <div id="excelFileUploadStatus" style="padding:20px" ></div>
                </div>
                <br />
                <h4>Upload your own template</h4>
                <asp:Label ID="lblUploadTemplate" runat="server" Visible="false" Text="Select Template File"></asp:Label>
                <asp:FileUpload ID="FileUploadTemplate" runat="server" />
                <asp:Button ID="btnTemplateUpload" class="btnstyle" runat="server" Text="Upload" OnClick="btnTemplateUpload_Click" />
               <div id="templateStatus" style="padding-top:20px"></div>
            </div>
        </div>
    </div>
</asp:Content>

