<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BabyLearn.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="assets/bootstrap-5.1.3-dist/css/bootstrap.css" />
    <title>Register</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="alert alert-danger" role="alert" id="alertBox" runat="server" visible="false"></div>

        <div class="container" style="width: 300px; height: 95vh; display: flex; justify-content: center; align-items: center;">

            <div style="width: 100%">

                <h1 class="text-primary text-center mb-5">Register</h1>

                <div class="form-group">
                    <div class="form-floating mb-2">
                        <input type="text" id="nameInput" class="form-control" placeholder="Name" runat="server" />
                        <label for="nameInput">Name</label>
                    </div>
                </div>

                <div class="form-group">
                    <div class="form-floating mb-2">
                        <input type="email" id="emailInput" class="form-control" placeholder="Email" runat="server" />
                        <label for="emailInput">Email</label>
                    </div>
                </div>

                <div class="form-group">
                    <div class="form-floating mb-2">
                        <input type="password" id="passwordInput" class="form-control" placeholder="Password" runat="server" />
                        <label for="passwordInput">Password</label>
                    </div>
                </div>

                <div class="form-group">
                    <div class="form-floating mb-2">
                        <input type="password" id="confirmPasswordInput" class="form-control" placeholder="Confirm password" runat="server" />
                        <label for="confirmPasswordInput">Confirm password</label>
                    </div>
                </div>

                <div class="form-group">
                    <div class="form-floating mb-3">
                        <input type="date" id="birthdateInput" class="form-control" runat="server" />
                        <label for="birthdateInput">Birth Date</label>
                    </div>
                </div>

                <div class="form-group text-center">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="gender" id="maleInput"  runat="server" checked />
                        <label class="form-check-label" for="maleInput">male</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="gender" id="femaleInput" runat="server" />
                        <label class="form-check-label" for="femaleInput">female</label>
                    </div>
                </div>

                <div class="form-group text-center w-100 mt-5 mb-2">
                    <asp:Button ID="RegisterBtn" runat="server" CssClass="btn btn-primary w-100" Text="Register" OnClick="RegisterBtn_Click" />
                </div>

                <p class="text-secondary text-center">
                    Already a member?
                    <a href="Login.aspx">
                        <u>login</u>
                    </a>

                </p>
            </div>

        </div>
    </form>

    <script src="assets/bootstrap-5.1.3-dist/js/bootstrap.bundle.js"></script>
</body>
</html>
