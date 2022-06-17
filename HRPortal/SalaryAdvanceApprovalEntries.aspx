<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalaryAdvanceApprovalEntries.aspx.cs" Inherits="HRPortal.SalaryAdvanceApprovalEntries" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <% var nav = new Config().ReturnNav(); %>
     <div class="row" >
        <div class="cil-md-12 col-lg-12 col-sm-12 col-xs-12">
         <div class="panel panel-primary">
             <div class="panel-heading">
                 My Approver Entries
             </div>
             <div class="panel-body">
                 <div runat="server" id="feedback"></div>
                    <div class="table-responsive">  
                  <table class="table table-striped table-bordered">
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
                <tbody>
                <%
                    String docNo = Request.QueryString["applicationNo"];
                    var approvalEnries = nav.ApprovalEntries.Where(r => r.Document_No == docNo).ToList();
                    foreach (var approvalEnrie in approvalEnries)
                    {
                        %>
                       <tr>
                    <td> <%=approvalEnrie.Sequence_No %> </td>
                    <td> <%=approvalEnrie.Status %> </td>
                    <td> <%=approvalEnrie.Sender_ID %> </td>
                     <td> <%=approvalEnrie.Approver_ID %> </td>
                     <td> <%=approvalEnrie.Amount %> </td>
                    <td> <%=Convert.ToDateTime(approvalEnrie.Date_Time_Sent_for_Approval).ToString("dd/MM/yyyy") %> </td>
                    <td> <%=Convert.ToDateTime(approvalEnrie.Due_Date).ToString("dd/MM/yyyy") %> </td>
                <% 
                  String comment = "";
                if (Convert.ToBoolean(approvalEnrie.Comment ) == false || Convert.ToBoolean(approvalEnrie.Comment) == true)

                {
                    var comments = nav.ApprovalCommentLine.Where(r => r.Table_ID == approvalEnrie.Table_ID && r.Record_ID_to_Approve == approvalEnrie.Record_ID_to_Approve && r.Workflow_Step_Instance_ID == approvalEnrie.Workflow_Step_Instance_ID
                    && r.Workflow_Step_Instance_ID == approvalEnrie.Workflow_Step_Instance_ID && r.User_ID == approvalEnrie.Approver_ID && r.Document_No == docNo);
                    foreach (var myComment in comments)
                    {
                        comment += comment.Length < 1 ? "<ul>" : "";
                        comment += "<li>" + myComment.Comment + "</li>";
                    }
                    comment += comment.Length > 0 ? "</ul>" : "";
                         
                }
               
 
                  
                    
                    %>
                   <td><%=comment%> </td>
                           </tr>
                    <%
                        
                    }
                     %>
               
              
                
                </tbody>
              </table>
                        </div>
             </div>
         </div>
            <%--<asp:Button ID="GoBack" runat="server" CssClass="btn btn-primary" Text="Go Back" OnClick="GoBack_Click" />--%>
        </div>
         
    </div>
     
</asp:Content>
