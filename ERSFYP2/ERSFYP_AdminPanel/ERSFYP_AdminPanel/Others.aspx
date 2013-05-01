<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="Others.aspx.cs" Inherits="ERSFYP_AdminPanel.Others" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h3>Departments</h3>


    <asp:EntityDataSource ID="ERS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnEntity %>"
        DefaultContainerName="ERS_LMTEntities" EnableDelete="True" 
        EnableFlattening="False" EnableInsert="True" EnableUpdate="True" 
        EntitySetName="Departments" EntityTypeFilter="Department">
    </asp:EntityDataSource>
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="DepartmentID" 
        DataSourceID="ERS" InsertItemPosition="LastItem">

        <EditItemTemplate>
            <tr >
                <td>
                    <asp:Button ID="UpdateButton"  CssClass="btn btn-success" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" CssClass="btn btn-danger" runat="server" CommandName="Cancel" 
                        Text="Cancel" />
                </td>
                
                <td>
                    <asp:TextBox ID="DepartmentNameTextBox" runat="server" 
                        Text='<%# Bind("DepartmentName") %>' />
                </td>
                <td>
                    <asp:TextBox ID="DepartmentDetailsTextBox" runat="server" 
                        Text='<%# Bind("DepartmentDetails") %>' />
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" 
                >
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr >
                <td>
                    <asp:Button ID="InsertButton" CssClass="btn btn-success" runat="server" CommandName="Insert" 
                        Text="Insert" />
                    <asp:Button ID="CancelButton" CssClass="btn btn-danger" runat="server" CommandName="Cancel" 
                        Text="Clear" />
                </td>
                
                <td>
                    <asp:TextBox ID="DepartmentNameTextBox" runat="server" 
                        Text='<%# Bind("DepartmentName") %>' />
                </td>
                <td>
                    <asp:TextBox ID="DepartmentDetailsTextBox" runat="server" 
                        Text='<%# Bind("DepartmentDetails") %>' />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr >
                <td>
                    <asp:Button ID="DeleteButton" runat="server" CssClass="btn btn-danger" CommandName="Delete" 
                        Text="Delete" />
                    <asp:Button ID="EditButton" runat="server" CssClass="btn btn-success" CommandName="Edit" Text="Edit" />
                </td>
               
                <td>
                    <asp:Label ID="DepartmentNameLabel" runat="server" 
                        Text='<%# Eval("DepartmentName") %>' />
                </td>
                <td>
                    <asp:Label ID="DepartmentDetailsLabel" runat="server" 
                        Text='<%# Eval("DepartmentDetails") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server"   >
               <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" class="table table-hover table-striped"   >
                            <tr runat="server" >
                                <th runat="server">
                                </th>
                               
                                <th runat="server">
                                    DepartmentName</th>
                                <th runat="server">
                                    DepartmentDetails</th>
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                          
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" 
                        >
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
   
    </asp:ListView>

   

   <h3>Categories</h3>

   <asp:EntityDataSource ID="ERSCategories" runat="server" 
           ConnectionString="<%$ ConnectionStrings:ConnEntity %>"
           DefaultContainerName="ERS_LMTEntities" EnableDelete="True" 
           EnableFlattening="False" EnableInsert="True" EnableUpdate="True" 
           EntitySetName="ReviewCategories" EntityTypeFilter="ReviewCategory">
       </asp:EntityDataSource>
   <asp:ListView ID="ListView2" runat="server" DataKeyNames="CategoryID" 
           DataSourceID="ERSCategories" InsertItemPosition="LastItem">
         
        
         
           <EditItemTemplate>
               <tr style="">
                   <td>
                     <asp:Button ID="UpdateButton"  CssClass="btn btn-success" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" CssClass="btn btn-danger" runat="server" CommandName="Cancel" 
                        Text="Cancel" />
                   </td>
                  
                   <td>
                       <asp:TextBox ID="CategoryNameTextBox" runat="server" 
                           Text='<%# Bind("CategoryName") %>' />
                   </td>
                  
               </tr>
           </EditItemTemplate>
           <EmptyDataTemplate>
               <table runat="server" style="">
                   <tr>
                       <td>
                           No data was returned.</td>
                   </tr>
               </table>
           </EmptyDataTemplate>
           <InsertItemTemplate>
               <tr style="">
                   <td>
                       <asp:Button ID="InsertButton" runat="server" CssClass="btn btn-success" CommandName="Insert" 
                           Text="Insert" />
                       <asp:Button ID="CancelButton" runat="server" CssClass="btn btn-danger" CommandName="Cancel" 
                           Text="Clear" />
                   </td>
                  
                   <td>
                       <asp:TextBox ID="CategoryNameTextBox" runat="server" 
                           Text='<%# Bind("CategoryName") %>' />
                   </td>
                 
               </tr>
           </InsertItemTemplate>
           <ItemTemplate>
               <tr style="">
                   <td>
                       <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" CssClass="btn btn-danger"
                           Text="Delete" />
                       <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-success" />
                   </td>
                  
                   <td>
                       <asp:Label ID="CategoryNameLabel" runat="server" 
                           Text='<%# Eval("CategoryName") %>' />
                   </td>
                 
               </tr>
           </ItemTemplate>
           <LayoutTemplate>
               <table runat="server">
                   <tr runat="server">
                       <td runat="server">
                           <table ID="itemPlaceholderContainer" runat="server" class="table table-striped">
                               <tr runat="server" style="">
                                   <th runat="server">
                                   </th>
                                   
                                   <th runat="server">
                                       CategoryName</th>
                                   
                               </tr>
                               <tr runat="server" ID="itemPlaceholder">
                               </tr>
                           </table>
                       </td>
                   </tr>
                   <tr runat="server">
                       <td runat="server" style="">
                       </td>
                   </tr>
               </table>
           </LayoutTemplate>
          
       
          
       </asp:ListView>
   


   <h3>Status</h3>
   
   
   <asp:ListView ID="ListView3" runat="server" DataKeyNames="ID" 
           DataSourceID="ERSStatus" InsertItemPosition="LastItem">
   
     
       <EmptyDataTemplate>
           <table runat="server" style="">
               <tr>
                   <td>
                       No data was returned.</td>
               </tr>
           </table>
       </EmptyDataTemplate>
       <InsertItemTemplate>
           <tr style="">
               <td>
                   <asp:Button ID="InsertButton" runat="server" CssClass="btn btn-success" CommandName="Insert" 
                       Text="Insert" />
                   <asp:Button ID="CancelButton" runat="server" CssClass="btn btn-danger" CommandName="Cancel" 
                       Text="Clear" />
               </td>
               
               <td>
                   <asp:TextBox ID="StatusNameTextBox" runat="server" 
                       Text='<%# Bind("StatusName") %>' />
               </td>
               
           </tr>
       </InsertItemTemplate>
       <ItemTemplate>
           <tr style="">
               <td>
                   <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" CssClass="btn btn-danger"
                       Text="Delete" />
                  
               </td>
              
               <td>
                   <asp:Label ID="StatusNameLabel" runat="server" 
                       Text='<%# Eval("StatusName") %>' />
               </td>
               
           </tr>
       </ItemTemplate>
       <LayoutTemplate>
           <table runat="server">
               <tr runat="server">
                   <td runat="server">
                       <table ID="itemPlaceholderContainer" runat="server" border="0" class="table table-striped">
                           <tr runat="server" style="">
                               <th runat="server">
                               </th>
                              
                               <th runat="server">
                                   StatusName</th>
                              
                           </tr>
                           <tr ID="itemPlaceholder" runat="server">
                           </tr>
                       </table>
                   </td>
               </tr>
               <tr runat="server">
                   <td runat="server" style="">
                   </td>
               </tr>
           </table>
       </LayoutTemplate>
     
       </asp:ListView>
   <asp:EntityDataSource ID="ERSStatus" runat="server" 
           ConnectionString="<%$ ConnectionStrings:ConnEntity %>"
           DefaultContainerName="ERS_LMTEntities" EnableDelete="True" 
           EnableFlattening="False" EnableInsert="True" 
           EntitySetName="Status" EntityTypeFilter="Status">
       </asp:EntityDataSource>
    


    

   <h3>Review Types</h3>

    
        <asp:ListView ID="ListView4" runat="server" DataKeyNames="ReviewTypeID" 
            DataSourceID="ERSReviewTypes" InsertItemPosition="LastItem">
     
            <EditItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CssClass="btn btn-success" CommandName="Update" 
                            Text="Update" />
                        <asp:Button ID="CancelButton" runat="server" CssClass="btn btn-danger" CommandName="Cancel" 
                            Text="Cancel" />
                    </td>
                    <td>
                        <asp:TextBox ID="TypeNameTextBox" runat="server" 
                            Text='<%# Bind("TypeName") %>' />
                    </td>
                    
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table id="Table1" runat="server" style="">
                    <tr>
                        <td>
                            No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="InsertButton" CssClass="btn btn-success" runat="server" CommandName="Insert" 
                            Text="Insert" />
                        <asp:Button ID="CancelButton" CssClass="btn btn-danger" runat="server" CommandName="Cancel" 
                            Text="Clear" />
                    </td>
                    <td>
                        <asp:TextBox ID="TypeNameTextBox" runat="server" 
                            Text='<%# Bind("TypeName") %>' />
                    </td>
                   
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                            Text="Delete" CssClass="btn btn-danger" />
                      
                    </td>
                    
                    <td>
                        <asp:Label ID="TypeNameLabel" runat="server" Text='<%# Eval("TypeName") %>' />
                    </td>
                    
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table id="Table2" runat="server">
                    <tr id="Tr1" runat="server">
                        <td id="Td1" runat="server">
                            <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
                                <tr id="Tr2" runat="server" style="">
                                    <th id="Th1" runat="server">
                                    </th>
                                    <th id="Th2" runat="server">
                                        TypeName</th>
                                </tr>
                                <tr ID="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="Tr3" runat="server">
                        <td id="Td2" runat="server" style="">
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            
        </asp:ListView>
        <asp:EntityDataSource ID="ERSReviewTypes" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnEntity %>"
            DefaultContainerName="ERS_LMTEntities" EnableDelete="True" 
            EnableFlattening="False" EnableInsert="True" EnableUpdate="True" 
            EntitySetName="ReviewTypes" EntityTypeFilter="ReviewType">
        </asp:EntityDataSource>
    

    <h3>Position</h3>
    <p>
        <asp:ListView ID="ListView5" runat="server" DataKeyNames="PositionID" 
            DataSourceID="ERSPosition" InsertItemPosition="LastItem">
            <EditItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-success"
                            Text="Update" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" CssClass="btn btn-danger"
                            Text="Cancel" />
                    </td>
                    
                    <td>
                        <asp:TextBox ID="PositionNameTextBox" runat="server" 
                            Text='<%# Bind("PositionName") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="PositionDetailsTextBox" runat="server" 
                            Text='<%# Bind("PositionDetails") %>' />
                    </td>
                    
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table id="Table3" runat="server" style="">
                    <tr>
                        <td>
                            No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" CssClass="btn btn-success"
                            Text="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" CssClass="btn btn-danger"
                            Text="Clear" />
                    </td>
                    
                    <td>
                        <asp:TextBox ID="PositionNameTextBox" runat="server" 
                            Text='<%# Bind("PositionName") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="PositionDetailsTextBox" runat="server" 
                            Text='<%# Bind("PositionDetails") %>' />
                    </td>
                    
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" CssClass="btn btn-danger" CommandName="Delete" 
                            Text="Delete" />
                     
                    </td>
                    
                    <td>
                        <asp:Label ID="PositionNameLabel" runat="server" 
                            Text='<%# Eval("PositionName") %>' />
                    </td>
                    <td>
                        <asp:Label ID="PositionDetailsLabel" runat="server" 
                            Text='<%# Eval("PositionDetails") %>' />
                    </td>
                    
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table id="Table4" runat="server">
                    <tr id="Tr4" runat="server">
                        <td id="Td3" runat="server">
                            <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
                                <tr id="Tr5" runat="server" style="">
                                    <th id="Th3" runat="server">
                                    </th>
                                    <th id="Th4" runat="server">
                                        PositionName</th>
                                    <th id="Th5" runat="server">
                                        PositionDetails</th>
                                   
                                </tr>
                                <tr ID="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="Tr6" runat="server">
                        <td id="Td4" runat="server" style="">
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            
        </asp:ListView>
        <asp:EntityDataSource ID="ERSPosition" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnEntity %>"
            DefaultContainerName="ERS_LMTEntities" EnableDelete="True" 
            EnableFlattening="False" EnableInsert="True" EnableUpdate="True" 
            EntitySetName="Positions" EntityTypeFilter="Position">
        </asp:EntityDataSource>
    </p>


   <h3>Roles</h3>
    <p>
        <asp:ListView ID="ListView6" runat="server" DataKeyNames="ID" 
            DataSourceID="ERSRoles" InsertItemPosition="LastItem">
            
            <EditItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-success"
                            Text="Update" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" CssClass="btn btn-danger"
                            Text="Cancel" />
                    </td>
                    <td>
                        <asp:TextBox ID="RoleNameTextBox" runat="server" 
                            Text='<%# Bind("RoleName") %>' />
                    </td>
                    
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table id="Table5" runat="server" style="">
                    <tr>
                        <td>
                            No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" CssClass="btn btn-success"
                            Text="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" CssClass="btn btn-danger"
                            Text="Clear" />
                    </td>
                    <td>
                        <asp:TextBox ID="RoleNameTextBox" runat="server" 
                            Text='<%# Bind("RoleName") %>' />
                    </td>
                    
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" CssClass="btn btn-danger" 
                            Text="Delete" />
                       
                    </td>
                    <td>
                        <asp:Label ID="RoleNameLabel" runat="server" Text='<%# Eval("RoleName") %>' />
                    </td>
                    
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table id="Table6" runat="server">
                    <tr id="Tr7" runat="server">
                        <td id="Td5" runat="server">
                            <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
                                <tr id="Tr8" runat="server" style="">
                                    <th id="Th7" runat="server">
                                    </th>
                                    <th id="Th8" runat="server">
                                        RoleName</th>
                                    
                                </tr>
                                <tr ID="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="Tr9" runat="server">
                        <td id="Td6" runat="server" style="">
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            
        </asp:ListView>
        <asp:EntityDataSource ID="ERSRoles" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnEntity %>"
            DefaultContainerName="ERS_LMTEntities" EnableDelete="True" 
            EnableFlattening="False" EnableInsert="True" EnableUpdate="True" 
            EntitySetName="Roles">
        </asp:EntityDataSource>
    </p>
   

</asp:Content>
