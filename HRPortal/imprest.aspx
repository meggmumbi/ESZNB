<%@ Page Title="Imprest" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="imprest.aspx.cs" Inherits="HRPortal.imprest" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="HRPortal.Models" %>
<%@ Import Namespace="System.Security" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step>6||step<1)
            {
               step = 1;  
            }
        }
        catch (Exception)
        { step = 1;
        }
        if (step == 1)
        {
           %>
       <div class="panel panel-primary">
        <div class="panel-heading">General Details
            <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 1 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
              <div class="row" >
        <div class="col-md-6 col-lg-6">
            <div class="form-group">
                <strong>Subject:</strong>
                <asp:TextBox runat="server" ID="subject" CssClass="form-control" placeholder="Subject"/>
            </div>
            <div class="form-group">
                <strong>Objective:</strong>
                <asp:TextBox runat="server" ID="objective" CssClass="form-control" placeholder="Objective" TextMode="MultiLine"/>
            </div>
            <div class="form-group">
                <strong>Destination Narration:</strong>
                <asp:TextBox runat="server" ID="destinationNarration" CssClass="form-control" placeholder="Destination Narration" TextMode="MultiLine" MaxLength="100"/>
            </div>
            <div class="form-group">
                <%--<strong>Fundcode/Constituency Code:</strong>--%>
                <strong>Division/Unit:</strong>
                <asp:DropDownList CssClass="form-control select2" runat="server" ID="fundcode"/>
            </div>
            </div>
            <div class="col-md-6 col-lg-6">
             <div class="form-group">
                <strong>Travel Date:</strong>
                <asp:TextBox runat="server" ID="travelDate" CssClass="form-control" placeholder="Travel Date" />
            </div>
            <div class="form-group">
                <strong>Number of Days:</strong>
                <asp:TextBox runat="server" ID="numberOfDays" CssClass="form-control" placeholder="Number of Days"/>
            </div>
                <div class="form-group">
                    <strong>Select Project</strong>
                   <asp:DropDownList runat="server" ID="job" CssClass="form-control select2" OnSelectedIndexChanged="job_SelectedIndexChanged" AutoPostBack="True"/>
                </div>
               <%-- <div class="form-group">
                    <strong>Select the Vote/JobTask:</strong>
                 <asp:DropDownList runat="server" ID="jobTaskno" CssClass="form-control select2"/>
                </div>--%>
              
         
          
            </div>
      </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="addGeneralDetails" OnClick="addGeneralDetails_Click"/>
            <span class="clearfix"></span>
        </div>
    </div>
    <% 
        }else if (step==2){
            %>
    <div class="panel panel-primary">
        <div class="panel-heading">Team
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 2 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="teamFeedback"></div>
            <!--team(destination town, vote item, no, number of days) -->
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Destination Town:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="destinationTown"/>
                </div>
            </div>
            <%--  <div class="col-md-6 col-lg-6">
              <div class="form-group">
                    <strong>Vote Item:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="voteItem"/>
                </div>
            </div>--%>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Team Member:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="teamMember"/>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Number of Days:</strong>
                    <asp:Textbox runat="server" CssClass="form-control" ID="teamNumberOfDays" placeholder="Number of Days"/>
                </div>
            </div>
            <div class="form-group">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Team Member" ID="addTeamMember" OnClick="addTeamMember_Click"/>
                <div class="clearfix"></div>
            </div>
            <hr/>
            <div class="table-responsive">               
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Destination Town</th>
                   <%-- <th>Vote Item</th>--%>
                    <th>Team Member</th>
                    <th>Number of Days</th>
                    <th>Total Daily Subsistence</th>
                    <th>Total Entitlement</th>
                    <th>Edit</th>
                    <th>Remove</th>
                </tr>
                </thead>
                <tbody>
                <%
                    var nav = new Config().ReturnNav();
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String imprestNo = Request.QueryString["imprestNo"];
                    var projectTeamMembers = nav.ProjectMembers.Where(r => r.Requestor == employeeNo && r.Imprest_Memo_No == imprestNo&&r.Type=="Person");
                    foreach (var member in projectTeamMembers)
                    {
                        %>
                    <tr>
                        <td><%=member.Work_Type %></td>
<%--                        <td><%=member.Type_of_Expense %></td>--%>
                        <td><%=member.Name %></td>
                        <td><%=member.Time_Period %></td>
                        <td><%=String.Format("{0:n}", Convert.ToDouble(member.Direct_Unit_Cost)) %></td>
                        <td><%=String.Format("{0:n}", Convert.ToDouble(member.Total_Entitlement)) %></td>
                        <td><label class="btn btn-success" onclick="editTeamMember('<%=member.Work_Type %>','<%=member.No %>', '<%=member.Time_Period %>');"><i class="fa fa-trash-o"></i> Edit</label></td>
                        <td><label class="btn btn-danger" onclick="removeTeamMember('<%=member.Work_Type %>','<%=member.No %>','<%=member.Name %>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                      
                    </tr>
                            <%
                    }
                     %>
                </tbody>
            </table>
                </div>

        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed2_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed3_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }else if (step==3){
              %>
    <div class="panel panel-primary">
        <div class="panel-heading">Fuel
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 3 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="fuelFeedback" runat="server"></div>
            <!-- fuel( work type, no, mileage) -->
            <div class="col-lg- col-md-6">
                <div class="form-group">
                    <strong>Work Type:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="workType"/>
                </div>
            </div>
             <div class="col-lg- col-md-6">
                <div class="form-group">
                    <strong>Resource:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="resource"/>
                </div>
            </div>
             <div class="col-lg- col-md-6">
                <div class="form-group">
                    <strong>Mileage:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Mileage" ID="Mileage"/>
                </div>
            </div>
             <div class="col-lg- col-md-6">
                <div class="form-group">
                    <br/>
                    <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="addFuel" Text="Add Fuel" OnClick="addFuel_Click"/>
                </div>
            </div>
            <hr/>
            <div class="table-responsive">               
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Work Type</th>
                    <th>Resource</th>
                    <th>Mileage</th>
                    <th>Edit</th>
                    <th>Remove</th>
                </tr>
                </thead>
                <%
                    var nav = new Config().ReturnNav();
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String imprestNo = Request.QueryString["imprestNo"];
                    var projectTeamMembers = nav.ProjectMembers.Where(r => r.Requestor == employeeNo && r.Imprest_Memo_No == imprestNo&&r.Type=="Machine");
                    foreach (var member in projectTeamMembers)
                    {
                        %>
                    <tr>
                        <td><%=member.Work_Type %></td>
                        <td><%=member.Name %></td>
                        <td><%=member.Time_Period %></td>
                       <td><label class="btn btn-success" onclick="editFuel('<%=member.Work_Type %>','<%=member.No %>','<%=member.Time_Period %>');"><i class="fa fa-edit-o"></i> Edit</label></td>
                       <td><label class="btn btn-danger" onclick="removeFuel('<%=member.Work_Type %>','<%=member.No %>','<%=member.Name %>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                    </tr>
                            <%
                    }
                     %>
            </table>
                </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed3_Click1"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed4_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }else if (step==4){
              %>
    <div class="panel panel-primary">
        <div class="panel-heading">Casuals
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 4 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="casualsFeedBack"></div>
          
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                <strong>Type:</strong>
                <asp:DropDownList runat="server" CssClass="form-control select2" ID="casualsType"/>
                    </div>
            </div>
              <div class="col-md-6 col-lg-6">
                <div class="form-group">
                <strong>Resource:</strong>
                <asp:DropDownList runat="server" CssClass="form-control select2" ID="casualsResource"/>
                    </div>
            </div>
              <div class="col-md-6 col-lg-6">
                <div class="form-group">
                <strong>Work Type:</strong>
                <asp:DropDownList runat="server" CssClass="form-control select2" ID="casualsWorkType"/>
                    </div>
            </div>
              <div class="col-md-6 col-lg-6">
                <div class="form-group">
                <strong>No. Required:</strong>
                <asp:Textbox runat="server" CssClass="form-control" ID="casualsNoRequired" placeholder="No. Required" TextMode="Number"/>
                    </div>
            </div> 
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                <strong>No. of Days:</strong>
                <asp:Textbox runat="server" CssClass="form-control" ID="casualsNoOfDays" placeholder="No. of Days"/>
                    </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <br/>
                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Casual" ID="addCasual" OnClick="addCasual_Click"/>
                </div>
            </div>
            <hr/>
            <div class="table-responsive">               
              <!-- casual (type, resource no, work type, no. required, no of days) -->
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Type</th>
                    <th>Resource</th>
                    <th>Work Type</th>
                    <th>No. Required</th>
                    <th>No. of Days</th>
                    <th>Edit</th>
                    <th>Remove</th>
                </tr>
                </thead>
                <tbody>
                <%
                    var nav = new Config().ReturnNav();
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String imprestNo = Request.QueryString["imprestNo"];
                    var projectTeamMembers = nav.Casuals.Where(r => r.Requestor == employeeNo && r.Imprest_Memo_No == imprestNo);
                    foreach (var member in projectTeamMembers)
                    {
                        %>
                    <tr>
                        <td><%=member.Type %></td>
                        <td><%=member.ResourceName %></td>
                        <td><%=member.Work_Type%></td>
                        <td><%=member.No_Required%></td>
                        <td><%=member.No_of_Days%></td>
                      
                        <td><label class="btn btn-success" onclick="editCasual('<%=member.Type %>', '<%=member.Resource_No %>', '<%=member.Work_Type %>', '<%=member.No_Required %>', '<%=member.No_of_Days %>');"><i class="fa fa-edit"></i> Edit</label></td>
                        <td><label class="btn btn-danger" onclick="removeCasual('<%=member.Type %>','<%=member.Resource_No %>','<%=member.ResourceName %>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                    </tr>
                            <%
                    }
                     %>
                    </tbody>
            </table>
                </div>
        </div>
        <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed5_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed6_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }else if (step==5){
              %>
    <div class="panel panel-primary">
        <div class="panel-heading">Other Costs
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 5 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="othercostsfeedback"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Vote Item:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="otherCostsVoteItem"/>
                </div>
            </div>
             <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Required For:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="requiredFor" placeholder="Required For"/>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Quantity Required:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="quantityRequired" placeholder="Quantity Required"/>
                </div>
            </div> 
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>No. of Days:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="otherCostsNoofDays" placeholder="No. of Days"/>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Unit Cost:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="otherCostsUnitCost" placeholder="Unit Cost"/>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <br/>
                    <asp:Button runat="server" CssClass="btn-success btn btn-block" Text="Add Cost" ID="addOtherCosts" OnClick="addOtherCosts_Click"/>
                    </div>
                    </div>
            <hr/>
               <div class="table-responsive">  
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <!--other costs(vote item, required for, quantity required, no of days, unit cost) -->
                    <th>Vote Item</th>
                    <th>Required for</th>
                    <th>Quantity Required</th>
                    <th>No. of Days</th>
                    <th>Unit Cost</th>
                    <th>Line Amount</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <%
                    //(costName, lineNo)
                    var nav = new Config().ReturnNav();
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String imprestNo = Request.QueryString["imprestNo"];
                    var otherCosts = nav.OtherCosts.Where(r => r.Requestor == employeeNo && r.Imprest_Memo_No == imprestNo);
                    foreach (var cost in otherCosts)
                    {
                        %>
                    <tr>
                        <td><%=cost.Description %></td>
                        <td><%=cost.Required_For %></td>
                        <td><%=cost.Quantity_Required %></td>
                        <td><%=cost.No_of_Days %></td>
                        <td><%=cost.Unit_Cost %></td>
                        <td><%=cost.Line_Amount %></td>
                        
                        
                        <td><label class="btn btn-success" onclick="editOtherCost('<%=cost.Line_No%>', '<%=cost.Type_of_Expense%>', '<%=cost.Required_For%>', '<%=cost.Quantity_Required%>', '<%=cost.No_of_Days%>','<%=cost.Unit_Cost%>');"><i class="fa fa-edit"></i> Edit</label></td>
                        <td><label class="btn btn-danger" onclick="removeOtherCost('<%=cost.Description %>','<%=cost.Line_No%>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                    </tr>
                            <%
                    }
                     %>
                </tbody>
            </table>
                   </div>
        </div>
        <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed8_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed8_Click1"  />
            <div class="clearfix"></div>
        </div>
        </div>
  
    <%
        }else if (step==6){
              %>
    <div class="panel panel-primary">
        <div class="panel-heading">Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 6 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
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
                       <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click"/>
                   </div>
               </div>
           </div>
               <div class="table-responsive">  
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Title</th>
                        <%-- <th>Download</th>--%>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                        try
                        {%>
                    <%  using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["S_URL"]))
                        {

                            String leaveNo = Request.QueryString["imprestNo"];
                            string password = ConfigurationManager.AppSettings["S_PWD"];
                            string account = ConfigurationManager.AppSettings["S_USERNAME"];
                            string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                            var secret = new SecureString();



                            foreach (char c in password)
                            {
                                secret.AppendChar(c);
                            }

                            ctx.Credentials = new NetworkCredential(account, secret, domainname);
                            ctx.Load(ctx.Web);
                            ctx.ExecuteQuery();
                            List list = ctx.Web.Lists.GetByTitle("ERP Documents");

                            //Get Unique rfiNumber
                            string uniqueLeaveNumber = leaveNo;

                            ctx.Load(list);
                            ctx.Load(list.RootFolder);
                            ctx.Load(list.RootFolder.Folders);
                            ctx.Load(list.RootFolder.Files);
                            ctx.ExecuteQuery();

                            FolderCollection allFolders = list.RootFolder.Folders;
                            foreach (Folder folder in allFolders)
                            {
                                if (folder.Name == "Kasneb")
                                {
                                    ctx.Load(folder.Folders);
                                    ctx.ExecuteQuery();
                                    var uniquerfiNumberFolders = folder.Folders;

                                    foreach (Folder folders in uniquerfiNumberFolders)
                                    {
                                        if (folders.Name == "Imprest Memo")
                                        {
                                            ctx.Load(folders.Folders);
                                            ctx.ExecuteQuery();
                                            var uniquevendorNumberSubFolders = folders.Folders;

                                            foreach (Folder vendornumber in uniquevendorNumberSubFolders)
                                            {
                                                if (vendornumber.Name == uniqueLeaveNumber)
                                                {
                                                    ctx.Load(vendornumber.Files);
                                                    ctx.ExecuteQuery();

                                                    FileCollection vendornumberFiles = vendornumber.Files;
                                                    foreach (Microsoft.SharePoint.Client.File file in vendornumberFiles)
                                                    {%>
                    <% ctx.ExecuteQuery();
                        alldocuments.Add(new SharePointTModel { FileName = file.Name });
                    %>


                    <% }%>


                    <% 
                        foreach (var item in alldocuments)
                        {%>
                    <tr>
                        <td><% =item.FileName %></td>
                        <td>
                            <label class="btn btn-danger" onclick="deleteFile('<%=item.FileName %>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                    </tr>
                    <% }
                    %>



                    <%  }

                                                }


                                            }
                                        }

                                    }
                                }

                            }

                        }
                        catch (Exception t)
                        {

                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                              "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    %>
                </tbody>
            </table>
                   </div>

          <%-- <table class="table table-bordered table-striped">
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
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Memo/";
                         String imprestNo = Request.QueryString["imprestNo"];
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + imprestNo+"/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                      
                       <td><a href="<%=fileFolderApplication %>\Imprest Memo\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
           </table>--%>
        </div>
        <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed10_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" OnClick="sendApproval_Click" ID="sendApproval"/>
            <div class="clearfix"></div>
        </div>
        </div>
  
    <%
        }
         %>

  
      <script>
          function removeTeamMember(workType, no, name) {
              document.getElementById("teamMembertoRemoveName").innerText = name;
              document.getElementById("ContentPlaceHolder1_removeNumber").value = no;
              document.getElementById("ContentPlaceHolder1_removeWorkType").value = workType;
              $("#removeTeamMemberModal").modal();
          }
      </script>  
    <script>
        // lineNo 
        function removeOtherCost(costName, lineNo) {
            document.getElementById("costtoRemoveName").innerText = costName;
            document.getElementById("ContentPlaceHolder1_costToRemovelineNo").value = lineNo;
            $("#removeOtherCostsModal").modal();
        }
    </script>   
     <script>
        
         function removeFuel(workType, no, name) {
             document.getElementById("fueltoRemoveName").innerText = name;
             document.getElementById("ContentPlaceHolder1_removeFuelNumber").value = no;
             document.getElementById("ContentPlaceHolder1_removeFuelWorkType").value = workType;
             $("#removeFuelModal").modal();
         }
     </script>
     <script>
        
         function deleteFile(fileName) {
             document.getElementById("filetoDeleteName").innerText = fileName;
             document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
             $("#deleteFileModal").modal(); 
         }
     </script> 
    <script>
        
        function removeCasual(type, resourceNo, resourceName) {
            document.getElementById("casualtoRemoveName").innerText = resourceName;
            document.getElementById("ContentPlaceHolder1_removeCasualType").value = type;
            document.getElementById("ContentPlaceHolder1_removeCasualResourceNo").value = resourceNo;
            $("#removeCasualsModal").modal();
        }
    </script> 
    <script>
        function editTeamMember(workType, no,myDays) {
            document.getElementById("ContentPlaceHolder1_editDestinationTown").value = workType;
            //document.getElementById("ContentPlaceHolder1_editVoteItem").value = expenseType;
            document.getElementById("ContentPlaceHolder1_editTeamMember").value = no;
            document.getElementById("ContentPlaceHolder1_editNumberOfDays").value = myDays;
            document.getElementById("ContentPlaceHolder1_originalNo").value = no;
            document.getElementById("ContentPlaceHolder1_originalWorkType").value = workType;

            $("#editTeamMemberModal").modal();
        }
    </script> 
    <script>
        function editFuel(workType, no, mileage) {
            document.getElementById("ContentPlaceHolder1_editFuelOriginalNo").value = no;
            document.getElementById("ContentPlaceHolder1_editFuelResource").value = no;
            document.getElementById("ContentPlaceHolder1_editFuelOriginalWorkTye").value = workType;
            document.getElementById("ContentPlaceHolder1_editFuelWorkType").value = workType;
            document.getElementById("ContentPlaceHolder1_editFuelMileage").value = mileage;

            $("#editFuelModal").modal();
        }
    </script> 
     <script>
         function editCasual(type, resourceNo, workType, noRequired, noOfDays) {
             //     
             //  
          
             document.getElementById("ContentPlaceHolder1_originalCasualsType").value = type;
             document.getElementById("ContentPlaceHolder1_originalCasualsResourceNo").value = resourceNo;
             document.getElementById("ContentPlaceHolder1_editCasualsType").value = type;
             document.getElementById("ContentPlaceHolder1_editCasualsResource").value = resourceNo;
             document.getElementById("ContentPlaceHolder1_editCasualsWorkType").value = workType;
             document.getElementById("ContentPlaceHolder1_editCasualsNoRequired").value = noRequired;
             document.getElementById("ContentPlaceHolder1_editCasualsNoOfDays").value = noOfDays;
            
             $("#editCasualsModal").modal();
         }
     </script>
      <script>
         function editOtherCost(lineNo, voteItem, requiredFor, quantityRequired, noOfDays,unitCost) {
                  
          
             document.getElementById("ContentPlaceHolder1_originalLine").value = lineNo;
             document.getElementById("ContentPlaceHolder1_editCostVoteItem").value = voteItem;
             document.getElementById("ContentPlaceHolder1_editCostRequiredFor").value = requiredFor;
             document.getElementById("ContentPlaceHolder1_editCostQuantityRequired").value = quantityRequired;
             document.getElementById("ContentPlaceHolder1_editCostNoofDays").value = noOfDays;
             document.getElementById("ContentPlaceHolder1_editCostUnitCost").value = unitCost;
            
             $("#editOtherCostsModal").modal();
         }
     </script>
    <div id="removeFuelModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Removal of Fuel</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to remove the fuel <strong id="fueltoRemoveName"></strong> from the imprest?</p>
          <asp:TextBox runat="server" ID="removeFuelNumber" type="hidden"/>
          <asp:TextBox runat="server" ID="removeFuelWorkType" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Fuel" OnClick="removeFuel_Click"/>
      </div>
    </div>

  </div>
</div>

  
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
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click"/>
      </div>
    </div>

  </div>
</div>
   
  <div id="removeTeamMemberModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Removal of Member</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to remove the team member <strong id="teamMembertoRemoveName"></strong> from the imprest team?</p>
          <asp:TextBox runat="server" ID="removeNumber" type="hidden"/>
          <asp:TextBox runat="server" ID="removeWorkType" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Member" OnClick="removeMember_Click"/>
      </div>
    </div>

  </div>
</div>
   
     <div id="editTeamMemberModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Team Member</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="originalNo" type="hidden"/>
          <asp:TextBox runat="server" ID="originalWorkType"   type="hidden"/>
        <div class="form-group">
            <strong>Destination Town</strong>
            <asp:DropDownList runat="server" CssClass="form-control select2" ID="editDestinationTown"/>
        </div>  
          <%--<div class="form-group">
            <strong>Vote Item:</strong>
            <asp:DropDownList runat="server" CssClass="form-control select2"  ID="editVoteItem"/>
        </div> --%>
          <div class="form-group">
            <strong>Team Member:</strong>
            <asp:DropDownList runat="server" CssClass="form-control select2" ID="editTeamMember"/>
        </div>
          <div class="form-group">
            <strong>Number of Days:</strong>
            <asp:TextBox runat="server" CssClass="form-control" placeholder="Number of Days" ID="editNumberOfDays"/>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Member" OnClick="editTeamMember_Click"/>
      </div>
    </div>

  </div>
</div>
    <div id="editFuelModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Fuel</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="editFuelOriginalWorkTye" type="hidden"/>
          <asp:TextBox runat="server" ID="editFuelOriginalNo"   type="hidden"/>
        <div class="form-group">
            <strong>Work Type</strong>
            <asp:DropDownList runat="server" CssClass="form-control select2" ID="editFuelWorkType"/>
        </div>  
          <div class="form-group">
            <strong>Resource:</strong>
            <asp:DropDownList runat="server" CssClass="form-control select2"  ID="editFuelResource"/>
        </div> 
          
          <div class="form-group">
            <strong>Mileage:</strong>
            <asp:TextBox runat="server" CssClass="form-control" placeholder="Mileage" ID="editFuelMileage"/>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Fuel" OnClick="editFuel_Click"/>
      </div>
    </div>

  </div>
</div>
    <div id="removeCasualsModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Removal of Casual</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to remove the casual <strong id="casualtoRemoveName"></strong> from the imprest team?</p>
          <asp:TextBox runat="server" ID="removeCasualType" type="hidden"/>
          <asp:TextBox runat="server" ID="removeCasualResourceNo" type="hidden"/> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Casual" OnClick="removeCasual_Click"/>
      </div>
    </div>

  </div>
</div>
   
        <div id="editCasualsModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Casual</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="originalCasualsType" type="hidden"/>
          <asp:TextBox runat="server" ID="originalCasualsResourceNo"   type="hidden"/>
        <div class="form-group">
            <strong>Type</strong>
            <asp:DropDownList runat="server" CssClass="form-control select2" ID="editCasualsType"/>
        </div>  
          <div class="form-group">
            <strong>Resource:</strong>
            <asp:DropDownList runat="server" CssClass="form-control select2"  ID="editCasualsResource"/>
        </div>  
          
          <div class="form-group">
            <strong>Work Type:</strong>
            <asp:DropDownList runat="server" CssClass="form-control select2"  ID="editCasualsWorkType"/>
        </div> 
          
          <div class="form-group"> 
            <strong>No. Required:</strong>
            <asp:TextBox runat="server" CssClass="form-control" placeholder="No. Required" ID="editCasualsNoRequired"/>
        </div>
           <div class="form-group">
            <strong>No. of Days:</strong>
            <asp:TextBox runat="server" CssClass="form-control" placeholder="No. of Days" ID="editCasualsNoOfDays"/>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Casual" OnClick="editCasual_Click"/>
      </div>
    </div>

  </div>
</div>
     <div id="removeOtherCostsModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content--> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Removal of Other Costs</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to remove the cost with vote item <strong id="costtoRemoveName"></strong> from the imprest?</p>
          <asp:TextBox runat="server" ID="costToRemovelineNo" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Cost" OnClick="removeOtherCost_Click"/>
      </div>
    </div>

  </div>
</div>
    <div id="editOtherCostsModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Other Cost</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="originalLine" type="hidden"/>
        <div class="form-group">
            <strong>Vote Item</strong>
            <asp:DropDownList runat="server" CssClass="form-control select2" ID="editCostVoteItem"/>
        </div>  
          
          
          <div class="form-group"> 
            <strong>Required For:</strong>
            <asp:TextBox runat="server" CssClass="form-control" placeholder="Required For" ID="editCostRequiredFor"/>
        </div>
           
          <div class="form-group"> 
            <strong>Quantity Required:</strong>
            <asp:TextBox runat="server" CssClass="form-control" placeholder="Quantity Required" ID="editCostQuantityRequired"/>
        </div>
           <div class="form-group">
            <strong>No. of Days:</strong>
            <asp:TextBox runat="server" CssClass="form-control" placeholder="No. of Days" ID="editCostNoofDays"/>
        </div> 
          <div class="form-group">
            <strong>Unit Cost:</strong>
            <asp:TextBox runat="server" CssClass="form-control" placeholder="No. of Days" ID="editCostUnitCost"/>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Cost" OnClick="editOtherCosts_Click"/>
      </div>
    </div>

  </div>
</div>
</asp:Content>
