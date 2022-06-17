<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StrategicRiskManagementPlans.aspx.cs" Inherits="HRPortal.StrategicRiskManagementPlans" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="panel panel-primary">
        <div class="panel-heading">Strategic Risk Management Plans</div>
        <div runat="server" id="feedback"></div>
        <div class="panel-body">
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Number</th>
                        <th>Document Date</th>
                        <th>Corporate Strategic Plan</th>
                        <th>Year Code</th>
                        <th>View</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = new Config().ReturnNav();
                        var queryRisk = nav.managementPlans.Where(r => r.Document_Type == "Corporate");
                        string DocType = "Corporate";
                        foreach (var risk in queryRisk)
                        {

                    %>
                    <tr>
                        <td><% =risk.Document_No %></td>
                        <td><% =Convert.ToDateTime(risk.Document_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% =risk.Corporate_Strategic_Plan_ID%></td>
                        <td><% =risk.Year_Code%></td>
                        <td><a href="StrategicRiskPlanCard.aspx?DocumentNo=<%=risk.Document_No %>&&DocType=<%=DocType %>" class="btn btn-success"><i class="fa fa-eye"></i>View Details</a> </td>
                        <%
                            } %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
