<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="templateSettings.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <asp:Button ID="btnTemplateUpload" runat="server" Text="Upload" OnClick="btnTemplateUpload_Click" />
     <asp:FileUpload ID="FileUploadTemplate" runat="server" />
    <br />
    <asp:Label ID="lblStatus" runat="server"></asp:Label>
</asp:Content>

