<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="PreviewEmail.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="emailPreview" runat="server"></div>
    <asp:GridView runat="server" ID="grdFileAttachments">
        
    </asp:GridView>
</asp:Content>

