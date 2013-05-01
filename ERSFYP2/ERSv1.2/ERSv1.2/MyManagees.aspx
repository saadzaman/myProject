<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyManagees.aspx.cs" Inherits="ERSv1._2.MyManagees" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <asp:ScriptManager ID="MainScriptManager" runat="server" />

<h4>My Managees</h4>
<div class="row dontShow" id="req">
<div class="span9">
<div class="alert">  
<a class="close" data-dismiss="alert">×</a>  
<strong>Request Sent!</strong> The Peer Will Recieve The Request On His Next Login. 
</div>  
</div>
</div>
<asp:GridView ID="ManageeList" runat="server" 
    CssClass="table" GridLines="None" DataKeyNames="EmpID"
    UseAccessibleHeader=true AutoGenerateColumns=false 
        ondatabound="ManageeList_DataBound" onrowcommand="ManageeList_RowCommand" onrowdatabound="ManageeList_RowDataBound" 
        >
  <Columns>
  <asp:TemplateField>
  <HeaderTemplate>
          <div class="row paddingForRow">
                      <div class="myspan3">
                              <asp:Label ID="Label2" runat="server" >Name</asp:Label>
                      </div>
                      <div class="myspan3">
                              <asp:Label ID="Label1" runat="server" >Designation</asp:Label>
                      </div>
                      <div class="myspan3">
                              <asp:Label ID="Label3" runat="server" >Department/Project</asp:Label>
                      </div>
                      <div class="myspan3">
                              <asp:Label ID="Label4" runat="server" >Status</asp:Label>
                      </div>


          </div>
   
  
  </HeaderTemplate>
  <ItemTemplate>
          <div class="row paddingForRow">
                      <div class="myspan3">
                              <asp:Label ID="Label2" runat="server" ><%# Eval("EmployeeName")%></asp:Label>
                      </div>
                      <div class="myspan3">
                              <asp:Label ID="Label1" runat="server" ><%# Eval("Designation")%></asp:Label>
                      </div>
                      <div class="myspan3">
                              <asp:Label ID="Label3" runat="server" ><%# Eval("Email")%></asp:Label>
                      </div>
                      <div class="myspan3">
                              <asp:Label ID="Label4" runat="server" ><%# Eval("EmployeeStatus")%></asp:Label>
                              <asp:Label ID="Fail" runat="server" ></asp:Label>
                           
                      </div>
                      


          </div>
          <div class="accordion-inner-noborder">
          
          <div class="accordion-group-noborder">
          
          <div class="pagination-right">
              <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel5" runat="server">
              <ProgressTemplate><img src=ajax-loader.gif/></ProgressTemplate>
              </asp:UpdateProgress>
        <asp:UpdatePanel ID="UpdatePanel5" class="fright" runat="server">
            <ContentTemplate> 
              
                <asp:Button class="btn-small btn btn-info" commandname="ShowPeers" text="Show Peers" OnClientClick='<%#string.Format("toggle(\"{0}\");", Eval("EmpID"))%>' CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'  ID="LinkButton1" runat="server"/> 
            </ContentTemplate>  
        </asp:UpdatePanel>
              <span class="paddingForRow"></span>
            <asp:Button ID="ConsoBtn" CssClass="btn-small btn btn-success" commandname="Consolidate" runat="server" text="Consolidate Review" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'/>
               
          </div>      

                <div class="accordion-inner-noborder dontShow" id="<%# Eval("EmpID")%>">
                <asp:UpdatePanel ID="UpdatePanelP" class="paddingForRow" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="ManageePeers" runat="server" 
                    DataKeyNames="ReviewID"
                    CssClass="table table-hover table-condensed" GridLines="None" 
                     onrowdatabound="ManageePeers_RowDataBound"
                    onrowcommand="ManageePeers_RowCommand" 
                    UseAccessibleHeader="true" AutoGenerateColumns="false"
                     OnDataBound="ManageePeers_DataBound" >
                             <Columns>
                                    <asp:TemplateField HeaderText="Name"> 
                                        <ItemTemplate>
                                           <asp:Label ID="NameLbl" runat="server"><%# Eval("EmployeeName")%></asp:Label>
                                        </ItemTemplate>
                                     </asp:TemplateField>

                                     <asp:TemplateField HeaderText="Designation"> 
                                        <ItemTemplate>
                                           <asp:Label ID="DesigLbl" runat="server"><%# Eval("Designation")%></asp:Label>
                                        </ItemTemplate>
                                     </asp:TemplateField>

                                     <asp:TemplateField HeaderText="Email"> 
                                        <ItemTemplate>
                                           <asp:Label ID="DeptLbl" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                        </ItemTemplate>
                                     </asp:TemplateField>

                                     <asp:TemplateField HeaderText="Status"> 
                                        <ItemTemplate>
                                           <asp:Label ID="StatusLbl" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                            <asp:HiddenField ID="ImPeerOf" runat="server" Value='<%# Eval("ImPeerOfID") %>' />
                                              <asp:HiddenField ID="PeerID" runat="server" Value='<%# Eval("PeerID") %>' />
                                        </ItemTemplate>
                                     </asp:TemplateField>


                                     <asp:TemplateField> 
                                        <ItemTemplate>
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate> 
                                                        <asp:Button ID="ShowButton" CssClass="btn btn-info" commandname="Show" runat="server" text="Show Review" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'/>
                                                        <asp:Button ID="AskButton" CssClass="btn btn-primary" commandname="Ask" runat="server" text="Ask For Review" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'/>
                                                    </ContentTemplate>  
                                                </asp:UpdatePanel>
                                         </ItemTemplate>
                                     </asp:TemplateField>
                            </Columns>
                     </asp:GridView>
            </ContentTemplate>  
            </asp:UpdatePanel>

               </div>
                    
          </div>
           
          </div>
  </ItemTemplate>
  </asp:TemplateField>


  </Columns>
</asp:GridView>



<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" data-keyboard="true"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
 
  <div class="modal-body">
    <p>Request Sent !!</p>
  </div>


</div>


</asp:Content>
