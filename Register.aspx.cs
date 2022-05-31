using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BabyLearn
{
    public partial class Register : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RegisterBtn_Click(object sender, EventArgs e)
        {
            if (nameInput.Value.Length == 0)
            {
                Alert("Please enter child name");
                return;
            }
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
            if (passwordInput.Value != confirmPasswordInput.Value)
            {
                Alert("Passwords do not match");
                return;
            }
            if (birthdateInput.Value.Length == 0)
            {
                Alert("Please enter child birthdate");
                return;
            }
            if (!maleInput.Checked && !femaleInput.Checked)
            {
                Alert("Please select your child gender");
                return;
            }

            string id = Guid.NewGuid().ToString();
            string name = nameInput.Value;
            string email = emailInput.Value;
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(passwordInput.Value);
            DateTime date = Convert.ToDateTime(birthdateInput.Value);
            string gender = maleInput.Checked ? "m" : "f";

            SqlCommand command1 = new SqlCommand("select Email from users where email = @email", Global.conn);
            command1.Parameters.AddWithValue("@email", email);
            SqlDataReader sdr = command1.ExecuteReader();

            if (!sdr.HasRows)
            {
                sdr.Close();

                SqlCommand command2 = new SqlCommand("INSERT INTO users VALUES(@id, @name, @email, @password, @gender, @date, NULL);", Global.conn);
                command2.Parameters.AddWithValue("@id", id);
                command2.Parameters.AddWithValue("@name", name);
                command2.Parameters.AddWithValue("@email", email);
                command2.Parameters.AddWithValue("@password", hashedPassword);
                command2.Parameters.AddWithValue("@gender", gender);
                command2.Parameters.AddWithValue("@date", date);
                command2.ExecuteNonQuery();

                Response.Redirect("Login.aspx");
            }
            else
            {
                Alert("This account already exists");
                sdr.Close();
            }
        }

        private void Alert(string message)
        {
            alertBox.Visible = true;
            alertBox.InnerHtml = message;
        }
    }
}
