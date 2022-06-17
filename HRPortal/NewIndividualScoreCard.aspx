<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="NewIndividualScoreCard.aspx.cs" Inherits="HRPortal.NewIndividualScoreCard" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        var nav = new Config().ReturnNav();

        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 5 || step < 1)
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
                Staff Performance Contract General Details (<i style="color:yellow">Kindly note that fields marked with <span style="color:red">*</span> are mandatory</i>)
                <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>            
            <div class="panel-body">
                <div runat="server" id="generalfeedback"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Employee Name</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Description <span style="color:red">*</span></label>
                        <asp:TextBox runat="server" ID="description" Class="form-control" />
                        <label runat="server" id="descriptionValidation" style="color:red" visible="false"><i>Kindly enter description to proceed!</i></label>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Supervisor Performance Contract <span style="color:red">*</span></label>
                         <asp:DropDownList runat="server" ID="seniorOfficerPC" Class="form-control select2" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="seniorOfficerPC_SelectedIndexChanged">
                             <asp:ListItem>--Select--</asp:ListItem>
                         </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Strategic Plan Number</label>
                        <asp:TextBox runat="server" ID="strategicplanno" Class="form-control"  readonly="true" />
                    </div>
                    <div class="form-group">
                        <label class="control-label">Contract Year</label>
                         <asp:TextBox runat="server" ID="contractYear" Class="form-control"  readonly="true" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Start Date</label>
                        <asp:TextBox runat="server" ID="startDate" Class="form-control"  readonly="true" />
                    </div>
                    <div class="form-group">
                        <label class="control-label">End Date</label>
                         <asp:TextBox runat="server" ID="endDate" Class="form-control"  readonly="true" />
                    </div>
                </div>

            </div> 
            <div class="panel-footer">
                <asp:Button runat="server" ID="SaveGeneralDetails" CssClass="btn btn-success pull-right" Text="Next" OnClick="SaveGeneralDetails_Click"/>
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
                    Core Initiative (<i style="color:yellow">Kindly click on Objective/Initiative to view/add sub-initiatives</i>)
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                <div runat="server" id="coreinitiativefeedback"></div>
                <div class="col-md-12 col-lg-12">
                      <div class="panel-body">
                        <label class="btn btn-success pull-right" data-toggle="modal" data-target="#primaryActivities"><i class="fa fa-plus fa-fw"></i>Select Activities</label>
                    </div>
                </div>
                   <div class="table-responsive">  
                 <table id="example1" class="table table-bordered table-striped primaryInitiativeTable">
                    <thead>
                        <tr>
                            <th style="display:none">No</th>
                            <th>Objective/Initiative</th>
                            <th>Start Date</th>
                            <th>Due Date</th>
                            <th>Agreed Target</th>
                            <th>Assigned Weight</th>
                            <th>Comments</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%   
                            var csp = Request.QueryString["StrategicPlanNo"]; 
                            var AnnualCode = Request.QueryString["AnnualCode"];  
                            var IndividualPCNo = Request.QueryString["IndividualPCNo"]; 
                            var SeniorPCNo = Request.QueryString["SeniorPCNo"];                       
                            var coreInitiatives = nav.PCObjective.Where(x => x.Strategy_Plan_ID == csp && x.Year_Reporting_Code == AnnualCode && x.Workplan_No == IndividualPCNo && x.Initiative_Type != "Project").ToList();
                            foreach (var initative in coreInitiatives)
                            {
                        %>
                        <tr>
                            <td style="display:none" id="entrynumberValue"><% =initative.EntryNo %></td>
                            <td><a href="SubIndicators.aspx?ActivityNo=<%=initative.Initiative_No %>&&IndividualPCNo=<%=initative.Workplan_No %>&&AssignedWeight=<%=initative.Assigned_Weight %>"</a><% =initative.Objective_Initiative%> </td>                         
                            <td><input type="date" style="width: 10em;" autocomplete="off" value="<%=Convert.ToDateTime(initative.Start_Date).ToString("yyyy-MM-dd")%>" /></td>
                            <td><input type="date" style="width: 10em;" autocomplete="off" value="<%=Convert.ToDateTime(initative.Due_Date).ToString("yyyy-MM-dd")%>" /></td>
                            <td><input type="number" step="any" min="0" style="width: 5em;" autocomplete="off" value="<%=initative.Imported_Annual_Target_Qty %>"/></td>
                            <td><input type="number" step="any" min="0" style="width: 5em;" autocomplete="off"  value="<%=initative.Assigned_Weight %>"/></td>
                            <td><input style="width: 10em;" type="text" autocomplete="off" value="<%=initative.Additional_Comments %>"/></td>
                            <td><label class="btn btn-danger" onclick="sendApprovalRequest('<%=initative.EntryNo %>');"><i class="fa fa-trash"></i>Remove</label></td>
                            <%
                                }

                            %>
                    </tbody>
                </table>
                       </div>
                    <center>
                        <input type="button" id="btnSave" class="btn btn-success btnSave" value="Save Core Initiatives" />                        
                        <div class="clearfix"></div>
                    </center>
            </div>
              <div class="panel-footer">
                <asp:Button runat="server" ID="NextToStep3" CssClass="btn btn-success pull-right" Text="Next" OnClick="NextToStep3_Click"/>
                <asp:Button runat="server" ID="BackToStep1" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep1_Click"/>
                <span class="clearfix"></span>
            </div> 
        </div>

        <div id="primaryActivities" class="modal fade" role="dialog">
                  <div class="modal-dialog" style="width:800px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">List of All Availlable Activities </h4>
                        </div>
                        <div class="modal-body">
                     <div class="row" style="width:800px">
                  <div class="panel-body" style="width:800px">
                         <div class="table-responsive">                 
                 <table id="example3" class="table table-bordered table-striped primaryActivityInitiativeTableDetails" id="primaryActivityInitiativeTableDetails" name="primaryActivityInitiativeTableDetails">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkBoxAll" name="checkBoxAll" class="custom-checkbox" /></th>
                            <th>No</th>
                            <th>Objective/Initiative</th>
                            <th>Year Reporting Code</th>
                            <th>Start Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var csp1 = Request.QueryString["StrategicPlanNo"]; 
                            var AnnualCode1 = Request.QueryString["AnnualCode"];  
                            var IndividualPCNo1 = Request.QueryString["IndividualPCNo"]; 
                            var SeniorPCNo1 = Request.QueryString["SeniorPCNo"]; 
                            var allActivities = nav.PCObjective.Where(s => s.Strategy_Plan_ID == csp1 && s.Year_Reporting_Code == AnnualCode1 && s.Workplan_No == SeniorPCNo1).ToList();
                            foreach (var initative in allActivities)
                            {
                             %>
                        <tr>
                             <td><input type="checkbox" class="checkboxes" id="selectedactivityrecords1" name="selectedactivityrecords1" value=""/></td>                           
                            <td><% =initative.Initiative_No %></td>
                             <td><% =initative.Objective_Initiative%> </td>
                            <td><% =initative.Year_Reporting_Code%></td>
                            <td><% = Convert.ToDateTime(initative.Start_Date).ToString("d/MM/yyyy")%></td>
                            <%
                              }
                            %>
                    </tbody>
                </table>
                             </div>
                <div class="row">
                   <div class="col-md-12 col-lg-12">
                    <div class="panel-footer">
                        <center>
                            <button type="button" class="btn btn-success btn_applyallselectedActvities" id="btn_applyallselectedActvities" name="btn_applyallselectedActvities">Submit Selected Activites</button>
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
    

            <% 
        }
        else if (step == 3)
        {
    %>

        
        <div class="panel panel-primary">
            <div class="panel-heading">
                Additional Initiatives (<i style="color:yellow">Kindly click on Objective/Initiative to view/add sub-initiatives</i>)
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
             <div runat="server" id="additionalfeedback"></div>
             <div class="col-md-12 col-lg-12">
                      <div class="panel-body">
                        <label class="btn btn-success pull-right" data-toggle="modal" data-target="#allsecondaryActivities"><i class="fa fa-plus fa-fw"></i>Select Activities</label>
                    </div>
                </div>
            <div class="panel-body">
                    <div class="table-responsive">  
                 <table id="example5" class="table table-bordered table-striped additionalactivitiestableData">
                    <thead>
                        <tr>
                             <th style="display:none">No</th>
                            <th>Objective/Initiative</th>
                            <th>Start Date</th>
                            <th>Due Date</th>
                            <th>Agreed Target</th>
                            <th>Assigned Weight</th>
                            <th>Comments</th>
                            <th>Remove</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                        var csp = Request.QueryString["StrategicPlanNo"]; 
                        var AnnualCode = Request.QueryString["AnnualCode"];  
                        var IndividualPCNo = Request.QueryString["IndividualPCNo"]; 
                        var SeniorPCNo = Request.QueryString["SeniorPCNo"]; 
                        var additionalInitiatives = nav.SecondaryPCObjective.Where(x => x.Workplan_No == IndividualPCNo && x.Strategy_Plan_ID == csp && x.Year_Reporting_Code == AnnualCode).ToList();
                        foreach (var item in additionalInitiatives)
                        {
                        %>
                        <tr>
                            <td style="display:none"><% =item.EntryNo %></td>
                            <td><a href="AdditionalSubIndicators.aspx?ActivityNo=<%=item.Initiative_No %>&&IndividualPCNo=<%=item.Workplan_No %>&&AssignedWeight=<%=item.Assigned_Weight %>"</a><% =item.Objective_Initiative%> </td>                      
                            <td><input type="date" style="width: 10em;" autocomplete="off" min="0" value="<%=Convert.ToDateTime(item.Start_Date).ToString("yyyy-MM-dd")%>"/></td>
                            <td><input type="date" style="width: 10em;"  autocomplete="off"  min="0" value="<%=Convert.ToDateTime(item.Due_Date).ToString("yyyy-MM-dd")%>"/></td>
                            <td><input type="number" step="any" style="width: 5em;"  autocomplete="off" min="0" value="<%=item.Imported_Annual_Target_Qty %>"/></td>
                            <td><input type="number" step="any" style="width: 5em;" autocomplete="off"  min="0"  value="<%=item.Assigned_Weight %>"/></td>
                            <td><input style="width: 10em;" type="text" autocomplete="off" value="" /></td>
                            <td><label class="btn btn-danger" onclick="removeAIline('<%=item.EntryNo %>');"><i class="fa fa-trash"></i>Remove</label></td>
                            <%
                            }

                            %>
                    </tbody>
                </table>
                        </div>
                    <center>
                         <input type="button" id="btnSaveAdditionalInitiativesData" class="btn btn-success btnSaveAdditionalInitiativesData" value="Save Additional Activities" />                           
                        <div class="clearfix"></div>
                    </center>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" ID="NextToStep4" CssClass="btn btn-success pull-right" Text="Next" OnClick="NextToStep4_Click"/>
                <asp:Button runat="server" ID="BackToStep2" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep2_Click"/>
                <span class="clearfix"></span>
            </div>  
        </div>

    <!--MODALS--> 



    <div id="allsecondaryActivities" class="modal fade" role="dialog">
                 <div class="modal-dialog" style="width:800px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">List of All Availlable Activities </h4>
                        </div>
                        <div class="modal-body">
                     <div class="row" style="width:800px">
                <div class="panel-body" style="width:800px">
                       <div class="table-responsive">  
                 <table id="example7" class="table table-bordered table-striped additionalinitiativesTable1" id="additionalinitiativesTable1" name="additionalinitiativesTable1">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkBoxAllGoods2" name="checkBoxAllGoods2" class="custom-checkbox" /></th>
                            <th>Activity ID</th>
                            <th>Description</th>
                            <th>Primary Directorate</th>
                             <th>Primary Department</th>
                        </tr>
                    </thead>

                    <tbody>
                     <%
                            var allActivities = nav.StrategyWorkplanLines.Where(s => s.Strategy_Plan_ID == csp && s.Year_Reporting_Code == AnnualCode).ToList();
                            foreach (var initative in allActivities)
                            {
                             %>
                        <tr>
                            <td><input type="checkbox" class="checkboxes" id="allselectedadditionalactivities" name="allselectedadditionalactivities" value=""/></td>                          
                            <td><% =initative.Activity_ID %></td>
                             <td><% =initative.Description%> </td>
                            <td><% =initative.Primary_Directorate%></td>
                            <td><% =initative.Primary_Department%></td>
                            <%
                              }
                            %>
                    </tbody>
                </table>
                           </div>
                  <div class="row">
                   <div class="col-md-12 col-lg-12">
                    <div class="panel-footer">
                        <center>
                            <button type="button" class="btn btn-success btn_insertadditionalinitiatives" id="btn_insertadditionalinitiatives" name="btn_insertadditionalinitiatives">Submit Selected Activites</button>
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
<!--MODALS--> 

                <% 
        }
        else if (step == 4)
        {
    %>
          
        <div class="panel panel-primary">
            <div class="panel-heading">
                Job Description
               <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                   <div class="table-responsive">  
                 <table id="example8" class="table table-bordered table-striped JDTargetsTable">
                    <thead>
                        <tr>
                            <th style="display:none">No</th>
                            <th style="display:none">Work Plan</th>
                            <th>Job Description </th>
                            <th>Annual Target</th>
                            <th>Assigned Weight</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var csp = Request.QueryString["StrategicPlanNo"]; 
                            var AnnualCode = Request.QueryString["AnnualCode"];  
                            var IndividualPCNo = Request.QueryString["IndividualPCNo"]; 
                            var SeniorPCNo = Request.QueryString["SeniorPCNo"]; 
                            var JD = nav.PCJobDescription.Where(x => x.Workplan_No == IndividualPCNo).ToList();
                            foreach (var item in JD)
                            {
                        %>
                        <tr>
                            <td style="display:none"><% =item.Line_Number %></td>
                            <td style="display:none"><% =item.Workplan_No%></td>
                            <td><% =item.Description%> </td>
                            <td><input type="number" id="txtannualtarget"  autocomplete="off"  min="0" value="<%=item.Imported_Annual_Target_Qty %>"/></td>
                            <td><input type="number" id="txtassignedweight" autocomplete="off"  min="0" value="<%=item.Assigned_Weight %>"/></td>
                            <%
                                }

                            %>
                    </tbody>
                </table>
                       </div>
                <center>
                    <input type="button" id="btn_saveJDTargets" class="btn btn-success btn_saveJDTargets" value="Save Job Description" />                            
                    <div class="clearfix"></div>
                </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" ID="NextToStep5" CssClass="btn btn-success pull-right" Text="Next" OnClick="NextToStep5_Click"/>
            <asp:Button runat="server" ID="BackToStep3" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="BackToStep3_Click"/>
            <span class="clearfix"></span>
        </div>  
    </div>

                    <% 
        }
        else if (step == 5)
        {
    %>

     <div class="panel panel-primary">
            <div class="panel-heading">
                Attach Supporting documents, maximum size is 5MB (The following formats are allowed: pdf)
                 <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 5 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">
                          <div runat="server" id="documentsfeedback"></div>
           <div class="row">
               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                   <div class="form-group">
                       <strong>Select file to upload:</strong>
                       <asp:FileUpload runat="server" ID="document" CssClass="form-control" style="padding-top: 0px;"/>
                   </div>
               </div>
               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                   <div class="form-group">
                       <br/>
                       <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument"/>
                   </div>
               </div>
           </div>
                   <div class="table-responsive">  
           <table class="table table-bordered table-striped">
               <thead>
               <tr>
                   <th>Document Title</th>
                   <th>Download</th>
                   <th>Delete</th>
               </tr>
               </thead>
               <tbody>
               <%
                   try
                   {
                       String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                       String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Individual Scorecard/";
                       String PCNo = Convert.ToString(Session["IndividualCardNo"]);
                       PCNo = PCNo.Replace('/', '_');
                       PCNo = PCNo.Replace(':', '_');
                       String documentDirectory = filesFolder + PCNo+"/";
                       if (Directory.Exists(documentDirectory))
                       {
                           foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                           {
                               String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                      
                       <td><a href="<%=fileFolderApplication %>\Individual Scorecard\<% =PCNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
                       <td><label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i> Delete</label></td>
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
         <center>
              <asp:Button runat="server" CssClass="btn btn-warning" Text="Print Performance Contract" ID="print" OnClick="print_Click"/>
             <asp:Button runat="server" CssClass="btn btn-warning" Text="Print Sub Indicators" ID="printsubindicators" OnClick="printsubindicators_Click"/>
         </center><br />
          <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="BackTostep4" OnClick="BackTostep4_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send For Approval" ID="submitPC" OnClick="submitPC_Click"/>
          <div class="clearfix"></div>
        </div>
    </div>

     <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
 <script type="text/javascript" src="http://ajax.cdnjs.com/ajax/libs/json2/20110223/json2.js"></script>
  <script src="CustomJs/CategoriesSelection.js"></script>
 <%} %>



<script>
        
    function deleteFile(fileName) {
        document.getElementById("filetoDeleteName").innerText = fileName;
        document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
        $("#deleteFileModal").modal(); 
    }

    $("#sDate").datepicker();
    $("#eDate").datepicker("setDate", new Date());
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
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deletefile"/>
      </div>
    </div>

  </div>
</div>

    <script>
        function sendApprovalRequest(documentNumber) {
            document.getElementById("ContentPlaceHolder1_approvedocNo").value = documentNumber;
            $("#sendImprestMemoForApproval").modal();
        }
        $(function () {
            $("#datepicker").datepicker();
        });
    </script>

    <div id="sendImprestMemoForApproval" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Remove core initiative</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approvedocNo" type="hidden" />
                    Are you sure you want to remove core initiative ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Remove" ID="revove" OnClick="revove_Click"/>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>

    <script>
        function removeAIline(documentNumber) {
            document.getElementById("ContentPlaceHolder1_approvedocNo1").value = documentNumber;
            $("#removeAImodal").modal();
        }
    </script>

    <div id="removeAImodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Remove additional initiative</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="approvedocNo1" type="hidden" />
                    Are you sure you want to additional initiative ? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Remove" ID="removeadditionalinitiative" OnClick="removeadditionalinitiative_Click"/>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
