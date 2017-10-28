<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="userHomePage.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="caption-side: top">
        <caption>Add Category</caption>
        <tr>
            <td>
                <asp:Label runat="server" ID="lblCategoryName" Text="Category Name"></asp:Label></td>
            <td>
                <asp:TextBox ValidationGroup="Category" runat="server" ID="tbxCategoryName" placeholder="Enter Category Name"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator ValidationGroup="Category" runat="server" ID="RFVCategoryName" ControlToValidate="tbxCategoryName" ErrorMessage="Category name required." ForeColor="Red"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button runat="server" ID="btnCategoryAdder" Text="Submit" OnClick="btnCategoryAdder_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <td colspan="2">
                    <asp:Label ID="lblCategoryAlreadyAdded" runat="server" Text="Category already added!" ForeColor="Red" Visible="false"></asp:Label>
                    <br />
                    <asp:Label ID="lblCategoryAdder"  runat="server" Text="Category added successfully!" ForeColor="Blue" Visible="false"></asp:Label>
            </td>
        </tr>
    </table>

    <table style="caption-side: top">
        <caption>Add Recipients</caption>
        <tr>
            <td>
                <asp:Label ID="lblRecipeintName" runat="server" Text="Recipient Name"></asp:Label></td>
            <td>
                <asp:TextBox ID="tbxRecipientName" ValidationGroup="Recipeint" runat="server" placeholder="Enter Recipient Name"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator runat="server" ValidationGroup="Recipient" ID="RFVRecipientName" ControlToValidate="tbxRecipientName" ErrorMessage="*Mandatory Field" ForeColor="Red"></asp:RequiredFieldValidator></td>

        </tr>
        <tr>
            <td>
                <asp:Label ID="lblRecipeintEmail" runat="server" Text="RecipientEmail"></asp:Label></td>
            <td>
                <asp:TextBox ID="tbxRecipientEmail" runat="server" ValidationGroup="Recipient" AutoPostBack="true" OnTextChanged="tbxRecipientEmail_TextChanged" placeholder="Enter Recipeint Email"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator runat="server" ID="RFVRecipientEmail" ValidationGroup="Recipient" ControlToValidate="tbxRecipientEmail" ErrorMessage="*Mandatory Field" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:Label runat="server" ID="lblInvalidEmail" ForeColor="Red"></asp:Label></td>
            <asp:RequiredFieldValidator ID="RegexEmail" runat="server" ControlToValidate="tbxRecipientEmail" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ErrorMessage="*Invalid Email" ForeColor="Red"></asp:RequiredFieldValidator>

        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lblRecipientCategory" Text="Input Cattegory name"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlCategoryName" runat="server"></asp:DropDownList></td>
        </tr>

        <tr>
            <td>
                <asp:Button ID="btnRecipientAdder" runat="server" Text="Submit" Height="24px" OnClick="btnRecipientAdder_Click1" />
            </td>
        </tr>
    </table>

</asp:Content>

