<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OngoingStrategicPlan.aspx.cs" Inherits="HRPortal.OngoingStrategicPlan" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Ongoing Corporate Strategic Plan</h3>
        </div>
        <ul class="nav nav-pills" role="tablist">
            <ul class="nav nav-tabs">
                <li class="active" style="background-color: #D3D3D3">
                    <a href="#home" data-toggle="tab">
                        <h3 class="panel-title" style="color: black">General Details</h3>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#theme" data-toggle="tab">
                        <h3 class="panel-title" style="color: black">Strategic Theme</h3>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#objective" data-toggle="tab">
                        <h3 class="panel-title" style="color: black">Strategic Objective </h3>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#strategies" data-toggle="tab">
                        <h3 class="panel-title" style="color: black">Strategies </h3>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#initiative" data-toggle="tab">
                        <h3 class="panel-title" style="color: black">Strategic Initiatives </h3>
                    </a>
                </li>

                <%--                      <li style="background-color:#D3D3D3">
                            <a href="#corevalues" data-toggle="tab"><h3 class="panel-title" style="color:black">Core Values </h3></a>
                        </li>
                       <li style="background-color:#D3D3D3">
                            <a href="#annualplans" data-toggle="tab"><h3 class="panel-title" style="color:black">Annual Implementation Plans</h3></a>
                        </li>
                       <li style="background-color:#D3D3D3">
                            <a href="#plannedyrs" data-toggle="tab"><h3 class="panel-title" style="color:black">Planned Years</h3></a>
                        </li>--%>
            </ul>
        </ul>
        <div class="tab-content">
            <div id="home" class="tab-pane active">
                <div class="panel panel-primary">
                    <div class="panel panel-heading">
                        <h3 class="panel-title">Corporate Strategic Plan General Details</h3>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped datatable" id="example6">
                            <thead>
                                <tr>
                                    <th>Description</th>
                                    <th>Primary Theme</th>
                                    <th>Duration</th>
                                    <th>Start Date</th>
                                    <th>Due Date</th>
                                    <th>Implementation</th>
                                    <th>Print</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                                    var nav = new Config().ReturnNav();
                                    var cspplan = nav.CorporateStrategicPlans.Where(r => r.Implementation_Status == "Ongoing").ToList();
                                    foreach (var csps in cspplan)
                                    {
                                        Session["cspNo"] = csps.Code;
                                %>
                                <tr>
                                    <td><% =csps.Description%></td>
                                    <td><% =csps.Primary_Theme%></td>
                                    <td><% =csps.Duration_Years%> </td>
                                    <td><% = Convert.ToDateTime(csps.Start_Date).ToString("dd/MM/yyyy")%></td>
                                    <td><% = Convert.ToDateTime(csps.End_Date).ToString("dd/MM/yyyy")%></td>
                                    <td><% =csps.Implementation_Status%></td>
                                    <td><a href="CSPReport.aspx?IndividualPCNo=<%=csps.Code %>">
                                        <label class="btn btn-success">View Report</label></a></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <%--                    <div id="corevalues" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Core Values</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example2">
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                         <%
                                        var nav1 = new Config().ReturnNav();
                                        var initiatives = nav.StrategyCoreValue.Where(x=> x.Strategic_Plan_ID == Convert.ToString(Session["cspNo"]));
                                        foreach (var initiative in initiatives)
                                        {
                                    %>
                                       <tr>
                                        <td><% =initiative.Description%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>--%>
            <div id="theme" class="tab-pane fade">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Strategic Theme</h3>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped datatable" id="example1">
                                <thead>
                                    <tr>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        var nav2 = new Config().ReturnNav();
                                        var themes = nav.StrategicTheme.Where(x => x.Strategic_Plan_ID == Convert.ToString(Session["cspNo"]));
                                        foreach (var theme in themes)
                                        {
                                    %>
                                    <tr>
                                        <td><% =theme.Description%></td>
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
            <div id="objective" class="tab-pane fade">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Strategic Objectives</h3>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped datatable" id="example4">
                                <thead>
                                    <tr>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        var nav3 = new Config().ReturnNav();
                                        var objectives = nav.StrategicObjective.Where(x => x.Strategic_Plan_ID == Convert.ToString(Session["cspNo"]));
                                        foreach (var objective in objectives)
                                        {
                                    %>
                                    <tr>
                                        <td><% =objective.Description%></td>
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

            <div id="strategies" class="tab-pane fade">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Strategies</h3>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped datatable" id="example5">
                                <thead>
                                    <tr>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        var nav4 = new Config().ReturnNav();
                                        var strategies = nav.Strategy.Where(x => x.Strategic_Plan_ID == Convert.ToString(Session["cspNo"]));
                                        foreach (var objective in strategies)
                                        {
                                    %>
                                    <tr>
                                        <td><% =objective.Description%></td>
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

            <%--                    <div id="annualplans" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Annual Implementation Plans</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example7">
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                     <%
                                        var plans = nav.AnnualStrategyWorkplan.Where(x=> x.Strategy_Plan_ID == Convert.ToString(Session["cspNo"]));
                                        foreach (var objective in plans)
                                        {
                                        %>
                                       <tr>
                                        <td><% =objective.Description%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>--%>

            <div id="initiative" class="tab-pane fade">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Strategic Initiatives</h3>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped datatable" id="example8">
                                <thead>
                                    <tr>
                                        <th>Description</th>
                                        <th>Key Performance Indicator</th>
                                        <th>Primary Directorate</th>
                                        <th>Planned Target</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        var initiave = nav.StrategicInitiative.Where(x => x.Strategic_Plan_ID == Convert.ToString(Session["cspNo"]));
                                        foreach (var objective in initiave)
                                        {
                                    %>
                                    <tr>
                                        <td><% =objective.Description%></td>
                                        <td><% =objective.Perfomance_Indicator%></td>
                                        <td><% =objective.Primary_Directorate%></td>
                                        <td><% =objective.Total_Posted_Planned_Target%></td>
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

            <%--                     <div id="plannedyrs" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Planned Years</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example8">
                                    <thead>
                                        <tr>
                                            <th>Annual Year Code</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                     <%
                                        var yrs = nav.CSPPlannedYears.Where(x=> x.CSP_Code == Convert.ToString(Session["cspNo"]));
                                        foreach (var objective in yrs)
                                        {
                                        %>
                                       <tr>
                                        <td><% =objective.Annual_Year_Code%></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>--%>
        </div>
    </div>
</asp:Content>
