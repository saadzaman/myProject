<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CategoryWeightage.aspx.cs" Inherits="ERSFYP_AdminPanel.CategoryWeightage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<script type="text/javascript">

    $(document).ready(function () {
        OnSelectedIndexChange();


        for (var i = 0; i < $("#MainContent_CountOfRepeaterItems").val(); i++) {
            $('#MainContent_Categories_Weightage_' + i).keyup(function () {
                OnSelectedIndexChange();
            });
        }
    });
    function OnSelectedIndexChange() {

        var sum = 0;

        for (var j = 0; j < $("#MainContent_CountOfRepeaterItems").val(); j++) {
            sum = sum + parseInt($('#MainContent_Categories_Weightage_' + j).val());
        }

        $('#MainContent_Total').val(sum);

    }

</script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   
    <asp:Label ID="Label1" runat="server" Text="Position: "></asp:Label>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
     <ContentTemplate>
    <asp:DropDownList ID="Position" runat="server" 
        onselectedindexchanged="Position_SelectedIndexChanged"  AutoPostBack="true">
    </asp:DropDownList>
    </ContentTemplate>
    </asp:UpdatePanel>  
    
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
     <ContentTemplate>
    <asp:Repeater ID="Categories" runat="server">
      <ItemTemplate>
        <div class="row">
           <div class="span3"> <asp:Label runat="server" ID="CategoryName" Text=<%# Eval("CategoryName") %>></asp:Label></div>
            <div class="span1"><asp:TextBox runat="server" ID="Weightage" Text=<%# Eval("Weightage")%>>
            </asp:TextBox></div>
            <asp:HiddenField runat="server" ID="CategoryID" Value=<%# Eval("CategoryID")%>>
            </asp:HiddenField>
        </div>
      </ItemTemplate>
    </asp:Repeater>
         <asp:HiddenField ID="CountOfRepeaterItems" Value="0" runat="server" />
    <div class="row">
           <div class="span3"> <asp:Label runat="server" ID="L_Total" Text="Total"></asp:Label></div>
            <div class="span1"><asp:TextBox ValidationGroup="total" runat="server" ReadOnly=true ID="Total"  Text="">
            </asp:TextBox>
                <asp:RangeValidator ID="RangeValidator1" ValidationGroup="total" runat="server" ControlToValidate="Total" MaximumValue=100 MinimumValue=100 ErrorMessage="must equal to 100"></asp:RangeValidator>
            </div>
            
        </div>
        <asp:Button ID="Save" ValidationGroup="total" runat="server"  Text="Button" 
             onclick="Save_Click" />
        
    </ContentTemplate>
    </asp:UpdatePanel> 
</asp:Content>
