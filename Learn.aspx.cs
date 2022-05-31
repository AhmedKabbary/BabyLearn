using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

namespace BabyLearn
{
    public partial class Learn : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlCommand command = new SqlCommand("select top 4 * from contents where Id not in (select ContentId from users_progress where UserId = @id) ORDER BY NEWID();", Global.conn);
                command.Parameters.AddWithValue("@id", this.GetUserId());
                SqlDataReader sdr = command.ExecuteReader();

                List<Dictionary<string, string>> lst = new List<Dictionary<string, string>>();

                while (sdr.Read())
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>
                    {
                        { "Id", (string)sdr["Id"] },
                        { "Word", (string)sdr["Word"] },
                        { "Picture", (string)sdr["Picture"] },
                        { "Category", (string)sdr["Category"]}
                    };
                    lst.Add(dic);
                }
                sdr.Close();

                if (lst.Count != 0)
                {
                    ViewState["words"] = lst;
                    ViewState["current"] = 0;
                    ViewState["count"] = lst.Count;

                    Update();
                }
                else Response.Redirect("Home.aspx");
            }
        }

        protected void nextBtn_Click(object sender, EventArgs e)
        {
            int current = Convert.ToInt32(ViewState["current"]);
            current++;
            ViewState["current"] = current;

            Update();

            int count = Convert.ToInt32(ViewState["count"]);
            nextBtn.Text = (current == count - 1) ? "Done" : "Next";
            prevBtn.Enabled = (current != 0);
        }

        private void Update()
        {
            List<Dictionary<string, string>> lst = (List<Dictionary<string, string>>)ViewState["words"];
            int current = Convert.ToInt32(ViewState["current"]);

            if (current == lst.Count) // end of the list, go back to home page
                Response.Redirect("Home.aspx", true);

            if (current < lst.Count)
            {
                var item = lst[current];
                title.InnerText = item["Word"].UpperFirstLetter();
                Image1.ImageUrl = item["Picture"];

                Response.Write($@"
                    <script>
                        let aud = new Audio(`assets/contents/audios/{item["Category"]}/{item["Word"]}.wav`);
                        window.onload = function () {{
                            aud.play();
                        }}
                    </script>
                ");

                try
                {
                    SqlCommand command2 = new SqlCommand("insert into users_progress values (@userId, @contentId, @points)", Global.conn);
                    command2.Parameters.AddWithValue("@userId", this.GetUserId());
                    command2.Parameters.AddWithValue("@contentId", item["Id"]);
                    command2.Parameters.AddWithValue("@points", 0);
                    command2.ExecuteNonQuery();
                }
                catch (SqlException) { }
            }
        }

        protected void prevBtn_Click(object sender, EventArgs e)
        {
            int current = Convert.ToInt32(ViewState["current"]);
            current--;
            ViewState["current"] = current;

            Update();

            int count = Convert.ToInt32(ViewState["count"]);
            nextBtn.Text = (current == count - 1) ? "Done" : "Next";
            prevBtn.Enabled = (current != 0);
        }
    }
}