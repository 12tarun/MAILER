<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="composeEmail.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        #divtemplatePreview {
            width: 645px;
            height: 135px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h1>Select Recipients</h1>
    <br />
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="updatePanelCheckbox" runat="server">
        <ContentTemplate>
            <asp:CheckBox ID="cbSelectAll" Text="Select All" OnCheckedChanged="cbSelectAll_CheckedChanged" runat="server" AutoPostBack="true" ToolTip="Check this checkbox to select all categories" />
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
        </ContentTemplate>
    </asp:UpdatePanel>
    <h1>Mail Credentials</h1>
    <asp:Label ID="lbltemplate" runat="server" Text="Select Template"></asp:Label>
    <asp:UpdatePanel ID="updatePanelTemplatePreview" runat="server">
        <ContentTemplate>
            <asp:RadioButtonList AutoPostBack="true" runat="server" ID="rbTemplates" OnSelectedIndexChanged="rbTemplates_SelectedIndexChanged" RepeatLayout="Table" RepeatDirection="Horizontal" RepeatColumns="4"></asp:RadioButtonList>
            <asp:HiddenField ID="hfTemplateCode" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <asp:TextBox ID="tbxMailSubject" runat="server" placeholder="subject"></asp:TextBox>
    <br />
    <asp:TextBox ID="tbxMailBody" runat="server" placeholder="enter mail body" ValidationGroup="mailCredentials" TextMode="MultiLine" Height="267px" Width="450px"></asp:TextBox>
    <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbxMailBody" ErrorMessage="*This field cant be empty" ForeColor="Red"></asp:RequiredFieldValidator>
    <div style="height: 87px; width: 813px">
        <h1>Template Preview</h1>
        <span id="divTemplatePreview" runat="server"></span>
    </div>
    <br />
    <br />
    <br />
    <br />
    <br />
    <asp:TextBox ID="tbxPassword" TextMode="Password" ValidationGroup="mailCredentials" runat="server" placeholder="enter your registered mail's password here" Width="450px"></asp:TextBox>
    <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbxPassword" ErrorMessage="*This field cant be empty" ForeColor="Red"></asp:RequiredFieldValidator>
    <br />
    <asp:Button ID="btnSend" Text="Send" runat="server" OnClick="btnSend_Click" />
    <br />
    <asp:Label ID="lblMailStatus" ForeColor="Blue" runat="server"></asp:Label>
    <script type="text/javascript">
        var templateCode;

        function setHTML()
        {
            var tbxMailBody = document.getElementById('<%= tbxMailBody.ClientID%>').value.replace(/(?:\r\n|\r|\n)/g, '<br />');
            hiddenStatusFlag = document.getElementById('<%= hfTemplateCode.ClientID%>').value.replace("{body}", tbxMailBody);
            document.getElementById('<%= divTemplatePreview.ClientID%>').innerHTML = hiddenStatusFlag;
        }
        window.onload = function () {
            interval = setInterval(setHTML, 100);
        }

    </script>
</asp:Content>
