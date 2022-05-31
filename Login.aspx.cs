using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Text;
using System.Web.Configuration;

namespace BabyLearn
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            if (!Regex.IsMatch(emailInput.Value, @"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"))
            {
                Alert("Please enter a valid email");
                return;
            }
            if (passwordInput.Value.Length < 8)
            {
                Alert("Password can not be less than 8 characters");
                return;
            }

            string email = emailInput.Value;
            string id = null;
            string databasepassword = null;
            string gid = Guid.NewGuid().ToString();

            SqlCommand command = new SqlCommand("select * from users where email = @email", Global.conn);
            command.Parameters.AddWithValue("@email", email);
            SqlDataReader sdr = command.ExecuteReader();

            if (sdr.HasRows)
            {
                sdr.Close();

                SqlDataReader sdr2 = command.ExecuteReader();
                while (sdr2.Read())
                {
                    id = sdr2["UserId"].ToString();
                    databasepassword = sdr2["HashedPassword"].ToString();
                }
                sdr2.Close();

                bool isValid = BCrypt.Net.BCrypt.Verify(passwordInput.Value, databasepassword);
                if (isValid)
                {
                    DateTime now = DateTime.Now;
                    SecurityTokenDescriptor tokenDescriptor = new SecurityTokenDescriptor
                    {
                        Claims = new Dictionary<string, object> {
                            {"sub", id},
                            {"jti", gid},
                        },
                        IssuedAt = now,
                        Expires = now.AddDays(7),
                        SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(Global.authKey), SecurityAlgorithms.HmacSha256Signature)
                    };
                    string token = new JwtSecurityTokenHandler().CreateEncodedJwt(tokenDescriptor);

                    SqlCommand command2 = new SqlCommand("INSERT INTO users_sessions VALUES(@id, @gid, @now, @expire);", Global.conn);
                    command2.Parameters.AddWithValue("@id", id);
                    command2.Parameters.AddWithValue("@gid", gid);
                    command2.Parameters.AddWithValue("@now", now);
                    command2.Parameters.AddWithValue("@expire", now.AddDays(7));
                    command2.ExecuteNonQuery();

                    HttpCookie authCookie = new HttpCookie("auth");
                    authCookie.Value = token;
                    authCookie.Secure = true;
                    authCookie.HttpOnly = true;
                    authCookie.Expires = now.AddDays(7);
                    Response.SetCookie(authCookie);
                    Response.Redirect("Home.aspx");
                }
                else Alert("Your password is incorrect");

            }
            else
            {
                sdr.Close();
                Alert("This user is not found");
            }
        }

        private void Alert(string message)
        {
            alertBox.Visible = true;
            alertBox.InnerHtml = message;
        }
    }
}
