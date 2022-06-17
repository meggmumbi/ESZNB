<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpenScoreCard.aspx.cs" Inherits="HRPortal.OpenScoreCard" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="panel panel-primary">
        <div class="panel-heading">Open Individual Performance  ScoreCard</div>
        <div runat="server" id="documentsfeedback"></div>
        <div class="panel-body">
               <div class="table-responsive">  
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Description</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>View Entries</th>
                        <th>Edit</th>
                        <th>Send/Cancel Approval</th>
                        <th>Print PC</th>
                         <th>Print Sub-Indicators</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = new Config().ReturnNav();
                        var performancelogs = nav.PerfomanceContractHeader.Where(r => r.Approval_Status != "Released" && r.Approval_Status != "Rejected" && r.Responsible_Employee_No == employeeNo && r.Document_Type == "Individual Scorecard");
                        foreach (var performancelog in performancelogs)
                        {
                    %>
                    <tr>
                        <td><% =performancelog.No%></td>
                        <td><% =performancelog.Description%></td>
                        <td><% =Convert.ToDateTime(performancelog.Start_Date).ToString("d/MM/yyyy")%></td>
                        <td><% =Convert.ToDateTime(performancelog.End_Date).ToString("d/MM/yyyy")%></td>
                        <td><a href="NewIndividualScoreCardEntries.aspx?IndividualPCNo=<%=performancelog.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Entries</a> </td>
                        <td>
                            <a href="NewIndividualScoreCard.aspx?step=1&&IndividualPCNo=<%=performancelog.No%>&&StrategicPlanNo=<%=performancelog.Strategy_Plan_ID %>&&WorkploanNo=<%=performancelog.Functional_WorkPlan %>&&annualplan=<%=performancelog.Annual_Workplan%>&&directorate=<%=performancelog.Directorate%>" class="btn btn-success"><i class="fa fa-pencil"></i>View/Edit</a>
                        </td>
                        <td>
                            <%
                                if (performancelog.Approval_Status == "Pending Approval")
                                {
                            %>
                            <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=performancelog.No %>');"><i class="fa fa-times"></i>Cancel Approval</label>

                            <%   
                                }
                                else if (performancelog.Approval_Status == "Open")
                                {
                            %>
                            <label class="btn btn-success" onclick="sendApprovalRequest('<%=performancelog.No %>');"><i class="fa fa-check"></i>Send Approval</label>
                            <% 
                                }
                            %>
                        </td>
                        <td>
                            <%
                                if (performancelog.Approval_Status == "Pending Approval")
                                {
                            %>
                            <a href="NewIndividualScoreCardReport.aspx?IndividualCardNo=<%=performancelog.No %>" class="btn btn-success"><i class="fa fa-download"></i>Print</a>

                            <%   
                                }
                                else if (performancelog.Approval_Status == "Open")
                                {
                            %>
                            <label class="btn btn-warning"><i class="fa fa-download"></i>Print</label>
                            <% 
                                }
                            %>
                        </td>
                          <td>
                            <%
                                if (performancelog.Approval_Status == "Pending Approval")
                                {
                            %>
                            <a href="SubIndicatorsReport.aspx?IndividualCardNo=<%=performancelog.No %>" class="btn btn-success"><i class="fa fa-download"></i>Print</a>

                            <%   
                                }
                                else if (performancelog.Approval_Status == "Open")
                                {
                            %>
                            <label class="btn btn-warning"><i class="fa fa-download"></i>Print</label>
                            <% 
                                }
                            %>
                        </td>
                        <%} %>
                </tbody>
            </table>
                   </div>
        </div>
    </div>
    <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("approvedocName").innerHTML = documentNumber;
            document.getElementById("MainBody_approvedocNo").value = documentNumber;
            $("#sendApproval").modal();
        }
        function cancelApprovalRequest(documentNumber) {
            document.getElementById("canceldocname").innerHTML = documentNumber;
            document.getElementById("MainBody_canceldocNo").value = documentNumber;
            $("#cancelApprovalModal").modal();
        }
    </script>
    <div id="sendApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Send perfomance contract For Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approvedocNo" type="hidden" />
                    Are you sure you want to send perfomance contract No <strong id="approvedocName"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" ID="sendapproval" OnClick="sendapproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <div id="cancelApprovalModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cancel perfomance contract approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="canceldocNo" type="hidden" />
                    Are you sure you want to cancel approval of  performance contract No <strong id="canceldocname"></strong>? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" ID="cancelapproval" OnClick="cancelapproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
