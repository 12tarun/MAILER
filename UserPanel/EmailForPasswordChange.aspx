<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmailForPasswordChange.aspx.cs" Inherits="UserPanel_EmailForPasswordChange" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css?family=Varela+Round|Roboto|Muli|Raleway" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../CSS/landingPage.css" />
</head>
<body>
    <div class="container-fluid bg-img" style="padding: 20px 50px">
        <form id="form1" runat="server">
            <div>
                <asp:Button class="btn btn-dark btnstyle " ID="btnBack" Text="back" runat="server" Style="float: right; border-radius: 10px; padding: 5px 20px" OnClick="btnBack_Click" />
                <br />
                <br />
                <div class="row justify-content-center">
                    <div class="card col-sm-4 col-xs-10 ">
                        <div class="card-body" style="text-align: center">

                            <h5>Enter the email id with which you created this account</h5>
                            <br />
                            <div class="input-group">
                                <asp:TextBox CssClass="form-control" ID="tbxForgotPassword" ValidationGroup="submit" runat="server"></asp:TextBox>
                            </div>
                            <br />
                            <asp:Button class="btn btn-dark btnstyle" ID="btnForgotPassword" Text="submit" runat="server" OnClick="btnForgotPassword_Click" />
                            <br />
                            <asp:RegularExpressionValidator Display="Dynamic" ValidationGroup="submit" runat="server" ForeColor="Red" ErrorMessage="Invalid email id" ControlToValidate="tbxForgotPassword" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic" ValidationGroup="submit" ErrorMessage="Enter email id" ControlToValidate="tbxForgotPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:Label ID="lblNoAccount" runat="server" ForeColor="Red" Text="Sorry! We don't have any account with this email id." Visible="false"></asp:Label>
                            <br />
                            <asp:Label ID="lblChangePasswordMail" ForeColor="Blue" Text="Email to set new password is sent successfully!" Visible="false" runat="server"></asp:Label>

                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
</body>
</html>
