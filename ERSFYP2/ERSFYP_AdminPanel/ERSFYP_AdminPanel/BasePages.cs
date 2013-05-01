using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ERSFYP_AdminPanel
{

    public partial class BasePages : System.Web.UI.Page
    {
        public string MenuItemEmployees { get; set; }
        public string MenuItemOthers { get; set; }
        public string MenuItemRelations { get; set; }
        public string MenuItemCategories { get; set; }

        public string Name { get; set; }


        public BasePages()
        {
            Name = "UnSigned";
        }
        
        
        
        public void HookOnFocus(Control CurrentControl)
        {
            //checks if control is one of TextBox, DropDownList, ListBox or Button
            if ((CurrentControl is TextBox) ||
                (CurrentControl is DropDownList) ||
                (CurrentControl is ListBox) ||
                (CurrentControl is Button))
                //adds a script which saves active control on receiving focus 
                //in the hidden field __LASTFOCUS.
                (CurrentControl as WebControl).Attributes.Add(
                   "onfocus",
                   "try{document.getElementById('__LASTFOCUS').value=this.id} catch(e) {}");
            //checks if the control has children
            if (CurrentControl.HasControls())
                //if yes do them all recursively
                foreach (Control CurrentChildControl in CurrentControl.Controls)
                    HookOnFocus(CurrentChildControl);
        }

        public void RestoreFocus()
        {
            Page.ClientScript.RegisterStartupScript(
            typeof(Relations),
            "ScriptDoFocus",
            SCRIPT_DOFOCUS.Replace("REQUEST_LASTFOCUS",
            Request["__LASTFOCUS"]),
            true);
        }
        
        public const string SCRIPT_DOFOCUS =
            @"window.setTimeout('DoFocus()', 1);
            function DoFocus()
            {
                try {
                    document.getElementById('REQUEST_LASTFOCUS').focus();
                } catch (ex) {}
            }";
    }


}