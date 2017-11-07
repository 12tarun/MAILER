<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="sentMails.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:GridView ID="gvMails" OnRowDataBound="gvMails_RowDataBound"  AutoGenerateColumns="False" runat="server">
        <Columns>
            <asp:TemplateField HeaderText="Recipient">
                <ItemTemplate>
                    <asp:Label ID="lblRecipient" runat="server" Text='<%#Bind("Recipient") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HiddenField ID="hfSentMailId" runat="server" Value='<%# Eval("sentMailId") %>' />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Subject">
                <ItemTemplate>
                    <asp:Label ID="lblSubject" runat="server" Text='<%#Bind("Subject") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Body">
                <ItemTemplate>
                    <asp:Label ID="lblBody" runat="server" Text='<%#Bind("Body") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField>
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
</asp:Content>

