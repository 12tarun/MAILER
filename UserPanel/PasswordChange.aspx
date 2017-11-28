<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PasswordChange.aspx.cs" Inherits="UserPanel_PasswordChange" %>

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
    <div class="container-fluid bg-img " style="padding: 0px 50px">
        <div class="row justify-content-center">
            <div class="card col-md-4 col-xs-6 " style="margin-top: 40px;">
                <div class="card-body" style="text-align: center">
                    <form id="form1" runat="server">
                        <div>
                            <div class="input-group">
                                <asp:TextBox CssClass="form-control" ID="tbxNewPassword" runat="server" placeholder="Enter new password" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFValidatorNewPassword" runat="server" Display="Dynamic" ControlToValidate="tbxNewPassword" ErrorMessage="New password required" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="REValidatorNewPassword" runat="server" Display="Dynamic" Font-Size="small" ErrorMessage="Password should contain atleast one digit, one alphabet and minimum length 6." ControlToValidate="tbxNewPassword" ForeColor="Red" ValidationExpression="^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$" />
                            </div>

                            <br />
                            <div class="input-group">
                                <asp:TextBox CssClass="form-control" ID="tbxConfirmNewPassword" runat="server" placeholder="Confirm new password" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFValidatorConfirmNewPassword" runat="server" Display="Dynamic" ControlToValidate="tbxConfirmNewPassword" ErrorMessage="Confirm new password required" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CMValidatorConfirmNewPassword" Display="Dynamic" ControlToValidate="tbxConfirmNewPassword" ErrorMessage="Passwords do not match" ForeColor="Red" ControlToCompare="tbxNewPassword" runat="server"></asp:CompareValidator>
                            </div>
                            <br />

                            <asp:Button class="btn-dark" ID="btnPasswordChanged" runat="server" OnClick="btnPasswordChanged_Click" Text="submit" />
                            <br />
                            <br />
                            <asp:Label ID="lblNewPassword" ForeColor="Blue" Visible="false" Text="New password set successfully!" runat="server"></asp:Label>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
</body>
</html>
