using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ERS.BAL;

namespace ERSv1._2
{
    public partial class ReviewForm : BasePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {   
            MenuItemMyReviews = "active";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            if (Session["UserId"] == null)
                Response.Redirect("Default.aspx");
            if (Request.QueryString["SRI"] != null && !IsPostBack)
            {

                   

                string referer = Request.UrlReferrer.ToString();           
                int ReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                //int EmpID = Int32.Parse(Request.QueryString["ROE"].ToString());
                
                            
                ERS.BAL.Reviews rev = new ERS.BAL.Reviews();
                ERS.DAL.EmployeeWithLM ReviewedEmp = rev.GetEmployeeFromReview(ReviewID);
                LMName.InnerText = ReviewedEmp.CurrEmployeeLM.Name;
                EmpName.InnerText = ReviewedEmp.CurrEmployee.Name;
                EmpDesignation.InnerText = ReviewedEmp.CurrEmployee.Position.PositionName;

                
                    bool isLMOfReview = rev.isLMOfReview(Int32.Parse(Session["UserID"].ToString()), ReviewID);
                    bool isEmpOfReview = rev.isEmpOfReview(Int32.Parse(Session["UserID"].ToString()), ReviewID);
                    if (!(isLMOfReview || isEmpOfReview))
                        Response.Redirect("Default.aspx");
                    if (isLMOfReview && Request.QueryString["type"] == "show")
                    {
                        PeerPanel.Visible = false;
                        LineManagerRating.Visible = false;
                        DirectorRating.Visible = false;
                        CalcRating.Visible = false;
                        submit.Visible = false;
                        save.Visible = false;
                    }
                    else if (isLMOfReview && Request.QueryString["type"] == "consolidate")
                    {
                        PeerPanel.Visible = true;
                        LineManagerRating.Visible = true;
                        DirectorRating.Visible = false;
                        CalcRating.Visible = false;
                        submit.Visible = true;

                    }
                    else
                    {
                        PeerPanel.Visible = false;
                        LineManagerRating.Visible = false;
                        DirectorRating.Visible = false;
                        CalcRating.Visible = false;
                        submit.Visible = false;
                        save.Visible = false;
                    }

               

                ViewState["PreviousPageUrl"] = Request.UrlReferrer.ToString();
                ViewState["ReviewID"] = ReviewID;
                ViewState["EmpID"] = ReviewedEmp.CurrEmployee.EmpID;
                
                Categories.DataSource = rev.GetAllCategories();
                Categories.DataBind();
                bool toShowOrNot = true;
                String Type = rev.GetType(ReviewID);

                if (Type != null)
                {
                    if (Type == "Complete")
                    {
                        toShowOrNot = false;
                        submit.Visible = false;
                        save.Visible = false;
                    }
                    else if (Type == "Draft" || Type == "Pending" )
                    {
                        toShowOrNot = true;
                        submit.Visible = true;
                        save.Visible = true;
                    }
                }
                
                    foreach (RepeaterItem a in Categories.Items)
                    {
                         int pReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                         int pCategoryID = Int32.Parse((a.FindControl("CatID") as HiddenField).Value);
                         String str = rev.GetType(ReviewID);
                        
                             ERS.ReviewInfo RevInfo = rev.GetReviewInfo(ReviewID, pCategoryID);
                             if(RevInfo != null )
                             {
                                 TextBox RatingsTxt = (a.FindControl("RatingsTxt") as TextBox);
                                 RatingsTxt.Text = RevInfo.Rating.ToString();
                                 RatingsTxt.Enabled = toShowOrNot;

                                 TextBox CommentsTxt = (a.FindControl("CommentsTxt") as TextBox);
                                 CommentsTxt.Text = RevInfo.Comments.ToString();
                                 CommentsTxt.Enabled = toShowOrNot;

                             }

                    }

                    if (Session["isLM"].Equals(true))
                    {
                         ERS.ReviewInfo RevInfo = rev.GetReviewInfo(ReviewID, 4);
                         if(RevInfo != null )
                             {
                                 LMCommentsTxt.Text = RevInfo.Comments;
                                 LMRatingsTxt.Text = RevInfo.Rating.ToString();
                            }
                    }


                    
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
            Reviews rev = new Reviews();
            List<ERS.ReviewInfo> Result = new List<ERS.ReviewInfo>();
            int pReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
            foreach (RepeaterItem a in Categories.Items)
            {
              
                int pCategoryID = Int32.Parse((a.FindControl("CatID") as HiddenField).Value);
               
                Double pRating = Double.Parse((a.FindControl("RatingsTxt") as TextBox).Text);
                String pComments = (a.FindControl("CommentsTxt") as TextBox).Text;
                Result.Add(new ERS.ReviewInfo() { CategoryID = pCategoryID, Comments = pComments, Rating = (decimal)pRating, ReviewId = pReviewID });
            
            }
            // FOR LM 
            bool isLMOfReview = rev.isLMOfReview(Int32.Parse(Session["UserID"].ToString()), pReviewID);
            if (Session["isLM"].Equals(true) && isLMOfReview)
            {
                int lReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                int lCategoryID = 4;
                Double lRating = Double.Parse(LMRatingsTxt.Text);
                String lComments = LMCommentsTxt.Text;
                Result.Add(new ERS.ReviewInfo() { CategoryID = lCategoryID, Comments = lComments, Rating = (decimal)lRating, ReviewId = lReviewID });
            }
            //ERS.BAL.Reviews rev = new ERS.BAL.Reviews();
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
            Reviews rev = new Reviews();
            int ReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
            bool isLMOfReview = rev.isLMOfReview(Int32.Parse(Session["UserID"].ToString()), ReviewID);
            //if(isLMOfReview)
               
            rev.FillReviews(Int32.Parse(Request.QueryString["SRI"].ToString()), Result, "save");
            Response.Redirect(ViewState["PreviousPageUrl"].ToString());
        }
    }
}