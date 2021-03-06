﻿using System;using System.Collections.Generic;
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
            if (Session["UserId"] == null)
                Response.Redirect("Default.aspx");
            if (!IsPostBack)
            {
                ERS.BAL.Managees BManagees = new Managees();
                ManageeList.DataSource = BManagees.GetManageesList((int)Session["UserID"]);
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

                    int EmpID = Int32.Parse((row.FindControl("ImPeerOf") as HiddenField).Value);  // He is the Person i.e LM's Managee whose review will be Opened
                    int peerID = Int32.Parse((row.FindControl("PeerID") as HiddenField).Value);
                    Response.Redirect("ReviewForm.aspx?ROE=" + EmpID + "&SRI=" + ReviewID);

                    break;

                case "Ask":

                       // ERS.DAL.ERSRepository Rep = new ERS.DAL.ERSRepository();
                       // ERS.Review temp = new ERS.Review();
                       // temp.Date =  DateTime.Now;
                        Reviews rev = new Reviews();
                        EmpID = Int32.Parse((row.FindControl("ImPeerOf") as HiddenField).Value);
                        peerID = Int32.Parse((row.FindControl("PeerID") as HiddenField).Value);
                        rev.AddReview(EmpID, (int)Session["UserID"], peerID, "None" , "Solicitation");
                        
                        string script = "OnSelectedIndexChange();";
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "UserSecurity", script, true);
                        GridView Peers = ((GridView)sender);
                            Managees BManagees = new Managees();
                            int LMID = Int32.Parse(Session["UserId"].ToString());
                            Peers.DataSource = BManagees.GetPeerList(EmpID,LMID);
                            Peers.DataBind();
                           

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
                    int LMID = Int32.Parse(Session["UserId"].ToString());
                    Peers.DataSource = BManagees.GetPeerList(EmpID,LMID);
                    Peers.DataBind();
                    Reviews rev = new Reviews();
                    rev.AddReview(EmpID, LMID, EmpID, "Self" , "Solicitation");
                    
                    // Label Fail = (row.FindControl("Fail") as Label);
                    // Fail.Text = rev.GetType(SelfId);
                    
                     break;

                case "Consolidate":

                    rev = new Reviews();
                    rowIndex = int.Parse(e.CommandArgument.ToString());
                    row = ((GridView)sender).Rows[rowIndex];
                    EmpID = (int)((GridView)sender).DataKeys[rowIndex]["EmpID"];
                    int ReviewID = rev.CreateReviewForConsolidate(EmpID, (int)Session["UserID"]);
                    Response.Redirect("ReviewForm.aspx?OpenedFor=consolidate&ROE=" + EmpID + "&SRI=" + ReviewID);

                    


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

                        int LMID = Int32.Parse(Session["UserId"].ToString());
                        Button ConsoBtn = (Button)e.Row.FindControl("ConsoBtn");
                        List<ERS.DAL.Managees> mylist = (List<ERS.DAL.Managees>)((GridView)sender).DataSource;
                        int EmpID = (int)((GridView)sender).DataKeys[e.Row.RowIndex]["EmpID"];
                        Managees BALManageeInst = new Managees();
                        Reviews RevInst = new Reviews();

                        if (BALManageeInst.CanConsolidate(EmpID))
                            ConsoBtn.Enabled = true;
                        else
                            ConsoBtn.Enabled = false;

                        if (BALManageeInst.isConsolidated(EmpID, LMID))
                            ConsoBtn.Text = "Show Consolidated Review";
                       
                     Label Fail = (e.Row.FindControl("Fail") as Label);

                     if (RevInst.GetStatus(LMID, EmpID) == "Completed")
                         ConsoBtn.ToolTip = "Self Review Has Been Filled By This Managee";
                     else
                         ConsoBtn.ToolTip = "Self Review Has Not Been Filled";

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

                        if (mylist[e.Row.RowIndex].Status == "Completed") //Completed
                        {
                            Button AskButton = (Button)e.Row.FindControl("AskButton");
                            AskButton.Visible = false;
                        }
                        else if (mylist[e.Row.RowIndex].Status == "Rejected") 
                        {
                            Button AskButton = (Button)e.Row.FindControl("AskButton");
                            AskButton.Visible = false;
                            Button ShowButton = (Button)e.Row.FindControl("ShowButton");
                            ShowButton.Visible = true;
                            ShowButton.Text = "See Rejected Review";
                        }

                        else if (mylist[e.Row.RowIndex].Status == "0") //NotAsked // Default Status
                        {
                            Button ShowButton = (Button)e.Row.FindControl("ShowButton");
                            ShowButton.Visible = false;

                        }
                        else //(mylist[e.Row.RowIndex].Status == "2") //Pending 
                        {
                            Button AskButton = (Button)e.Row.FindControl("AskButton");
                            AskButton.Visible = false;
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