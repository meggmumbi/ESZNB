<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PeriodicStatusDetails.aspx.cs" Inherits="HRPortal.PeriodicStatusDetails" %>
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
            <asp:Button runat="server" ID="printriskreport" CssClass="btn btn-success" Style="margin-left: 90%" Text="Print Report" OnClick="printriskreport_Click" />
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
                    <strong>Risk Register Type:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="corporateplan" ReadOnly="true" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Risk Management Plan ID:</strong>
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
           <div class="table-responsive">
                        <table class="table table-bordered table-striped tblselectedServices" id="example8">
                            <thead>
                                <tr>

                                    <th></th>
                                    <th>Risk Title</th>
                                    <th>Risk Likelihood rating</th>
                                    <th>Risk Impact Rating</th>
                                    <th>Risk Impact Rating</th>
                                    <th>Risk Impact Type</th>
                                    <th>Risk Status</th>
                                  

                                </tr>
                            </thead>
                            <tbody>

                                <% 
                                    var nav = new Config().ReturnNav();
                                    string docNo = Request.QueryString["DocumentNo"].Trim();
                                    var Activities = nav.RiskStatusReportLines.Where(r => r.Document_No == docNo).ToList();
                                    int count = 0;
                                    foreach (var activity in Activities)
                                    {
                                        count++;
                                %>
                                <tr>


                                    <td><%=count %></td>
                                    <td><%=activity.Risk_Title %></td>
                                    <td><%=activity.Risk_Likelihood_Code %></td>
                                    <td><%=activity.Risk_Impact_Code %></td>
                                    <td><%=activity.Risk_Impact_Type %></td>
                                    <td><%=activity.Risk_Status %></td>
                                   
                                    <%}
                                    %>
                                </tr>
                            </tbody>
                        </table>
                    </div>
        </div>
    </div>
</asp:Content>
