<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>SIGN UP</h2>
        <div>
            <asp:ScriptManager ID="SMCapcha" runat="server"></asp:ScriptManager>
            <asp:TextBox ID="tbxFullname" runat="server" ValidationGroup="register" placeholder="Full Name"></asp:TextBox>
            <asp:RequiredFieldValidator ControlToValidate="tbxFullName" ValidationGroup="register" Display="Dynamic" ForeColor="Red" ID="RFValidatorFullName" runat="server" ErrorMessage="Full name required"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:TextBox ID="tbxUsername" runat="server" ValidationGroup="register" placeholder="Username" AutoPostBack="true" OnTextChanged="tbxUsername_TextChanged"></asp:TextBox>
            <asp:RequiredFieldValidator Display="Dynamic" ID="RFValidatorUsername" ValidationGroup="register" ControlToValidate="tbxUsername" runat="server" ErrorMessage="Username required" ForeColor="red"></asp:RequiredFieldValidator>
            <asp:Label ID="lblInvalidUsername" runat="server" Display="Dynamic" ForeColor="Red"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="tbxEmail" runat="server" ValidationGroup="register" placeholder="Email" AutoPostBack="true" OnTextChanged="tbxEmail_TextChanged"></asp:TextBox>
            <asp:RequiredFieldValidator Display="Dynamic" ID="RFValidatorEmail" ValidationGroup="register" runat="server" ControlToValidate="tbxEmail" ErrorMessage="Email id required" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator Display="Dynamic" ID="REValidatorEmail" runat="server" ValidationGroup="register" ForeColor="Red" ErrorMessage="Invalid email id" ControlToValidate="tbxEmail" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" />
            <asp:Label ID="lblInvalidEmail" runat="server" Display="Dynamic" ForeColor="Red"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="tbxPassword" runat="server" placeholder="Password" ValidationGroup="register" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFValidatorPassword" runat="server" Display="Dynamic" ValidationGroup="register" ControlToValidate="tbxPassword" ErrorMessage="Password required" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="REValidatorPassword" runat="server" Display="Dynamic" ValidationGroup="register" Font-Size="small" ErrorMessage="Password should contain atleast one digit, one alphabet and minimum length 6." ControlToValidate="tbxPassword" ForeColor="Red" ValidationExpression="^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$" />
            <br />
            <br />
            <asp:TextBox ID="tbxComfrimPassword" runat="server" placeholder="Confirm Password" ValidationGroup="register" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFValidatorConPassword" runat="server" Display="Dynamic" ValidationGroup="register" ControlToValidate="tbxComfrimPassword" ErrorMessage="Confirm password required" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CMValidatorConfirmPassword" Display="Dynamic" ValidationGroup="register" ControlToValidate="tbxComfrimPassword" ErrorMessage="Passwords do not match" ForeColor="Red" ControlToCompare="tbxPassword" runat="server"></asp:CompareValidator>
            <br />
            <br />
            <asp:UpdatePanel ID="UPCaptcha" runat="server">
                <ContentTemplate>
                    <asp:Image ID="imgCaptcha" Width="100px" Height="50px" runat="server" />
                    <br />
                    <asp:Button ID="btnRefresh" runat="server" Text="Refresh" OnClick="btnRefresh_Click" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <br />
            <asp:TextBox ID="tbxCaptcha" runat="server" placeholder="Enter above captcha"></asp:TextBox>
            <asp:Label ID="lblIncorrectCaptcha" runat="server" Display="Dynamic" ForeColor="Red"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnSubmit" Text="submit" runat="server" OnClick="btnSubmit_Click" />
        </div>
        <br />
        <br />
        <h2>LOGIN</h2>
        <div>
            <asp:TextBox ID="tbxLoginEmail" runat="server" ValidationGroup="login" placeholder="Enter Email Id"></asp:TextBox>
            <asp:RequiredFieldValidator Display="Dynamic" ID="RFValidatorLoginEmail" ValidationGroup="login" runat="server" ErrorMessage="Please enter an email id" ControlToValidate="tbxLoginEmail" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:TextBox ID="tbxLoginPassword" runat="server" ValidationGroup="login" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
            <asp:RequiredFieldValidator Display="Dynamic" ID="RFValidatorLoginPassword" ValidationGroup="login" runat="server" ControlToValidate="tbxLoginPassword" ErrorMessage="Please enter the password" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" />
            <br />
            <br />
            <asp:Label ID="lblWarning" runat="server" Display="Dynamic" ForeColor="Red" ></asp:Label>
        </div>
    </form>
</body>
</html>
