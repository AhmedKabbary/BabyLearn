<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Quiz.aspx.cs" Inherits="BabyLearn.Quiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Quiz</title>

    <style>
        .choice {
            width: 150px;
            height: 150px;
            margin: 16px;
            border-radius: 10px;
            object-fit: cover;
        }

        .right {
            outline: 5px solid green;
        }

        .wrong {
            outline: 5px solid red;
        }

        .choice:hover {
            outline: 5px solid var(--bs-primary);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="w-100 bg-light d-flex justify-content-center align-items-center">

        <div>
            <h2 class="text-center mb-5">
                <span id="title" runat="server">Which is word?</span>
                &nbsp
                <span id="score" runat="server"></span>
            </h2>

            <table style="min-height: 380px">
                <tbody>
                    <tr>
                        <td>
                            <asp:ImageButton ID="choice1" runat="server" CssClass="choice card" OnClick="choice_Click" Style="object-fit: contain" />
                        </td>
                        <td>
                            <asp:ImageButton ID="choice2" runat="server" CssClass="choice card" OnClick="choice_Click" Style="object-fit: contain" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ImageButton ID="choice3" runat="server" CssClass="choice card" OnClick="choice_Click" Style="object-fit: contain" />
                        </td>
                        <td>
                            <asp:ImageButton ID="choice4" runat="server" CssClass="choice card" OnClick="choice_Click" Style="object-fit: contain" />
                        </td>
                    </tr>
                </tbody>
            </table>

        </div>

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick" Enabled="False"></asp:Timer>
    </div>

</asp:Content>
