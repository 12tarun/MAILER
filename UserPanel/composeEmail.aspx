<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="composeEmail.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        #divtemplatePreview {
            width: 100%;
            max-height: 500px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../scripts/tinymce/tinymce.min.js">
        
    </script>
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
        <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div id="modal-header" class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">SELECT RECIPIENTS</h5>
                        <button type="button" class="close btnstyle" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div id="modal-body" class="modal-body">

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
                                                <asp:CheckBox ID="cbCategory" ForeColor="Black" runat="server" OnCheckedChanged="cbCategory_CheckedChanged" AutoPostBack="true" Text='<%# Eval("categoryName") %>' />

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
                    <div id="" class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>                        
                    </div>
                </div>
            </div>
        </div>
        <%--   <div id="side-menu">
            <h1>Select Recipients</h1>
            
            </>
        </div>
        <div id="openside">
            <i id="open" onclick="open()" class="fa fa-chevron-circle-right" aria-hidden="true">SELECT-RECEPEINT</i>
            <i id="close" onclick="close()" class="fa fa-chevron-circle-left" aria-hidden="true">SELECT-RECEPEINT</i>
        </div>--%>

        <div class="row compose">
            <div class="col-4 txt-style left-side">
                <div class="scroll-area">
                                        <h3>TEXT FIELD</h3>
                    <div class="padding">
                        <asp:TextBox ID="tbxMailSubject" runat="server" Width="80%" placeholder="subject"></asp:TextBox>
                    </div>
                    <asp:Button  class="btnstyle" ID="btnAddRecipientName" runat="server" Text="Add Recipient Name" ToolTip="Corresponding mails will be sent with corresponding names" OnClick="btnAddRecipientName_Click1" />
                    <asp:TextBox ID="tbxMailBody" runat="server" placeholder="enter mail body" ValidationGroup="mailCredentials" TextMode="MultiLine" Height="267px" Width="100%"></asp:TextBox>

                    <div class="padding">
                        <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbxMailBody" ErrorMessage="This field can't be empty" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="padding">
                        <asp:FileUpload ID="fileAttachment" ToolTip="Add Attachments" runat="server" AllowMultiple="true" />
                    </div>
                    <div class="padding">
                        <asp:TextBox ID="tbxPassword" TextMode="Password" ValidationGroup="mailCredentials" runat="server" placeholder="enter your registered mail's password here" Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="mailCredentials" ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbxPassword" ErrorMessage="This field can't be empty" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <asp:Button ID="btnSend" class="btn btn-primary btnstyle" Text="Send" runat="server" OnClick="btnSend_Click" />
                        <button type="button" class="btn btnstyle btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg" style="width: 150px">
                            Select Recipients
                        </button>
                    </div>
                    <div id="labelStatusAlert" style="padding-top: 20px"></div>
                    <asp:Label ID="lblMailStatus" ForeColor="Blue" runat="server"></asp:Label>
                    <asp:HiddenField ID="hfMailBody" runat="server" />
                </div>
            </div>
            <div class="col-4 txt-style">
                <div class="temp-prev" style="text-align:left">
                        <h1>Template Preview</h1>
                    <div class="temp-area">
                        <span id="divTemplatePreview" runat="server"></span>
                    </div>
                </div>
            </div>


            <div class="col-4 txt-style right-side">
                <div class="scroll-area">
                        <h3>SELECT TEMPELATE</h3>
                    <asp:label id="lbltemplate" runat="server"></asp:label>
                    <asp:radiobuttonlist autopostback="true" runat="server" id="rbTemplates" onselectedindexchanged="rbTemplates_SelectedIndexChanged" repeatlayout="Table" repeatdirection="Horizontal" repeatcolumns="1"></asp:radiobuttonlist>
                    <asp:hiddenfield id="hfTemplateCode" runat="server" />

                    <div runat="server" id="accordion" role="tablist">
                        <div class="card">
                            <div class="card-header" role="tab" id="headingOne">
                                <h5>
                                    <a data-toggle="collapse" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">SELECT HEADER
                                    </a>
                                </h5>
                            </div>

                            <div id="collapseOne" class="collapse show" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordion">
                                <div class="card-body">
                                    <img style="width:100%" onclick="selecth(event)" src="https://imgur.com/g5jMshb.png" />
                                    <img style="width:100%" onclick="selecth(event)" src="https://imgur.com/paNU89v.png" />
                                    <img style="width:100%" onclick="selecth(event)" src="" />
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" role="tab" id="headingTwo">
                                <h5 class="mb-0">
                                    <a class="collapsed" data-toggle="collapse" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">SELECT FOOTER
                                    </a>
                                </h5>
                            </div>
                            <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo" data-parent="#accordion">
                                <div class="card-body">
                                    <img style="width:100%" onclick="selectf(event)" src="https://imgur.com/DeXPNzz.png" />
                                    <img style="width:100%" onclick="selectf(event)" src="https://imgur.com/knGsWV1.png" />
                                    <img style="width:100%" onclick="selectf(event)" src="https://imgur.com/C9p0Px4.png" />
                                    <img style="width:100%" onclick="selectf(event)" src="https://imgur.com/Vhc1DV5.png" />
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" role="tab" id="headingThree">
                                <h5 class="mb-0">
                                    <a class="collapsed" data-toggle="collapse" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">SELECT BACKGROUND
                                    </a>
                                </h5>
                            </div>
                            <div id="collapseThree" class="collapse" role="tabpanel" aria-labelledby="headingThree" data-parent="#accordion">
                                <div class="card-body">
                                    <img style="width:100%" onclick="selectb(event)" src="https://imgur.com/gCmf51d.png" />
                                    <br />
                                    <br />
                                    <img style="width:100%" onclick="selectb(event)" src="https://imgur.com/jpRK6bX.png" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../script/jquery-1.11.2.js"></script>
    <script type="text/javascript">
        //$(document).on('click', '.dropdown-menu', function (e) {
        //    console.log("hello");
        //    e.stopPropagation(); // it will not propagate the action to parent for closing
        //});mceu_51-inp
        var interval;
        tinymce.init({
            selector: 'textarea',
            height: 180,
            theme: 'modern',
            init_instance_callback: function (editor) {
                editor.on('focus', function (e) {
                    interval = setInterval(setHTML, 100);
                });
                editor.on('blur', function (e) {
                    clearInterval(interval);
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
        function setHTML() {
            var previousBody = tbxBody;
            var tbxBody = tinyMCE.activeEditor.getContent({ format: 'html' });
            templateCode = templateCode.replace(previousBody, tbxBody);
            var displayCode = templateCode.replace("{body}", tbxBody);
            document.getElementById('<%= divTemplatePreview.ClientID%>').innerHTML = displayCode;
            document.getElementById('<%= hfMailBody.ClientID%>').value = templateCode;
        }
        var selhid, selfid, selbid;
        var templateCode = document.getElementById('<%= hfTemplateCode.ClientID%>').value;
        function selecth(eheader) {
            selprevhID = selhid;
            selhid = eheader.target.src;
            templateCode = templateCode.replace("{header}", selhid);
            templateCode = templateCode.replace(selprevhID, selhid);
            document.getElementById('<%= divTemplatePreview.ClientID%>').innerHTML = templateCode;
        }
        function selectf(efooter) {
            selprevfId = selfid;
            selfid = efooter.target.src;
            var tbxBody = tinyMCE.activeEditor.getContent({ format: 'html' });
            templateCode = templateCode.replace("{footer}", selfid);
            templateCode = templateCode.replace(selprevfId, selfid);
            document.getElementById('<%= divTemplatePreview.ClientID%>').innerHTML = templateCode;
        }
        function selectb(ebackground) {
            selprevbID = selbid;
            selbid = ebackground.target.src;
            templateCode = templateCode.replace("{background}", selbid);
            templateCode = templateCode.replace(selprevbID, selbid);
            document.getElementById('<%= divTemplatePreview.ClientID%>').innerHTML = templateCode;
        }


    </script>
</asp:Content>
