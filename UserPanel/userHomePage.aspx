<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="userHomePage.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function CheckFile(fileUpload) {
            if (fileUpload.value != '') {
                document.getElementById("<%=btnUploadExcel.ClientID%>").click();
            }
        }
    </script>
    <table style="caption-side: top">
        <caption>Add Category</caption>
        <tr>
            <td>
                <asp:Label runat="server" ID="lblCategoryName" Text="Category Name"></asp:Label>
            </td>
            <td>
                <asp:TextBox ValidationGroup="Category" runat="server" ID="tbxCategoryName" placeholder="Enter Category Name"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ValidationGroup="Category" runat="server" ID="RFVCategoryName" ControlToValidate="tbxCategoryName" ErrorMessage="Category name required." ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button runat="server" ID="btnCategoryAdder" Text="Submit" OnClick="btnCategoryAdder_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblCategoryAlreadyAdded" runat="server" Text="Category already added!" ForeColor="Red" Visible="false"></asp:Label>
            </td>
        </tr>
    </table>

    <table style="caption-side: top">
        <caption>Add Recipients</caption>
        <tr>
            <td>
                <asp:Label runat="server" ID="lblRecipientCategory" Text="Choose Category name"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlCategoryName" ValidationGroup="Recipient" runat="server"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblRecipeintName" runat="server" Text="Recipient Name"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbxRecipientName" ValidationGroup="Recipient" runat="server" placeholder="Enter Recipient Name"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator runat="server" ValidationGroup="Recipient" ID="RFValidatorRecipientName" ControlToValidate="tbxRecipientName" ErrorMessage="Recipient name required" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblRecipientEmail" runat="server" Text="Recipient Email"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbxRecipientEmail" runat="server" ValidationGroup="Recipient" placeholder="Enter Recipient Email"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator runat="server" ID="RFValidatorRecipientEmail" ValidationGroup="Recipient" ControlToValidate="tbxRecipientEmail" ErrorMessage="Recipient email required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="REValidatorRecipientEmail" ValidationGroup="Recipient" runat="server" ControlToValidate="tbxRecipientEmail" Display="Dynamic" ForeColor="Red" ErrorMessage="Invalid email id" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"></asp:RegularExpressionValidator>
                <asp:Label ID="lblEmailAlreadyExists" Text="Email already exists in this category" Visible="false" ForeColor="Red" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnRecipientAdd" runat="server" OnClick="btnRecipientAdd_Click" Text="Add" />
            </td>
        </tr>
    </table>
    <br />
    <br />
    <h4>Add recipients through MS-Excel</h4>
    <asp:Label ID="lblSelectExcel" runat="server" Text="Select File:"></asp:Label>
    <asp:FileUpload ID="FileUploadExcel" runat="server" />
    <asp:Button ID="btnUploadExcel" runat="server" Text="Upload" OnClick="btnUploadExcel_Click" />
    <br />
    <br />
    <asp:Label ID="lblWrongExcel" Text="Only .xls, xlsx file is acceptable." Visible="false" ForeColor="Red" runat="server" ></asp:Label>
</asp:Content>

