<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="BabyLearn.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Profile</title>

    <style>
        .picture_parent {
            width: 200px;
            height: 200px;
            position: relative;
            border-radius: 50%;
        }

        .picture_child1 {
            width: 200px;
            height: 200px;
            position: absolute;
            top: 0px;
            left: 0px;
            border-radius: 50%;
        }

        .picture_child2 {
            width: 200px;
            height: 200px;
            position: absolute;
            top: 0px;
            left: 0px;
            border-radius: 50%;
            cursor: pointer;
            background: rgba(0, 0, 0, 0.5);
            opacity: 0;
            color: white;
            font-size: 1.5em;
            font-weight: bold;
        }

            .picture_child2:hover {
                opacity: 1;
            }

        .title {
            font-size: 2em;
            font-weight: bold;
        }

        td:hover {
            background-color: #0d6efd
        }

        a {
            text-decoration: none;
        }

        td:hover a {
            color: white;
        }

        .t {
            width: 70%
        }

        .side-button {
            cursor: pointer;
            padding: 4px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="w-100 bg-light">

        <div class="alert alert-danger" role="alert" id="alertBox" runat="server" visible="false"></div>

        <div class="container mt-5 mb-5" >

            <div class="row">
                <div class="col-12 col-md-4">

                    <div class="d-flex justify-content-center mb-5">
                        <div class="picture_parent" onclick="document.getElementById('<%= PictureUpload.ClientID %>').click()">
                            <asp:Image ID="Picture" runat="server" CssClass="picture_child1 img-previewer" Style="object-fit: cover;" />
                            <div class="picture_child2 d-flex justify-content-center align-items-center">
                                <span>change picture</span>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-center mb-3">
                        <div class="t">
                            <table class="table table-bordered table-sm">
                                <tbody class="text-primary">
                                    <tr>
                                        <td>
                                            <div class="side-button" onclick="document.getElementById('<%= LinkButton1.ClientID %>').click()">
                                                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">
                                                    <i class="bi bi-person-badge"></i>
                                                    &nbsp;
                                                    <span>Account Details</span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="side-button" onclick="document.getElementById('<%= LinkButton2.ClientID %>').click()">
                                                <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click">
                                                    <i class="bi bi-key"></i>
                                                    &nbsp;
                                                    <span>Change password</span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="side-button" onclick="document.getElementById('<%= LinkButton3.ClientID %>').click()">
                                                <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click">
                                                    <i class="bi bi-box-arrow-in-right"></i>
                                                    &nbsp;
                                                    <span>Logout</span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!--Hidden file input-->
                    <asp:FileUpload ID="PictureUpload" class="fileUpload-previewer" runat="server" Style="display: none;" />
                </div>

                <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">

                    <asp:View ID="View1" runat="server">
                        <div class="col-12 col-md-8">
                            <div>
                                <p class="title">Account Settings</p>

                                <div class="form-group mb-3">
                                    <label for="userName" class="form-label">Name</label>
                                    <input id="userNameInput" class="form-control" type="text" placeholder="Enter your name" runat="server" />
                                </div>

                                <div class="form-group mb-3">
                                    <label for="email" class="form-label">Email address</label>
                                    <input id="emailInput" class="form-control" type="text" placeholder="name@example.com" runat="server" />
                                </div>

                                <div class="form-group mb-3">
<l                                   <label for="birthdate" class="form-label">Birth Date</label>
                                    <asp:TextBox ID="birthdateInput" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                                </div>

                                <div class="form-group row mb-4">
                                    <div class="col-auto">
                                        <input class="form-check-input" type="radio" name="gender" id="maleInput" runat="server" />
                                        <label class="form-check-label" for="maleInput">Male</label>
                                    </div>
                                    <div class="col-auto">
                                        <input class="form-check-input" type="radio" name="gender" id="femaleInput" runat="server" />
                                        <label class="form-check-label" for="femaleInput">Female</label>
                                    </div>
                                </div>

                                <asp:Button ID="saveChangesBtn" runat="server" Text="Save changes" class="btn btn-primary" OnClick="saveChangesBtn_Click" />
                            </div>
                        </div>
                    </asp:View>

                    <asp:View ID="View2" runat="server">
                        <div class="col-12 col-md-8">
                            <div>
                                <p class="title">Change Password</p>

                                <div class="form-group mb-3">
                                    <label for="currentPasswordInput" class="form-label">Current Password</label>
                                    <input id="currentPasswordInput" class="form-control" type="password" placeholder="********" runat="server" />
                                </div>

                                <div class="form-group mb-3">
                                    <label for="newPasswordInput" class="form-label">New Password</label>
                                    <input id="newPasswordInput" class="form-control" type="password" placeholder="********" runat="server" />
                                </div>
                                <div class="form-group mb-3">
                                    <label for="confirmNewPasswordInput" class="form-label">Confirm Password</label>
                                    <input id="confirmNewPasswordInput" class="form-control" type="password" placeholder="********" runat="server" />
                                </div>

                                <asp:Button ID="savePasswordBtn" runat="server" Text="Save changes" class="btn btn-primary" OnClick="savePasswordBtn_Click" />
                            </div>
                        </div>

                    </asp:View>

                </asp:MultiView>

            </div>
        </div>

    </div>

    <script src="assets/img-preview.js"></script>
</asp:Content>
