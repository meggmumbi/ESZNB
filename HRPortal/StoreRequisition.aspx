<%@ Page Title="Store Requisition" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StoreRequisition.aspx.cs" Inherits="HRPortal.StoreRequisition" %>

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
    <!-- location code, description,  -->
    <%
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
                        <strong>Location:</strong>

                        <asp:DropDownList runat="server" ID="location" CssClass="form-control select2" />
                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Division/Unit:</strong>

                        <asp:DropDownList runat="server" ID="fundCode" CssClass="form-control select2" />
                    </div>
                </div>
            </div>




            <div class="row">

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Branches:</strong>
                        <asp:DropDownList runat="server" ID="branch" CssClass="form-control select2" />
                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Select Project:</strong>
                        <asp:DropDownList runat="server" ID="job" CssClass="form-control select2" OnSelectedIndexChanged="job_SelectedIndexChanged" AutoPostBack="True" />
                    </div>
                </div>
            </div>

            <div class="row">

                <div class="col-md-12 col-lg-12">
                    <div class="form-group">
                        <strong>Description:</strong>
                        <asp:TextBox runat="server" ID="description" CssClass="form-control" placeholder="Description" />
                    </div>
                </div>


            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
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
            Store Requisition Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>



            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Item Category:</strong>
                    <asp:DropDownList runat="server" ID="itemCategory" CssClass="form-control select2" OnSelectedIndexChanged="itemCategory_SelectedIndexChanged" AutoPostBack="True" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Item:</strong>
                    <asp:DropDownList runat="server" ID="item" CssClass="form-control select2" OnSelectedIndexChanged="item_SelectedIndexChanged" AutoPostBack="true" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Quantity Requested:</strong>
                    <asp:TextBox runat="server" ID="quantityRequested" CssClass="form-control" placeholder="Quantity Requested" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Unit of Measure</strong>
                    <asp:TextBox runat="server" ID="baseUnits" CssClass="form-control" placeholder="unit of measure"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Item" ID="addItem" OnClick="addItem_Click" />
                </div>
            </div>
            
                <table class="table table-bordered table-striped ">
                    <thead>
                        <tr>

                            <th>Item Category</th>
                            <th>Item </th>
                            <th>Quantity Requested </th>
                            <th>Direct Unit Cost Excl. VAT </th>
                            <th>Line Amount Excl. VAT </th>
                            <th>Amount </th>
                            <th>Remove </th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String requisitionNo = Request.QueryString["requisitionNo"];
                            var nav = new Config().ReturnNav();
                            var purhaseLines = nav.PurchaseLines.Where(r => r.Document_No == requisitionNo);
                            foreach (var line in purhaseLines)
                            {
                        %>
                        <tr>

                            <td><% =line.Item_Category %></td>
                            <td><% =line.Description %></td>
                            <td><% =line.Qty_Requested %></td>
                            <td><%=String.Format("{0:n}", Convert.ToDouble(line.Direct_Unit_Cost)) %></td>
                            <td><%=String.Format("{0:n}", Convert.ToDouble(line.Line_Amount)) %></td>
                            <td><%=String.Format("{0:n}", Convert.ToDouble(line.Amount)) %></td>

                            <td>
                                <label class="btn btn-danger" onclick="removeLine('<% =line.Description %>','<%=line.Line_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                        </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>
          
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed1_Click" />

            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (step == 3)
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
                               // var vendorNo = Convert.ToString(Session["vendorNo"]);
                               String leaveNo = Request.QueryString["requisitionNo"];
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
                                           if (folders.Name == "Store Requisitions")
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
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Store Requisition/";
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
                      
                       <td><a href="<%=fileFolderApplication %>\Store Requisition\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
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
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" ID="sendApproval" OnClick="sendApproval_Click"/><div class="clearfix"></div>
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
        <p>Are you sure you want to remove the item <strong id="itemName"></strong> from the Store Requisition?</p>
          <asp:TextBox runat="server" ID="lineNo" type="hidden"/>
      </div>
     
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" OnClick="deleteLine_Click"/>
      </div>
    </div>

  </div>
</div>

</asp:Content>
