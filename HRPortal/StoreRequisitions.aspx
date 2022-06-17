<%@ Page Title="Store Requisitions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StoreRequisitions.aspx.cs" Inherits="HRPortal.StoreRequisitions" %>
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
        var headers = nav.PurchaseHeader.Where(r => r.Status != "Released"&& r.Document_Type=="Store Requisition"&&r.Request_By_No==employeeNo);
        if (status== "approved")
        {
            myStatus = "Approved";
            headers = nav.PurchaseHeader.Where(r => r.Status == "Released"&& r.Document_Type=="Store Requisition"&&r.Request_By_No==employeeNo);
        }
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <%=myStatus %> Store Requisitions
        </div>
        <div class="panel-body">
            <!--No, status, location code, description , view/edit -->
            <div runat="server" id="feedback"></div>
               <div class="table-responsive">  
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Requisition No</th>
                    <th>Status</th>
                    <th>Location Code</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>View Approval Entries</th>
                     <th>Send/Cancel Approval</th>
                    <th>View/Edit</th>
                </tr>
                </thead>
                <tbody>
                <%
                    foreach (var header in headers)
                    {
                        %>
                    <tr>
                        <td><% =header.No %></td>
                        <td><% =header.Status %></td>
                        <td><% =header.Location_Code %></td>
                        <td><% =header.Description%></td>
                        <td><% =header.Status%></td>
                        <%--<td><label class="btn btn-success" onclick="showApprovalEntries('<%=header.No %>', '38', 'Store Requisition');"><i class="fa fa-eye"></i> View Entries</label></td>--%>
                        <td><a href="StoreRequisitionsApproverEntries.aspx?requisitionNo=<%=header.No %>" class="btn btn-success"><i class="fa fa-eye"></i> View Entries</a> </td>

                        <td>
                        <%
                            if (header.Status=="Pending Approval")
                            {
                                 %>
                         <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=header.No %>');"><i class="fa fa-times"></i> Cancel Approval Request</label>
                        
                        <%   
                            }else if (header.Status=="Open")
                            {
                                  %>
                         <label class="btn btn-success" onclick="sendApprovalRequest('<%=header.No %>');"><i class="fa fa-check"></i> Send Approval Request</label>
                        <% 
                            }
                             %>
                            </td>
                        <td><a href="StoreRequisition.aspx?step=1&&requisitionNo=<%=header.No %>" class="btn btn-success">View/Edit</a></td>
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
        <h4 class="modal-title">Store Requisition <strong id="myRecordId"></strong> Approval Entries</h4>
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
            document.getElementById("approveImprestMemoNo").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_imprestMemoToApprove").value = documentNumber;

            $("#sendImprestMemoForApproval").modal();
        }
        function cancelApprovalRequest(documentNumber) {
           
            document.getElementById("cancelImprestMemoText").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_cancelImprestMemoNo").value = documentNumber;

            $("#cancelImprestMemoForApprovalModal").modal();
        }
		 </script>
		
		<div id="sendImprestMemoForApproval" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Send Store Requisition For Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="imprestMemoToApprove" type="hidden"/>
          Are you sure you want to send store Requisition No <strong id="approveImprestMemoNo"></strong>  for approval ? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-success" Text="Send Approval" OnClick="sendApproval_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
     <div id="cancelImprestMemoForApprovalModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Cancel Store Requisition Approval</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="cancelImprestMemoNo" type="hidden"/> 
          Are you sure you want to cancel approval of  Store Requisition No <strong id="cancelImprestMemoText"></strong>? 
        </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Cancel Approval" OnClick="cancelApproval_Click" />
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>
</asp:Content>
