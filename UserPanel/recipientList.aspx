<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanel/userPanel.master" AutoEventWireup="true" CodeFile="recipientList.aspx.cs" Inherits="UserPanel_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid child-page">
        <div class="container content txt-style">
            <div class="justify-content-center">
                <i class="fa fa-list" style="font-size: 50px" aria-hidden="true"></i>
                <br>
                <h1>RECIPIENT LIST</h1>
                <div class="txt-style">
                    <asp:ScriptManager runat="server"></asp:ScriptManager>
                    <asp:TextBox ID="tbxSearch" placeholder="Enter Recipient Name" Width="200px" OnTextChanged="tbxSearch_TextChanged" AutoPostBack="true" runat="server"></asp:TextBox>
                    <asp:Button ID="btnSearch" class="btnstyle" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    <br />
                    <br />
                    <asp:GridView ID="grdView" class="table table-responsive" runat="server" AllowPaging="true" AutoGenerateColumns="false" OnRowDataBound="grdView_RowDataBound" OnPageIndexChanging="grdView_PageIndexChanging">
                        <Columns>
                            <asp:BoundField HeaderStyle-Width="200px" DataField="Name" HeaderText="Recipient Name" ItemStyle-CssClass="ContactName" />
                            <asp:TemplateField HeaderStyle-Width="700px" HeaderText="Recipient Email">
                                <ItemTemplate>
                                    <%# Eval("Email") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Category">
                                <ItemTemplate>
                                    <%# Eval("Category") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

