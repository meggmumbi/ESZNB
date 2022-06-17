<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StandardAppraisalSubIndicators.aspx.cs" Inherits="HRPortal.StandardAppraisalSubIndicators" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <section class="content-header">
        <h1>Standard Appraisal Sub Objectives and Outcomes
        </h1>
        <ol class="breadcrumb" style="background-color: antiquewhite">
            <li><a href="Dashboard.aspx"><i class="fa fa-dashboard"></i>Objectives and Outcomes</a></li>
            <li><a href="imprest.aspx">Sub Objectives and Outcomes</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
               Sub Objectives and Outcomes
            </div>
            <div class="panel-body">
            <div runat="server" id="FeedBack"></div>
                   <div class="table-responsive">  
               <table id="example5" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Objective/Initiative</th>
                            <th>Target Qty</th>
                            <th>Final/Actual Qty</th>
                            <th>Weight %</th>                 
                        </tr>
                    </thead>

                    <tbody>
                        <% 
                            var nav = new Config().ReturnNav();
                            string docNo = Request.QueryString["docNo"];
                            string InitiativeNo = Request.QueryString["InitiativeNo"];
                            var tb = nav.SubObjectiveEvaluation.Where(r => r.Performance_Evaluation_ID == docNo && r.Intiative_No == InitiativeNo).ToList();
                            foreach (var csps in tb)
                            {
                        %>
                        <tr>
                            <td><% =csps.Objective_Initiative%></td>
                            <td><% =csps.Target_Qty%> </td>
                            <td><% =csps.Final_Actual_Qty%></td>
                            <td><% =csps.Weight%> </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                       </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click"/>
            <div class="clearfix"></div>
        </div>
      </div>
    </div>
    </section>
</asp:Content>
