<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="salaryAdvanceApplications.aspx.cs" Inherits="HRPortal.salaryAdvanceApplications" %>

<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        String employeeNo = Convert.ToString(Session["employeeNo"]);
        String status = String.IsNullOrEmpty(Request.QueryString["status"]) ? "open" : Request.QueryString["status"];
        String myStatus = "Open";
        var nav = new Config().ReturnNav();
        var salaryAdvance = nav.Payments.Where(r => r.Status != "Released" && r.Account_No == employeeNo && r.Document_Type == "Salary Advance");
        if (status == "approved")
        {
            myStatus = "Approved";
            salaryAdvance = nav.Payments.Where(r => r.Status == "Released" && r.Document_Type == "Salary Advance" && r.Account_No == employeeNo);
        }
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <%=myStatus %>Salary Advance
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <div class="table-responsive">
                <table class="table table-bordered table-striped" id="example8">
                    <thead>
                        <tr>
                            <th>Document No</th>
                            <th>Account No</th>
                            <th>Account Name</th>
                            <th>Salary Advance</th>
                            <th>No of Months Deducted</th>
                            <th>Monthly Installments</th>
                            <th>Status</th>
                            <th>Approval Entries</th>
                            <th>Send/Cancel Approval</th>
                            <th>View/Edit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            foreach (var advance in salaryAdvance)
                            {
                        %>
                        <tr>
                            <td><% =advance.No %></td>
                            <td><% =advance.Account_No %></td>
                            <td><% =advance.Account_Name %></td>
                            <td><% =String.Format("{0:n}", Convert.ToDouble(advance.Salary_Advance)) %></td>
                            <td><% =String.Format("{0:n}", Convert.ToDouble(advance.No_of_months_deducted)) %></td>
                            <td><% =String.Format("{0:n}", Convert.ToDouble(advance.Monthly_Installment)) %></td>
                            <td><% =advance.Status %></td>
                            <%--<td><label class="btn btn-success" onclick="showApprovalEntries('<%=memo.No %>', '57008', 'Imprest Memo');"><i class="fa fa-eye"></i> View Entries</label></td>--%>
                            <td><a href="SalaryAdvanceApprovalEntries.aspx?applicationNo=<%=advance.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Entries</a> </td>

                            <td>
                                <%
                                    if (advance.Status == "Pending Approval")
                                    {
                                %>
                                <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=advance.No %>');"><i class="fa fa-times"></i>Cancel Approval Request</label>

                                <%   
                                    }
                                    else if (advance.Status == "Open")
                                    {
                                %>
                                <label class="btn btn-success" onclick="sendApprovalRequest('<%=advance.No %>');"><i class="fa fa-check"></i>Send Approval Request</label>
                                <% 
                                    }
                                    else
                                    {%>
                                <td><strong>The Salary Advance application has been approved</strong></td>
                                <%
                                    }
                                %>
                            </td>
                            <%if (advance.Status == "Open")
                                {
                            %>
                            <td><a href="SalaryAdvanceApplication.aspx?&&applicationNo=<%=advance.No %>" class="btn btn-success">View/Edit</a></td>

                            <%}
                                else
                                { %>
                            <td></td>
                            <%} %>
                        </tr>
                        <%
                            } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div id="showApprovalEntriesModal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Imprest Memo No <strong id="myRecordId"></strong>Approval Entries</h4>
                </div>
                <div class="modal-body">
                    <div class="overlay" id="myLoading">
                        <i class="fa fa-refresh fa-spin" id="refreshBar"></i>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped" id="entriesTable" style="display: none;">
                                <thead>
                                    <tr>
                                        <th>Sequence No.</th>
                                        <th>Status</th>
                                        <th>Sender Id</th>
                                        <th>Approver Id</th>
                                        <th>Amount</th>
                                        <th>Date Sent for Approval</th>
                                        <th>Due Date</th>
                                        <th>Comment(s)</th>
                                    </tr>
                                </thead>
                                <tbody id="approvalEntries"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>

    <script>
        function showApprovalEntries(recordId, tableId, recordType) {
            //   
            $("#myLoading").addClass("overlay");
            $('#entriesTable').hide();
            $('#refreshBar').show();
            document.getElementById("myRecordId").innerHTML = recordId;

            $.ajax({
                url: "receiver/api/values",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify({
                    'TableId': tableId,
                    'DocumentType': recordType,
                    'DocumentNo': recordId
                }),
                dataType: "json"
            })
      .done(function (response) {
          var table = $("#entriesTable tbody");
          for (var i = document.getElementById("entriesTable").rows.length; i > 1; i--) {
              document.getElementById("entriesTable").deleteRow(i - 1);
          }

          for (var i = 0; i < response.length; i++) {
              var obj = response[i];//obj.enrolmentId
              table.append("<tr>" +
                  "<td>" + obj.SequenceNo + "</td>"
                  + "<td>" + obj.Status + "</td>"
                  + "<td>" + obj.SenderId + "</td>"
                  + "<td>" + obj.ApproverId + "</td>"
                  + "<td>" + obj.Amount + "</td>"
                  + "<td>" + obj.DateSentforApproval + "</td>"
                  + "<td>" + obj.DueDate + "</td>"
                  + "<td>" + obj.Comment + "</td>"
                   + " </tr>");

          }
          $("#myLoading").removeClass("overlay");
          $('#entriesTable').show();
          $('#refreshBar').hide();

      })

            $("#showApprovalEntriesModal").modal();
        }

    </script>
    <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("approveSalaryAdvance").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_salaryAdvanceToApprove").value = documentNumber;

            $("#sendSalaryAdvanceForApproval").modal();
        }
        function cancelApprovalRequest(documentNumber) {

            document.getElementById("cancelSalaryAdvance").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_cancelSallaryAdvanceNo").value = documentNumber;

            $("#cancelSalaryAdvanceForApprovalModal").modal();
        }
    </script>

    <div id="sendSalaryAdvanceForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Send Salary Advance application For Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="salaryAdvanceToApprove" type="hidden" />
                    Are you sure you want to send Salary Advance Application No <strong id="approveSalaryAdvance"></strong>for approval ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" OnClick="sendApproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <div id="cancelSalaryAdvanceForApprovalModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cancel Salary Advance Approval</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="cancelSallaryAdvanceNo" type="hidden" />
                    Are you sure you want to cancel approval of  Salary Advance Application No <strong id="cancelSalaryAdvance"></strong>? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" OnClick="cancelApproval_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
