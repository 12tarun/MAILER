<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="PreviewEmail.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="emailPreview" runat="server"></div>
    <asp:GridView runat="server" ID="grdFileAttachments">
        <Columns>
            <asp:TemplateField HeaderText="FileName">
                <ItemTemplate>
                    <%# Eval("FileName") %>
                </ItemTemplate>
                
            </asp:TemplateField>
        <asp:TemplateField HeaderText="FileSize">
            <ItemTemplate>
                <%# Eval("FileSize") %>
            </ItemTemplate>
        </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

