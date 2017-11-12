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

                    <asp:TextBox ID="tbxSearch" placeholder="Enter Recipient Name" OnTextChanged="tbxSearch_TextChanged" AutoPostBack="true" runat="server"></asp:TextBox>

                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    <br />
                    <asp:GridView ID="grdView" runat="server" AllowPaging="true" AutoGenerateColumns="false" OnRowDataBound="grdView_RowDataBound" OnPageIndexChanging="grdView_PageIndexChanging">
                        <Columns>
                            <asp:BoundField HeaderStyle-Width="150px" DataField="Name" HeaderText="Recipient Name" ItemStyle-CssClass="ContactName" />
                            <asp:TemplateField HeaderText="Recipient Email">
                                <ItemTemplate>
                                    <%# Eval("Email") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category">
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

