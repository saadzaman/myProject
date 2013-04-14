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
            int DirectorID = -1;
            if(Session["UserId"]!=null)
           DirectorID = Int32.Parse(Session["UserId"].ToString());
            else
           Response.Redirect("Default.aspx");
            
            if (!IsPostBack)
            { 
            ERS.BAL.Director DirectorInst = new ERS.BAL.Director();
            LineManagerList.DataSource = DirectorInst.GetLineManagers(DirectorID);
            LineManagerList.DataBind();
            }

        }

        protected void LineManagerList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowIndex = Int32.Parse(e.CommandArgument.ToString());
            int LMID = (int)((GridView)sender).DataKeys[rowIndex]["LMID"];
          
            Response.Redirect("ReviewDirector.aspx?LMID=" +  LMID);
        }

        protected void LineManagerList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                switch (e.Row.RowType)
                {

                    case DataControlRowType.Header:
                        //...
                        break;

                    case DataControlRowType.DataRow:


                        Label ConsoReport = (Label)e.Row.FindControl("ConsoReport");
                        int LMID = (int)((GridView)sender).DataKeys[e.Row.RowIndex]["LMID"];
                        ERS.BAL.Director Dir = new ERS.BAL.Director();
                        if (Dir.AreReviewPending(LMID))
                            ConsoReport.Text = "All Requested Reviews Filled";
                        else
                             ConsoReport.Text = "Reviews Are Pending ";

                        break;
                }
            }
            catch
            {
                //...throw
            }
        }
    }
}