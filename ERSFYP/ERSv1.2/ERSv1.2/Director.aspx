<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Director.aspx.cs" Inherits="ERSv1._2.Director"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<h2>Line Manager</h2>


<div class = "row fright">

<div><asp:TextBox ID="TextBox2" runat="server" placeholder="Enter Person To Search"></asp:TextBox></div>
 <div class="fright"><asp:Button ID="Search" CssClass="btn btn-success"  runat="server" text="Search"/>  </div>

</div>

    <asp:GridView DataKeyNames="LMID" CssClass="table table-hover table-striped" 
                 ID="LineManagerList" AutoGenerateColumns="false" runat="server" 
        GridLines="None" onrowcommand="LineManagerList_RowCommand" onrowdatabound="LineManagerList_RowDataBound" 
                
                 >

                        <Columns>
                            <asp:TemplateField HeaderText="Line Manager"> 
                            <ItemTemplate>
                            <asp:Label ID="Label1" runat="server"><%# Eval("LMName")%></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
        
                            <asp:TemplateField HeaderText="Designation"> 
                            <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" ><%# Eval("LMDesignation")%></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
        
                            <asp:TemplateField HeaderText="LM's Director"> 
                            <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" ><%# Eval("LMDirector")%></asp:Label>
                            <asp:HiddenField ID="EmpID" runat=server Value='<%# Eval("DirectorID")%>' />
                            </ItemTemplate>
                            </asp:TemplateField>
        

        
                            
                            <asp:TemplateField > 
                            <ItemTemplate>
                                <asp:Button ID="Cross" CssClass="btn btn-primary" commandname="Cross" runat="server" text="CrossLevel" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'/>
                                <asp:Label ID="ConsoReport" runat="server"  Text="" Font-Size="X-Small"></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
        
                        </Columns>



             </asp:GridView>

</asp:Content>
