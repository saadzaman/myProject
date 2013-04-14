<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReviewDirector.aspx.cs" Inherits="ERSv1._2.ReviewDirector" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
 <asp:ScriptManager ID="MainScriptManager" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<h4> LineManager And Employees Under Him</h4>

 
                <asp:UpdatePanel ID="ReviewPanel" runat="server">
               
                <ContentTemplate>
                                      
                    <asp:GridView ID="AllReviews" runat="server" 
                    CssClass="table table-hover table-striped"  GridLines="None" 
                    UseAccessibleHeader=true >
                   
                    </asp:GridView> 
                
                </ContentTemplate>                                      
                </asp:UpdatePanel>

</asp:Content>
