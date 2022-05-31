using System;
using System.Threading;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace BabyLearn
{
    public partial class Quiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlCommand cmd = new SqlCommand("SELECT TOP 10 users_progress.ContentId, contents.Word, contents.Picture, contents.Category, users_progress.Points FROM users_progress INNER JOIN contents ON users_progress.ContentId = contents.Id and users_progress.UserId=@id order by Points", Global.conn);
                cmd.Parameters.AddWithValue("@id", this.GetUserId());

                List<List<string>> list = new List<List<string>>();

                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    List<string> l = new List<string>
                    {
                        sdr[0].ToString(),
                        sdr[1].ToString(),
                        sdr[2].ToString(),
                        sdr[3].ToString(),
                        sdr[4].ToString(),
                    };
                    list.Add(l);
                }
                sdr.Close();

                if (list.Count != 0 || list.Count < 4)
                {
                    ViewState["current"] = 0;
                    ViewState["list"] = list;
                    Update();
                }
                else Response.Redirect("Home.aspx");
            }
        }

        protected void choice_Click(object sender, ImageClickEventArgs e)
        {
            List<List<string>> list = ViewState["list"] as List<List<string>>;
            int current = (int)ViewState["current"];

            string query;

            string conId = list[current][0];
            ImageButton choice = (sender as ImageButton);
            if (choice.ImageUrl == list[current][2])
            {
                choice.CssClass += " right";
                query = $"update users_progress set Points = Points + 1 where Points < 12 and UserId = @userId and ContentId = @contentId";
            }
            else
            {
                choice.CssClass += " wrong";
                query = $"update users_progress set Points = Points - 1 where Points > -12 and UserId = @userId and ContentId = @contentId";

                ImageButton[] choices = { choice1, choice2, choice3, choice4 };
                foreach (ImageButton anotherChoice in choices)
                {
                    if (anotherChoice.ImageUrl == list[current][2])
                    {
                        anotherChoice.CssClass += " right";
                    }
                }
            }

            SqlCommand c = new SqlCommand(query, Global.conn);
            c.Parameters.AddWithValue("@userId", this.GetUserId());
            c.Parameters.AddWithValue("@contentId", conId);
            c.ExecuteNonQuery();

            choice1.Enabled = false;
            choice2.Enabled = false;
            choice3.Enabled = false;
            choice4.Enabled = false;


            ViewState["current"] = current + 1;
            Timer1.Enabled = true;
        }

        protected void Update()
        {
            int current = (int)ViewState["current"];
            List<List<string>> list = ViewState["list"] as List<List<string>>;

            if (current == list.Count)
                Response.Redirect("Home.aspx");

            string cid = list[current][0];
            string word = list[current][1];
            string category = list[current][3];
            string picture = list[current][2];
            int points = Convert.ToInt32(list[current][4]);


            title.InnerText = $"Which is {word}?";
            score.InnerText = Global.MapScoreToEmojie(points);

            Response.Write($@"
                <script>
                    let aud = new Audio(`assets/contents/audios/{category}/{word}.wav`);
                    window.onload = function () {{
                        aud.play();
                    }}
                </script>
            ");

            SqlCommand c = new SqlCommand("SELECT TOP 4 Picture FROM Contents WHERE Category = @c ORDER BY NEWID();", Global.conn);
            c.Parameters.AddWithValue("@c", category);
            c.Parameters.AddWithValue("@cid", cid);
            SqlDataReader sdr = c.ExecuteReader();

            List<string> options = new List<string>(4);
            while (sdr.Read())
            {
                options.Add(sdr["Picture"].ToString());
            }
            sdr.Close();

            Random rand = new Random();
            if (!options.Contains(picture))
            {
                int r = rand.Next(0, 4);
                options[r] = picture;
            }

            choice1.Enabled = true;
            choice2.Enabled = true;
            choice3.Enabled = true;
            choice4.Enabled = true;

            choice1.CssClass = "choice";
            choice2.CssClass = "choice";
            choice3.CssClass = "choice";
            choice4.CssClass = "choice";

            choice1.ImageUrl = options[0];
            choice2.ImageUrl = options[1];
            choice3.ImageUrl = options[2];
            choice4.ImageUrl = options[3];
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            Update();
            Timer1.Enabled = false;
        }
    }
}