using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;
using System.Speech.Synthesis;

namespace BabyLearn
{
    public class Global : System.Web.HttpApplication
    {
        public static byte[] authKey;
        public static SqlConnection conn;

        protected void Application_Start(object sender, EventArgs e)
        {
            authKey = Encoding.Unicode.GetBytes(WebConfigurationManager.AppSettings["AuthKey"]);
            conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["connect"].ConnectionString);
            conn.Open();

            if (false) // should be true when we need to generate audio files for new words
            {
                SqlCommand command = new SqlCommand("Select Word, Category from contents", conn);
                SqlDataReader sdr = command.ExecuteReader();
                while (sdr.Read())
                {
                    SpeechSynthesizer synthesizer = new SpeechSynthesizer
                    {
                        Rate = -5
                    };
                    synthesizer.SetOutputToWaveFile(Server.MapPath($"~/assets/contents/audios/{sdr["Category"]}/{sdr["Word"]}.wav"));
                    synthesizer.Speak(sdr["Word"].ToString());
                }
                sdr.Close();
            }
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {
            conn.Close();
        }

        public static string MapScoreToEmojie(int score)
        {
            if (score > 0)
            {
                string[] emojies = { "🙂", "😊", "😁", "😀", "😃", "😄", "🤗", "🥰", "😎", "❤", "💖" };
                if (score > emojies.Length - 1) return emojies[emojies.Length - 1];
                else return emojies[score];
            }
            else if (score < 0)
            {
                string[] emojies = { "😕", "🙁", "☹", "😟", "😥", "😞", "😔", "😓", "😖", "😫", "😭" };
                int index = Math.Abs(score);
                if (index > emojies.Length - 1) return emojies[emojies.Length - 1];
                else return emojies[index];
            }
            return "😶";
        }
    }

    public static class Extensions
    {
        public static string GetUserId(this Page page)
        {
            HttpCookie authCookie = page.Request.Cookies.Get("auth");
            if (authCookie != null)
            {
                string token = authCookie.Value;

                if (token == null || token == "")
                    page.Response.Redirect("Login.aspx");

                try
                {
                    var tokenHandler = new JwtSecurityTokenHandler();
                    tokenHandler.ValidateToken(token, new TokenValidationParameters
                    {
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = new SymmetricSecurityKey(Global.authKey),
                        ValidateIssuer = false,
                        ValidateAudience = false,
                        ClockSkew = TimeSpan.Zero
                    }, out SecurityToken validatedToken);

                    var jwtToken = (JwtSecurityToken)validatedToken;
                    var userId = jwtToken.Subject;
                    return userId;
                }
                catch
                {
                    page.Response.Redirect("Login.aspx");
                }
            }
            else page.Response.Redirect("Login.aspx");

            return null;
        }

        public static string UpperFirstLetter(this string input)
        {
            var chars = input.ToCharArray();
            chars[0] = char.ToUpper(input[0]);
            return new string(chars);
        }
    }
}