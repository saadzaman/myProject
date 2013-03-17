using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ERS;


namespace ERSv1._2
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            ERS.BAL.Login lg = new ERS.BAL.Login();
            Employee Current = lg.GetUserID(UserName.Text.Trim());
            if (Current != null)
            {
                int UserID = Current.EmpID;

                Session.Add("UserID", UserID);
                Session.Add("UserName", Current.Name);
                Session.Add("isLM",lg.isLM(UserID));
                Response.Redirect("MyReviews.aspx");

            }
            else
            {
                FailureText.Text = "Sorry Your Credentials are Incorrect";
            }
        }
    }
}