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
    </div>

</asp:Content>
