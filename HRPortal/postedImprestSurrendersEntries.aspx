<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="postedImprestSurrendersEntries.aspx.cs" Inherits="HRPortal.postedImprestSurrendersEntries" %>
<%@ Import Namespace="HRPortal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                       <th> Posted By</th>
                       <th>Amount</th>
                       <th>Posted Date</th>
                      
                       <th>Comment(s)</th>
                   
                  </tr>
                </thead>
                <tbody>
                <%
                    String docNo = Request.QueryString["surrenderNo"];
                    var leaves = nav.ApprovalEntries.Where(r => r.Document_No == docNo).ToList();
                    foreach (var leave in leaves)
                    {
                        %>
                       <tr>
                    <td> <%=leave.Sequence_No %> </td>
                    <td> <%=leave.Status %> </td>
                    <td> <%=leave.Sender_ID %> </td>
                     <td> <%=leave.Last_Modified_By_User_ID %> </td>
                     <td> <%=leave.Amount %> </td>
                    <td> <%=Convert.ToDateTime(leave.Last_Date_Time_Modified).ToString("dd/MM/yyyy") %> </td>
                 
                <% 
                  String comment = "";
                if (Convert.ToBoolean(leave.Comment ) == false || Convert.ToBoolean(leave.Comment) == true)

                {
                    var comments = nav.ApprovalCommentLine.Where(r => r.Table_ID == leave.Table_ID && r.Record_ID_to_Approve == leave.Record_ID_to_Approve && r.Workflow_Step_Instance_ID == leave.Workflow_Step_Instance_ID
                    && r.Workflow_Step_Instance_ID == leave.Workflow_Step_Instance_ID && r.User_ID == leave.Approver_ID && r.Document_No == docNo);
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
