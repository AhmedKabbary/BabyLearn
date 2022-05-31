<%@ Page Async="true" Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Learn.aspx.cs" Inherits="BabyLearn.Learn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Learn</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="w-100 bg-light">

        <div class="container d-flex justify-content-center align-items-center text-center pt-5 pb-5">
            <div>
                <h2 class="mb-5">
                    <span id="title" runat="server">Word</span>
                    &nbsp
                    <i class="bi bi-volume-up-fill" style="font-size: smaller; cursor: pointer;" onclick="aud.play()"></i>
                </h2>

                <asp:Image ID="Image1" runat="server" CssClass="text-center mb-5" Style="width: 75%; max-width: 425px; min-height: 50vh; object-fit: contain;" />

                <div style="width: 100%; display: flex; justify-content: space-between;">
                    <asp:Button ID="prevBtn" runat="server" class="btn btn-outline-primary" Text="Previous" OnClick="prevBtn_Click" Enabled="false" />
                    <asp:Button ID="nextBtn" runat="server" class="btn btn-primary" Text="Next" OnClick="nextBtn_Click" />
                </div>
            </div>
        </div>

    </div>

</asp:Content>
