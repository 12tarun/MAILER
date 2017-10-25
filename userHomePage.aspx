<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userHomePage.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="caption-side: top">
                <caption>Add Category</caption>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lblCategoryName" Text="Category Name"></asp:Label></td>
                    <td>
                        <asp:TextBox ValidationGroup="Category" runat="server" ID="tbxCategoryName" placeholder="Enter Category Name"></asp:TextBox></td>
                    <td>
                        <asp:RequiredFieldValidator runat="server" ID="RFVCategoryName" ControlToValidate="tbxCategoryName" ErrorMessage="*Mandatory Field" ForeColor="Red"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button runat="server" ID="btnCategoryAdder" Text="Submit" OnClick="btnCategoryAdder_Click" /></td>
                </tr>
            </table>
            <table style="caption-side: top">
                <caption>Add Recipients</caption>
                <tr>
                    <td>
                        <asp:Label ID="lblRecipeintName" runat="server" Text="Recipient Name"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="tbxRecipientName" ValidationGroup="Recipeint" runat="server" placeholder="Enter Recipient Name"></asp:TextBox></td>
                    <td><asp:RequiredFieldValidator runat="server" ID="RFVRecipientName" ControlToValidate="tbxRecipientName" ErrorMessage="*Mandatory Field" ForeColor="Red"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRecipeintEmail" runat="server" Text="RecipientEmail"></asp:Label></td>
                    <td><asp:TextBox ID="tbxRecipientEmail" runat="server" ValidationGroup="Recipient" placeholder="Enter Recipeint Email"></asp:TextBox></td>    
                    <td><asp:RequiredFieldValidator runat="server" ID="RFVRecipientEmail" ControlToValidate="tbxRecipientEmail" ErrorMessage="*Mandatory Field" ForeColor="Red"></asp:RequiredFieldValidator> </td>
                </tr>
                <tr>
                <td >
                    <asp:Label runat="server" ID="lblRecipientCategory" Text="Input Cattegory name"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlCategoryName" runat="server"></asp:DropDownList></td>
            </tr>

                <tr>
                    <td>
                        <asp:Button ID="btnRecipientAdder" runat="server" Text="Submit" />
                    </td>
                </tr>
            </table>

        </div>
    </form>
</body>
</html>
