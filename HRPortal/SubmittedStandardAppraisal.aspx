<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubmittedStandardAppraisal.aspx.cs" Inherits="HRPortal.SubmittedStandardAppraisal" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="panel panel-primary">
            <div class="panel-heading">
                Submitted Standard Appraisal
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                   <div class="table-responsive">  
                 <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Document No</th>
                            <th>Employee Name</th>
                            <th>Supervisor Name</th>
                            <th>Description</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                           <%-- <th>View Details</th>--%>
                            <th>Print</th>
                        </tr>
                    </thead>
                    <tbody> 
                    <%
                        var nav = new Config().ReturnNav();
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var data = nav.PerfomanceEvaluation.Where(r => r.Employee_No == employeeNo && r.Closed == false && r.Evaluation_Type == "Standard Appraisal/Supervisor Score Only" && r.Approval_Status == "Released" && r.Document_Type == "Performance Appraisal" && r.Document_Status == "Submitted");
                        foreach (var item in data)
                        {
                    %>
                    <tr>
                                               
                        <td><% =item.No %></td>
                        <td><% =item.Employee_Name %></td>
                        <td><% =item.Supervisor_Name%></td>
                        <td><% =item.Description%></td>
                        <td><% = Convert.ToDateTime(item.Evaluation_Start_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(item.Evaluation_End_Date).ToString("dd/MM/yyyy")%></td>
<%--                        <td><a href="SubmittedStandardAppraisalDetails.aspx?docNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Details</a> </td>--%>
                        <td><a href="StandardAppraisalReport.aspx?docNo=<%=item.No %>" class="btn btn-warning"><i class="fa fa-download"></i>Print</a> </td>
                        <%
                            }
                      %>
                </tbody>
                </table>
                       </div>
            </div>        
        </div> 
</asp:Content>
