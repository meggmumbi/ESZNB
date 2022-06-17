<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PerformanceLog.aspx.cs" Inherits="HRPortal.PerformanceLog" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <%
    var nav = new Config().ReturnNav();
    var csp = Request.QueryString["CSPNo"];
    var IndividualPCNo = Request.QueryString["IndividualPCNo"];
    string PlogNumber = Request.QueryString["PerformanceLogNo"];

    int step = 1;
    try
    {
        step = Convert.ToInt32(Request.QueryString["step"]);
        if (step > 3 || step < 1)
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
        <div class="panel panel-primary">
            <div class="panel panel-heading">
                Performance Log General Details (<i style="color:yellow">Kindly note that fields marked with <span style="color:red">*</span> are mandatory</i>)
                <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                 <div runat="server" id="generalfeedback"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.</label>
                        <asp:label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                   <div class="form-group">
                        <label class="control-label">Employee Name</label>
                        <asp:label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:label>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Personal Score Card<span style="color:red">*</span></label>
                        <asp:DropDownList runat="server" id="personalscorecardno" cssclass="form-control" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="personalscorecardno_SelectedIndexChanged">
                            <asp:ListItem>--Select Personal Score Card--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Description<span style="color:red">*</span></label>
                        <asp:TextBox runat="server" id="description" cssclass="form-control" placeholder="Enter Description"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Activity Start Date</label>
                        <asp:TextBox runat="server" id="startDate" cssclass="form-control" ReadOnly="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Activity End Date</label>
                        <asp:TextBox runat="server" id="endDate" cssclass="form-control" ReadOnly="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Year Reporting Code</label>
                        <asp:TextBox runat="server" id="yr" cssclass="form-control" ReadOnly="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Corporate Strategic Plan</label>
                        <asp:TextBox runat="server" id="csp" cssclass="form-control" ReadOnly="true"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Annual Work Plan</label>
                        <asp:TextBox runat="server" id="awp" cssclass="form-control" ReadOnly="true"/>
                    </div>
                </div>

            </div>
            <div class="panel-footer">
                <asp:Button runat="server" ID="apply" CssClass="btn btn-success pull-right" Text="Next" OnClick="apply_Click"/>
                <span class="clearfix"></span>
            </div>
        </div>
        <% 
            }
            else if (step == 2)
            {
    %>

        <div class="panel panel-primary">
            <div class="panel-heading">
                Performance Targets (<i style="color:yellow">Kindly click on the Description of each line to add sub-targets</i>)
                <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div runat="server" id="feedback"></div>
              <div class="col-md-12 col-lg-12">
                    <div class="panel-body">
                        <label class="btn btn-warning pull-right" data-toggle="modal" data-target="#plogsJDActivities"><i class="fa fa-plus fa-fw"></i>Select Activities From Job Description</label>
                        <label class="btn btn-primary pull-right" data-toggle="modal" data-target="#plogsAddActivities"><i class="fa fa-plus fa-fw"></i>Select Activities From Additional Initiatives</label>
                        <label class="btn btn-success pull-right" data-toggle="modal" data-target="#plogsActivities"><i class="fa fa-plus fa-fw"></i>Select Activities From Core Initiatives</label>                                                
                    </div>
                </div>
            <div class="panel-body">
                   <div class="table-responsive">  
                 <table id="example1" class="table table-bordered table-striped PerformanceTargetsTableData">
                    <thead>
                        <tr>
                            <th>Initiative No</th>
                            <th>Description</th> 
                            <th>Save/Edit</th>
                            <th>Comments Status</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody> 
                      <%
                          string employeeNo = Convert.ToString(Session["employeeNo"]);
                          string CSPNo = Request.QueryString["CSPNo"];
                          var data = nav.PlogLines.Where(r => r.PLog_No == PlogNumber && r.Employee_No == employeeNo);
                          foreach (var item in data)
                          {
                    %>
                    <tr>
                            <td><% = item.Initiative_No %></td>
                            <td><a href="SubPlogIndicators.aspx?PlogNo=<%= PlogNumber %>&&InitiativeNo=<%=item.Initiative_No %>&&PCID=<%= item.Personal_Scorecard_ID %>&&description=<%= item.Sub_Intiative_No %> &&CSPNo=<%=CSPNo%>"</a><% = item.Sub_Intiative_No%> </td>
                            <td><label class="btn btn-success" onclick="moredetails('<%=item.Activity_Type%>','<%=Convert.ToDateTime(item.Planned_Date).ToString("d/MM/yyyy")%>','<%=Convert.ToDateTime(item.Due_Date).ToString("d/MM/yyyy")%>',
                                '<%=Convert.ToDateTime(item.Achieved_Date).ToString("d/MM/yyyy")%>','<%=""%>','<%=item.Unit_of_Measure%>',
                                '<%=item.Target_Qty%>','<%=item.Remaining_Targets%>','<%=item.Achieved_Target%>','<%=item.Comments%>','<%=item.Sub_Intiative_No%>','<%=item.EntryNo%>','<%=item.Initiative_No%>');"><i class="fa fa-save"></i>Save / Edit Comments</label></td>
                        <%
                            if (item.Comments.Length > 0)
                            {
                                %> <td><label class="btn btn-success"><i class="fa fa-check"></i>Data Saved</label></td><%
                            }
                            else
                            {
                                %> <td><label class="btn btn-danger"><i class="fa fa-times"></i>Not Saved</label></td><%
                            }
                         %>
                            <td><label class="btn btn-danger" onclick="sendApprovalRequest('<%=item.EntryNo%>');"><i class="fa fa-trash"></i>Remove</label></td>
                        <%
                            }
                      %>
                    </tr>
                </tbody>
                </table>
                       </div>
            </div>
            </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            LIST OF ALL UPLOADED PLOG LINES DOCUMENTS (<i style="color: yellow">You can track your document using plog line initiative number</i>)
        </div>
        <div class="panel-body">
             <div runat="server" id="documentsfeedback"></div>
               <div class="table-responsive">  
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Title</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try
                        {
                            String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Performance Logs Card/";
                            String imprestNo = Request.QueryString["PerformanceLogNo"];
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + imprestNo + "/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                    %>
                    <tr>
                        <td><% =file.Replace(documentDirectory, "") %></td>
                        <td>
                            <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                    </tr>
                    <%
                                }
                            }
                        }
                        catch (Exception)
                        {

                        }%>
                </tbody>
            </table>
                   </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" ID="NextToStep3" CssClass="btn btn-success pull-right" Text="Next" OnClick="NextToStep3_Click" />
            <asp:Button runat="server" ID="BackToStep1" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep1_Click" />
            <span class="clearfix"></span>
        </div>
    </div>

    <% 
            }
            else if (step == 3)
            {
    %>



    <div class="panel panel-primary">

        <div class="panel-heading">
            <i class="icon-file"></i>
            Performance Log Report
        </div>
        <!-- /widget-header -->
        <div class="panel-body">
            <div runat="server" id="re"></div>
            <div class="form-group">
                <iframe runat="server" class="col-sm-12 col-xs-12 col-md-12 col-lg-12" height="500px" id="p9form" style="margin-top: 10px;"></iframe>
            </div>
        </div>

        <div class="panel-footer">
            <asp:Button runat="server" ID="SubmitPlogs" CssClass="btn btn-success pull-right" Text="Send For Approval" OnClick="SubmitPlogs_Click" />
            <asp:Button runat="server" ID="BackToStep2" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep2_Click" />
            <span class="clearfix"></span>
        </div>
    </div>
    <!--End attach documents--> 
<%} %>

    <div id="plogsActivities" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">List of All Availlable Core Initiatives Activities </h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="panel-body">
                            <div runat="server" id="generalfeedbacks"></div>
                               <div class="table-responsive">  
                            <table id="example6" class="table table-bordered table-striped primaryActivityInitiativeTableDetails1" id="primaryActivityInitiativeTableDetails1" name="primaryActivityInitiativeTableDetails1">
                                <thead>
                                    <tr>
                                        <th>
                                            <input type="checkbox" id="checkBoxAll" name="checkBoxAll" class="custom-checkbox" /></th>
                                        <th>plogNo</th>
                                        <th>No</th>
                                        <th>Objective/Initiative</th>
                                        <th>Year Reporting</th>
                                        <th>Assigned Weight</th>
                                        
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        var ScoreCardNumber = Request.QueryString["ScoreCardNo"];
                                        var strategyPlanNumber = Request.QueryString["CSPNo"];
                                        var nav1 = new Config().ReturnNav();
                                        var performancelogs1 = nav.PCObjective.Where(r => r.Workplan_No == ScoreCardNumber);
                                        // && r.Strategy_Plan_ID == strategyPlanNumber
                                        foreach (var performancelog in performancelogs1)
                                        {
                                    %>
                                    <tr>
                                        <td>
                                            <input type="checkbox" class="checkboxes" id="selectedactivityrecords1" name="selectedactivityrecords1" value="" /></td>
                                        <td><% =PlogNumber%></td>
                                        <td><% =performancelog.Initiative_No %></td>
                                        <td><% =performancelog.Objective_Initiative%> </td>
                                        <td><% =performancelog.Year_Reporting_Code%></td>
                                        <td><% =performancelog.Assigned_Weight%></td>
                                        <%
                                            }
                                        %>
                                    </tr>
                                </tbody>
                            </table>
                                   </div>
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="panel-footer">
                                        <center>
                            <button type="button" class="btn btn-success btn_applyallselectedActvities1" id="btn_applyallselectedActvities1" name="btn_applyallselectedActvities1">Submit Selected Activites</button>
                        </center>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="plogsAddActivities" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">List of All Availlable Additional Initiatives Activities </h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="panel-body">
                            <div runat="server" id="Div1"></div>
                               <div class="table-responsive">  
                            <table id="example7" class="table table-bordered table-striped AdditionalToPlogTableDetails" id="AdditionalToPlogTableDetails" name="AdditionalToPlogTableDetails">
                                <thead>
                                    <tr>
                                        <th>
                                            <input type="checkbox" id="checkBoxAll2" name="checkBoxAll" class="custom-checkbox" /></th>
                                        <th>plogNo</th>
                                        <th>No</th>
                                        <th>Objective/Initiative</th>
                                        <th>Year Reporting</th>
                                        <th>Assigned Weight</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        var ScoreCardNumber1 = Request.QueryString["ScoreCardNo"];
                                        var strategyPlanNumber1 = Request.QueryString["CSPNo"];
                                        var performancelogs2 = nav.SecondaryPCObjective.Where(r => r.Workplan_No == ScoreCardNumber);
                                        // && r.Strategy_Plan_ID == strategyPlanNumber
                                        foreach (var performancelog in performancelogs2)
                                        {
                                    %>
                                    <tr>
                                        <td>
                                            <input type="checkbox" class="checkboxes" id="selectedactivityrecords2" name="selectedactivityrecords2" value="" /></td>
                                        <td><% =PlogNumber%></td>
                                        <td><% =performancelog.Initiative_No %></td>                                       
                                        <td><% =performancelog.Objective_Initiative%> </td>
                                        <td><% =performancelog.Year_Reporting_Code%></td>
                                        <td><% =performancelog.Assigned_Weight%></td>
                                       
                                        <%
                                            }
                                        %>
                                    </tr>
                                </tbody>
                            </table>
                                   </div>
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="panel-footer">
                                        <center>
                                            <button type="button" class="btn btn-success btn_AdditionalToPlogTableDetails" id="btn_AdditionalToPlogTableDetails" name="btn_AdditionalToPlogTableDetails">Submit Selected Activites</button>
                                        </center>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="plogsJDActivities" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">List of All Job Description Activities </h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="panel-body">
                            <div runat="server" id="Div2"></div>
                               <div class="table-responsive">  
                            <table id="example3" class="table table-bordered table-striped JDInitiativeTableDetails" id="JDInitiativeTableDetails" name="JDInitiativeTableDetails">
                                <thead>
                                    <tr>
                                        <th>
                                            <input type="checkbox" id="checkBoxAll3" name="checkBoxAll" class="custom-checkbox" /></th>
                                        <th>plogNo</th>
                                        <th>No</th>
                                        <th>Description</th>
                                        <th>Assigned Weight</th>
                                        <%--<th style="display: none">plogNo</th>--%>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        var ScoreCardNumber3 = Request.QueryString["ScoreCardNo"];
                                        var strategyPlanNumber3 = Request.QueryString["CSPNo"];
                                        var performancelogs3 = nav.JobDescription.Where(r => r.Workplan_No == ScoreCardNumber);
                                        // && r.Strategy_Plan_ID == strategyPlanNumber
                                        foreach (var performancelog in performancelogs3)
                                        {
                                    %>
                                    <tr>
                                        <td>
                                            <input type="checkbox" class="checkboxes" id="selectedactivityrecords3" name="selectedactivityrecords3" value="" /></td>
                                        <td><% =PlogNumber%></td>
                                        <td><% =performancelog.Line_Number %></td>
                                        <td><% =performancelog.Description%> </td>
                                        <td><% =performancelog.Assigned_Weight%></td>
                                        <%
                                    }
                                        %>
                                    </tr>
                                </tbody>
                            </table>
                                   </div>
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="panel-footer">
                                        <center>
                                            <button type="button" class="btn btn-success btn_JDInitiativeTableDetails" id="btn_JDInitiativeTableDetails" name="btn_JDInitiativeTableDetails">Submit Selected Activites</button>
                                        </center>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
       
<script>

    function deleteFile(fileName) {
        document.getElementById("filetoDeleteName").innerText = fileName;
        document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
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
        <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong> ?</p>
          <asp:TextBox runat="server" ID="fileName" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deletefile" OnClick="deletefile_Click"/>
      </div>
    </div>

  </div>
</div>

    <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("ContentPlaceHolder1_approvedocNo").value = documentNumber;
            $("#sendImprestMemoForApproval").modal();
        }
    </script>

    <div id="sendImprestMemoForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Remove Performance update line</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approvedocNo" type="hidden" />
                    Are you sure you want to remove Performance update line ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Remove" ID="revovePlogLine" OnClick="revovePlogLine_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>

        <script>
            function moredetails(activitytype, Planned_Date, Due_Date, Achieved_Date, Outcome_Perfomance_Indicator, Unit_of_Measure, Target_Qty, Remaining_Targets, Achieved_Target, Comments, Description, LineNo, InitiativeNo) {
                document.getElementById("ContentPlaceHolder1_txtactivitytype").value = activitytype;
                document.getElementById("ContentPlaceHolder1_txtPlanned_Date").value = Planned_Date;
                document.getElementById("ContentPlaceHolder1_txtDue_Date").value = Due_Date;
                document.getElementById("ContentPlaceHolder1_txtAchieved_Date").value = Achieved_Date;
                document.getElementById("ContentPlaceHolder1_txtOutcome_Perfomance_Indicator").value = Outcome_Perfomance_Indicator;
                document.getElementById("ContentPlaceHolder1_txtUnit_of_Measure").value = Unit_of_Measure;
                document.getElementById("ContentPlaceHolder1_txtTarget_Qty").value = Target_Qty;
                document.getElementById("ContentPlaceHolder1_txtRemaining_Targets").value = Remaining_Targets;
                document.getElementById("ContentPlaceHolder1_txtAchieved_Target").value = Achieved_Target;
                document.getElementById("ContentPlaceHolder1_txtComments").value = Comments;
                document.getElementById("ploglineName").innerText = Description;
                document.getElementById("ContentPlaceHolder1_txtLineNo").value = LineNo;
                document.getElementById("ContentPlaceHolder1_txtInitiativeNo").value = InitiativeNo;
            $("#moredetailsmodal").modal();
        }
    </script>

    <div id="moredetailsmodal" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width:80%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Plog Lines More Details</h4>
                </div>
                <div class="modal-body">
                     <p style="color:red"> <strong id="ploglineName"></strong> </p>
                    <asp:TextBox runat="server" ID="txtLineNo" type="hidden"/>
                    <asp:TextBox runat="server" ID="txtInitiativeNo" type="hidden"/>
                    <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Activity Type</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtactivitytype" ReadOnly="true" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Planned Start Date:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ReadOnly="true" ID="txtPlanned_Date" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Planned Due Date:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ReadOnly="true" ID="txtDue_Date" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Achieved Date:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ReadOnly="true" ID="txtAchieved_Date" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Performance Indicator:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ReadOnly="true" ID="txtOutcome_Perfomance_Indicator" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Unit of Measure:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ReadOnly="true" ID="txtUnit_of_Measure" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Target Quantity:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ReadOnly="true" ID="txtTarget_Qty" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Remaining Quantity:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ReadOnly="true" ID="txtRemaining_Targets" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Achieved Target:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtAchieved_Target" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Comments:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtComments" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Upload Document:</strong>
                            <asp:FileUpload runat="server" CssClass="form-control" ID="txtfileupload" />
                        </div>
                    </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save / Update " ID="savePlogLine" OnClick="savePlogLine_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>

