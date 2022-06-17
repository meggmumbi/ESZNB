<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AnnualWorkPlan.aspx.cs" Inherits="HRPortal.AnnualWorkPlan" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Annual Work Plan</h3>
        </div>    
            <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#home" data-toggle="tab"   <h3 class="panel-title" style="color:black">General Details</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#menu1" data-toggle="tab"><h3 class="panel-title" style="color:black">Strategic WorkPlan Lines</h3></a>
                        </li>
                    </ul>
               </ul>
            <div class="tab-content">
                <div id="home" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">Annual Work Plan General Details</h3>
                        </div>
                        <div class="table-responsive">               
                             <table class="table table-bordered table-striped dataTable" id="example1">
                                <thead>
                                    <tr>
                                        <th>Description</th>
                                        <th>Strategy Plan No.</th>
                                        <th>Year Reporting</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>View Report</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        var nav = new Config().ReturnNav();
                                        var workplans = nav.AnnualStrategyWorkplan.Where(x=>x.Current_AWP==true &&x.Approval_Status=="Released");
                                        foreach (var workplan in workplans)
                                        {
                                    %>
                                    <tr>
                                        <td><% =workplan.Description%></td>
                                        <td><% =workplan.Strategy_Plan_ID%> </td>
                                        <td><% =workplan.Year_Reporting_Code%></td>
                                        <td><% = Convert.ToDateTime(workplan.Start_Date).ToString("dd/MM/yyyy")%></td>
                                        <td><% = Convert.ToDateTime(workplan.End_Date).ToString("dd/MM/yyyy")%></td>
                                         <td><a href="AWPReport.aspx?IndividualPCNo=<%=workplan.No %>"><label class="btn btn-success">View Report</label></a></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                </tbody>
                            </table>
                            </div>
                        </div>
                  </div>
                    <div id="menu1" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Strategic WorkPlan Lines</h3>
                            </div>
                            <div class="panel-body">
                               <table id="example2" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Activity</th>
                                            <th>Performance Indicator</th>                                           
                                            <th>Q1 Target</th>
                                            <th>Q2 Target</th>
                                            <th>Q3 Target</th>
                                            <th>Q4 Target</th>
                                            <th>Annual Target</th>
                                            <th>Primary Directorate</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                         <%
                                             var nav1 = new Config().ReturnNav();
                                             string PlanNumber = "";
                                             var plans = nav.AnnualStrategyWorkplan.Where(x=>x.Current_AWP==true);
                                             foreach (var plan in plans)
                                             {
                                                 PlanNumber = plan.No;
                                             }
                                             var workplanLines = nav.StrategyWorkplanLines.Where(x=>x.No==PlanNumber);
                                             foreach (var workplanLine in workplanLines)
                                             {
                                    %>
                                       <tr>
                                           <td><% =workplanLine.Description%></td>
                                           <td><% =workplanLine.Perfomance_Indicator%></td>
                                            <td><% =workplanLine.Q1_Target%></td>
                                            <td><% =workplanLine.Q2_Target%></td>
                                            <td><% =workplanLine.Q3_Target%></td>
                                           <td><% =workplanLine.Q4_Target%></td>
                                           <td><% =workplanLine.Imported_Annual_Target_Qty%></td>
                                           <td><% =workplanLine.Primary_Directorate%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
              </div>
         </div>
</asp:Content>
