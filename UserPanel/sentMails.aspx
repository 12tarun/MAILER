<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="sentMails.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <asp:GridView ID="gvMails" AllowPaging="true" AutoGenerateColumns="False" runat="server" OnPageIndexChanging="gvMails_PageIndexChanging">

        <Columns>
            <asp:TemplateField HeaderText="Recipient" ItemStyle-Width="150px">
                <ItemTemplate>
                    <%#Eval("Recipient").ToString().Length > 13 ? (Eval("Recipient").ToString().Substring(0,13))+" ......": Eval("Recipient") %>
                    <asp:Label ID="lblRecipient" Visible="false" runat="server" Text='<%#Bind("Recipient") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="lblSentMailId" runat="server" Text='<%# Eval("sentMailId") %>' Visible="false"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Subject" ItemStyle-Width="220px">
                <ItemTemplate>
                    <%#Eval("Subject").ToString().Length > 20 ? (Eval("Subject").ToString().Substring(0,20))+" ......": Eval("Subject") %>
                    <asp:Label ID="lblSubject" Visible="false" runat="server" Text='<%#Bind("Subject") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Body" ItemStyle-Width="900px">
                <ItemTemplate>
                    <%#Eval("Body").ToString().Length > 125 ? (Eval("Body").ToString().Substring(0,125))+" ......": Eval("Body") %>
                    <asp:Label ID="lblBodyValue" Visible="false" Text='<%#Bind("Body") %>' runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="lblTemplateId" runat="server" Text='<%#Bind("templateId") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Date" ItemStyle-Width="150px">
                <ItemTemplate>
                    <asp:Label ID="lblDate" runat="server" Text='<%#Bind("Date") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField ItemStyle-Width="100px">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkBtnPreview" OnClick="lnkBtnPreview_Click" Text="Preview" runat="server"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

