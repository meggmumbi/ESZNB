<%@ Page Title="Leave Application" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="leaveapplication.aspx.cs" Inherits="HRPortal.leaveapplication" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>

<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="HRPortal.Models" %>
<%@ Import Namespace="System.Security" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"].Trim());
            if (step>2||step<1)
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
        <div class="panel-heading">Leave Application
             <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
         <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="form-group">
                   <label class="span2" >Leave Type</label>
                     
                     <asp:DropDownList runat="server" ID="leaveType" AppendDataBoundItems="true" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="leaveType_SelectedIndexChanged" >
                         <asp:ListItem Text="--- Select ----" Value=" " />
                         </asp:DropDownList>
               </div>
              <div class="form-group">
                   <label class="span2">Annual Leave Type</label>
                   <asp:DropDownList ID="annualLeaveType" runat="server" visible="false"  CssClass="form-control select2" 
                    AutoPostBack="false" >
                      <asp:ListItem>Select</asp:ListItem>
                      <asp:ListItem Value="0">Annual Leave</asp:ListItem>
                      <asp:ListItem Value="1">Emergency Leave</asp:ListItem>
                       </asp:DropDownList>
                </div>
                 <div class="form-group">
                   <label class="span2">Days Applied</label>
                   <asp:Textbox runat="server" ID="daysApplied" CssClass="form-control span3" type ="number"/>
               </div>
               
                 <div class="form-group">
                   <label class="span2">Start Date</label>
                   <asp:Textbox runat="server" ID="leaveStartDate" CssClass="form-control span3"/>
               </div>
                   <div class="form-group" style="display:none">
                   <label class="span2">Reliever <span class="text-danger">*</span></label>
                 <asp:DropDownList runat="server" ID="Reliever"  CssClass="form-control select2" />
               </div>
               
               <strong> More Leave Details</strong> <i>(Optional)</i>
                <hr/>
                
                  <div class="form-group">
                   <label class="span2">Phone Number</label>
                   <asp:Textbox runat="server" ID="phoneNumber" CssClass="form-control span3"/>
               </div>
                  <div class="form-group">
                   <label class="span2">Email Address</label>
                   <asp:Textbox runat="server" ID="emailAddress" CssClass="form-control span3"/>
               </div>
                  <div class="form-group">
                      <asp:Label ID="examDetail" CssClass="span2" runat="server" Text="Label">Details of Exam</asp:Label>
                  <%-- <label class="span2" id="" runat="server">Details of Exam</label>--%>
                   <asp:Textbox runat="server" ID="examDetails" CssClass="form-control span3" TextMode="MultiLine"/>
               </div>
                  <div class="form-group">
                      <asp:Label ID="examDate" CssClass="span2" runat="server" Text="Label">Start Date of Exam</asp:Label>
                  <%-- <label class="span2" id="">Date of Exam</label>--%>
                   <asp:Textbox runat="server" ID="dateOfExam" CssClass="form-control span3"/>
               </div>
                  <div class="form-group">
                       <asp:Label ID="attempts" CssClass="span2" runat="server" Text="Label">End Date of Exam</asp:Label>
                   <%--<label class="span2" id="attempts">Number of Previous Attempts</label>--%>
                   <asp:Textbox runat="server" ID="previousAttempts" CssClass="form-control span3" type="number"/>
               </div>
                 

           
     
         </div>
         <div class="panel-footer">
             <asp:Button runat="server" ID="apply" CssClass="btn btn-success pull-right" Text="Next" OnClick="apply_Click" />
             <div class="clearfix"></div>
         </div>
    </div>
    <% 
        }else if (step==2){
              %>
    <div class="panel panel-primary">
        <div class="panel-heading">Supporting Documents<i><strong>Mandatory Documents attachment for paternity, maternity and Study leave</strong></i>
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
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
                           <th>Download</th>
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
                            String leaveNo = Request.QueryString["leaveNo"];
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
                                        if (folders.Name == "Leave Application")
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
                    <%--    <td> 
                        <label class="btn btn-success" onclick="downloadFile('<%=item.FileName %>');">Download</label>
                        </td>--%>
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
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Leave Application Card/";
                         String imprestNo = Request.QueryString["leaveNo"];
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
                      
                       <td><a href="<%=fileFolderApplication %>\Leave Application\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
            <%
                string leavetype = Request.QueryString["leavetype"];
                if(leavetype=="MATERNITY" && alldocuments.Count == 0)
                {
                    sendApproval.Visible = false;
                }
                else if(leavetype=="PATERNITY" && alldocuments.Count == 0)
                {
                    sendApproval.Visible = false;
                }
                else if(leavetype=="STUDY" && alldocuments.Count == 0)
                {
                    sendApproval.Visible = false;
                }
                else
                {
                    sendApproval.Visible = true;
                }

                 %>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" OnClick="sendApproval_Click" ID="sendApproval" Visible="false"/>
            <div class="clearfix"></div>
        </div>
        </div>
  
    <%
        }
         %>
   <script>
        
         function deleteFile(fileName) {
             document.getElementById("filetoDeleteName").innerText = fileName;
             document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
             $("#deleteFileModal").modal();
             downloadFile
         }

         function downloadFile(fileName) {
             document.getElementById("filetoDownloadName").innerText = fileName;
             document.getElementById("ContentPlaceHolder1_fileName1").value = fileName;
             $("#downloadFileModal").modal();
             
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
     <div id="downloadFileModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Download File</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to download the file <strong id="filetoDownloadName"></strong> ?</p>
          <asp:TextBox runat="server" ID="fileName1" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-primary" Text="Download File" ID="downloadFile" OnClick="downloadFile_Click"/>
      </div>
    </div>

  </div>
</div>
</asp:Content>
