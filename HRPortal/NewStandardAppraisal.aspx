<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewStandardAppraisal.aspx.cs" Inherits="HRPortal.NewStandardAppraisal" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        var nav = new Config().ReturnNav();
        var csp = Convert.ToString(Session["StrategicPlanNo"]);
        var IndividualPCNo = Convert.ToString(Session["IndividualPCNo"]);

        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 2 || step < 1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        if (step == 1)
        {
    %>
        <div class="panel panel-primary">
            <div class="panel panel-heading">
                Standard Appraisal General Details
                <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                 <div runat="server" id="generalfeedback"></div>
                
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Strategy Plan</label>
                        <asp:DropDownList runat="server" id="strategyplan" cssclass="form-control" AutoPostBack="true" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Performance Management Plan</label>
                        <asp:DropDownList runat="server" id="performancemngplan" cssclass="form-control" AutoPostBack="true" OnSelectedIndexChanged="performancemngplan_SelectedIndexChanged" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Personal Scorecard</label>
                        <asp:DropDownList runat="server" id="personalscorecard" cssclass="form-control" AutoPostBack="true" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Performance Task</label>
                        <asp:DropDownList runat="server" id="performancetask" cssclass="form-control" AutoPostBack="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Supervisor Name</label>
                        <asp:DropDownList runat="server" id="supervisorname" cssclass="form-control select2" AutoPostBack="true" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Description</label>
                        <asp:TextBox runat="server" id="description" cssclass="form-control"/>
                    </div>
                </div>

            </div>
            <div class="panel-footer">
                <asp:Button runat="server" ID="addgeneraldetails" CssClass="btn btn-success pull-right" Text="Next" OnClick="addgeneraldetails_Click"/>
                <span class="clearfix"></span>
            </div>
        </div>
            <% 
            }
            else if (step == 2)
            {
    %>
<div class="panel panel-primary">
    <% string docNo = Request.QueryString["docNo"]; %>

        <div class="panel panel-heading">
            <h3 class="panel-title"> Standard Appraisal Details</h3>
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>  
        <div runat="server" id="feedback"></div>
            <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#objectives" data-toggle="tab"   <h3 class="panel-title" style="color:black">Objectives and Outcomes</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#proficiency" data-toggle="tab"><h3 class="panel-title" style="color:black">Proficiency Evaluation</h3></a>
                        </li>
<%--                        <li style="background-color:yellow">
                            <a href="#report" data-toggle="tab"><h3 class="panel-title" style="color:black">View Evaluation Report </h3></a>
                        </li>--%>
                    </ul>
               </ul>
            <div class="tab-content">
                <div id="objectives" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">Objectives and Outcomes</h3>
                        </div>
                           <div class="table-responsive">  
                            <table class="table table-bordered table-striped datatable" id="example5">
                                <thead>
                                    <tr>
                                        <th>Objective/Initiative</th>
                                        <th>Achived Target</th>
                                        <th>Weight</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%                                                                              
                                        var cspplan = nav.ObjectiveEvaluationResult.Where(r => r.Performance_Evaluation_ID == docNo).ToList();
                                        foreach (var csps in cspplan)
                                        {
                                    %>
                                    <tr>
                                         <td><a href="StandardAppraisalSubIndicators.aspx?docNo=<%=csps.Performance_Evaluation_ID %>&&InitiativeNo=<%=csps.Intiative_No %>"</a><% =csps.Objective_Initiative%> </td> 
                                         <td><% =csps.Target_Qty%> </td>
                                         <td><% =csps.Weight%> </td>
                                  </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                               </div>
                    </div>
                  </div>
                    <div id="proficiency" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Proficiency Evaluation</h3>
                            </div>
                            <div class="panel-body">
                                   <div class="table-responsive">  
                                <table class="table table-bordered table-striped datatable" id="example4">
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                            <th>Target Quantity</th>
                                           
                                        </tr>
                                    </thead>
                                    <tbody>
                                         <%
                                        var initiatives = nav.ProficiencyEvaluationResult.Where(x=> x.Performance_Evaluation_ID == docNo);
                                        foreach (var initiative in initiatives)
                                        {
                                    %>
                                       <tr>
                                                                
                                            <td><% =initiative.Description%></td>
                                           <td><% =initiative.Target_Qty%></td>
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
                
<%--                  <div id="report" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Evaluation Report</h3>
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                 <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" ID="p9form" style="margin-top: 10px;" ></iframe>
                                </div>
                            </div>
                        </div>
                    </div> --%>                    
            </div>
                <div class="panel-footer">
                    <asp:Button runat="server" ID="previous" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click"/>
                    <asp:Button runat="server" ID="Sendapproval" CssClass="btn btn-success pull-right" Text="Submit To Supervisor" OnClick="Sendapproval_Click"/>
                <span class="clearfix"></span>
            </div>
        </div>
        <% 
            }
    %>

</asp:Content>
