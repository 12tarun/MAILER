<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="composeEmail.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <script>
   </script>
    <h1>Select Recipients</h1>
    <br />
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="updatePanelCheckbox" runat="server"><ContentTemplate>
    <asp:CheckBox ID="cbSelectAll" Text="Select All" OnCheckedChanged="cbSelectAll_CheckedChanged" runat="server" AutoPostBack="true" ToolTip="Check this checkbox to select all of the following" />
    <br />
    <asp:Repeater ID="rptrCategory" runat="server">
        <ItemTemplate>

            <asp:CheckBox ID="cbCategory" runat="server" OnCheckedChanged="cbCategory_CheckedChanged" AutoPostBack="true" Text='<%# Eval("categoryName") %>' />
            <asp:Repeater ID="rptrRecipient" runat="server">
                <ItemTemplate>
                    <asp:CheckBox ToolTip='<%# Eval("email") %>' runat="server" ID="cbRecipient" OnCheckedChanged="cbRecipient_CheckedChanged" AutoPostBack="true" Text='<%# Eval("name") %>' />
                    <asp:HiddenField ID="hfRecipientId" Value='<%# Eval("recipientId") %>' runat="server" />
                </ItemTemplate>
            </asp:Repeater>
            <br />
        </ItemTemplate>
    </asp:Repeater>
        </ContentTemplate></asp:UpdatePanel>
    <h1>Mail Credentials</h1>
    <asp:Label ID="lbltemplate" runat="server" Text="Select Template"></asp:Label>
    <asp:RadioButtonList AutoPostBack="true" runat="server"  ID="rbTemplates" OnSelectedIndexChanged="rbTemplates_SelectedIndexChanged" RepeatLayout="Table" RepeatDirection="Horizontal" RepeatColumns="4"></asp:RadioButtonList>
    <br />

    <asp:TextBox ValidationGroup="mailCredentials" ID="tbxMailSubject" runat="server" placeholder="subject"></asp:TextBox>
    <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RFVtbxMailSubject" runat="server" ControlToValidate="tbxMailSubject" ErrorMessage="*This field cant be empty" ForeColor="Red"></asp:RequiredFieldValidator>
    <br />
    <asp:TextBox ID="tbxMailBody" runat="server" placeholder="enter mail body" ValidationGroup="mailCredentials" TextMode="MultiLine" Height="267px" Width="450px"></asp:TextBox>
    <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbxMailBody" ErrorMessage="*This field cant be empty" ForeColor="Red"></asp:RequiredFieldValidator>
    <iframe id="I1" runat="server"  name="I1"></iframe>
  

    <br />
    <asp:TextBox ID="tbxPassword" TextMode="Password" ValidationGroup="mailCredentials" runat="server" placeholder="enter your registered mail's password here" Width="450px"></asp:TextBox>
     <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbxPassword" ErrorMessage="*This field cant be empty" ForeColor="Red"></asp:RequiredFieldValidator>    
    <br />
    <asp:Button ID="btnSend" Text="Send" runat="server" OnClick="btnSend_Click" />
    <br />
    <asp:Label ID="lblMailStatus" runat="server"></asp:Label>
</asp:Content>
