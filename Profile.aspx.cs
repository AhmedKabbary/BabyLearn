using System;
using System.Collections.Generic;
using System.IO;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BabyLearn
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = this.GetUserId();
            if (!IsPostBack)
            {
                SqlCommand command = new SqlCommand($"select * from users where Userid=@id", Global.conn);
                command.Parameters.AddWithValue("@id", id);

                SqlDataReader sdr = command.ExecuteReader();
                if (sdr.Read())
                {
                    userNameInput.Value = sdr["Username"].ToString();
                    emailInput.Value = sdr["Email"].ToString();

                    DateTime date = Convert.ToDateTime(sdr["BirthDate"].ToString());
                    birthdateInput.Text = date.ToString("yyyy-MM-dd");

                    if (sdr["Gender"].ToString() == "m")
                        maleInput.Checked = true;
                    else
                        femaleInput.Checked = true;

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

            if (PictureUpload.HasFile)
            {
                // Delete old picture
                SqlCommand command = new SqlCommand($"select Picture from users where Userid=@id", Global.conn);
                command.Parameters.AddWithValue("@id", id);

                SqlDataReader sdr = command.ExecuteReader();
                if (sdr.Read())
                {
                    if (!sdr.IsDBNull(0)) // 0 is the index of column in result which means the picture in that query
                    {
                        File.Delete(Server.MapPath($"~/{sdr["Picture"]}"));
                    }
                }
                sdr.Close();

                // Set new picture
                string ext = Path.GetExtension(PictureUpload.PostedFile.FileName);
                PictureUpload.PostedFile.SaveAs(Server.MapPath($"~/Users_Data/{id}{ext}"));

                SqlCommand command2 = new SqlCommand("update users set Picture=@path where Userid=@id;", Global.conn);
                command2.Parameters.AddWithValue("@id", id);
                command2.Parameters.AddWithValue("@path", $"Users_Data/{id}{ext}");
                command2.ExecuteNonQuery();

                Picture.ImageUrl = $"Users_Data/{id}{ext}";
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;
        }

        private void Alert(string message)
        {
            alertBox.Visible = true;
            alertBox.InnerHtml = message;
        }

        protected void saveChangesBtn_Click(object sender, EventArgs e)
        {
            if (userNameInput.Value.Length == 0)
            {
                Alert("Please enter child name");
                return;
            }
            if (!Regex.IsMatch(emailInput.Value, @"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"))
            {
                Alert("Please enter a valid email");
                return;
            }
            if (birthdateInput.Text.Length == 0)
            {
                Alert("Please enter child birthdate");
                return;
            }
            if (!maleInput.Checked && !femaleInput.Checked)
            {
                Alert("Please select your child gender");
                return;
            }

            string id = this.GetUserId();
            string name = userNameInput.Value;
            string email = emailInput.Value;
            string date = birthdateInput.Text;
            string gender = maleInput.Checked ? "m" : "f";

            SqlCommand command2 = new SqlCommand("Update users set Username=@name, Email=@email, Gender=@gender, BirthDate=@date where Userid=@id;", Global.conn);
            command2.Parameters.AddWithValue("@id", id);
            command2.Parameters.AddWithValue("@name", name);
            command2.Parameters.AddWithValue("@email", email);
            command2.Parameters.AddWithValue("@date", date);
            command2.Parameters.AddWithValue("@gender", gender);
            command2.ExecuteNonQuery();
            Response.Redirect("Home.aspx");
        }

        protected void savePasswordBtn_Click(object sender, EventArgs e)
        {

            if (currentPasswordInput.Value.Length < 8)
            {
                Alert("Password can not be less than 8 characters");
                return;
            }
            if (newPasswordInput.Value.Length < 8)
            {
                Alert("Password can not be less than 8 characters");
                return;
            }
            if (newPasswordInput.Value != confirmNewPasswordInput.Value)
            {
                Alert("Passwords do not match");
                return;
            }

            string id = this.GetUserId();

            SqlCommand command = new SqlCommand($"select HashedPassword from users where Userid=@id", Global.conn);
            command.Parameters.AddWithValue("@id", id);

            SqlDataReader sdr = command.ExecuteReader();
            if (sdr.Read())
            {
                string databasepassword = sdr["HashedPassword"].ToString();
                sdr.Close();

                bool isValid = BCrypt.Net.BCrypt.Verify(currentPasswordInput.Value, databasepassword);
                if (isValid)
                {
                    string newHashedPassword = BCrypt.Net.BCrypt.HashPassword(newPasswordInput.Value);

                    SqlCommand command3 = new SqlCommand("Update users set HashedPassword = @password where Userid=@id;", Global.conn);
                    command3.Parameters.AddWithValue("@password", newHashedPassword);
                    command3.Parameters.AddWithValue("@id", id);
                    command3.ExecuteNonQuery();
                }
                else
                {
                    Alert("Your password is wrong");
                }
            }
            sdr.Close();
            Response.Redirect("Home.aspx");
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            HttpCookie authCookie = new HttpCookie("auth", "");
            Response.SetCookie(authCookie);
            Response.Redirect("Login.aspx");
        }
    }
}