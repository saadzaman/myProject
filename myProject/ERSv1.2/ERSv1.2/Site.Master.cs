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

    }
}
