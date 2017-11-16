<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="PreviewEmail.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid child-page">
        <div class="container content txt-style">
            <p style="float:left"> To: > < </p>
            <asp:Repeater ID="rptrMailRecipientName" runat="server">
                <ItemTemplate>
                    <div style="float:left">
                        <asp:Label ID="lblMailRecipientName" ForeColor="White" Text='<%# string.Concat(Eval("name"), "> <") %>' ToolTip='<%# Eval("email") %>'  runat="server" ></asp:Label>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <br />
            <br />
            <div class="row">
                <div class="col-5">
                    <div id="emailPreview" runat="server"></div>
                </div>
                <div class="col-7">
                    <asp:GridView runat="server" class="table table-responsive" ID="grdFileAttachments">
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

