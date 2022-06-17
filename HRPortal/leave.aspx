<%@ Page Title="Leave" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="leave.aspx.cs" Inherits="HRPortal.leave" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <% var nav = new Config().ReturnNav(); %>
     <div class="row" >
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
         <div class="panel panel-primary" >
             <div class="panel-heading">
                 My Leave Applications
             </div>
             <div class="panel-body">
                 <div runat="server" id="feedback"></div>
                    <div class="table-responsive">  
                  <table class="table table-striped table-bordered"  style="width:100%">
                <thead>
                  <tr>
                    <th> Application No</th>
                    <th> Leave Type</th>
                      <th>Annual Leave Type</th>
                    <th> Days Applied</th>
                    <th> Leave Start Date</th>
                    <th> Application Date</th>
                      <th>Return Date</th>
                    <th> Status</th>
                     <%-- <th> Leave Form</th>--%>
                      <th> Edit</th>
                    <th> Approval Entries</th>
                    <th> Send/Cancel Approval</th>
                   
                  </tr>
                </thead>
                <tbody>
                <%
                    var leaves = nav.LeaveApplications.Where(r => r.Employee_No == (String) Session["employeeNo"]);
                    foreach (var leave in leaves)
                    {
                        %>
                       <tr>
                    <td> <%=leave.Application_Code %> </td>
                    <td> <%=leave.Leave_Type %> </td>
                    <td> <%=leave.Annual_Leave_Type %> </td>
                    
                            
                    
                    <td> <%=leave.Days_Applied %> </td>
                    <td> <%=Convert.ToDateTime(leave.Start_Date).ToString("dd/MM/yyyy") %> </td>
                    <td> <%=Convert.ToDateTime(leave.Application_Date).ToString("dd/MM/yyyy") %> </td>
                    <td> <%=Convert.ToDateTime(leave.Return_Date).ToString("dd/MM/yyyy") %> </td>
                    <td> <%=leave.Status %> </td>
                           <%--<td><a class="btn btn-success" href="leave.aspx?leave=<%=leave.Application_Code %>"><i class="fa fa-file"></i> View</a></td>--%>
                           <td><a href="leaveapplication.aspx?leaveno=<%=leave.Application_Code %>" class="btn btn-success"><i class="fa fa-edit"></i> Edit</a> </td>
                           <td><a href="ApproverEntry.aspx?leaveno=<%=leave.Application_Code %>" class="btn btn-success"><i class="fa fa-file"></i> View Entries</a> </td>

                   <%-- <td><label class="btn btn-success" onclick="showApprovalEntries('<%=leave.Application_Code %>', '69205', 'Leave Application');"><i class="fa fa-eye"></i> View Entries</label></td>
                    --%>
                    <td>
                        <!-- Open,Pending Approval,Rejected,Released-->
                        <%
                            if (leave.Status=="Open"||leave.Status=="Rejected")
                            {
                                %>
                         <label class="btn btn-success" onclick="sendLeaveForApproval('<%=leave.Application_Code %>', '<%=leave.Leave_Type %>', ' <%=Convert.ToDateTime(leave.Start_Date).ToString("dd/MM/yyyy") %>');"><i class="fa fa-check"></i> Send Approval Request</label>
                        <%
                            }else if (leave.Status=="Pending Approval")
                            {
                                
                               %>
                         <label class="btn btn-danger" onclick="cancelLeaveApproval('<%=leave.Application_Code %>', '<%=leave.Leave_Type %>', ' <%=Convert.ToDateTime(leave.Start_Date).ToString("dd/MM/yyyy") %>');"><i class="fa fa-times"></i> Cancel Approval Request</label>
                        
                        <% 
                            } %>
                       
                        

                    </td>
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
     
   <div id="leaveFormModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Leave Form</h4>
      </div>
      <div class="modal-body">
          <iframe runat="server" ID="leaveForm" width="100%" height="500px"></iframe>
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
 <div id="sendLeaveForApprval" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Send Leave For Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="leavNoToApprove" type="hidden"/>
          Are you sure you want to send Leave No <strong id="approveLeaveNo"></strong> of Type <strong id="approveLeaveType"></strong> starting on <strong id="approveStartDate"></strong> for approval ? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" OnClick="sendApproval_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
     <div id="cancelLeaveApprovalModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Cancel Leave Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="cancelLeaveNo" type="hidden"/> 
          Are you sure you want to cancel leave approval of  Leave No <strong id="cancelLeaveNoText"></strong> of Type <strong id="cancelLeaveType"></strong> starting on <strong id="cancelStartDate"></strong>? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" OnClick="cancelApproval_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
  <div id="showApprovalEntriesModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Leave No <strong id="myRecordId"></strong> Approval Entries</h4>
      </div>
      <div class="modal-body">
          <div class="overlay" id="myLoading">
              <i class="fa fa-refresh fa-spin" id="refreshBar"></i>
               <div class="table-responsive">  
       <table class="table table-bordered table-striped"  id="entriesTable" style="display: none;">
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
            
        
            $(document).ready(function () {
                

            });
        </script>
    <script>
        function showLeaveForm() {
            $("#leaveFormModal").modal();
        }

        function sendLeaveForApproval(leaveno, leaveType, startDate) {
            document.getElementById("approveLeaveNo").innerHTML = leaveno;
            document.getElementById("approveLeaveType").innerHTML = leaveType;
            document.getElementById("approveStartDate").innerHTML = startDate;
            document.getElementById("ContentPlaceHolder1_leavNoToApprove").value = leaveno;

            $("#sendLeaveForApprval").modal();
        }
        function cancelLeaveApproval(leaveno, leaveType, startDate) {
            //   
            document.getElementById("cancelLeaveNoText").innerHTML = leaveno;
            document.getElementById("cancelLeaveType").innerHTML = leaveType;
            document.getElementById("cancelStartDate").innerHTML = startDate;
            document.getElementById("ContentPlaceHolder1_cancelLeaveNo").value = leaveno;

            $("#cancelLeaveApprovalModal").modal();
        }
        function showApprovalEntries(recordId, tableId, recordType)
        { 
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
                 +"<td>" + obj.Status + "</td>"
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

</asp:Content>
