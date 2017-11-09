<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="Registration" %>

<!DOCTYPE html>
<!--This is Registration file -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../Css/landingPage.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css?family=Varela+Round|Roboto|Muli|Raleway" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid bg-img">
            <nav class="navbar">
                <h1 class="navbar-brand logo">
                    <img class="logo" src="../Images/message.gif" /></h1>
                <h1 class="brnd-name">MAILER</h1>
            </nav>
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-lg-6">
                        <div class="container">
                            <img class="animation" src="../Images/message.gif" />
                        </div>
                    </div>
                    <div class="col-xs-12 col-lg-6">
                        <div class="txt">
                            <h1>EASY AND COMPATIBLE</h1>
                            <div class="btn btn-primary btn-lg login btnstyle" href="#" data-toggle="modal" data-target="#login-modal">Log in</div>
                            <div class="btn btn-primary btn-lg login btnstyle" href="#" data-toggle="modal" data-target="#signup-modal">sign up</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="signup-modal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ModalLabel">SIGN UP</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">



                        <asp:ScriptManager ID="SMCapcha" runat="server"></asp:ScriptManager>
                        <div class="form-group">
                            <label for="InputUsername">Username <i class="fa fa-user" aria-hidden="true"></i></label>
                            <asp:TextBox ID="tbxFullname" runat="server" ValidationGroup="register" placeholder="Full Name"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="tbxFullName" ValidationGroup="register" Display="Dynamic" ForeColor="Red" ID="RFValidatorFullName" runat="server" ErrorMessage="Full name required"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <asp:TextBox ID="tbxUsername" runat="server" ValidationGroup="register" placeholder="Username" AutoPostBack="true" OnTextChanged="tbxUsername_TextChanged"></asp:TextBox>
                            <asp:RequiredFieldValidator Display="Dynamic" ID="RFValidatorUsername" ValidationGroup="register" ControlToValidate="tbxUsername" runat="server" ErrorMessage="Username required" ForeColor="red"></asp:RequiredFieldValidator>
                            <asp:Label ID="lblInvalidUsername" runat="server" Display="Dynamic" ForeColor="Red"></asp:Label>
                        </div>

                        <div class="form-group">
                            <label for="InputEmail">Email address @</label>
                            <asp:TextBox ID="tbxEmail" runat="server" ValidationGroup="register" placeholder="Email" AutoPostBack="true" OnTextChanged="tbxEmail_TextChanged"></asp:TextBox>
                            <asp:RequiredFieldValidator Display="Dynamic" ID="RFValidatorEmail" ValidationGroup="register" runat="server" ControlToValidate="tbxEmail" ErrorMessage="Email id required" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator Display="Dynamic" ID="REValidatorEmail" runat="server" ValidationGroup="register" ForeColor="Red" ErrorMessage="Invalid email id" ControlToValidate="tbxEmail" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" />
                            <asp:Label ID="lblInvalidEmail" runat="server" Display="Dynamic" ForeColor="Red"></asp:Label>
                            <small id="emailHelp" class="form-text text-muted"></small>
                        </div>

                        <div class="form-group">
                            <label for="InputPassword">Password <i class="fa fa-key" aria-hidden="true"></i></label>
                            <asp:TextBox ID="tbxPassword" runat="server" placeholder="Password" ValidationGroup="register" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFValidatorPassword" runat="server" Display="Dynamic" ValidationGroup="register" ControlToValidate="tbxPassword" ErrorMessage="Password required" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="REValidatorPassword" runat="server" Display="Dynamic" ValidationGroup="register" Font-Size="small" ErrorMessage="Password should contain atleast one digit, one alphabet and minimum length 6." ControlToValidate="tbxPassword" ForeColor="Red" ValidationExpression="^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$" />
                        </div>

                        <div class="form-group">
                            <asp:TextBox ID="tbxComfirmPassword" runat="server" placeholder="Confirm Password" ValidationGroup="register" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFValidatorConfirmPassword" runat="server" Display="Dynamic" ValidationGroup="register" ControlToValidate="tbxComfirmPassword" ErrorMessage="Confirm password required" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CMValidatorConfirmPassword" Display="Dynamic" ValidationGroup="register" ControlToValidate="tbxComfirmPassword" ErrorMessage="Passwords do not match" ForeColor="Red" ControlToCompare="tbxPassword" runat="server"></asp:CompareValidator>
                        </div>

                        <div class="form-group">
                            <asp:UpdatePanel ID="UPCaptcha" runat="server">
                                <ContentTemplate>
                                    <asp:Image ID="imgCaptcha" Width="100px" Height="50px" runat="server" />
                                    <br />
                                    <asp:Button ID="btnRefresh" runat="server" Text="Refresh" OnClick="btnRefresh_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <br />
                            <asp:TextBox ID="tbxCaptcha" runat="server" placeholder="Enter above captcha"></asp:TextBox>
                            <asp:Label ID="lblIncorrectCaptcha" runat="server" Display="Dynamic" ForeColor="Red"></asp:Label>
                            <div class="form-check">
                            </div>

                            <asp:Button ID="btnRegister" Text="register" class="btn btn-dark submit" runat="server" OnClick="btnRegister_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ModalLabel">LOG IN</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <div class="form-group">
                            <label for="InputEmail">Email address @</label>
                            <asp:TextBox ID="tbxLoginEmail" runat="server" ValidationGroup="login" placeholder="Enter Email Id"></asp:TextBox>
                            <asp:RequiredFieldValidator Display="Dynamic" ID="RFValidatorLoginEmail" ValidationGroup="login" runat="server" ErrorMessage="Please enter an email id" ControlToValidate="tbxLoginEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                            <small id="emailHelp" class="form-text text-muted"></small>
                        </div>
                        <div class="form-group">
                            <label for="InputPassword">Password <i class="fa fa-key" aria-hidden="true"></i></label>
                            <asp:TextBox ID="tbxLoginPassword" runat="server" ValidationGroup="login" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
                            <asp:RequiredFieldValidator Display="Dynamic" ID="RFValidatorLoginPassword" ValidationGroup="login" runat="server" ControlToValidate="tbxLoginPassword" ErrorMessage="Please enter the password" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:LinkButton ID="LnkBtnForgotPassword" runat="server" OnClick="LnkBtnForgotPassword_Click" Text="forgot password?"></asp:LinkButton>
                        </div>
                        <div class="form-check">
                        </div>
                        <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Login" />
                        <asp:Label ID="lblWarning" runat="server" Display="Dynamic" ForeColor="Red"></asp:Label>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
</body>
</html>
