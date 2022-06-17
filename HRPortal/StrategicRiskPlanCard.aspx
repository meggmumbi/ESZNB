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
        <div class="panel-body">
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Risk Category</th>
                        <th>Risk Title</th>
                        <th>Risk Source</th>
                        <th>Date Raised</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        String DocumentNo = Request.QueryString["DocumentNo"];
                        var queryRisk = nav.ManagementPlanLines.Where(r => r.Document_No == DocumentNo);
                        foreach (var risk in queryRisk)
                        {
                    %>
                    <tr>
                        <td><%=risk.Risk_Category %></td>
                        <td><%=risk.Risk_Title %></td>
                        <td><%=risk.Risk_Source_ID %></td>
                        <td><% =Convert.ToDateTime(risk.Date_Raised).ToString("dd/MM/yyyy")%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

</asp:Content>
