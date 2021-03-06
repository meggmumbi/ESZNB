<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RiskOwnership.aspx.cs" Inherits="HRPortal.RiskOwnership" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <div class="panel panel-primary">
        <div class="panel-heading">RMP Risk Ownership</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <div class="row">
                <label runat="server" class="btn btn-success" onclick="RiskResponse('<%=DocumentNo%>');" ><i class="fa fa-arrow-right"></i>Add Responsible Officer</label>
            </div>

            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Risk Description</th>
                        <th>Responsibility Center</th>
                        <th>Responsible Officer</th>
                      
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        string doctype = Request.QueryString["DocumentType"];
                        int riskId = Convert.ToInt32(Request.QueryString["RiskId"]);
                        string docNumber = Request.QueryString["DocumentNo"];
                        var queryRisk = nav.RmpLineRiskOwnerships.Where(r => r.Risk_ID==riskId && r.Document_No==docNumber);
                        foreach (var risk in queryRisk)
                        {
                    %>
                    <tr>
                        <td><% =risk.Risk_Title %></td>
                        <td><% =risk.Desciption%></td>
                        <td><% =risk.Responsible_Officer_Name%></td>
                       
                        <%
                            } %>
                    </tr>
                </tbody>
            </table>
        </div>
             <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />
          
            <div class="clearfix"></div>
        </div>
    </div>

         <script>
         function RiskResponse(DocNO) {
            
             document.getElementById("ContentPlaceHolder1_originalNo").value = DocNO;
            
            $("#editTeamMemberModal").modal();
        }
    </script>
    <div id="editTeamMemberModal" class="modal fade" role="dialog">
         
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Risk Response</h4>
                </div>
                <div class="modal-body">
                    <div id="Div1" runat="server"></div>
                    <asp:TextBox runat="server" ID="originalNo" type="hidden" />
                  
                    <div class="form-group">
                        <strong>Responsibility center:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select" ID="responsibilityCenter" />
                    </div>
                    <div class="form-group">
                        <strong>Responsible Officer :</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select" ID="Officer" />
                    </div>
            


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Add Responsible Officer" ID="resikResp" OnClick="resikResp_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
