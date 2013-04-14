<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReviewDirector.aspx.cs" Inherits="ERSv1._2.ReviewDirector" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <asp:ScriptManager ID="MainScriptManager" runat="server" />
 
 <h4 style = " display: inline;">Select An Employee Under LineManager </h4> <pstyle = " display: inline;" ><small> &nbsp;( Line Managers Review Will Be Highlighted )</small> </p>

  
  <asp:UpdatePanel ID="UpdatePanel2" runat="server">           
  <ContentTemplate>
  
     <asp:DropDownList ID="LineManagees" runat="server" 
         onselectedindexchanged="LineManagees_SelectedIndexChanged" AutoPostBack="True">
     </asp:DropDownList>
  
    </ContentTemplate>
    </asp:UpdatePanel>

 
                
<div class = "row">


        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                            
                <div id="forNav" class="span2">
                        <ul class="nav nav-stacked nav-pills">    
                        <asp:Repeater id="Categories" runat="server">
                            <ItemTemplate>
                                
                                <li runat="server" id="CatLI"  >
                                    <asp:LinkButton ID="ButtonHeading" CommandArgument='<%# Eval("CategoryID") %>' runat="server" onclick="ButtonHeading_Click" ><%# Eval("CategoryName") %></asp:LinkButton>
                                </li>
                                
                            </ItemTemplate>
                         </asp:Repeater>
                         </ul>   
                  </div>      
  </ContentTemplate>
  </asp:UpdatePanel>

        

        <asp:UpdatePanel ID="ReviewPanel" runat="server">
            <ContentTemplate>

                <div id="forReviews" class = "span8">
                    <asp:GridView ID="AllReviews" runat="server" 
                    CssClass="table table-hover table-striped" DataKeyNames="ID"  GridLines="None" 
                    UseAccessibleHeader=true onrowdatabound="AllReviews_RowDataBound" AutoGenerateColumns="false">
                    
                       <Columns>
                            <asp:TemplateField ItemStyle-Width=2 HeaderText="Name"> 
                            <ItemTemplate>
                                <div style = "width:100px">
                                    <asp:Label ID="Label1"  runat="server"><%# Eval("Name")%></asp:Label>
                               </div>
                            </ItemTemplate>
                            </asp:TemplateField>
  
                            <asp:TemplateField  ItemStyle-Width=2  HeaderText="Rating"> 
                            <ItemTemplate>
                                <div style = "width:75px">
                                    <asp:Label ID="Label2"  runat="server" ><%# Eval("Rating")%></asp:Label>
                                </div>
                            </ItemTemplate>
                            </asp:TemplateField>
        
                            <asp:TemplateField   HeaderText="Comment"> 
                            <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" ><%# Eval("Comment")%></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
                    </Columns>

                   
                    </asp:GridView> 
                </div>
            </ContentTemplate>                                      
            </asp:UpdatePanel>
                
</div>

                
                
                <hr />

                <p class="lead pagination-centered">Calculated Rating :&nbsp;<span runat="server" id="CRating">2.25</span></p>
                

                <hr />

<asp:UpdatePanel ID="UpdatePanel3" runat="server">
 <ContentTemplate>
                <fieldset class="margin-top15">
                <div class="row well">
                <div class="accordion-group-noborder control-group span">                                
                <h4 class="accordion-heading">Directors Feedback For <span runat="server" id="LMName"></span></h4><br />
                        <div class="span3">
                        <label class="control-label" for="Ratings">Ratings</label>
                        <asp:TextBox ID="RatingsTxt" Columns="70" Rows="3" runat="server"></asp:TextBox>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="RatingsTxt" Type="Double" MinimumValue="1" MaximumValue="5" ErrorMessage="RangeValidator"></asp:RangeValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2"  ValidationGroup="FillReview" runat="server" ControlToValidate="RatingsTxt" ErrorMessage="Please Insert Ratings"></asp:RequiredFieldValidator>
                        </div>
                                                     
                        <div class="span5">
                        <label class="control-label" for="Comments">Comments</label>
                        <asp:TextBox ID="CommentsTxt" runat="server" TextMode="MultiLine" Width="400px" ValidationGroup="FillReview" Rows="5"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="FillReview" runat="server" ControlToValidate="CommentsTxt" ErrorMessage="Please Insert Comments"></asp:RequiredFieldValidator>
                        </div>

                        <div class="span1 padding-top15">
                        <asp:Button ID="Save" runat="server" Text="Save" 
                                CssClass="btn btn-large btn-success" onclick="Save_Click" /> 
                        </div>

                                                     
                 </div>
                 </div>
                </fieldset>

</ContentTemplate>                                      
</asp:UpdatePanel>
                
            
        

</asp:Content>
