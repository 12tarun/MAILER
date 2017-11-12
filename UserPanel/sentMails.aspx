<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="sentMails.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="container-fluid child-page">
        <div class="container content txt-style">
            <i class="fa fa-envelope-open" style="font-size:50px" aria-hidden="true"></i>
            <h1>OUTBOX</h1>
    <asp:GridView ID="gvMails" AllowPaging="true" AutoGenerateColumns="False" runat="server" OnPageIndexChanging="gvMails_PageIndexChanging" class="table table-responsive">
        <Columns>
            <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Recipient">
                <ItemTemplate>
                    <%#Eval("Recipient").ToString().Length > 13 ? (Eval("Recipient").ToString().Substring(0,13))+"........": Eval("Recipient") %>
                    <asp:Label ID="lblRecipient" Visible="false" runat="server" Text='<%#Bind("Recipient") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField Visible="false" >
                <ItemTemplate>
                    <asp:Label ID="lblSentMailId" Visible="false" runat="server" Text='<%#Bind("sentMailId") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Subject">
                <ItemTemplate>
                    <%#Eval("Subject").ToString().Length > 20 ? (Eval("Subject").ToString().Substring(0,20))+"........": Eval("Subject") %>
                    <asp:Label ID="lblSubject" Visible="false" runat="server" Text='<%#Bind("Subject") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderStyle-Width="500px" HeaderText="Body">
                <ItemTemplate >
                    <%#Eval("Body").ToString().Length > 125 ? (Eval("Body").ToString().Substring(0,125))+"........": Eval("Body") %>
                    <asp:Label Id="lblBodyValue" Visible="false" Text='<%#Bind("Body") %>' runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="lblTemplateId" runat="server" Text='<%#Bind("templateId") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Date">
                <ItemTemplate>
                    <asp:Label ID="lblDate" runat="server" Text='<%#Bind("Date") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkBtnPreview" OnClick="lnkBtnPreview_Click" Text="Preview" runat="server"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
            </div>
         </div>
</asp:Content>


