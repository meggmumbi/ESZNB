<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StrategicRiskPlanCard.aspx.cs" Inherits="HRPortal.StrategicRiskPlanCard" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="panel panel-primary">
         <div class="panel-heading">
             <%
                 string DocumentNo = Request.QueryString["DocumentNo"];
                 string doctype = Request.QueryString["DocType"];
                 if (doctype == "Corporate")
                 {
             %>Strategic Risk Management Plan<%
                                                 }
                                                 else if (doctype == "Functional (Directorate)")
                                                 {
             %><p>Directorate Risk Management Plan</p>
             <%
                 }
                 else if (doctype == "Functional (Department)")
                 {
                     regResponse.Visible = true;

             %><p>Departmental Risk Management Plan</p>
             <%
                 }
                 else if (doctype == "Functional (Region)")
                 {
             %><p>Regional Risk Management Plan</p>
             <%
                 }
                 else if (doctype == "Project")
                 {
             %><p>Project Risk Management Plan</p>
             <%
                 }
             %>
         </div>
         <br />
         <div>
            <asp:Button runat="server" ID="printriskreport" CssClass="btn btn-success" Style="margin-left: 90%" Text="Print Report" OnClick="printriskreport_Click1" />
        </div>
        <div class="panel-body">
            <div runat="server" id="teamFeedback"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Document Number:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="documentno" ReadOnly="true" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Document Date:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="documentdate" ReadOnly="true" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Corporate Strategic Plan:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="corporateplan" ReadOnly="true" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Year Code:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="yearcode" ReadOnly="true" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Descriptiom:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="description" ReadOnly="true" />
                </div>
            </div>
        </div>
    </div>
    <hr />
    <div class="panel panel-primary">
         <div runat="server" id="regResponse" visible="false">
              <label runat="server" class="btn btn-success" onclick="RiskResponse('<%=DocumentNo%>');" ><i class="fa fa-arrow-right"></i>Add New Risk</label>
        </div>
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped datatable">
                <thead>
                    <tr>
                        <th>Risk Category</th>
                        <th>Risk Title</th>
                        <th>Strategic Pillar</th>
                        <th>Date Raised</th>
                        <th>Risk Likelihood Rating</th>                     
                        <th>Risk Impact Rating</th>                      
                        <th>Overal Risk Rating</th>
                        <th>Risk Heat Zone</th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        
                        var queryRisk = nav.ManagementPlanLines.Where(r => r.Document_No == DocumentNo);
                        foreach (var risk in queryRisk)
                        {
                    %>
                    <tr>
                        <td><%=risk.Risk_Category %></td>
                        <td><%=risk.Risk_Title %></td>
                        <td><%=risk.Risk_Source_ID %></td>
                        <td><% =Convert.ToDateTime(risk.Date_Raised).ToString("dd/MM/yyyy")%></td>
                         <td><%=risk.Risk_Likelihood_Rating %></td>
                         <td><%=risk.Risk_Impact_Rating %></td>
                         <td><%=risk.Overal_Risk_Rating %></td>
                        <td><%=risk.Risk_Heat_Zone %></td>
                           <td><a href="RiskOwnership.aspx?DocumentNo=<%=risk.Document_No%>&&DocumentType=<%=risk.Document_Type %>&&RiskId=<%=risk.Risk_ID %>" class="btn btn-success"><i class="fa fa-eye"></i>View Ownership</a></td>
                         <td><a href="RiskResponseLine.aspx?DocumentNo=<%=risk.Document_No%>&&DocumentType=<%=risk.Document_Type %>&&RiskId=<%=risk.Risk_ID %>" class="btn btn-success"><i class="fa fa-eye"></i>View Mitigation</a></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
         <script>
         function RiskResponse(DocNO) {
            
             document.getElementById("ContentPlaceHolder1_originalNo").value = DocNO;
            
            $("#editTeamMemberModal").modal();
        }
    </script>
    <div id="editTeamMemberModal" class="modal fade" role="dialog">
           <asp:ScriptManager ID="ScriptManger1" runat="Server" />
        <asp:UpdatePanel ID="updPanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Risk Response</h4>
                </div>
                <div class="modal-body">
                    <div id="generalFeedback" runat="server"></div>
                    <asp:TextBox runat="server" ID="originalNo" type="hidden" />
                    <div class="form-group">
                        <strong>Risk Category:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select" ID="riskCat" />
                    </div>
                      <div class="form-group">
                        <strong>Strategic Pillars:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select" ID="startPillars" />
                    </div>
                    <div class="form-group">
                        <strong>Risk Description:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="riskDesc" />
                    </div>
                    <div class="form-group">
                        <strong>Risk Likelihood Rating:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="risklikelihoodCode" OnSelectedIndexChanged="riskActual_SelectedIndexChanged" AutoPostBack="true" />
                    </div>
                    <div class="form-group">
                        <strong>Risk Likelihood Actual Rating:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control"  ID="riskActual"  />
                    </div>
                    <div class="form-group">
                        <strong>Risk Impact Rating:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select" ID="impactType" OnSelectedIndexChanged="impactType_SelectedIndexChanged" AutoPostBack="true"  />
                    </div>
                       <div class="form-group">
                        <strong>Risk Impact Actual Rating:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select" ID="impactRating" />
                    </div>
                        <div class="form-group">
                        <strong>Risk Impact Type :</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select" ID="RiskImpactTyp" OnSelectedIndexChanged="RiskImpactTyp_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="">--select--</asp:ListItem>
                            <asp:ListItem Value="1">Negative</asp:ListItem>
                            <asp:ListItem Value="2">Positive</asp:ListItem>
                            </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Risk Appetite:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select" ID="riskappetite" />
                    </div>
                    <div class="form-group">
                        <strong>Risk Impact Codes:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select" ID="impactCodes" />
                    </div>
                    <div class="form-group">
                        <strong>General Risk Response Strategy :</strong>
                        <asp:DropDownList runat="server" CssClass="form-control select" ID="GenRiskStrat" />
                    </div>
            


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Add Risk Responce" ID="resikResp" OnClick="resikResp_Click" />
                </div>
            </div>

        </div>
                   </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
