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

        protected void rep_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
         
        }
        protected void Page_Load(object sender, EventArgs e)
        {   

            // Init , check session
            MenuItemMyReviews = "active";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            if (Session["UserId"] == null)
                Response.Redirect("Default.aspx");

           
            if (Request.QueryString["SRI"] != null && !IsPostBack)
            {
                string referer = Request.UrlReferrer.ToString();
                int ReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                
                ERS.BAL.Reviews rev = new ERS.BAL.Reviews();
                String Type = rev.GetType(ReviewID);
                ERS.DAL.EmployeeWithLM ReviewedEmp = rev.GetEmployeeFromReview(ReviewID);
                LMName.InnerText = ReviewedEmp.CurrEmployeeLM.Name;
                EmpName.InnerText = ReviewedEmp.CurrEmployee.Name;
                EmpDesignation.InnerText = ReviewedEmp.CurrEmployee.Position.PositionName;

                
                bool isLMOfReview = rev.isLMOfReview(Int32.Parse(Session["UserID"].ToString()), ReviewID);
                bool isEmpOfReview = rev.isEmpOfReview(Int32.Parse(Session["UserID"].ToString()), ReviewID);
                // Is it LM's Filled Review For Employee
                bool LMSConsolidation = rev.isLMSConsolidation(ReviewID);
                    
                // If this review is opened by someone who is not LM of this review 
                // OR it is opened by employee himself or Reviewer Self OR Reviewers


                //Setting all to false;
                PeerPanel.Visible = false;
                LineManagerRating.Visible = false;
                DirectorRating.Visible = false;
                CalcRating.Visible = false;
                submit.Visible = false;
                save.Visible = false;
                Reject.Visible = false;


                 if (!(isLMOfReview || isEmpOfReview))
                        Response.Redirect("Default.aspx");

                // LM Opens for seeing And is not his own consolidation
                if (isLMOfReview && LMSConsolidation)
                    {
                        PeerPanel.Visible = true;
                        LineManagerRating.Visible = true;
                        Reject.Visible = false;
                    }
                else if ( isLMOfReview &&  Type == "Solicitation"  )
                    {
                        PeerPanel.Visible = true;
                        Reject.Visible = true;
                    }
               
                   
                    else
                    {   // Review is opened by an Employee
                        PeerPanel.Visible = false;
                        LineManagerRating.Visible = false;
                        DirectorRating.Visible = false;
                        CalcRating.Visible = false;
                        submit.Visible = false;   // Disabling , will enable after querying and gettiing actual status of review
                        save.Visible = false;
                        Reject.Visible = false;
                    }

               
               
                // Save in Viewstate
                ViewState["PreviousPageUrl"] = Request.UrlReferrer.ToString();
                ViewState["ReviewID"] = ReviewID;
                ViewState["EmpID"] = ReviewedEmp.CurrEmployee.EmpID;

                // Load Cats
                Categories.DataSource = rev.GetCategories();
                Categories.DataBind();


                # region Decide To Show LM Comment Or Not

                bool toShowOrNot = true;
                String StatusOfCurrentReview = rev.GetStatus(ReviewID);
                if (StatusOfCurrentReview != null)
                {
                    if (StatusOfCurrentReview == "Complete")
                    {
                        toShowOrNot = false;
                        submit.Visible = false;
                        save.Visible = false;
                    }
                    else if (StatusOfCurrentReview != "Rejected")
                    {
                        toShowOrNot = true;
                        submit.Visible = true;
                        save.Visible = true;
                    }
                }
                #endregion

                # region Loading Saved Text

                foreach (RepeaterItem a in Categories.Items)
                    {
                         int pReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                         int pCategoryID = Int32.Parse((a.FindControl("CatID") as HiddenField).Value);
                         String str = rev.GetStatus(ReviewID);
                        
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
                        int lCategoryID = rev.GetCategoryID("LineManager");
                         ERS.ReviewInfo RevInfo = rev.GetReviewInfo(ReviewID,lCategoryID);
                         if(RevInfo != null )
                             {
                                 LMCommentsTxt.Text = RevInfo.Comments;
                                 LMRatingsTxt.Text = RevInfo.Rating.ToString();
                                 LMCommentsTxt.Enabled = toShowOrNot;
                                 LMRatingsTxt.Enabled = toShowOrNot;
                            }
                    }


                 #endregion

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
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            Reviews rev = new Reviews();
            List<ERS.ReviewInfo> Result = new List<ERS.ReviewInfo>();
            int pReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
            
            // Filling Categories Comments & Ratings
            foreach (RepeaterItem a in Categories.Items)
            {
                int pCategoryID = Int32.Parse((a.FindControl("CatID") as HiddenField).Value);
                Double pRating = Double.Parse((a.FindControl("RatingsTxt") as TextBox).Text);
                String pComments = (a.FindControl("CommentsTxt") as TextBox).Text;

                // THe statement Below should be done by rev.AddReviewInfo 
                Result.Add(new ERS.ReviewInfo() { CategoryID = pCategoryID, Comments = pComments, Rating = (decimal)pRating, ReviewId = rev.GetAReviewID(pReviewID) });
            }

            // Filling LMS Comments and Ratings 
            bool isLMOfReview = rev.isLMOfReview(Int32.Parse(Session["UserID"].ToString()), pReviewID);
            if (Session["isLM"].Equals(true) && isLMOfReview)
            {
                int lReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                int lCategoryID = rev.GetCategoryID("LineManager");
                Double lRating = Double.Parse(LMRatingsTxt.Text);
                String lComments = LMCommentsTxt.Text;

                // THe statement Below should be done by rev.AddReviewInfo 
                Result.Add(new ERS.ReviewInfo() { CategoryID = lCategoryID, Comments = lComments, Rating = (decimal)lRating, ReviewId = rev.GetAReviewID(lReviewID) });
            }
            
            //If Review is filled by LM , its consolidated if by employee its just filled
            if( isLMOfReview)
                rev.FillReviews(Int32.Parse(Request.QueryString["SRI"].ToString()), Result, "Consolidated");
            else
                rev.FillReviews(Int32.Parse(Request.QueryString["SRI"].ToString()), Result, "Completed");
            
            Response.Redirect(ViewState["PreviousPageUrl"].ToString());
        }

        protected void save_Click(object sender, EventArgs e)
        {
            Reviews rev = new Reviews();
            List<ERS.ReviewInfo> Result = new List<ERS.ReviewInfo>();
            
           // SaveCategories Comments and Ratings
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
                
                // DO IT VIA ADD REVIEW bitch
                Result.Add(new ERS.ReviewInfo() { CategoryID = pCategoryID, Comments = pComments, Rating = (decimal)pRating, ReviewId = rev.GetAReviewID(pReviewID) });

            }
           
            int ReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
            bool isLMOfReview = rev.isLMOfReview(Int32.Parse(Session["UserID"].ToString()), ReviewID);
            
            // Saving LM's
            if (Session["isLM"].Equals(true) && isLMOfReview)
            {
                int lReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
                int lCategoryID = rev.GetCategoryID("LineManager");
                Double lRating = Double.Parse(LMRatingsTxt.Text);
                String lComments = LMCommentsTxt.Text;

                // THe statement Below should be done by rev.AddReviewInfo 
                Result.Add(new ERS.ReviewInfo() { CategoryID = lCategoryID, Comments = lComments, Rating = (decimal)lRating, ReviewId = rev.GetAReviewID(lReviewID) });
            }
               
            rev.FillReviews(Int32.Parse(Request.QueryString["SRI"].ToString()), Result, "Drafted");
            Response.Redirect(ViewState["PreviousPageUrl"].ToString());
        }


        protected void Reject_Click(object sender, EventArgs e)
        {
            Reviews rev = new Reviews();
            int ReviewID = Int32.Parse(Request.QueryString["SRI"].ToString());
            rev.RejectReview(ReviewID, FeedbackTxt.Text.ToString(), Int32.Parse(Session["UserID"].ToString()));
            Response.Redirect(ViewState["PreviousPageUrl"].ToString());
            
        }
    }
}