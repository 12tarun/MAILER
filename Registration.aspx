<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="tbxFullName" runat="server" placeholder="Full Name"></asp:TextBox>
            <asp:RequiredFieldValidator ControlToValidate="tbxFullName" Display="Dynamic" ForeColor="Red" ID="RFValidatorFullName" runat="server" ErrorMessage="Full name required"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:TextBox ID="tbxUsername" runat="server" placeholder="Username" AutoPostBack="true" OnTextChanged="tbxUsername_TextChanged"></asp:TextBox>
            <asp:RequiredFieldValidator Display="Dynamic" ID="RFValidatorUsername" ControlToValidate="tbxUsername" runat="server" ErrorMessage="Username required" ForeColor="red"></asp:RequiredFieldValidator>
            <asp:Label ID="lblInvalidUsername" runat="server" Display="Dynamic" ForeColor="Red" ></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="tbxEmail" runat="server" placeholder="Email" AutoPostBack="true" OnTextChanged="tbxEmail_TextChanged"></asp:TextBox>
            <asp:RequiredFieldValidator Display="Dynamic" ID="RFValidatorEmail" runat="server" ControlToValidate="tbxEmail" ErrorMessage="Email id required" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator Display="Dynamic" ID="REValidatorEmail" runat="server" ForeColor="Red" ErrorMessage="Invalid email id" ControlToValidate="tbxEmail" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" />
            <asp:Label ID="lblInvalidEmail" runat="server" Display="Dynamic" ForeColor="Red" ></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="tbxPassword" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFValidatorPassword" runat="server" Display="Dynamic" ControlToValidate="tbxPassword" ErrorMessage="Password required" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="REValidatorPassword" runat="server" Display="Dynamic" Font-Size="small" ErrorMessage="Password should contain atleast one digit, one alphabet and minimum length 6." ControlToValidate="tbxPassword" ForeColor="Red" ValidationExpression="^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$" />
            <br />
            <br />
            <asp:TextBox ID="tbxComfrimPassword" runat="server" placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFValidatorConPassword" runat="server" Display="Dynamic" ControlToValidate="tbxComfrimPassword" ErrorMessage="Confirm password required" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CMValidatorConfirmPassword" Display="Dynamic" ControlToValidate="tbxComfrimPassword" ErrorMessage="Passwords do not match" ForeColor="Red" ControlToCompare="tbxPassword" runat="server"></asp:CompareValidator>
            <br />
            <br />
            <asp:Button ID="btnSubmit" Text="submit" runat="server" OnClick="btnSubmit_Click" />
        </div>
    </form>
</body>
</html>
