<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubmittedStandardAppraisalDetails.aspx.cs" Inherits="HRPortal.SubmittedStandardAppraisalDetails" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="panel panel-primary">
    <% string docNo = Request.QueryString["docNo"];
        var nav = new Config().ReturnNav(); %>
        <div class="panel panel-heading">
            <h3 class="panel-title">Submitted Standard Appraisal</h3>
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
                      <li style="background-color:#D3D3D3">
                            <a href="#improvement" data-toggle="tab"><h3 class="panel-title" style="color:black">Improvement Plan </h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#training" data-toggle="tab"><h3 class="panel-title" style="color:black">Training Needs </h3></a>
                        </li>
                        <li style="background-color:yellow">
                            <a href="#report" data-toggle="tab"><h3 class="panel-title" style="color:black">Report </h3></a>
                        </li>
                    </ul>
               </ul>
            <div class="tab-content">
                <div id="objectives" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">-Objectives and Outcomes</h3>
                        </div>
                           <div class="table-responsive">  
                            <table class="table table-bordered table-striped datatable" id="example5">
                                <thead>
                                    <tr>
                                        <th>Objective/Initiative</th>
                                        <th>Target Quantity</th>
                                        <th>Appraiser Review Quantity</th>
                                        <th>Final/Actual Quantity</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%                                                                              
                                        var cspplan = nav.ObjectiveEvaluationResult.Where(r => r.Performance_Evaluation_ID == docNo).ToList();
                                        foreach (var csps in cspplan)
                                        {
                                    %>
                                    <tr>
                                        <td><% =csps.Objective_Initiative%></td>
                                        <td><% =csps.Target_Qty%> </td>
                                        <td><% =csps.AppraiserReview_Qty%></td>
                                         <td><% =csps.Final_Actual_Qty%></td>
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
                                            <th>Appraiser Review Quantity</th>
                                            <th>Final/Actual Quantity</th>
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
                                            <td><% =initiative.AppraiserReview_Qty%></td>
                                            <td><% =initiative.Final_Actual_Qty%></td>
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
                    <div id="improvement" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Evaluation Improvement Plan</h3>
                            </div>
                            <div class="panel-body">
                                   <div class="table-responsive">  
                                <table class="table table-bordered table-striped datatable" id="example3">
                                    <thead>
                                        <tr>
                                            <th>PIP Category</th>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                      <%
                                        var themes = nav.EvaluationPIP.Where(x=> x.Perfomance_Evaluation_No == docNo);
                                        foreach (var theme in themes)
                                        {
                                        %>
                                       <tr>
                                           <td><% =theme.PIP_Category%></td>
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
                    <div id="training" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Evaluation Training Needs</h3>
                            </div>
                            <div class="panel-body">
                                   <div class="table-responsive">  
                                <table class="table table-bordered table-striped datatable" id="example2">
                                    <thead>
                                        <tr>
                                            <th>Training Need Category</th>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                     <%
                                        var objectives = nav.EvaluationTrainingneeds.Where(x=> x.Perfomance_Evaluation_No == docNo);
                                        foreach (var objective in objectives)
                                        {
                                        %>
                                       <tr>
                                           <td><% =objective.Training_Need_Category%></td>
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
                
                  <div id="report" class="tab-pane fade">
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
                    </div>                     
            </div>
        </div>
</asp:Content>
