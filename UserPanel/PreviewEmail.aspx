<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="PreviewEmail.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid child-page">
        <div class="container content txt-style">
           <asp:button runat="server" ID="btnBack" Text="back" class="btnstyle" style="float:right" OnClick="btnBack_Click"></asp:button>
            <br />
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
            <h6 style="float:left">SUBJECT: <asp:Label ID="lblSubject" runat="server"></asp:Label> </h6>
            <br />
            <br />
            <div class="row">
                <div class="col-5">
                    <div id="emailPreview" style="text-align:left" runat="server"></div>
                </div>
                <div class="col-7">
                    <asp:GridView runat="server" class="table table-responsive" ID="grdFileAttachments">
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

