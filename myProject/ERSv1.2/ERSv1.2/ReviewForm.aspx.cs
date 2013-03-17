using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ERSv1._2
{
    public partial class ReviewForm : BasePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {   
            MenuItemMyReviews = "active";
            string referer = Request.UrlReferrer.ToString();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            if (Session["isLM"].Equals(false))
            {
                PeerPanel.Visible = false;
                LineManagerRating.Visible = false;
                DirectorRating.Visible = false;
                CalcRating.Visible = false;
            }
            
            if (Request.QueryString["SRI"] != null && !IsPostBack)
            {
                int ReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                //Whose Review is filled/has been filled
                int EmpID = Int32.Parse(Request.QueryString["ROE"].ToString());
                ViewState["ReviewID"] = ReviewID;
                ViewState["EmpID"] = EmpID;
                ERS.BAL.Reviews rev = new ERS.BAL.Reviews();
                ERS.DAL.EmployeeWithLM ReviewedEmp = rev.GetEmployee(EmpID);
                LMName.InnerText = ReviewedEmp.CurrEmployeeLM.Name;
                EmpName.InnerText = ReviewedEmp.CurrEmployee.Name;
                EmpDesignation.InnerText = ReviewedEmp.CurrEmployee.Position.PositionName;
                Categories.DataSource = rev.GetAllCategories();
                Categories.DataBind();
               // if (Request.QueryString["type"] == "show")
               // {
                ViewState["PreviousPageUrl"] = Request.UrlReferrer.ToString();
                    foreach (RepeaterItem a in Categories.Items)
                    {
                         int pReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                         int pCategoryID = Int32.Parse((a.FindControl("CatID") as HiddenField).Value);
                         bool isDraft = rev.isDraft(ReviewID);
                        
                             ERS.ReviewInfo RevInfo = rev.GetReviewInfo(ReviewID, pCategoryID);
                             if(RevInfo != null )
                             {
                                 TextBox RatingsTxt = (a.FindControl("RatingsTxt") as TextBox);
                                 RatingsTxt.Text = RevInfo.Rating.ToString();
                                 if(!isDraft)
                                 RatingsTxt.Enabled = false;
                                 TextBox CommentsTxt = (a.FindControl("CommentsTxt") as TextBox);
                                 CommentsTxt.Text = RevInfo.Comments.ToString();
                                 if (!isDraft)
                                 CommentsTxt.Enabled = false;
                             }
                         

                    }
                //}
            }
           
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (!Session["isLM"].Equals(false))
            {
                LinkButton SendButton = (LinkButton)sender;
                int a = Int32.Parse(SendButton.CommandArgument);
                ERS.BAL.Reviews rev = new ERS.BAL.Reviews();
                List<ERS.DAL.EmpWithRevInfo_Cat> Source = rev.GetAllReviewsOf_Peer_GivenCategory(Int32.Parse(ViewState["EmpID"].ToString()), a);
                PeerReviews.DataSource = Source;
                PeerReviews.DataBind();
            }
          
          //  lblHelloWorld.Text = "Hello, world - this is a fresh message from ASP.NET AJAX! The time right now is: " + DateTime.Now.ToLongTimeString();
        }

        protected void submit_Click(object sender, EventArgs e)
        {

            List<ERS.ReviewInfo> Result = new List<ERS.ReviewInfo>();
            foreach (RepeaterItem a in Categories.Items)
            {
                int pReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                int pCategoryID = Int32.Parse((a.FindControl("CatID") as HiddenField).Value);
                Double pRating = Double.Parse((a.FindControl("RatingsTxt") as TextBox).Text);
                String pComments = (a.FindControl("CommentsTxt") as TextBox).Text;
                Result.Add(new ERS.ReviewInfo() { CategoryID = pCategoryID, Comments = pComments, Rating = (decimal)pRating, ReviewId = pReviewID });
            
            }
            ERS.BAL.Reviews rev = new ERS.BAL.Reviews();
            rev.FillReviews(Int32.Parse(Request.QueryString["SRI"].ToString()), Result , "submit");
            Response.Redirect(ViewState["PreviousPageUrl"].ToString());
        }

        protected void save_Click(object sender, EventArgs e)
        {

            List<ERS.ReviewInfo> Result = new List<ERS.ReviewInfo>();
            foreach (RepeaterItem a in Categories.Items)
            {
                int pReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                int pCategoryID = Int32.Parse((a.FindControl("CatID") as HiddenField).Value);
                TextBox RatingTxt = (a.FindControl("RatingsTxt") as TextBox);
                TextBox CommentsTxt = (a.FindControl("CommentsTxt") as TextBox);
                 Double pRating = 0 ;
                if(RatingTxt.Text.Length > 0 )   
                pRating = (Double.Parse(RatingTxt.Text));
                    String pComments = CommentsTxt.Text;
                

                Result.Add(new ERS.ReviewInfo() { CategoryID = pCategoryID, Comments = pComments, Rating = (decimal)pRating, ReviewId = pReviewID });

            }
            ERS.BAL.Reviews rev = new ERS.BAL.Reviews();
            rev.FillReviews(Int32.Parse(Request.QueryString["SRI"].ToString()), Result, "save");
            Response.Redirect(ViewState["PreviousPageUrl"].ToString());
        }
    }
}