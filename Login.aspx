<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BabyLearn.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="assets/bootstrap-5.1.3-dist/css/bootstrap.css" />
    <title>Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="alert alert-danger" role="alert" id="alertBox" runat="server" visible="false"></div>

        <div class="container" style="width: 300px; height: 100vh; display: flex; justify-content: center; align-items: center;">

            <div style="width: 100%">

                <h1 class="text-primary text-center mb-5">Login</h1>

                <div class="form-group">
                    <div class="form-floating mb-2">
                        <input  type="email" id="emailInput" class="form-control" placeholder="Email" runat ="server" />
                        <label for="emailInput">Email</label>
                    </div>
                </div>

                <div class="form-group">
                    <div class="form-floating mb-3">
                        <input type="password" id="passwordInput" class="form-control" placeholder="Password" runat ="server" />
                        <label for="passwordInput">Password</label>
                    </div>
                </div>

                <div class="form-group text-center w-100 mt-5 mb-2">
                    <asp:Button ID="LoginBtn" runat="server" CssClass="btn btn-primary w-100" Text="Login" OnClick="LoginBtn_Click" />
                </div>

                <p class="text-secondary text-center">
                    Don’t have an account?
                    <a href="Register.aspx">
                        <u>register</u>
                    </a>
                </p>

            </div>

        </div>

    </form>

    <script src="assets/bootstrap-5.1.3-dist/js/bootstrap.bundle.js"></script>
</body>
</html>