<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" EnableEventValidation="true" EnableViewStateMac="true"  CodeBehind="Relations.aspx.cs" Inherits="ERSFYP_AdminPanel.Relations" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent"  runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="MainScriptManager" runat="server">
    </asp:ScriptManager>
    
<asp:UpdatePanel ID="one" runat=server>
<ContentTemplate>

 <asp:Repeater ID="Repeater1" runat="server">
    <ItemTemplate>
      <div class="row paddingForRow">
       <asp:DropDownList ID="dd" runat="server" AutoPostBack="True"  DataTextField="Name" DataValueField="EmpID"
        onselectedindexchanged="dd_SelectedIndexChanged" >
           

        </asp:DropDownList>
            <asp:HiddenField runat="server" id="selected" >
           </asp:HiddenField>


           <asp:DropDownList ID="Type" runat="server" AutoPostBack="True"  DataTextField="RelationName" DataValueField="id"
        onselectedindexchanged="Type_SelectedIndexChanged" >
           

        </asp:DropDownList>
            <asp:HiddenField runat="server" id="TypeT" Value="-1">
           </asp:HiddenField>

          <asp:TextBox ID="Change" runat="server" Text="0"/>
     <asp:DropDownList ID="Emp" runat="server" AutoPostBack="True" DataTextField="Name" DataValueField="EmpID"
        onselectedindexchanged="Emp_SelectedIndexChanged" >
           

        </asp:DropDownList>

        
            <asp:HiddenField runat="server" id="EmpT">
           </asp:HiddenField>
           </div>
        </ItemTemplate>
    </asp:Repeater>

</ContentTemplate>
</asp:UpdatePanel>
   
   
   <asp:UpdatePanel ID="two" runat=server>
<ContentTemplate>

   
    <asp:Button ID="Button1" runat="server" Text="Add More" CssClass="btn btn-success" onclick="Button1_Click" />

    </ContentTemplate>
</asp:UpdatePanel>
       
     
</asp:Content>
