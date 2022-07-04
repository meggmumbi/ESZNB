<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewRiskIncidentLogs.aspx.cs" Inherits="HRPortal.NewRiskIncidentLogs" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace ="HRPortal.Models" %>
<%@ Import Namespace ="System.Security" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <%
          int step = 1;


          try
          {
              step = Convert.ToInt32(Request.QueryString["step"]);
              if (step > 2 || step < 1)
              {
                  step = 1;
              }
          }
          catch (Exception)
          {
              step = 1;
          }
          if (step == 1)
          {
    %>
    <!--location code, description, -->
    <div class="panel panel-primary">
        <div class="panel-heading">
            General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
       
              <div class="row">
                            <div class="col-md-6 col-lg-6">
                         <div class="form-group">
                        <strong>Risk Register Type</strong>
                        <asp:DropDownList ID="strategicplanno" runat="server" CssClass="form-control select2" OnSelectedIndexChanged="riskType_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem>Select</asp:ListItem>
                            <asp:ListItem Value="1">Corporate</asp:ListItem>
                            <asp:ListItem Value="2">Functional (Directorate)</asp:ListItem>
                            <asp:ListItem Value="3">Functional (Department)</asp:ListItem>
                            <asp:ListItem Value="4">Project</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                       
                    </div>
                         <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Risk Management Plan</label>
                        <asp:DropDownList runat="server" ID="funcionalworkplan" Class="form-control" OnSelectedIndexChanged="funcionalworkplan_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem>--Select Department/Center PC ID--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                          <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Risk </label>
                        <asp:DropDownList runat="server" ID="RiskId" Class="form-control" OnSelectedIndexChanged="RiskId_SelectedIndexChanged" AutoPostBack="true"/>
                    </div>
                </div>
                               <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Incident Description </label>
                        <asp:TextBox runat="server" ID="RiskDescription" Class="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Risk Incident Category.</label>
                        <asp:DropDownList runat="server" ID="riskVategory" Class="form-control" OnSelectedIndexChanged="riskVategory_SelectedIndexChanged" AutoPostBack="true" />
                    </div>
                    </div>
                     <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Severity Level.</label>
                        <asp:DropDownList runat="server" ID="severityLevel" Class="form-control" />
                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Incident Date .</label>
                        <asp:Textbox runat="server" ID="dateIncident" TextMode="Date" Class="form-control" />
                    </div>
                    </div>
                     <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Incident Time.</label>
                        <asp:Textbox runat="server" ID="timeIncident" TextMode="Time" Class="form-control" />
                    </div>
                </div>              
                     <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Occurrence Type.</label>
                        <asp:DropDownList runat="server" ID="OccurrenceType" Class="form-control">
                            <asp:ListItem Value="0">--select--</asp:ListItem>
                            <asp:ListItem Value="1">Occurred</asp:ListItem>
                            <asp:ListItem Value="2">Near-Miss</asp:ListItem>
                            </asp:DropDownList>
                    </div>
                </div>              
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Incident Location Details.</label>
                        <asp:Textbox runat="server" ID="incidentLocations" Class="form-control" />
                    </div>
                </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <label class="control-label">Risk Category Trigger.</label>
                            <asp:DropDownList runat="server" ID="primTrigger" Class="form-control" />
                        </div>
                    </div>
                      <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Root Cause Summery .</label>
                        <asp:Textbox runat="server" ID="rootCauseSumm" Class="form-control" />
                    </div>
                </div>
                         <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Category of Person Reporting.</label>
                        <asp:DropDownList runat="server" ID="categoryOfPerson" Class="form-control">
                            <asp:ListItem Value="0">--select--</asp:ListItem>
                            <asp:ListItem Value="1">Internal Employee</asp:ListItem>
                            <asp:ListItem Value="2">Contractor Employee</asp:ListItem>
                             <asp:ListItem Value="3">Subcontractor Employee</asp:ListItem>
                             <asp:ListItem Value="4">Visitor</asp:ListItem>
                             <asp:ListItem Value="5">Public</asp:ListItem>
                             <asp:ListItem Value="6">Anonymous</asp:ListItem>
                             <asp:ListItem Value="7">Other</asp:ListItem>
                            </asp:DropDownList>
                    </div>
                </div> 
                       <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Reported By (Name) .</label>
                        <asp:Textbox runat="server" ID="reportedBy" Class="form-control" />
                    </div>
                </div>
                      <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Division.</label>
                         <asp:DropDownList runat="server" CssClass="form-control select" ID="responsibilityCenter" />
                    </div>
                </div>

                  <p> --- Escalation Details --</p>
                  <div class="col-md-6 col-lg-6">
                      <div class="form-group">
                          <label class="control-label">Escalate to Officer No.</label>
                          <asp:DropDownList runat="server" CssClass="form-control select" ID="EscalationOfficer" />
                      </div>
                  </div>
           

              </div>
                
           
        </div>
            <div class="panel-footer">
          
            <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="next" Text="Next" OnClick="next_Click" />

            <div class="clearfix"></div>
        </div>
       
    </div>
    <%
        }

        else if (step == 2)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
          Inscident Impact Summary
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Impact Type.</label>
                        <asp:DropDownList runat="server" ID="impactType" Class="form-control">
                            <asp:ListItem Value="0">--select--</asp:ListItem>
                            <asp:ListItem Value="1">Injury</asp:ListItem>
                            <asp:ListItem Value="2">Fatality (Death)</asp:ListItem>
                             <asp:ListItem Value="3">Financial Loss</asp:ListItem>
                             <asp:ListItem Value="4">Schedule Delay/Service Disruption(Days)</asp:ListItem>
                            
                            </asp:DropDownList>
                    </div>
                </div>  
                 <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Description</label>
                        <asp:Textbox runat="server" ID="description" Class="form-control" />
                    </div>
                </div>
            
                         <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Category of Person Reporting.</label>
                        <asp:DropDownList runat="server" ID="personReporting" Class="form-control">
                            <asp:ListItem Value="0">--select--</asp:ListItem>
                            <asp:ListItem Value="1">Internal Employee</asp:ListItem>
                            <asp:ListItem Value="2">Contractor Employee</asp:ListItem>
                             <asp:ListItem Value="3">Subcontractor Employee</asp:ListItem>
                             <asp:ListItem Value="4">Visitor</asp:ListItem>
                             <asp:ListItem Value="5">Public</asp:ListItem>
                             <asp:ListItem Value="6">Anonymous</asp:ListItem>
                             <asp:ListItem Value="7">Other</asp:ListItem>
                            </asp:DropDownList>
                    </div>
                </div> 
                   <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.</label>
                         <asp:DropDownList runat="server" CssClass="form-control select" ID="Officer" />
                    </div>
                </div>     
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Contact Details:</strong>
                    <asp:TextBox runat="server" ID="contactDetails" CssClass="form-control" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Additional Comments :</strong>
                    <asp:TextBox runat="server" ID="additionalComments" CssClass="form-control" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Police Report Reference Number :</strong>
                    <asp:TextBox runat="server" ID="policeReport" CssClass="form-control" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Police Report Date :</strong>
                    <asp:TextBox runat="server" ID="reportDate" TextMode="Date" CssClass="form-control" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Police Station :</strong>
                    <asp:TextBox runat="server" ID="policeStation"  CssClass="form-control" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Reporting Officer :</strong>
                    <asp:TextBox runat="server" ID="ReportingOfficer"  CssClass="form-control" />
                </div>
            </div>

            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Incident Impact " ID="addIncidentLog" OnClick="addIncidentLog_Click" />
                </div>
            </div>
            </div>
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
                        <th>Remove </th>
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

                        <td>
                            <label class="btn btn-danger" onclick="removeLine('<% =line.Description %>','<%=line.Line_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                    </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
                  
        </div>
                </div>
           
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click"  />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Post" ID="post" OnClick="post_Click"  />

            <div class="clearfix"></div>
        </div>
    </div>
        <%} %>

       <script>
        function removeLine(itemName, lineNo) {
            document.getElementById("itemName").innerText = itemName;
            document.getElementById("ContentPlaceHolder1_lineNo").value = lineNo;
            $("#removeLineModal").modal();
        }
    </script>
    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the Incident <strong id="itemName"></strong>from the Incident Summary List?</p>
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" OnClick="deleteLine_Click" />
                </div>
            </div>

        </div>
    </div>
    <script>
        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainBody_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>
    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
