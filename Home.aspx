<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="BabyLearn.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="assets/Chart.js"></script>
    <title>Home</title>

    <style>
        .square {
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            border-radius: 5%;
            margin: 8px;
        }

        /* xm */
        @media only screen and (max-width: 576px) {
            .square {
                width: 150px;
                height: 150px;
                font-size: large;
            }
        }

        /* sm */
        @media only screen and (min-width: 576px) {
            .square {
                width: 200px;
                height: 200px;
                font-size: x-large;
            }
        }

        /* md */
        @media only screen and (min-width: 768px) {
            .square {
                width: 125px;
                height: 125px;
                font-size: large;
            }
        }

        /* lg */
        @media only screen and (min-width: 992px) {
            .square {
                width: 200px;
                height: 200px;
                font-size: x-large;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="w-100 bg-light">
        <div class="container pt-5 pb-5">
            <div class="row">
                <div class="col-12 col-md-6 mb-3">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <asp:Image ID="Picture" runat="server" class="rounded-pill"
                                    Style="width: 100px; height: 100px; object-fit: cover;" />
                                <div class="d-flex flex-column justify-content-around ms-3">
                                    <div>
                                        <h5 id="nameLabel" runat="server" class="card-title fw-bold mb-1">User name</h5>
                                        <p id="ageLabel" runat="server" class="card-subtitle text-muted mb-2">n years old</p>
                                        <a href="Profile.aspx" style="text-decoration: none;">Edit profile</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Statistics:</h5>
                            <canvas id="myChart" style="width: 100%;"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-center align-items-center mt-5 mb-5">
                                <table>
                                    <tr>
                                        <td>
                                            <a class="btn btn-primary square" href="Learn.aspx">Learn new words</a>
                                        </td>
                                        <td>
                                            <a class="btn btn-danger square" href="Quiz.aspx">Test yourself</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a class="btn btn-success square" href="Draw.aspx">Try draw something</a>
                                        </td>
                                        <td>
                                            <a class="btn btn-warning square" href="Collections.aspx">View my
                                                collections</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        <%@ Import namespace="BabyLearn" %>
        <%@ Import namespace="System.Data.SqlClient" %>

        <%
        int completed = 0;
        int remaining = 0;

        SqlCommand command2 = new SqlCommand("select (select count(*) from contents), (select count(*) from users_progress where UserId=@id)", Global.conn);
        command2.Parameters.AddWithValue("@id", this.GetUserId());
        SqlDataReader sdr2 = command2.ExecuteReader();
        if (sdr2.Read())
        {
            completed = sdr2.GetInt32(1);
            remaining = sdr2.GetInt32(0) - completed;
        }
        sdr2.Close();
        %>

        new Chart("myChart", {
            type: "doughnut",
            data: {
                labels: ['completed', 'remaining'],
                datasets: [{
                    backgroundColor: ['#0d6efd'],
                    data: [<%=completed%>, <%=remaining%>]
                }]
            },
            options: {
                title: {
                    display: true,
                    text: 'User Progress'
                }
            }
        });
    </script>
</asp:Content>
