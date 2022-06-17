<%@ Page Title="Imprest Surrender" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImprestSurrender.aspx.cs" Inherits="HRPortal.ImprestSurrender" %>
<%@ Import Namespace="System.IO" %>
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
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step>3||step<1)
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
   <!-- <div class="panel panel-primary">
        <div class="panel-heading">
            Imprest Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="generalFeedback"></div>
             <div class="row">
    <div class="col-md-6 col-lg-6">
        <div class="form-group">
            <strong>Imprest Issue Doc. No.</strong>
            <asp:DropDownList runat="server" ID="imprest" CssClass="form-control select2"/>
        </div>
    </div>
    </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>-->
    <% } 
         if (step == 2)
        {
            %>
     <div class="panel panel-primary">
        <div class="panel-heading">
            Imprest Surrender Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>
            <h4>Imprest Surrender for Imprest No</h4>
               <div class="table-responsive">  
            <table class="table table-bordered table-striped" id="linesTable" runat="server">
                <thead>
                <tr>
                    <th>Account Type</th>
                    <th>Account No</th>
                    <th>Account Name</th>
                    <th>Amount</th>
                    <th>Actual Spent</th>
                    <th>Receipt No</th>
                </tr>
                </thead>
            </table>
                   </div>
        </div>
        <div class="panel-footer">
          <!--  <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click"/>-->
           
            
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed1_Click" />
             <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save" ID="save" OnClick="save_Click" style="margin-right:10px;"/>
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
                            String imprestNo = Request.QueryString["surrenderNo"];
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
                                        if (folders.Name == "Imprest Surrender")
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
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Surrender/";
                         String imprestNo = Request.QueryString["surrenderNo"];
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
                      
                       <td><a href="<%=fileFolderApplication %>\Imprest Surrender\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed2_Click"  />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send for Approval" ID="sendForApproval" OnClick="sendForApproval_Click"/>
            <div class="clearfix"></div>
        </div>
        </div>
  
    
		   
                <%
        } %>
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
