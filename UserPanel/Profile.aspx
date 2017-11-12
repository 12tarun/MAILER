<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h2>Full Name
    </h2>
    <asp:Label ID="lblEditFullName" Font-Size="Large" runat="server"></asp:Label>
    <br />
    <br />
    <asp:TextBox ID="tbxEditFullName" runat="server" placeholder="Enter new fullname" Visible="false"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvFullname" runat="server" ControlToValidate="tbxEditFullName" ErrorMessage="*Enter a name" ForeColor="Red"></asp:RequiredFieldValidator>
    <asp:Button ID="btnEnterFullName" OnClick="btnEnterFullName_Click" Visible="false" Text="Update" runat="server" />
    <br />
    <asp:Button ID="btnEditFullName" Text="Edit" runat="server" OnClick="btnEditFullName_Click" />
    <br />
    <br />
    <h2>Profile Picture
    </h2>
    <asp:Image ID="imgEditProfilePicture" Width="200px" Height="250px" runat="server" />
    <br />
    <br />
    <asp:FileUpload ID="fileUploadDP" runat="server" />
    <asp:Button ID="btnDP" runat="server" Text="Edit" OnClick="btnDP_Click" />
    <br />
    <br />
    <asp:Label ID="lblWrongExtension" Text="Only .jpg or .png file is acceptable." Visible="false" runat="server" ForeColor="Red"></asp:Label>
    <br />
    <br />
        <h2>Username
    </h2>
    <asp:Label ID="lblEditUsername" Font-Size="Large" runat="server"></asp:Label>
    <br />
    <br />
    <asp:TextBox ID="tbxEditUsername" runat="server" placeholder="Enter new username" OnTextChanged="tbxEditUsername_TextChanged" Visible="false"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbxEditUsername" ErrorMessage="*Enter a name" ForeColor="Red"></asp:RequiredFieldValidator>
    <asp:Label ID="lblInvalidUsername" Visible="false" ForeColor="Red" Text="Username is already used" runat="server"></asp:Label>
    <br />
    <asp:Button ID="btnEditUsername" Text="Edit" OnClick="btnEditUsername_Click" runat="server" />
</asp:Content>

