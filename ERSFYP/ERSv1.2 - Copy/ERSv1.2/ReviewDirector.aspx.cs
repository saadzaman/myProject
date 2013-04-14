using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ERSv1._2
{
    public partial class ReviewDirector : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            if (Session["UserId"] == null)
                Response.Redirect("Default.aspx");
            if (Request.QueryString["SRI"] != null && !IsPostBack)
            {
                int ReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                //  bool isDirector = rev.isEmpOfReview(Int32.Parse(Session["UserID"].ToString()), ReviewID);
                // If not goto Default  
               // ERS.BAL.Reviews rev = new ERS.BAL.Reviews();
               // List<ERS.DAL.EmpWithRevInfo_Cat> Source = rev.GetAllReviewsOf_Peer_GivenCategory(Int32.Parse(ViewState["EmpID"].ToString()), a);
              //  AllReviews.DataSource = Source;
              //  AllReviews.DataBind();
            }
        }
    }
}