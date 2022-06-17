<%@ Page Title="Imprest Requisition" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImprestRequisition.aspx.cs" Inherits="HRPortal.ImprestRequisition" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <%
        String employeeNo = Convert.ToString(Session["employeeNo"]);
        String status = String.IsNullOrEmpty(Request.QueryString["status"]) ? "open" : Request.QueryString["status"];
        String myStatus = "Open";
        var nav = new Config().ReturnNav();
        var payments = nav.Payments.Where(r => r.Status != "Released"&& r.Account_No==employeeNo&&r.Payment_Type=="Imprest");
        if (status== "approved")
        {
            myStatus = "Approved";
            payments = nav.Payments.Where(r => r.Status == "Released"&& r.Account_No==employeeNo&&r.Posted==false&&r.Payment_Type=="Imprest");
        }
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <%=myStatus %> Imprest Requisition
        </div>
        <div class="panel-body">
               <div class="table-responsive">  
            <!-- No,date , imprest Amount, payee, status , view /edit -->
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Imprest No</th>
                    <th>Date</th>
                    <th>Imprest Amount</th>
                    <th>Payee</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <%
                    foreach (var payment in payments)
                    {
                        %>
                    <tr>
                        <td><% =payment.No %></td>
                        <td><% =Convert.ToDateTime(payment.Date).ToString("dd/MM/yyyy") %></td>
                       
                        <td><% =String.Format("{0:n}", Convert.ToDouble(payment.Imprest_Amount)) %></td>
                        <td> <% =payment.Payee%> </td>
                        <td><% =payment.Status%></td>
                    </tr>
                    <%
                    } %>
                </tbody>
            </table>
                   </div>
        </div>
    </div>
    
</asp:Content>
