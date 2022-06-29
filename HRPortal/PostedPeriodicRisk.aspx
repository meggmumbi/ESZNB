<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PostedPeriodicRisk.aspx.cs" Inherits="HRPortal.PostedPeriodicRisk" %>
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
        var headers = nav.RiskMEHeader.Where(r => r.Posted == false && r.Document_Type=="Risk Status Report"&&r.DocumentCreator==employeeNo);
        if (status== "approved")
        {
            myStatus = "Approved";
            headers = nav.RiskMEHeader.Where(r => r.Posted ==  true && r.Document_Type=="Risk Status Report"&&r.DocumentCreator==employeeNo);
        }
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <%=myStatus %> Periodic Status Report 
        </div>
        <div class="panel-body">
            <!--No, status, location code, description , view/edit -->
            <div runat="server" id="feedback"></div>
               <div class="table-responsive">  
            <table class="table table-bordered table-striped" id="example1">
                <thead>
                <tr>
                    <th>Doc No</th>
                    <th>Register type </th>                   
                    <th>Description</th>                  
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <%
                    foreach (var header in headers)
                    {
                %>
                    <tr>
                        <td><% =header.Document_No %></td>
                        <td><% =header.Risk_Register_Type %></td>
                        <td><% =header.Description %></td>


                        <%
                            if (header.Posted == false)
                            {
                        %>
                        <td><a href="RiskStatusReport.aspx?step=1&&requisitionNo=<%=header.Document_No %>" class="btn btn-success">View/Edit</a></td>
                        <% 
                        }
                        else
                        {
                        %>

                        <td><a href="PeriodicStatusDetails.aspx?DocumentNo=<%=header.Document_No %>&&DocType=<%=header.Document_Type %>" class="btn btn-success"><i class="fa fa-eye"></i>View Details</a> </td>
                        <%} %>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
               </div>
        </div>
    </div>

</asp:Content>
