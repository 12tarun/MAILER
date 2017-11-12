<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid child-page">
        <div class="container content txt-style">
            <i class="fa fa-user" style="font-size:50px" aria-hidden="true"></i>
            <h1>PROFILE</h1>
            <h2>Full Name</h2>
            <asp:label id="lblEditFullName" font-size="Large" runat="server"></asp:label>
            <br />
            <asp:textbox id="tbxEditFullName" runat="server" placeholder="Enter new fullname" visible="false"></asp:textbox>
            <br />
            <asp:RequiredFieldValidator ID="RFValidatorEditFullname" runat="server" Display="Dynamic" ValidationGroup="editFullName" ControlToValidate="tbxEditFullName" ErrorMessage="This field can't be empty" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <asp:button id="btnEnterFullName" class="btnstyle" onclick="btnEnterFullName_Click" visible="false" text="Update" runat="server" />
            <br />
            <asp:button id="btnEditFullName" class="btnstyle" text="Edit" runat="server" onclick="btnEditFullName_Click" />
            <br />
            <br />
            <h2>Profile Picture</h2>
            <asp:image id="imgEditProfilePicture" width="200px" height="250px" runat="server" />
            <br />
            <br />
            <asp:fileupload id="fileUploadDP" runat="server" />
            <asp:button id="btnDP" class="btnstyle" runat="server" text="Edit" onclick="btnDP_Click" />
            <br />
            <br />
            <asp:label id="lblWrongExtension" text="Only .jpg or .png file is acceptable." visible="false" runat="server" forecolor="Red"></asp:label>
            <br />
            <br />
            <h2>Username</h2>
            <asp:label id="lblEditUsername" font-size="Large" runat="server"></asp:label>
            <br />
            <br />
            <asp:textbox id="tbxEditUsername" runat="server" placeholder="Enter new username" visible="false"></asp:textbox>
            <br />
            <asp:RequiredFieldValidator ID="RFValidatorEditUsername" runat="server" Display="Dynamic" ValidationGroup="editUsername" ControlToValidate="tbxEditUsername" ErrorMessage="This field can't be empty" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:label id="lblInvalidUsername" visible="false" forecolor="Red" text="Username is already used" runat="server"></asp:label>
            <br />
            <asp:button id="btnEditUsername" class="btnstyle" text="Edit" onclick="btnEditUsername_Click" runat="server" />
        </div>
    </div>
</asp:Content>

