using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ERSFYP_AdminPanel
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            BasePages current = Page as BasePages;



            if (current != null && !string.IsNullOrEmpty(current.MenuItemOthers))
            {
                Others.Attributes["class"] = current.MenuItemOthers;
            }

          

        }

        protected void LogOut_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }

    }
}
