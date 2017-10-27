<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmailForPasswordChange.aspx.cs" Inherits="UserPanel_EmailForPasswordChange" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="btnBack" Text="back" runat="server" style="float:right" OnClick="btnBack_Click" />
            <br />
            <br />
            <h2>Enter the email id with which you created this account</h2>
            <asp:TextBox ID="tbxForgotPassword" ValidationGroup="submit" runat="server"></asp:TextBox>
            <asp:Button ID="btnForgotPassword" Text="submit" runat="server" OnClick="btnForgotPassword_Click" />
            <br />
            <asp:RegularExpressionValidator Display="Dynamic" ValidationGroup="submit" runat="server" ForeColor="Red" ErrorMessage="Invalid email id" ControlToValidate="tbxForgotPassword" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator runat="server" Display="Dynamic" ValidationGroup="submit" ErrorMessage="Enter email id" ControlToValidate="tbxForgotPassword" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:Label ID="lblNoAccount" runat="server" ForeColor="Red" Text="Sorry! We don't have any account with this email id." Visible="false" ></asp:Label>
            <br />
            <asp:Label ID="lblChangePasswordMail" ForeColor="Blue" Text="Email to set new password is sent successfully!" Visible="false" runat="server" ></asp:Label>
        </div>
    </form>
</body>
</html>
