<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenStandardAppraisal.aspx.cs" Inherits="HRPortal.OpenStandardAppraisal" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="panel panel-primary">
            <div class="panel-heading">
                Open Standard Appraisal
            </div>
            <div class="panel-body">
                <div runat="server" id="documentsfeedback"></div>
                   <div class="table-responsive">  
                 <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Strategy Plan</th>
                            <th>Performance Mgnt Plan</th>
                            <th>Description</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Edit</th>
                            <th>Submit To Supervisor</th>
                        </tr>
                    </thead>
                    <tbody> 
                    <%
                        var nav = new Config().ReturnNav();
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var data = nav.PerfomanceEvaluation.Where(r => r.Employee_No == employeeNo && r.Evaluation_Type == "Standard Appraisal/Supervisor Score Only" && r.Approval_Status == "Open" && r.Document_Type == "Performance Appraisal" && r.Document_Status == "Draft");
                        foreach (var item in data)
                        {
                    %>
                    <tr>
                                               
                        <td><% =item.CspDescription %></td>
                        <td><% =item.pmpDescription%></td>
                        <td><% =item.Description%></td>
                        <td><% = Convert.ToDateTime(item.Evaluation_Start_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(item.Evaluation_End_Date).ToString("dd/MM/yyyy")%></td>
                        <td><a href="NewStandardAppraisal.aspx?docNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-pencil"></i>Edit</a> </td>
                        <td><label class="btn btn-success" onclick="sendApprovalRequest('<%=item.No %>');"><i class="fa fa-check"></i>Submit To Supervisor</label></td>
                        <%
                            }
                      %>
                </tbody>
                </table>
                       </div>
            </div>        
        </div>
    
      <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("approvedocName").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_approvedocNo").value = documentNumber;
            $("#sendImprestMemoForApproval").modal();
        }
    </script>

    <div id="sendImprestMemoForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Submit appraisal to supervisor</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approvedocNo" type="hidden" />
                     Are you sure you want to submit appraisal No <strong id="approvedocName"></strong> to your supervisor ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Submit To Supervisor" ID="sendapproval" OnClick="sendapproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div> 
</asp:Content>
