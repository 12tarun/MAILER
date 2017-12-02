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
    <script src="../scripts/tinymce/tinymce.min.js"></script>
  <script>
//      tinymce.init({
//    selector: 'textarea',
//    height: 200,
//    setup: function (editor) {
//        editor.on('focus', function (e) {
//            setInterval(setHTML, 100);
//        });
//    }
//});
    </script>

    <div class="container-fluid child-page">
        <div class="row">
            <div class="col-3 sel-rec">
                
                <h1>Select Recipients</h1>
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="updatePanelCheckbox" runat="server">
                    <ContentTemplate>
                        <h3>
                            <asp:CheckBox ID="cbSelectAll" Text="Select All" OnCheckedChanged="cbSelectAll_CheckedChanged" runat="server" AutoPostBack="true" ToolTip="Check this checkbox to select all categories" />
                        </h3>
                        <br />
                        <div>
                            <asp:Repeater ID="rptrCategory" runat="server">
                                <ItemTemplate>

                                    <div class="dropdown">
                                        <asp:CheckBox ID="cbCategory" ForeColor="White" runat="server" OnCheckedChanged="cbCategory_CheckedChanged" AutoPostBack="true" Text='<%# Eval("categoryName") %>' />

                                        <span id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                           <i class="fa fa-caret-down" aria-hidden="true"></i>
                                        </span>
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            
                                                <ul>
                                                    <asp:Repeater ID="rptrRecipient" runat="server">
                                                        <ItemTemplate>
                                                            <a class="dropdown-item" href="#">


                                                                <asp:CheckBox ToolTip='<%# Eval("email") %>' runat="server" ID="cbRecipient" OnCheckedChanged="cbRecipient_CheckedChanged" AutoPostBack="false" Text='<%# Eval("name") %>' />
                                                                <asp:HiddenField ID="hfRecipientId" Value='<%# Eval("recipientId") %>' runat="server" />


                                                            </a>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </ul>
                                            
                                        </div>
                                    </div>
                                    <br />
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>


            <div class="col-9">
                <div class="row">
                    <div class="col-6 txt-style">
                        <div class="temp-prev">
                            <div id="labelStatusAlert" style="padding-top:0px"></div>
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
                        <asp:TextBox ID="tbxMailSubject" runat="server" Width="300px" onkeydown="return (event.keyCode!=13);" placeholder="subject"></asp:TextBox>
                        <br />
                        <br />
                        <asp:Button runat="server" Text="Add Recipient Name" ID="btnAddRecipientName" OnClick="btnAddRecipientName_Click" Width="180px" class="btnstyle" />
                        <br />
                        <asp:TextBox ID="tbxMailBody" runat="server" placeholder="enter mail body" ValidationGroup="mailCredentials" TextMode="MultiLine" Height="267px" Width="520px"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbxMailBody" ErrorMessage="This field can't be empty" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />
                        <asp:FileUpload ID="fileAttachment" ToolTip="Add Attachments" runat="server" AllowMultiple="true" />
                        <br />
                        <br />
                        <asp:TextBox ID="tbxPassword" TextMode="Password" ValidationGroup="mailCredentials" runat="server" placeholder="enter your registered email's password here" Width="310px"></asp:TextBox>
                        <asp:Button ID="btnSend" class="btnstyle" Text="Send" runat="server" OnClick="btnSend_Click" />
                        <br />
                        <asp:RequiredFieldValidator Display="Dynamic" ValidationGroup="mailCredentials" ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbxPassword" ErrorMessage="This field can't be empty" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:Label ID="lblMailStatus" ForeColor="Blue" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <br />
    <br />
    <script src="../script/jquery-1.11.2.js"></script>
    <script type="text/javascript">
        function setHTML() {
            var tbxBody = tinyMCE.activeEditor.getContent({ format: 'html' });
            hiddenStatusFlag = document.getElementById('<%= hfTemplateCode.ClientID%>').value.replace("{body}", tbxBody);
            document.getElementById('<%= divTemplatePreview.ClientID%>').innerHTML = hiddenStatusFlag;
        }
        //$(document).on('click', '.dropdown-menu', function (e) {
        //    console.log("hello");
        //    e.stopPropagation(); // it will not propagate the action to parent for closing
        //});
          
        tinymce.init({
            selector: 'textarea',
            height: 180,
            theme: 'modern',
            setup: function (editor) {
                editor.on('focus', function (e) {
            
                    setInterval(setHTML, 100);
                });
            },
            plugins: [
    "advlist autolink lists link image charmap print preview anchor",
    "searchreplace visualblocks code fullscreen",
    "insertdatetime media table contextmenu paste"
            ],
          //  plugins: 'print preview fullpage powerpaste searchreplace autolink directionality advcode visualblocks visualchars fullscreen image link media template codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists textcolor wordcount tinymcespellchecker a11ychecker imagetools mediaembed  linkchecker contextmenu colorpicker textpattern help',
            toolbar1: 'formatselect | bold italic strikethrough forecolor backcolor | link | alignleft aligncenter alignright alignjustify  | numlist bullist outdent indent  | removeformat',
            image_advtab: true,
            templates: [
              { title: 'Test template 1', content: 'Test 1' },
              { title: 'Test template 2', content: 'Test 2' }
            ],
            content_css: [
              '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
              '//www.tinymce.com/css/codepen.min.css'
            ]
  
        });
    
        $('.dropdown-menu a.dropdown-item').click(function (e) {
            e.stopPropagation();
        });
        //$(document).ready(function () {
        //    $("ul.dropdown-menu input[type=checkbox]").each(function () {
        //        $(this).change(function () {
        //            var line = "";
        //            $("ul.dropdown-menu input[type=checkbox]").each(function () {
        //                if ($(this).is(":checked")) {
        //                    line += $("+ span", this).text() + ";";
        //                }
        //            });
        //            $("input.form-control").val(line);
        //        });
        //    });
        //});
    </script>
</asp:Content>
