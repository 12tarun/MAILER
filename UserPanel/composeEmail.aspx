<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="composeEmail.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        #divtemplatePreview {
            width: 645px;
            height: 135px;
        }

/*.dropdown {
  position: absolute;
  top:50%;
  transform: translateY(-50%);
}

a {
  color: #fff;
}

.dropdown dd,
.dropdown dt {
  margin: 0px;
  padding: 0px;
}

.dropdown ul {
  margin: -1px 0 0 0;
}

.dropdown dd {
  position: relative;
}

.dropdown a,
.dropdown a:visited {
  color: #fff;
  text-decoration: none;
  outline: none;
  font-size: 12px;
}

.dropdown dt a {
  background-color: #4F6877;
  display: block;
  padding: 8px 20px 5px 10px;
  min-height: 25px;
  line-height: 24px;
  overflow: hidden;
  border: 0;
  width: 272px;
}

.dropdown dt a span,
.multiSel span {
  cursor: pointer;
  display: inline-block;
  padding: 0 3px 2px 0;
}

.dropdown dd ul {
  background-color: #4F6877;
  border: 0;
  color: #fff;
  display: none;
  left: 0px;
  padding: 2px 15px 2px 5px;
  position: absolute;
  top: 2px;
  width: 280px;
  list-style: none;
  height: 100px;
  overflow: auto;
}

.dropdown span.value {
  display: none;
}

.dropdown dd ul li a {
  padding: 5px;
  display: block;
}

.dropdown dd ul li a:hover {
  background-color: #fff;
}*/

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
                        <dl class="dropdown">
                            <asp:Repeater ID="rptrCategory" runat="server">
                                <ItemTemplate>
                                    <dt>
                                        <a href="#">
                                            <span class="hida">
                                                <asp:CheckBox ID="cbCategory" ForeColor="White" runat="server" OnCheckedChanged="cbCategory_CheckedChanged" AutoPostBack="true" Text='<%# Eval("categoryName") %>' />
                                            </span>
                                            <p class="multiSel"></p>
                                        </a>
                                    </dt>
                                    <dd>
                                        <div class="mutliSelect">
                                            <ul>
                                                <asp:Repeater ID="rptrRecipient" runat="server">
                                                    
                                                    <ItemTemplate>
                                                        <li>
                                                            <asp:CheckBox ToolTip='<%# Eval("email") %>' runat="server" ID="cbRecipient" OnCheckedChanged="cbRecipient_CheckedChanged" AutoPostBack="true" Text='<%# Eval("name") %>' />
                                                            <asp:HiddenField ID="hfRecipientId" Value='<%# Eval("recipientId") %>' runat="server" />
                                                        </li>                                                     
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ul>
                                        </div>
                                        <br />
                                </ItemTemplate>
                            </asp:Repeater>
                        </dl>
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
                        <asp:RadioButtonList AutoPostBack="true"  runat="server" ID="rbTemplates"  OnSelectedIndexChanged="rbTemplates_SelectedIndexChanged" RepeatLayout="Table" RepeatDirection="Horizontal" RepeatColumns="4"></asp:RadioButtonList>
                        <asp:HiddenField ID="hfTemplateCode" runat="server" />

                        <br />
                        <asp:TextBox ID="tbxMailSubject" runat="server" Width="300px" placeholder="subject"></asp:TextBox>
                        <br />
                        <br />
                        <%--<asp:Label ID="lblSummernote" runat="server" Text="Image" AssociatedControlID="txtSummernote" CssClass="control-label col-md-3"></asp:Label>--%>
                        <asp:TextBox ID="tbxMailBody" runat="server" placeholder="enter mail body" ValidationGroup="mailCredentials" TextMode="MultiLine" Height="267px" Width="520px"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbxMailBody" ErrorMessage="This field can't be empty" ForeColor="Red"></asp:RequiredFieldValidator>
                        <%--  <asp:Label ID="lblSum" runat="server" Text="Summernote"></asp:Label>--%>
                        <br />
                        <br />
                        <asp:FileUpload ID="fileAttachment" ToolTip="Add Attachments" runat="server" AllowMultiple="true" />
                        <br />
                        <br />
                        <asp:TextBox ID="tbxPassword" TextMode="Password" ValidationGroup="mailCredentials" runat="server" placeholder="enter your registered mail's password here" Width="300px"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbxPassword" ErrorMessage="This field can't be empty" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:Button ID="btnSend" class="btnstyle" Text="Send" runat="server" OnClick="btnSend_Click" />
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

        $(".dropdown dt a").on('click', function () {
            $(".dropdown dd ul").slideToggle('fast');
        });

        $(".dropdown dd ul li a").on('click', function () {
            $(".dropdown dd ul").hide();
        });

        function getSelectedValue(id) {
            return $("#" + id).find("dt a span.value").html();
        }

        $(document).bind('click', function (e) {
            var $clicked = $(e.target);
            if (!$clicked.parents().hasClass("dropdown")) $(".dropdown dd ul").hide();
        });

        $('.mutliSelect input[type="checkbox"]').on('click', function () {

            var title = $(this).closest('.mutliSelect').find('input[type="checkbox"]').val(),
              title = $(this).val() + ",";

            if ($(this).is(':checked')) {
                var html = '<span title="' + title + '">' + title + '</span>';
                $('.multiSel').append(html);
                $(".hida").hide();
            } else {
                $('span[title="' + title + '"]').remove();
                var ret = $(".hida");
                $('.dropdown dt a').append(ret);

            }
        });
    </script>
    <%--    <script src="../script/jquery-1.11.2.js"></script>
    <script>
        $(function () {
            // Set up your summernote instance
            $("#<%= tbxMailBody.ClientID %>").summernote();
            focus: true
            // When the summernote instance loses focus, update the content of your <textarea>
            $("#<%= tbxMailBody.ClientID %>").on('summernote.blur', function () {
                $('#<%= tbxMailBody.ClientID %>').html($('#<%= tbxMailBody.ClientID %>').summernote('code'));
           });
        });
    </script>
    <script type="text/javascript">
        function funcMyHtml() {
            debugger;
            document.getElementById("#<%= tbxMailBody.ClientID %>").value = $('#<%= tbxMailBody.ClientID %>').summernote('code');
        }
    </script>--%>
</asp:Content>
