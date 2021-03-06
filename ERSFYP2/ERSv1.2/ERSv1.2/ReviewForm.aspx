﻿<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/Site.Master"  AutoEventWireup="true" CodeBehind="ReviewForm.aspx.cs" Inherits="ERSv1._2.ReviewForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

<script  type="text/javascript" >

    function hideDiv(divID) {
        $('#' + divID).hide(500);
    }

    function showDiv(divID) {
        $('#' + divID).show(500);

    }

    function toggle(divID) {
        if ($('#' + divID).css('display') == 'block')
            hideDiv(divID);
        else
            showDiv(divID);
    }



</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <asp:ScriptManager ID="MainScriptManager" runat="server" />

<fieldset>
       
     
       <legend>Review Form</legend>
<div class="row">  
        <div class="span6">
            <fieldset>
                <div class="well">
                            
        <asp:Repeater id="Categories" runat="server">
                <ItemTemplate>
                 
                                <div class="control-group">
                                    <h3>
                                     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                     <ContentTemplate> 
                                       <asp:LinkButton ID="ButtonHeading" CommandArgument='<%# Eval("CategoryID") %>'  OnClientClick='<%#string.Format("toggle(\"{0}\");", Eval("CategoryID"))%>'  runat="server" onclick="LinkButton1_Click"><%# Eval("CategoryName")%></asp:LinkButton>
                                     </ContentTemplate>  
                                    </asp:UpdatePanel>
                                    </h3>
                                    <div id="<%# Eval("CategoryID") %>" class="dontShow">
                                    <asp:HiddenField ID="CatID" runat="server" Value='<%# Eval("CategoryID") %>' />
                                             <div class="control-group">
                                                    <label class="control-label" for="Ratings">Ratings</label>
                                                    <div class="controls">
                                                        
                                                      <asp:TextBox ID="RatingsTxt" Columns="70" Rows="3" runat="server"></asp:TextBox>
                                                      <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="RatingsTxt" Type="Double" MinimumValue="1" MaximumValue="5" ErrorMessage="RangeValidator"></asp:RangeValidator>
                                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator2"  ValidationGroup="FillReview" runat="server" ControlToValidate="RatingsTxt" ErrorMessage="Please Insert Ratings"></asp:RequiredFieldValidator>
                                                     </div>
                                             </div>

	                                         <div class="control-group">
                                                    <label class="control-label" for="Comments">Comments</label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="CommentsTxt" runat="server" TextMode="MultiLine" Width="250px" ValidationGroup="FillReview" Rows="4"></asp:TextBox>
                                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="FillReview" runat="server" ControlToValidate="CommentsTxt" ErrorMessage="Please Insert Comments"></asp:RequiredFieldValidator>
                                                     </div>
                                             </div>
                                     </div>
                                   </div> 		


                    
        
           	    </ItemTemplate>
        </asp:Repeater>
</div>
            	
                        
                   
                   
                   
            </fieldset>

    
        </div>

        <div class="accordion-inner-noborder">
  
            
                      <div class="row span3">
                       <span class="label label-info">Requested By :  </span>
                       <span class="label" id="LMName" runat="server">Zeeshan Ashraf</span>
                      </div>
  
                      <div class="row span3">
                       <span class="label label-info">Name :  </span>
                       <span class="label" id="EmpName" runat="server">Saad Zaman</span>
                       </div>
       
                      <div class="row span3">
                       <span class="label label-info">Designation :  </span>
                       <span class="label" runat="server" id="EmpDesignation">Software Engineer</span>
                       </div>

                     

           </div>



        <div class="span45 margin-top15">
                
               
               
               
                <asp:UpdatePanel ID="PeerPanel" runat="server">
               
                <ContentTemplate>
                      <p class="accordion-heading">Reviews From Peers - <span>Quality</span></p>                  
                    <asp:GridView ID="PeerReviews" runat="server" 
                    CssClass="table table-hover table-striped"  GridLines="None" 
                    UseAccessibleHeader=true AutoGenerateColumns= false
                   >
                   
                    <Columns>
                            <asp:TemplateField HeaderText="Name"> 
                            <ItemTemplate>
                            <asp:Label ID="Label1" runat="server"><%# Eval("Name")%></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
        
                            <asp:TemplateField HeaderText="Rating"> 
                            <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" ><%# Eval("Rating")%></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
        
                            <asp:TemplateField HeaderText="Comment"> 
                            <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" ><%# Eval("Comment")%></asp:Label>
                            
                            </ItemTemplate>
                            </asp:TemplateField>
                    </Columns>

                    </asp:GridView> 
                
                </ContentTemplate>                                      
                </asp:UpdatePanel>
                                    
                                   
  
                     
           </div>



</div>
    



 <fieldset>
      
              <div class="control-group" runat="server" id="LineManagerRating">
                <h3 class="accordion-heading">Line Manager's</h3>
                     <div class="accordion-inner">
                           <div class="row">
                            <div class="span5 control-group">
                                <label class="control-label" for="Comments">Comment</label>
                                <div class="controls">
                                  <asp:TextBox ID="LMCommentsTxt" runat="server" TextMode="MultiLine" Width="250px" ValidationGroup="FillReview" Rows="4"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="FillReview" runat="server" ControlToValidate="LMCommentsTxt" ErrorMessage="Please Insert Comment"></asp:RequiredFieldValidator>
                                  
                             </div>
                             </div>
       
                            <div class="span3 control-group"  >
                                <label class="control-label" for="Rating">Ratings</label>
                                <div class="controls">
                                   <asp:TextBox ID="LMRatingsTxt" Columns="70" Rows="3" runat="server" ValidationGroup="FillReview"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidatorlm" ValidationGroup="FillReview" runat="server" ControlToValidate="LMRatingsTxt" ErrorMessage="Please Insert Ratings"></asp:RequiredFieldValidator>
                                 </div>
                             </div>
                             </div>
                    </div>

                </div>
                
              <div class="control-group" runat="server" id="DirectorRating"> 
                <h3 class="accordion-heading">Director's</h3>
                     <div class="accordion-inner">
                           <div class="row">
                            <div class="span5 control-group">
                                <label class="control-label" for="Comments">Comment</label>
                                <div class="controls">
                                 <textarea class="span5" id='LMComment' cols="80" rows="3" runat="server"></textarea>
                             </div>
                             </div>
       
                            <div class="span3 control-group">
                                <label class="control-label" for="Rating">Ratings</label>
                                <div class="controls">
                                <input type="text" id='Text4' runat="server">
                                 </div>
                             </div>
                             </div>
                    </div>
                </div>
                
              <div class="accordion-inner"  runat="server" id="CalcRating">
                <div class="pagination-centered">
                <h3>Calculated Rating</h3>
                 <font size=4 color=green>2.25</font>
                </div>
                </div>

              <div class="accordion-inner-noborder">
                <div class="pagination-centered">
                <asp:Button ID="submit" runat="server" ValidationGroup="FillReview" class="btn btn-success" Text="Submit Review" 
                        onclick="submit_Click" />
                <asp:Button ID="save" runat="server"  class="btn btn-info" Text="Draft Review" 
                        onclick="save_Click" />
                <asp:Button ID="Reject" runat="server"  data-toggle="modal" data-target="#GetFeedBack" class="btn btn-danger" Text="Reject Review" 
                        />
             
                </div>
               </div>

              
             
               
</fieldset>


    </div>
 </fieldset> 



 


<!-- Modal -->
<div id="GetFeedBack" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Please Identify The Reason For Rejecting</h3>
  </div>

  <div class="modal-body">
    <asp:TextBox ID="FeedbackTxt" runat="server"  Width="450" 
          TextMode="MultiLine" MaxLength="100" ></asp:TextBox>
  </div>


  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
     <asp:Button ID="Button1" runat="server"  class="btn btn-danger" Text="Reject" 
                        onclick="Reject_Click" />
             
  </div>
</div>


</asp:Content>
