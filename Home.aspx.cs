using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BabyLearn
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = this.GetUserId();

            SqlCommand command = new SqlCommand("select * from users where UserId=@id", Global.conn);
            command.Parameters.AddWithValue("@id", id);
            SqlDataReader sdr = command.ExecuteReader();
            if (sdr.Read())
            {
                nameLabel.InnerHtml = sdr["UserName"].ToString();
                DateTime birthDate = Convert.ToDateTime(sdr["BirthDate"].ToString());
                int age = (int)((DateTime.Now - birthDate).TotalDays / 365);
                ageLabel.InnerText = $"{age} years old";

                if (sdr.IsDBNull(6)) // 6 is the index of column in result which means the picture in that query
                {
                    if (sdr["Gender"].ToString() == "m")
                        Picture.ImageUrl = "assets/icons/boy.png";
                    else
                        Picture.ImageUrl = "assets/icons/girl.png";
                }
                else
                    Picture.ImageUrl = sdr["Picture"].ToString();
            }
            sdr.Close();
        }
    }
}