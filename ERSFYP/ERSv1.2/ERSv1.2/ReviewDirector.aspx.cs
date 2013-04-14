using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace ERSv1._2
{
    public partial class ReviewDirector : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
         //   if (Session["UserId"] == null)
          //      Response.Redirect("Default.aspx");
            if (!IsPostBack)
            {
                int DirectorID;
                if (Session["UserId"] != null)
                    DirectorID = Int32.Parse(Session["UserId"].ToString());
                else
                    Response.Redirect("Default.aspx");
                // Check if this person is valid

                int LMID = Int32.Parse(Request.QueryString["LMID"]);

                ERS.BAL.Director Dir = new ERS.BAL.Director();
                ERS.BAL.Reviews rev = new ERS.BAL.Reviews();

                List<ERS.ReviewCategory> Source = rev.GetAllCategories();
                Categories.DataSource = Source;
                Categories.DataBind();

                
                LineManagees.DataSource = Dir.GetManagees(LMID); ;
                LineManagees.DataTextField = "Name";
                LineManagees.DataValueField = "EmpID";
                LineManagees.DataBind();

                if (ViewState["SelCatID"] == null)
                    ViewState["SelCatID"] = Source.First().CategoryID;
                System.Web.UI.HtmlControls.HtmlGenericControl LI2 = (System.Web.UI.HtmlControls.HtmlGenericControl)Categories.Items[0].FindControl("CatLI");
                                LI2.Attributes["class"] = "active";
             
                AllReviews.DataSource = rev.GetAllReviewsOf_Peer_GivenCategory(Int32.Parse(LineManagees.SelectedValue), Int32.Parse(ViewState["SelCatID"].ToString())); ;
                AllReviews.DataBind();
                LMName.InnerHtml = LineManagees.SelectedItem.ToString();



                int lCategoryID = rev.GetCategoryID("Director");
                int LMIDWhoisOn = Int32.Parse(Request.QueryString["LMID"]);
                int EmpID = Int32.Parse(LineManagees.SelectedValue);
                 DirectorID = Int32.Parse(Session["UserId"].ToString());
                int ReviewID = rev.GetReviewID(LMIDWhoisOn, DirectorID, EmpID);
                if (ReviewID != -1)
                {
                    ERS.ReviewInfo RevInfo = rev.GetReviewInfo(ReviewID, lCategoryID);
                    if (RevInfo != null)
                    {
                        CommentsTxt.Text = RevInfo.Comments;
                        RatingsTxt.Text = RevInfo.Rating.ToString();
                    }

                }
            }
            
        }

        protected void ButtonHeading_Click(object sender, EventArgs e)
        {
            
            LinkButton SendButton = (LinkButton)sender;
            int CatID = Int32.Parse(SendButton.CommandArgument);
            var item = (RepeaterItem)SendButton.NamingContainer;
            System.Web.UI.HtmlControls.HtmlGenericControl LI = (System.Web.UI.HtmlControls.HtmlGenericControl)item.FindControl("CatLI");
            LI.Attributes["class"] = "active";
            foreach (RepeaterItem a in Categories.Items)
            {
                System.Web.UI.HtmlControls.HtmlGenericControl LI2 = (System.Web.UI.HtmlControls.HtmlGenericControl)a.FindControl("CatLI");
                if( LI2 != LI )
                    LI2.Attributes["class"] = "";
            }

            ERS.BAL.Reviews rev = new ERS.BAL.Reviews();
            List<ERS.DAL.EmpWithRevInfo_Cat> Source = rev.GetAllReviewsOf_Peer_GivenCategory(Int32.Parse(LineManagees.SelectedValue), CatID);
            AllReviews.DataSource = Source;
            AllReviews.DataBind();

            ViewState["SelCatID"] = CatID;

        }

        protected void LineManagees_SelectedIndexChanged(object sender, EventArgs e)
        {
            LMName.InnerHtml = LineManagees.SelectedItem.ToString();
            ERS.BAL.Reviews rev = new ERS.BAL.Reviews();

            int lCategoryID = rev.GetCategoryID("Director");
            int LMIDWhoisOn = Int32.Parse(Request.QueryString["LMID"]);
            int EmpID = Int32.Parse(LineManagees.SelectedValue);
            int DirectorID = Int32.Parse(Session["UserId"].ToString());
            int ReviewID = rev.GetReviewID(LMIDWhoisOn , DirectorID , EmpID );
            if (ReviewID != -1)
            {
                ERS.ReviewInfo RevInfo = rev.GetReviewInfo(ReviewID, lCategoryID);
                if (RevInfo != null)
                {
                    CommentsTxt.Text = RevInfo.Comments;
                    RatingsTxt.Text = RevInfo.Rating.ToString();
                }
            }
            else
            {
                CommentsTxt.Text = "";
                RatingsTxt.Text = "";
            }

           // ERS.BAL.Reviews rev = new ERS.BAL.Reviews();
            List<ERS.DAL.EmpWithRevInfo_Cat> Source = rev.GetAllReviewsOf_Peer_GivenCategory(Int32.Parse(LineManagees.SelectedValue), Int32.Parse(ViewState["SelCatID"].ToString()));
            AllReviews.DataSource = Source;
            AllReviews.DataBind();
        }

        protected void AllReviews_RowDataBound(object sender, GridViewRowEventArgs e)
        {
              try
            {
                switch (e.Row.RowType)
                {

                    case DataControlRowType.Header:
                        //...
                        break;

                    case DataControlRowType.DataRow:
                        int LMIDWhoisOn = Int32.Parse(Request.QueryString["LMID"]);
                        
                        int LMID = (int)((GridView)sender).DataKeys[e.Row.RowIndex]["ID"];
                        if (LMID == LMIDWhoisOn)
                        {
                            e.Row.BackColor = Color.FromArgb(229, 229, 229);
                            e.Row.BorderWidth = 4;
                        }break;
                }
            }
              catch
              {
                  //...throw
              }
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            ERS.BAL.Reviews rev = new ERS.BAL.Reviews();
            int LMIDWhoisOn = Int32.Parse(Request.QueryString["LMID"]);
            int EmpID = Int32.Parse(LineManagees.SelectedValue);
            int  DirectorID = Int32.Parse(Session["UserId"].ToString());
            // Creating Review For CrossLevel ( THere must be a seperat fun calling addReview in BAL )
            int ReviewID = rev.AddReview(EmpID, LMIDWhoisOn , DirectorID , "Directors Feedback");
            int lCategoryID = rev.GetCategoryID("Director");
            Double lRating = Double.Parse(RatingsTxt.Text);
            String lComments = CommentsTxt.Text;

            // THe statement Below should be done by rev.AddReviewInfo 
            rev.InsertReviewInfo( lCategoryID,  lComments, (decimal)lRating, ReviewID );

            AllReviews.DataSource = rev.GetAllReviewsOf_Peer_GivenCategory(Int32.Parse(LineManagees.SelectedValue), Int32.Parse(ViewState["SelCatID"].ToString())); ;
            AllReviews.DataBind();
            
           


        }
    }
}