using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ERS.BAL;
namespace ERSv1._2
{
    public partial class MyReviews : BasePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          //   Permissions perm = new Permissions();
          //  perm.Insert(1, 2);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            MenuItemMyReviews = "active";
            if (Session["UserId"] == null)
                Response.Redirect("Default.aspx");

            if (!IsPostBack)
            {
                Reviews BReviews = new Reviews();
                ReviewList.DataSource = BReviews.GetReviewsList((Int32)Session["UserID"]);
                ReviewList.DataBind();
            }
        }

        protected void ReviewList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                switch (e.Row.RowType)
                {

                    case DataControlRowType.Header:
                        //...
                        break;
                    
                    case DataControlRowType.DataRow:

                        List<ERS.DAL.EmployeeReviews> mylist = (List<ERS.DAL.EmployeeReviews>)ReviewList.DataSource;

                                if (mylist[e.Row.RowIndex].Status == 1)
                                {
                                    Button FillButton = (Button)e.Row.FindControl("FillButton");
                                    FillButton.Visible = false;
                                }
                                else
                                {
                                    Button ShowButton = (Button)e.Row.FindControl("ShowButton");
                                    ShowButton.Visible = false;
                                }
                                break;
                }
            }
            catch
            {
                //...throw
            }

        }

        protected void ReviewList_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            int rowIndex = int.Parse(e.CommandArgument.ToString());
            int ReviewID = (int)ReviewList.DataKeys[rowIndex]["ReviewID"];
            GridViewRow row = ((GridView)sender).Rows[rowIndex];

            switch (e.CommandName.ToString())
            {
                case "Show":

                                    
                    // When You Are A normal employee in this screen
                    // When You Are Seeing , You were the reviewee and you want to see what you have filled .
                    // Of that Employee
                    int a = Int32.Parse((row.FindControl("EmpID") as HiddenField).Value);
                   // Session["ReviewOfEmployee"] = a;
                   // Session["ShowReviewOfID"] = ReviewID;
                    Response.Redirect("ReviewForm.aspx?type=show&ROE=" + a + "&SRI=" + ReviewID);

                    break;

                case "Fill":
                    
                    
                    // When You Are A normal employee in this screen
                    // You will always be filling Review of Someone .. which is EmpID
                    a = Int32.Parse((row.FindControl("EmpID") as HiddenField).Value);
                    //Session["ReviewOfEmployee"] = a;
                    //Session["ShowReviewOfID"] = ReviewID;
                    Response.Redirect("ReviewForm.aspx?ROE="+a+"&SRI=" + ReviewID);

                    break;
            
            
            }
        }



       

      
    }
}