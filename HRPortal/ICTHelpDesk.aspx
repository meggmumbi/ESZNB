<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ICTHelpDesk.aspx.cs" Inherits="HRPortal.ICTHelpDesk" %>
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

   <%-- <div class="panel panel-primary">
        <div class="panel-heading">Send Request to ICT Help Desk
            <span class="pull-right"></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="ictFeedback" runat="server"></div>
              <div class="row" >
        <div class="col-md-6 col-lg-6">
            <div class="form-group">
                <strong>ICT Issue Category:</strong>
               
            </div>
                 <div class="form-group">
                <strong>Asset Involved:</strong>
               
            </div>
            <div class="form-group">
                <strong>Description:</strong>
               
            </div>
            
            </div>
            
      </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Send Request
                " ID="addICTHelpDeskRequest" OnClick="addICTHelpDeskRequest_Click"/>
            <span class="clearfix"></span>
        </div>
    </div>--%>
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
    <div class="panel panel-primary">
         <div class="panel-heading">
           Send Request to ICT Help Desk
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>

        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Help Desk </a></li>
                        <li class="breadcrumb-item active">Help Desk Request</li>
                    </ol>
                </div>
            </div>
            <div id="ictFeedback" runat="server"></div>
            <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>ICT Issue Category:<span class="text-danger">*</span></strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="category" OnSelectedIndexChanged="category_SelectedIndexChanged" AutoPostBack="true" />
                    </div>


                    <div class="form-group">
                        <strong>Sub-category:<span class="text-danger">*</span></strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="subcategory" />
                    </div>
                    <div class="form-group">
                        <strong>Asset Inventory:</strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="asset" />
                    </div>
                </div>

            </div>
            <div class="row">
              
                
                   

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Description: (<i>maximum of 250 chararcters</i>)<span class="text-danger">*</span></strong>
                        <asp:TextBox runat="server" ID="Description" CssClass="form-control" placeholder="Description" TextMode="MultiLine" Rows="4"/>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="dynamic"   ControlToValidate="Description" ValidationExpression="^([\S\s]{0,250})$" ErrorMessage="Please enter maximum of 250 characters" ForeColor="Red"> </asp:RegularExpressionValidator>
                    </div>
                </div>
            </div>


        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="addICTHelpDeskRequest" OnClick="addICTHelpDeskRequest_Click" OnClientClick="if(this.value === 'Saving...') { return false; } else { this.value = 'Saving...'; }" />
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
            Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">ICTHelpDesk</a></li>
                        <li class="breadcrumb-item active">ICTHelpDesk Supporting Documents </li>
                    </ol>
                </div>
                </div>
                 <div runat="server" id="Div1"></div>
                  <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <strong>Select file to upload:</strong>
                        <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click" />
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
                            // var vendorNo = Convert.ToString(Session["vendorNo"]);
                            String leaveNo = Request.QueryString["applicationNo"];
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
                                        if (folders.Name == "ICTHelpDesk")
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
                                            
                                          </tr> --%>

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


                                //return Json(alldocuments, JsonRequestBehavior.AllowGet);
                            }

                        }
                        catch (Exception t)
                        {

                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    %>

                   
          
                </tbody>
            </table>
                </div>
            
            </div>
          <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" id="previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Request" ID="sendApproval" OnClick="sendApproval_Click"/><div class="clearfix"></div>
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
        }
    </script>
    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
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
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="Unnamed_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
