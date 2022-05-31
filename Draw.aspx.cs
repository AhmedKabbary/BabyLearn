using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BabyLearn
{
    public partial class Draw : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SELECT TOP 1 Drawing FROM contents WHERE Drawing IS NOT NULL ORDER BY NEWID();", Global.conn);
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                Image1.ImageUrl = sdr["Drawing"].ToString();
            }
            sdr.Close();
        }
    }
}