<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReviewForm.aspx.cs" Inherits="ERSv1._2.ReviewForm" %>
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
       <div class="well">
     
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
                                                     
                                                     </div>
                                             </div>

	                                         <div class="control-group">
                                                    <label class="control-label" for="Comments">Comments</label>
                                                    <div class="controls">
                                                        <asp:TextBox ID="CommentsTxt" runat="server" TextMode="MultiLine" Width="250px" Rows="4"></asp:TextBox>
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
                    UseAccessibleHeader=true >
                   
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
                                 <textarea class="span5" id='Textarea4' cols="80" rows="3" runat="server"></textarea>
                             </div>
                             </div>
       
                            <div class="span3 control-group"  >
                                <label class="control-label" for="Rating">Ratings</label>
                                <div class="controls">
                                <input type="text" id='Text5' runat="server">
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
                                 <textarea class="span5" id='Textarea3' cols="80" rows="3" runat="server"></textarea>
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
                <asp:Button ID="submit" runat="server" class="btn btn-success" Text="Submit Review" 
                        onclick="submit_Click" />
                <asp:Button ID="reset" runat="server" class="btn btn-danger" Text="Reset Review" />
             
                </div>
               </div>

              
             
               
</fieldset>


    </div>
 </fieldset> 
</asp:Content>
