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

            if (step > 1 || step < 1)
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
            <h3 class="panel-title">Risk Incident Log</h3>
        </div>
        <div class="row user-tabs">
            <div class="col-lg-12 col-md-12 col-sm-12 line-tabs">
                <div class="stepwizard">
                    <div class="stepwizard-row setup-panel">
                        <div class="stepwizard-step col-xs-step">
                            <a href="#step-1" type="button" class="btn btn-success btn-circle">1</a>
                            <p><small>General Details</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
                            <p><small>Additional Incident Information</small></p>
                        </div>
                        <div class="stepwizard-step col-xs-step">
                            <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled="disabled">3</a>
                            <p><small>Attach Supporting Documents</small></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-primary setup-content" id="step-1">
            <div class="panel panel-heading">
                <h3 class="panel-title">General Details</h3>
            </div>
            <div class="panel-body">
                <div runat="server" id="generalfeedback"></div>
                <%--                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Employee Name</label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                    </div>
                </div>--%>
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
                        <label class="control-label">Risk Incident Category.</label>
                        <asp:DropDownList runat="server" ID="annualreportingcode" Class="form-control" />
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
                        <label class="control-label">Incident Date.</label>
                        <asp:DropDownList runat="server" ID="DropDownList10" Class="form-control" />
                    </div>
                    </div>
                     <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Occurrence Type.</label>
                        <asp:DropDownList runat="server" ID="DropDownList11" Class="form-control">
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
                            <label class="control-label">Primary Trigger.</label>
                            <asp:DropDownList runat="server" ID="primTrigger" Class="form-control" />
                        </div>
                    </div>
                  </div>
                <div class="col-md-12 col-lg-12">
                    <div class="panel-footer">
                        <center>
                           <asp:Button runat="server" ID="apply" CssClass="btn btn-success" Text="Save Details"/>
                        <div class="clearfix"></div>
                       </center>
                    </div>
                </div>
                <br />
                <div class="row">
                    <button class="btn btn-warning nextBtn pull-right" type="button">Next</button>
                </div>
           
        </div>
        <div class="panel panel-primary setup-content" id="step-2">
            <div class="panel panel-heading">
                <h3 class="panel-title">Additional Incident Information</h3>
            </div>
            <div class="panel-body">
                <div runat="server" id="Div1"></div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Impact Type</label>
                        <asp:DropDownList runat="server" ID="impacttype" Class="form-control" />
                    </div>
                    <div class="form-group">
                        <label class="control-label">Description</label>
                        <asp:TextBox runat="server" ID="description" Class="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Category Of Party Affected</label>
                        <asp:DropDownList runat="server" ID="categoryparty" Class="form-control" />
                    </div>
                    <div class="form-group">
                        <label class="control-label">Internal Employee Name</label>
                        <asp:TextBox runat="server" ID="TextBox1" Class="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Contact Details</label>
                        <asp:TextBox runat="server" ID="contactdetails" Class="form-control" />
                    </div>
                    <div class="form-group">
                        <label class="control-label">Additional Comments</label>
                        <asp:TextBox runat="server" ID="additionalcomments" Class="form-control" />
                    </div>
                </div>
                <div class="col-md-12 col-lg-12">
                    <div class="panel-footer">
                        <center>
                           <asp:Button runat="server" ID="Button1" CssClass="btn btn-success" Text="Save Details"/>
                        <div class="clearfix"></div>
                       </center>
                    </div>

                </div>
                <div class="row">
                    <button class="btn btn-warning nextBtn pull-right" type="button">Next</button>
                    <button class="btn btn-warning nextBtn pull-left" type="button">Previous</button>
                </div>
            </div>
        </div>
        <div class="panel panel-primary setup-content" id="step-3">
            <div class="panel panel-heading">
                <h3 class="panel-title">Attach Supporting Documents</h3>
            </div>
            <div class="panel-body">
                <div runat="server" id="documentsfeedback"></div>
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
                  String  imprestNo = Request.QueryString["imprestNo"];
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
                            if (folders.Name == "Risk")
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
                    </tbody>
                </table>
                <div class="row">
                    <button class="btn btn-success pull-right" type="button">Send For Approval</button>
                    <button class="btn btn-warning nextBtn pull-left" type="button">Previous</button>
                </div>
            </div>
        </div>
    </div>
    <%
        }

    %>
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
