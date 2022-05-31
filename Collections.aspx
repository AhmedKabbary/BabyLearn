<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Collections.aspx.cs" Inherits="BabyLearn.Collections" %>

<%@ Import Namespace="BabyLearn" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Collections</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="w-100 bg-light">
        <div class="container pt-5 pb-5">
            <div class="row justify-content-center">
                <%
                    SqlCommand cmd = new SqlCommand("SELECT Category, COUNT(Id) AS Total, COUNT(Points) AS Done FROM contents LEFT JOIN users_progress ON contents.Id = users_progress.ContentId AND users_progress.UserId=@id GROUP BY Category", Global.conn);
                    cmd.Parameters.AddWithValue("@id", this.GetUserId());

                    SqlDataReader sdr = cmd.ExecuteReader();
                    while (sdr.Read())
                    {
                        string category = sdr["Category"].ToString();
                        double done = double.Parse(sdr["Done"].ToString());
                        double total = double.Parse(sdr["Total"].ToString());

                        int percentage = (int)((done / total) * 100);

                        Response.Write($@"
                            <div class='col-auto'>
                                <div class='card mt-3 mb-3' style='width: 18rem;'>
                                    <img src='assets/contents/categories/{category}.jpg' class='card-img-top' style='height: 18rem; object-fit: contain;'>
                                    <div class='card-body'>
                                        <h5 class='card-title text-center'>{category}</h5>
                                        <div class='progress mt-3'>
                                            <div class='progress-bar' role='progressbar' style='width: {percentage}%;' aria-valuenow='{percentage}' aria-valuemin='0' aria-valuemax='100'>{percentage}%</div>
                                        </div>
                                    </div>
                                </div>
                            </div>"
                        );
                    }
                    sdr.Close();
                %>
            </div>
        </div>
    </div>
</asp:Content>
