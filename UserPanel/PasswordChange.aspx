<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PasswordChange.aspx.cs" Inherits="UserPanel_PasswordChange" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="tbxNewPassword" runat="server" placeholder="Enter new password" TextMode="Password" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFValidatorNewPassword" runat="server" Display="Dynamic" ControlToValidate="tbxNewPassword" ErrorMessage="New password required" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="REValidatorNewPassword" runat="server" Display="Dynamic" Font-Size="small" ErrorMessage="Password should contain atleast one digit, one alphabet and minimum length 6." ControlToValidate="tbxNewPassword" ForeColor="Red" ValidationExpression="^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$" />
            <br />
            <br />
            <asp:TextBox ID="tbxConfirmNewPassword" runat="server" placeholder="Confirm new password" TextMode="Password" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFValidatorConfirmNewPassword" runat="server" Display="Dynamic" ControlToValidate="tbxConfirmNewPassword" ErrorMessage="Confirm new password required" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CMValidatorConfirmNewPassword" Display="Dynamic" ControlToValidate="tbxConfirmNewPassword" ErrorMessage="Passwords do not match" ForeColor="Red" ControlToCompare="tbxNewPassword" runat="server"></asp:CompareValidator>
            <br />
            <br />
            <asp:Button ID="btnPasswordChanged" runat="server" OnClick="btnPasswordChanged_Click" Text="submit" />
            <br />
            <br />
            <asp:Label ID="lblNewPassword" ForeColor="Blue" Visible="false" Text="New password set successfully!" runat="server" ></asp:Label>
        </div>
    </form>
</body>
</html>
