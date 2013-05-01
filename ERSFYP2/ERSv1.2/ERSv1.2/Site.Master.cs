using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ERSv1._2
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
       

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            BasePages current = Page as BasePages;

            if (Session["UserID"] == null)
                navBar.Visible = false;
            else
                userName.InnerText = Session["UserName"].ToString();
            if (Session["isLM"] != null)
                if (Session["isLM"].Equals(false))
                {
                    MyManagees.Visible = false;
                        
                }
          //  if(current!=null)
          //  if(current.Name != null )
          //  userName.InnerText = current.Name;

            if (current != null && !string.IsNullOrEmpty(current.MenuItemDirector))
            {
                MyDirector.Attributes["class"] = current.MenuItemDirector;
            }
            
            if (current != null && !string.IsNullOrEmpty(current.MenuItemMyReviews))
            {
                
                MyReviews.Attributes["class"] = current.MenuItemMyReviews;
            }
            if (current != null && !string.IsNullOrEmpty(current.MenuItemMyManagees))
            {
                
                MyManagees.Attributes["class"] = current.MenuItemMyManagees;
              
            }
            if (current != null && !string.IsNullOrEmpty(current.MenuItemDirector))
            {

                MyDirector.Attributes["class"] = current.MenuItemDirector;
            }
            if (current != null && !string.IsNullOrEmpty(current.MenuItemAbout))
            {

                MyAbout.Attributes["class"] = current.MenuItemAbout;
            }
            
        }

        protected void LogOut_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }

    }
}
