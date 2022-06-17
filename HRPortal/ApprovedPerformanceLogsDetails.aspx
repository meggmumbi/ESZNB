<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedPerformanceLogsDetails.aspx.cs" Inherits="HRPortal.ApprovedPerformanceLogsDetails" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            Performance Targets (<i style="color:yellow">Kindly click on the Description of each line to view Performance Update Sub Indicators</i>)
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <div class="table-responsive">               
                <table id="example4" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Description</th> 
                        <th>Planned Start Date</th>
                        <th>Planned Due Date</th>
                        <th>Achieved Date</th>
                       <%-- <th>Performance Indicator</th>--%>
                        <th>Unit of Measure</th>
                        <th>Target Qty</th>
                        <th>Remaining Target</th>
                        <th>Achieved Qty</th>
                        <th>Comments</th>
                    </tr>
                </thead>
                <tbody> 
                <%
                    var nav = new Config().ReturnNav();
                    string employeeNo = Convert.ToString(Session["employeeNo"]);
                    string PlogNumber = Request.QueryString["PerformanceLogNo"];
                    var performancelogs = nav.PlogLines.Where(r => r.Employee_No == employeeNo && r.PLog_No == PlogNumber);
                    foreach (var item in performancelogs)
                    {
                %>
                <tr>                                            
                    <td><a href="SubPlogIndicatorsApproved.aspx?PlogNo=<%=item.PLog_No %>&&InitiativeNo=<%=item.Initiative_No %>&&PCID=<%=item.Personal_Scorecard_ID %>"</a><% =item.Sub_Intiative_No%> </td>
                    <td><% = Convert.ToDateTime(item.Planned_Date).ToString("d/MM/yyyy") %></td>
                    <td><% = Convert.ToDateTime(item.Due_Date).ToString("d/MM/yyyy") %></td>
                    <td><% = Convert.ToDateTime(item.Achieved_Date).ToString("d/MM/yyyy") %></td>
                   <%-- <td><% = item.Outcome_Perfomance_Indicator %></td>--%>
                    <td><% = item.Unit_of_Measure %></td>
                    <td><% = item.Target_Qty %></td>
                    <td><% = item.Remaining_Targets %></td> 
                    <td><% = item.Achieved_Target %></td>
                    <td><% = item.Comments %></td> 
                    <%
                        }
                    %>
            </tbody>
            </table>
                </div>
        </div>          
    </div> 
</asp:Content>
