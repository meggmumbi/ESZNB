<%@ Page Title="Fleet Requisition" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FleetRequisition.aspx.cs" Inherits="HRPortal.FleetRequisition" %>
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
            if (step>3||step<1)
            {
               step = 1; 
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        if (step==1)
        {
           %>
    
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        General Details
                          <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
                    </div>
                    <div class="panel-body">
                        <div id="generalFeedback" runat="server"></div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>From:</strong>
                                <asp:Textbox runat="server" CssClass="form-control" ID="from" placeholder="From"/>
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Destination:</strong>
                                <asp:Textbox runat="server" CssClass="form-control" ID="destination" placeholder="Destination"/>
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Date of Trip:</strong>
                                <asp:Textbox runat="server" CssClass="form-control" ID="dateofTrip" placeholder="Date of Trip"/>
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Time Out:</strong><br/>
                                 <asp:DropDownList runat="server" ID="hour" style="height: 34px;"/> :
                                <asp:DropDownList runat="server" ID="minute" style="height: 34px;"/> 
                                <asp:DropDownList runat="server" ID="amPM" style="height: 34px;"/> 
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Journey Route:</strong>
                                <asp:Textbox runat="server" CssClass="form-control" ID="journeyRoute" placeholder="Journey Route"/>
                               
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>No. of Days Requested:</strong>
                                <asp:Textbox runat="server" CssClass="form-control" ID="noOfDays" placeholder="No. of Days Requested"/>
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Purpose of Trip:</strong>
                                <asp:Textbox runat="server" CssClass="form-control" ID="purposeOfTrip" placeholder="Purpose of Trip"/>
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Comments:</strong>
                                <asp:Textbox runat="server" CssClass="form-control" ID="comments" placeholder="Comments"/>
                            </div>
                        </div>
<!-- from, destination, date of trip, time out, journey route, no of days requested, purpose of trip, comments,  -->
                    </div>
                    <div class="panel-footer">
                        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click"/>
                        <div class="clearfix"></div>
                    </div>
                </div>
            <% 
        }else if (step==2)
        {
            
           %>
            <div class="panel panel-primary">
                <div class="panel-heading">Travel Requisition Staff
                    
                      <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
                </div>
                <div class="panel-body">
                    <div id="linesFeedback" runat="server"></div>
                    <div class="row">
                        <div class="col-md-8 col-lg-8">
                            <strong>Employee:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control select2" ID="employee"/>
                        </div>
                        <div class="col-md-4 col-lg-4">
                            <br/>
                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Team Member" ID="addTeamMember" OnClick="addTeamMember_Click"/>
                        </div>
                    </div>
                    <br/>
                    <div class="table-responsive">               
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th>Employee Number</th>
                            <th>Employee Name</th>
                            <th>Remove</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            var nav = new Config().ReturnNav();
                              String requisitionNo = Request.QueryString["requisitionNo"];
                            var lines = nav.TravelRequisitionStaff.Where(r => r.Req_No == requisitionNo);
                            foreach (var line in lines)
                            {
                              %>
                            <tr>
                                <td><% =line.Employee_No %></td>
                                <td><% =line.Employee_Name %></td>
                                <td><label class="btn btn-danger" onclick="removeStaff('<%=line.EntryNo %>', '<%=line.Employee_Name %>');"> <i class="fa fa-trash-o"></i> Remove</label></td>
                            </tr>
                            <%  
                            }
                        %>
                        </tbody>
                    </table>
                        </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click"/>
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed1_Click" />
                    
                        <div class="clearfix"></div>
                </div>
            </div>
            <%
                }else if (step == 3)
                {
                    %>
    
 <div class="panel panel-primary">
        <div class="panel-heading">Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
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
                <%--   <th>Download</th>--%>
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
                  String  imprestNo = Request.QueryString["requisitionNo"];
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
                string uniqueLeaveNumber = imprestNo;

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
                            if (folders.Name == "Fleet Requisition Card")
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
                                         <%-- <tr>
                                           

                                              <%
                                                  foreach (var item in alldocuments)
                                                  {%>
                                                   <td><% =item.FileName %></td>
                                                      <td><label class="btn btn-danger" onclick="deleteFile('<%=item.FileName %>');"><i class="fa fa-trash-o"></i> Delete</label></td>

                                                 <% }
                                                   %>
                                            
                                          </tr>   --%> 

                                       <% }%>
                                        
                                             <%
                                                  foreach (var item in alldocuments)
                                                  {%>
                                                       <tr>
                                                   <td><% =item.FileName %></td>
                                                   <td><label class="btn btn-danger" onclick="deleteFile('<%=item.FileName %>');"><i class="fa fa-trash-o"></i> Delete</label></td>
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
              <%-- <%
                   try
                   {
                       String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Fleet Requisition Card/";
                         String imprestNo = Request.QueryString["requisitionNo"];
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
                       
                   }%>--%>
               </tbody>
           </table>
                </div>
         <%--  <table class="table table-bordered table-striped">
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
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Fleet Requisition Card/";
                         String imprestNo = Request.QueryString["requisitionNo"];
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
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed2_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" ID="sendApproval" OnClick="sendApproval_Click"/>
            <div class="clearfix"></div>
        </div>
        </div>
  
    
		   
    <%
                }
         %>
     <script>
         function removeStaff(id, name) {
             var host = '<%=ConfigurationManager.AppSettings["SiteLocation"]%>';
             var requisitionNo = '<%=Request.QueryString["requisitionNo"]%>';
            swal({
                title: "Are you sure you want to remove " + name + " from the travel requisition?",
                text: "Once deleted, this action cannot be undone!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
              .then((willDelete) => {
                  if (willDelete) {

                      window.location.href = host+"FleetRequisition.aspx?step=2&&requisitionNo=" + requisitionNo + "&&entry=" + id;
                      /*swal("Poof! Your imaginary file has been deleted!", {
                          icon: "success",
                      });*/
                  } /*else {
                     swal("Your imaginary file is safe!");
                 }*/
              });
        }
    </script>
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
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click"/>
      </div>
    </div>

  </div>
</div>




</asp:Content>
