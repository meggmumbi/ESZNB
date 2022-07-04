<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedRiskIncidentLogs.aspx.cs" Inherits="HRPortal.ApprovedRiskIncidentLogs" %>
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
                        <strong>Risk Register Type</strong>
                        <asp:TextBox ID="strategicplanno" runat="server" CssClass="form-control select2" ReadOnly/>
                            
                      
                    </div>
                       
                    </div>
                         <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Risk Management Plan</label>
                        <asp:TextBox runat="server" ID="funcionalworkplan" Class="form-control" ReadOnly/>
                            
                    </div>
                </div>
                          <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Risk </label>
                        <asp:TextBox runat="server" ID="RiskId" Class="form-control" ReadOnly/>
                    </div>
                </div>
                               <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Incident Description </label>
                        <asp:TextBox runat="server" ID="RiskDescription" Class="form-control" ReadOnly />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Risk Incident Category.</label>
                        <asp:TextBox runat="server" ID="riskVategory" Class="form-control" ReadOnly/>
                    </div>
                    </div>
                     <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Severity Level.</label>
                        <asp:TextBox runat="server" ID="severityLevel" Class="form-control" ReadOnly />
                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Incident Date .</label>
                        <asp:Textbox runat="server" ID="dateIncident" TextMode="Date" Class="form-control" ReadOnly />
                    </div>
                    </div>
                     <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Incident Time.</label>
                        <asp:Textbox runat="server" ID="timeIncident" TextMode="Time" Class="form-control" ReadOnly />
                    </div>
                </div>              
                     <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Occurrence Type.</label>
                        <asp:TextBox runat="server" ID="OccurrenceType" Class="form-control" ReadOnly />
                            
                    </div>
                </div>              
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Incident Location Details.</label>
                        <asp:Textbox runat="server" ID="incidentLocations" Class="form-control" ReadOnly />
                    </div>
                </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <label class="control-label">Risk Category Trigger.</label>
                            <asp:TextBox runat="server" ID="primTrigger" Class="form-control" ReadOnly />
                        </div>
                    </div>
                      <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Root Cause Summery .</label>
                        <asp:Textbox runat="server" ID="rootCauseSumm" Class="form-control" ReadOnly />
                    </div>
                </div>
                         <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Category of Person Reporting.</label>
                        <asp:TextBox runat="server" ID="categoryOfPerson" Class="form-control" ReadOnly />
                         
                    </div>
                </div> 
                       <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Reported By (Name) .</label>
                        <asp:Textbox runat="server" ID="reportedBy" Class="form-control" ReadOnly />
                    </div>
                </div>
                      <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Division.</label>
                         <asp:TextBox runat="server" CssClass="form-control select" ID="responsibilityCenter" ReadOnly />
                    </div>
                </div>

                  <p> --- Escalation Details --</p>
                  <div class="col-md-6 col-lg-6">
                      <div class="form-group">
                          <label class="control-label">Escalate to Officer No.</label>
                          <asp:TextBox runat="server" CssClass="form-control select" ID="EscalationOfficer"  ReadOnly/>
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
                        <th>Impact Type</th>
                        <th>Decsription</th>
                        <th>Employee</th>
                        <th>Contact Details </th>
                        <th>Additional Comments </th>
                        <th>Police Report Ref No</th>
                        <th>Police Report Date </th>
                        <th>Police Station</th>
                        <th>Reporting Officer</th>
                      
                    </tr>
                </thead>
                <tbody>
                    <%
                        String requisitionNo = Request.QueryString["requisitionNo"];
                        var nav = new Config().ReturnNav();
                        var purhaseLines = nav.IncidentImpactSummary.Where(r => r.Incident_No == requisitionNo);
                        foreach (var line in purhaseLines)
                        {
                    %>
                    <tr>
                        <td><% =line.Impact_Type %></td>
                        <td><% =line.Description %></td>
                        <td><% =line.Name %></td>
                        <td><% =line.Contact_Details %></td>
                        <td><% =line.Additional_Comments %></td>
                        <td><%=line.Police_Report_Reference_No %></td>
                        <td><%=Convert.ToString(line.Police_Report_Date) %></td>
                        <td><%=line.Police_Station %></td>
                        <td><%=line.Reporting_Officer %></td>

                       
                    </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
                  
        </div>
        </div>
    </div>
</asp:Content>
