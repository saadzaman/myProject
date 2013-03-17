using System;using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using ERS.BAL;
using System.Web.UI.WebControls;

namespace ERSv1._2
{
    public partial class MyManagees :BasePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            MenuItemMyManagees = "active";
            Session["LMID"] = 2;
            Session["UserType"] = "LM";
       
            
            if (!IsPostBack)
            {
                ERS.BAL.Managees BManagees = new Managees();
                ManageeList.DataSource = BManagees.GetManageesList((int)Session["LMID"]);
                ManageeList.DataBind();
                
            }
          }

        protected void ManageePeers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            
            // This is the Review ID of his LineManagee with that Particular Peer
            int ReviewID = (int)((GridView)sender).DataKeys[rowIndex]["ReviewID"];
            GridViewRow row = ((GridView)sender).Rows[rowIndex];
            
            switch (e.CommandName.ToString())
            {
                case "Show":

                    // I , LineManager Of  "ImPeerOf"( A employee of which a peer is selected ) 
                    // wants to see what the peer has filled about my LineManagee
                    //Session["ShowReviewOfID"] = ReviewID;    //ReviewID
                    int EmpID = Int32.Parse((row.FindControl("ImPeerOf") as HiddenField).Value);  // He is the Person i.e LM's Managee whose review will be Opened
                    int peerID = Int32.Parse((row.FindControl("PeerID") as HiddenField).Value);
                    Response.Redirect("ReviewForm.aspx?type=show&ROE=" + EmpID + "&SRI=" + ReviewID);

                    break;

                case "Ask":

                        ERS.DAL.ERSRepository Rep = new ERS.DAL.ERSRepository();
                        ERS.Review temp = new ERS.Review();
                        temp.Date =  DateTime.Now;
                        EmpID = Int32.Parse((row.FindControl("ImPeerOf") as HiddenField).Value);
                        peerID = Int32.Parse((row.FindControl("PeerID") as HiddenField).Value);
                        temp.EmpID = EmpID;
                        temp.LMID = Int32.Parse( Session["LMID"].ToString() );
                        temp.IsActive = 0;
                        temp.Status = 2;
                        temp.version = 1;
                        temp.ReviewTypeID = 0;
                        temp.feedback = "None";
                        temp.ReviewerID = peerID;
                     


                        Rep.InsertReview(temp);
                        string script = "alert('" + "A Request Has Been Sent" + "')";
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "UserSecurity", script, true);
                        ((GridView)sender).DataBind();

                    break;


            }
        }

       

        protected void ManageeList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            

            switch (e.CommandName.ToString())
            {
              case "ShowPeers":

                    int rowIndex = int.Parse(e.CommandArgument.ToString());
                    // Which is one of LM's ManageeID
                    int EmpID = (int)((GridView)sender).DataKeys[rowIndex]["EmpID"];
                    GridViewRow row = ((GridView)sender).Rows[rowIndex];
                  
                    Managees BManagees = new Managees();
                    GridView Peers = (GridView) row.FindControl("ManageePeers");
                    Peers.DataSource = null;

                    Peers.DataSource = BManagees.GetPeerList(EmpID);
                    Peers.DataBind();

                    break;

                case "Consolidate":

                   

                    break;


            }
        }


        #region Visuals
        protected void ManageeList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                switch (e.Row.RowType)
                {

                    case DataControlRowType.Header:
                        //...
                        break;

                    case DataControlRowType.DataRow:

                        List<Review> mylist = (List<Review>)((GridView)sender).DataSource;
                        Button ConsoBtn = (Button)e.Row.FindControl("ConsoBtn");
                           
                        if (mylist[e.Row.RowIndex].isReady)
                            ConsoBtn.Enabled = false;
                        else
                            ConsoBtn.Enabled = true;  
                       
                        break;
                }
            }
            catch
            {
                //...throw
            }
        }

        protected void ManageePeers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                switch (e.Row.RowType)
                {

                    case DataControlRowType.Header:
                        //...
                        break;

                    case DataControlRowType.DataRow:

                        List<ERS.DAL.PeersWithReviews> mylist = (List<ERS.DAL.PeersWithReviews>)((GridView)sender).DataSource;

                        if (mylist[e.Row.RowIndex].Status == "1") //Completed
                        {
                            Button AskButton = (Button)e.Row.FindControl("AskButton");
                            AskButton.Visible = false;
                        }
                        else if (mylist[e.Row.RowIndex].Status == "2") //Pending 
                        {
                            Button AskButton = (Button)e.Row.FindControl("AskButton");
                            AskButton.Visible = false;
                            Button ShowButton = (Button)e.Row.FindControl("ShowButton");
                            ShowButton.Visible = false;
                        }
                        else if (mylist[e.Row.RowIndex].Status == "0") //NotAsked 
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


        protected void ManageePeers_DataBound(object sender, EventArgs e)
        {
            GridView ManageeList = (GridView)sender;
            // ManageeList.HeaderRow.TableSection = TableRowSection.TableHeader;

        }

        protected void ManageeList_DataBound(object sender, EventArgs e)
        {
            ManageeList.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        #endregion
    }
}