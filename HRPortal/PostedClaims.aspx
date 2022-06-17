<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PostedClaims.aspx.cs" Inherits="HRPortal.PostedClaims" %>

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
        String myStatus = "approved";
        var nav = new Config().ReturnNav();
        var payments = nav.Payments.Where(r => r.Status == "Released"&& r.Account_No==employeeNo&&r.Posted==true&&r.Payment_Type=="Staff Claim");
       
    %>
 <div class="panel panel-primary">
        <div class="panel-heading">
           Posted Staff Claims
        </div>
        <div class="panel-body">
            <!--No, status, location code, description , view/edit -->
            <div runat="server" id="feedback"></div>
               <div class="table-responsive">  
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Claim No</th>
                    <th>Status</th>
                    <th>Payment Narration</th>
                    <th>Status</th>
                    <th>Posted</th>
                    <th>View Approval Entries</th>
                     
                </tr>
                </thead>
                <tbody>
                <%
                    foreach (var header in payments)
                    {
                        %>
                    <tr>
                   <td><% =header.No %></td>
                        <td><% =header.Status %></td>
                        <td><% =header.Payment_Narration%></td>
                        <td><% =header.Status%></td>
                         <td><% =header.Posted%></td>
                        <%--<td><label class="btn btn-success" onclick="showApprovalEntries('<%=header.No %>', '57000', 'staff Claims');"><i class="fa fa-eye"></i> View Entries</label></td>--%>
                       <td><a href="postedstaffclaim.aspx?claimNo=<%=header.No %>" class="btn btn-success"><i class="fa fa-eye"></i> View Entries</a> </td>

                      
                      
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
        <h4 class="modal-title">Imprest Memo No <strong id="myRecordId"></strong> Approval Entries</h4>
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
               <th>Date Posted</th>    
               <th>Posted By</th>             
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
                  + "<td>" + obj.DatePosted + "</td>"
                  
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
