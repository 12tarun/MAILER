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
    <div class="container-fluid child-page">
        <div class="row">
            <div class="col-3 sel-rec">
                <h1>Select Recipients</h1>
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="updatePanelCheckbox" runat="server">
                    <ContentTemplate>
                        <h3>
                            <asp:CheckBox ID="cbSelectAll" Text="Select All" OnCheckedChanged="cbSelectAll_CheckedChanged" runat="server" AutoPostBack="true" ToolTip="Check this checkbox to select all categories" /></h3>
                        <br />
                        <asp:Repeater ID="rptrCategory" runat="server">
                            <ItemTemplate>
                                <span>
                                    <h4>
                                        <asp:CheckBox ID="cbCategory" runat="server" OnCheckedChanged="cbCategory_CheckedChanged" AutoPostBack="true" Text='<%# Eval("categoryName") %>' />
                                    </h4>
                                </span>
                                <asp:Repeater ID="rptrRecipient" runat="server">
                                    <ItemTemplate>
                                        <span>
                                            <h4>
                                                <asp:CheckBox ToolTip='<%# Eval("email") %>' runat="server" ID="cbRecipient" OnCheckedChanged="cbRecipient_CheckedChanged" AutoPostBack="true" Text='<%# Eval("name") %>' />
                                                <asp:HiddenField ID="hfRecipientId" Value='<%# Eval("recipientId") %>' runat="server" />
                                            </h4>
                                        </span>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <br />
                            </ItemTemplate>
                        </asp:Repeater>
                    </ContentTemplate>

                </asp:UpdatePanel>
            </div>
            <div class="col-9">
                <div class="row">
                    <div class="col-6 txt-style">
                        <div class="temp-prev">
                            <h1>Template Preview</h1>
                            <span id="divTemplatePreview" runat="server"></span>
                        </div>
                    </div>
                    <div class="col-6 compose-area">
                        <h1>Mail Credentials</h1>
                        <asp:Label ID="lbltemplate" runat="server" Text="Select Template"></asp:Label>
                                <asp:RadioButtonList AutoPostBack="true" runat="server" ID="rbTemplates" OnSelectedIndexChanged="rbTemplates_SelectedIndexChanged" RepeatLayout="Table" RepeatDirection="Horizontal" RepeatColumns="4"></asp:RadioButtonList>
                                <asp:HiddenField ID="hfTemplateCode" runat="server" />
                       
                        <br />
                        <asp:TextBox ID="tbxMailSubject" runat="server" placeholder="subject"></asp:TextBox>
                        <br />
                        <asp:TextBox ID="tbxMailBody" runat="server" placeholder="enter mail body" ValidationGroup="mailCredentials" TextMode="MultiLine" Height="267px" Width="450px"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbxMailBody" ErrorMessage="*This field cant be empty" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <br />
                        <asp:FileUpload ID="fileAttachment" runat="server" AllowMultiple="true" />
                        <br />
                        <br />
                        <asp:TextBox ID="tbxPassword" TextMode="Password" ValidationGroup="mailCredentials" runat="server" placeholder="enter your registered mail's password here" Width="450px"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbxPassword" ErrorMessage="*This field cant be empty" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:Button ID="btnSend" Text="Send" runat="server" OnClick="btnSend_Click" />
                        <br />
                        <asp:Label ID="lblMailStatus" ForeColor="Blue" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../script/jquery-1.11.2.js"></script>
    <script type="text/javascript">
        var templateCode;
        var interval;
        var tbxBody = $('#<%=tbxMailBody.ClientID%>');
        var hfTemplateCode = document
        tbxBody.focus(function () {
            interval = setInterval(setHTML, 100);
        });
        tbxBody.blur(function () {
            clearInterval(interval);
        });
        function setHTML() {
            var tbxMailBody = document.getElementById('<%= tbxMailBody.ClientID%>').value.replace(/(?:\r\n|\r|\n)/g, '<br />');
            hiddenStatusFlag = document.getElementById('<%= hfTemplateCode.ClientID%>').value.replace("{body}", tbxMailBody);
            document.getElementById('<%= divTemplatePreview.ClientID%>').innerHTML = hiddenStatusFlag;
        }
    </script>
</asp:Content>
