using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ERS.BAL;

namespace ERSv1._2
{
    public partial class Director :BasePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MenuItemDirector = "active";
           /*int DirectorID = Int32.Parse(Session["UserId"].ToString());
            if (!IsPostBack)
            { 
            ERS.BAL.Director DirectorInst = new ERS.BAL.Director();
            LineManagerList.DataSource = DirectorInst.GetLineManagers(DirectorID);
            LineManagerList.DataBind();
            }*/

        }
    }
}