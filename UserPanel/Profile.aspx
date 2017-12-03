<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid child-page">
        <div class="container content txt-style">
            <div id="profilepicAlert"></div>
            <div id="usernameAlert"></div>
            <br />
            <i class="fa fa-user" style="font-size: 50px" aria-hidden="true"></i>
            <h1>PROFILE</h1>
            <h2>Full Name</h2>
            <asp:Label ID="lblEditFullName" Font-Size="Large" runat="server"></asp:Label>
            <br />
            <asp:TextBox ID="tbxEditFullName" runat="server" placeholder="Enter new fullname" Visible="false"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator ID="RFValidatorEditFullname" runat="server" Display="Dynamic" ValidationGroup="editFullName" ControlToValidate="tbxEditFullName" ErrorMessage="This field can't be empty" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <asp:Button ID="btnEnterFullName" class="btnstyle" OnClick="btnEnterFullName_Click" Visible="false" Text="Update" runat="server" />
            <br />
            <asp:Button ID="btnEditFullName" class="btnstyle" Text="Edit" runat="server" OnClick="btnEditFullName_Click" />
            <br />
            <br />
            <h2>Profile Picture</h2>
            <asp:Image ID="imgEditProfilePicture" Width="200px" Height="250px" runat="server" />
            <br />
            <br />
            <asp:FileUpload ID="fileUploadDP" runat="server" />
            <asp:Button ID="btnDP" class="btnstyle" runat="server" Text="Edit" OnClick="btnDP_Click" />
            <br />
            <asp:Label ID="lblWrongExtension" Text="Only .jpg or .png file is acceptable." Visible="false" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <br />
            <h2>Username</h2>
            <asp:Label ID="lblEditUsername" Font-Size="Large" runat="server"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="tbxEditUsername" runat="server" placeholder="Enter new username" Visible="false"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator ID="RFValidatorEditUsername" runat="server" Display="Dynamic" ValidationGroup="editUsername" ControlToValidate="tbxEditUsername" ErrorMessage="This field can't be empty" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:Label ID="lblInvalidUsername" Visible="false" ForeColor="Red" Text="Username is already used" runat="server"></asp:Label>
            <br />
            <asp:Button ID="btnEditUsername" class="btnstyle" Text="Edit" OnClick="btnEditUsername_Click" runat="server" />
        </div>
    </div>
</asp:Content>

