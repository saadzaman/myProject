<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyReviews.aspx.cs" Inherits="ERSv1._2.MyReviews"   %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h4>My Reviews</h4>
   
  
  <div class=row>
        <label class="span2">
                <input type="checkbox" id="cb" runat="server" value=""/>All
        </label>

        <label class="span2">
                <input type="checkbox" id="cb2" runat="server" value=""/>Remaining
        </label>

         <div class="span3">
                    <div class="span2">
                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                 </div>
     
                 <div class="span">  
                        <a href="#" class="btn" ><i class="icon-search"></i></a>
                 </div>
                                                       
         </div>

      
      
      </div>

        
           <div>
             <asp:GridView DataKeyNames="ReviewID" CssClass="table table-hover table-striped" 
                 ID="ReviewList" AutoGenerateColumns="false" runat="server" GridLines="None" 
                 onrowdatabound="ReviewList_RowDataBound" onrowcommand="ReviewList_RowCommand" 
                 >

                        <Columns>
                            <asp:TemplateField HeaderText="Employee"> 
                            <ItemTemplate>
                            <asp:Label ID="Label1" runat="server"><%# Eval("EmployeeName")%></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
        
                            <asp:TemplateField HeaderText="LineManager"> 
                            <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" ><%# Eval("LineManager")%></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
        
                            <asp:TemplateField HeaderText="Deadline"> 
                            <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" ><%# Eval("Deadline")%></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
        

                            <asp:TemplateField HeaderText="Type"> 
                            <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" ><%# Eval("Type")%></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
        
        
                             <asp:TemplateField HeaderText="Feedback"> 
                            <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" ><%# Eval("Feedback")%></asp:Label>
                            <asp:HiddenField ID="EmpID" runat=server Value='<%# Eval("CurrEmployee.EmpID")%>' />
                            </ItemTemplate>
                            </asp:TemplateField>
        
                            
                            <asp:TemplateField > 
                            <ItemTemplate>
                               <asp:Button ID="ShowButton" CssClass="btn btn-success" commandname="Show" runat="server" text="Show Review" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'/>
                               <asp:Button ID="FillButton" CssClass="btn btn-primary" commandname="Fill" runat="server" text="Fill Review" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'/>
                            </ItemTemplate>
                            </asp:TemplateField>
        
                        </Columns>



             </asp:GridView>
      
    
</div>
</asp:Content>
