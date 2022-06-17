<%@ Page Title="Store Requisitions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StoreR.aspx.cs" Inherits="HRPortal.StoreR" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        
        String employeeNo = Convert.ToString(Session["employeeNo"]);
        String status = String.IsNullOrEmpty(Request.QueryString["status"]) ? "partially" : Request.QueryString["status"];
        String myStatus = "partially";
        var nav = new Config().ReturnNav();
        var headers = nav.PurchaseLines.Where(r => r.Status == "Released"&& r.Document_Type=="Store Requisition"&&r.Request_By_No==employeeNo && r.Partially_Issued==true);
        if (status== "approved")
        {
            myStatus = "Approved";
            headers = nav.PurchaseLines.Where(r => r.Status == "Released"&& r.Document_Type=="Store Requisition"&&r.Request_By_No==employeeNo && r.Fully_Issued==true);
        }
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <%=myStatus %> Store Requisitions
        </div>
        <div class="panel-body">
            <!--No, status, location code, description , view/edit -->
            <div runat="server" id="feedback"></div>
            <table class="table table-bordered table-striped" id="myTable">
                <thead>
                <tr>
                    <th>Requisition No</th>
                    <th>Status</th>
                    <th>Unit of Measure</th>
                    <th>Description</th>
                    <th>Quantity Requested</th>
                     <th>Quantity Issued</th>
                    
                </tr>
                </thead>
                <tbody>
                <%
                    foreach (var header in headers)
                    {
                        %>
                    <tr>
                        <td><% =header.No %></td>
                        <td><% =header.Status %></td>
                        <td><% =header.Unit_of_Measure%></td>
                        <td><% =header.Description%></td>
                        <td><% =header.Qty_Requested%></td>
                        <td><% =header.Remaining_Quantity%></td>
                      <%
                          }
                           %>
                </tbody>
            </table>
        </div>
    </div>

       <script>
           $(document).ready(function () {
               $('#myTable').DataTable();
           });
       </script>
  
</asp:Content>
