<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedScoreCard.aspx.cs" Inherits="HRPortal.ApprovedScoreCard" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="panel panel-primary">
        <div class="panel-heading">Approved Individual Performance  ScoreCard</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <div class="table-responsive">               
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Description</th>
                        <th>Strategy Plan</th>
                        <th>Annual Reporting code </th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>View</th>
                        <th>Print Pc</th>
                        <th>Print Sub-Indicators</th>
                        <th>Lock</th>
                        <th>Sign</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        string employeeNo = Convert.ToString(Session["employeeNo"]);
                        var data = nav.PerfomanceContractHeader.Where(r => r.Responsible_Employee_No == employeeNo && r.Score_Card_Type == "Staff" && r.Approval_Status == "Released" && r.Document_Type == "Individual Scorecard");
                        foreach (var item in data)
                        {
                    %>
                    <tr>
                        <td><% =item.No%></td>
                        <td><% =item.Description%></td>
                        <td><% =item.Strategy_Plan_ID %></td>
                        <td><% =item.Annual_Reporting_Code %></td>
                        <td><% =Convert.ToDateTime(item.Start_Date).ToString("d/MM/yyyy")%></td>
                        <td><% =Convert.ToDateTime(item.End_Date).ToString("d/MM/yyyy")%></td>
                        <td><a href="ApprovedIndividualScoreCardDetails.aspx?IndividualPCNo=<%=item.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View</a></td>
                        <td><a href="NewIndividualScoreCardReport.aspx?IndividualCardNo=<%=item.No %>" class="btn btn-warning"><i class="fa fa-download"></i>Print PC</a></td>
                        <td><a href="NewIndividualScoreCardSubIndicatorsReport.aspx?IndividualCardNo=<%=item.No %>" class="btn btn-warning"><i class="fa fa-download"></i>Print Sub Indicators</a></td>
                        <td>
                            <%
                                if (item.Change_Status == "Locked")
                                {
                            %>
                            <label class="btn btn-info"><i class="fa fa-times"></i>Locked</label>

                            <%   
                                }
                                else if (item.Change_Status == "Open")
                                {
                            %>
                            <label class="btn btn-success" onclick="lockPC('<%=item.No %>');"><i class="fa fa-check"></i>Lock</label>
                            <% 
                                }
                            %>
                        </td>
                        <td>
                            <%
                                if (item.Status == "Signed")
                                {
                            %>
                            <label class="btn btn-info"><i class="fa fa-times"></i>signed</label>

                            <%   
                                }
                                else if (item.Status != "Signed" && item.Status != "Cancelled")
                                {
                            %>
                            <label class="btn btn-success" onclick="signPC('<%=item.No %>');"><i class="fa fa-check"></i>Sign</label>
                            <% 
                                }
                            %>
                        </td>
                        <%
                            }
                        %>
                </tbody>
            </table>
                </div>
        </div>
    </div>
     <script>
        function lockPC(documentNumber) {
            document.getElementById("approvedocName").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_approvedocNo").value = documentNumber;
            $("#sendpcApproval").modal();
        }
        function signPC(documentNumber) {
            document.getElementById("canceldocname").innerHTML = documentNumber;
            document.getElementById("ContentPlaceHolder1_canceldocNo").value = documentNumber;
            $("#cancelpcApprovalModal").modal();
        }
    </script>

    <div id="sendpcApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Lock perfomance contract</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approvedocNo" type="hidden" />
                    Are you sure you want to lock perfomance contract No <strong id="approvedocName"></strong> ? <i style="color:red">Kindly note the once you lock, you cannot revert the changes!!</i>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Lock" ID="lockpc" OnClick="lockpc_Click"/>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
    <div id="cancelpcApprovalModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Sign perfomance contract</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="canceldocNo" type="hidden" />
                    Are you sure you want to sign performance contract No <strong id="canceldocname"></strong>? <i style="color:red">Kindly note the once you sign, you cannot revert the changes!!</i>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Sign" ID="cancelapproval" OnClick="cancelapproval_Click"/>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
