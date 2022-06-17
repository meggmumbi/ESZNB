<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedPerformanceLogs.aspx.cs" Inherits="HRPortal.ApprovedPerformanceLogs" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="panel panel-primary">
            <div class="panel-heading">
                Approved Performance Updates
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="table-responsive">               
                 <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Description</th>
                            <th>Personal Score Card</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>View Details</th>
                            <%--<th>Print</th>--%>
                        </tr>
                    </thead>
                    <tbody> 
                    <%
                        var nav = new Config().ReturnNav();
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var data = nav.PerformanceDiaryLog.Where(r => r.Employee_No == employeeNo && r.Approval_Status == "Released" && r.Posted == true);
                        foreach (var item in data)
                        {
                    %>
                    <tr>
                        <td><% =item.No %></td>
                        <td><% =item.Description%></td>
                        <td><% =item.Personal_Scorecard_ID%></td>
                        <td><% = Convert.ToDateTime(item.Activity_Start_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(item.Activity_End_Date).ToString("dd/MM/yyyy")%></td> 
                        <td><a href="ApprovedPerformanceLogsDetails.aspx?PerformanceLogNo=<%=item.No %>" class="btn btn-warning"><i class="fa fa-eye"></i>View Details</a></td>   
                        <%--<td><a href="PLogReport.aspx?PerformanceLogNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-download"></i>Print</a></td>  --%> 
                        <%
                            }
                      %>
                </tbody>
                </table>
                    </div>
            </div>        
        </div> 
</asp:Content>

