using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class NewRiskIncidentLogs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                var nav = new Config().ReturnNav();
                var severityLevels = nav.severityLevel;
                severityLevel.DataSource = severityLevels;
                severityLevel.DataValueField = "Code";
                severityLevel.DataTextField = "Description";
                severityLevel.DataBind();
                severityLevel.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var trigger = nav.RiskCategoryTrig;
                primTrigger.DataSource = trigger;
                primTrigger.DataValueField = "Risk_Category_ID";
                primTrigger.DataTextField = "Description";
                primTrigger.DataBind();
                primTrigger.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
            }
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            // string filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Memo/";
            //if (document.HasFile)
            //    bool fileuploadSuccess = false;
            string sUrl = ConfigurationManager.AppSettings["S_URL"];
            string defaultlibraryname = "ERP%20Documents/";
            string customlibraryname = "Kasneb/Risk";
            string sharepointLibrary = defaultlibraryname + customlibraryname;
            String leaveNo = Request.QueryString["imprestNo"];

            string username = ConfigurationManager.AppSettings["S_USERNAME"];
            string password = ConfigurationManager.AppSettings["S_PWD"];
            string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];

            bool bbConnected = Config.Connect(sUrl, username, password, domainname);

            try
            {
                if (bbConnected)
                {
                    Uri uri = new Uri(sUrl);
                    string sSpSiteRelativeUrl = uri.AbsolutePath;
                    string uploadfilename = leaveNo + "_" + document.FileName;
                    Stream uploadfileContent = document.FileContent;

                    var sDocName = UploadFleetRequisition(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                    string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                    if (!string.IsNullOrEmpty(sDocName))
                    {
                        var status = Config.ObjNav.AddFleetRequisitionSharepointLinks(leaveNo, uploadfilename, sharepointlink);
                        string[] info = status.Split('*');
                        if (info[0] == "success")
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                        else
                        {
                            documentsfeedback.InnerHtml =
                                "<div class='alert alert-danger'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    }
                    else
                    {
                        documentsfeedback.InnerHtml =
                              "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }


                }
                else
                {
                    documentsfeedback.InnerHtml =
                              "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception ex)
            {

                documentsfeedback.InnerHtml =
                             "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }

        public string UploadFleetRequisition(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            leaveNo = Request.QueryString["imprestNo"];

            string parent_folderName = "Kasneb/Risk";
            string subFolderName = leaveNo;
            string filelocation = sLibraryName + "/" + subFolderName;
            try
            {
                // if a folder doesn't exists, create it
                var listTitle = "ERP Documents";
                if (!FolderExists(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName))
                    CreateFolder(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName);

                if (Config.SPWeb != null)
                {
                    var sFileUrl = string.Format("{0}/{1}/{2}", sSpSiteRelativeUrl, filelocation, sFileName);
                    Microsoft.SharePoint.Client.File.SaveBinaryDirect(Config.SPClientContext, sFileUrl, fs, true);
                    Config.SPClientContext.ExecuteQuery();
                    sDocName = sFileName;
                }
            }

            catch (Exception)
            {
                sDocName = string.Empty;
            }
            return sDocName;
        }


        public static bool FolderExists(Web web, string listTitle, string folderUrl)
        {
            var list = web.Lists.GetByTitle(listTitle);
            var folders = list.GetItems(CamlQuery.CreateAllFoldersQuery());
            web.Context.Load(list.RootFolder);
            web.Context.Load(folders);
            web.Context.ExecuteQuery();
            var folderRelativeUrl = string.Format("{0}/{1}", list.RootFolder.ServerRelativeUrl, folderUrl);
            return Enumerable.Any(folders, folderItem => (string)folderItem["FileRef"] == folderRelativeUrl);
        }

        private static void CreateFolder(Web web, string listTitle, string folderName)
        {
            var list = web.Lists.GetByTitle(listTitle);
            var folderCreateInfo = new ListItemCreationInformation
            {
                UnderlyingObjectType = FileSystemObjectType.Folder,
                LeafName = folderName
            };
            var folderItem = list.AddItem(folderCreateInfo);
            folderItem.Update();
            web.Context.ExecuteQuery();
        }
        protected void deleteFile_Click(object sender, EventArgs e)
        {
            var sharepointUrl = ConfigurationManager.AppSettings["S_URL"]; try
            {
                using (ClientContext ctx = new ClientContext(sharepointUrl))
                {

                    string password = ConfigurationManager.AppSettings["S_PWD"];
                    string account = ConfigurationManager.AppSettings["S_USERNAME"];
                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                    var secret = new SecureString();
                    var parentFolderName = @"ERP%20Documents/Kasneb/Risk/";
                    var leaveNo = Request.QueryString["imprestNo"];

                    foreach (char c in password)
                    { secret.AppendChar(c); }
                    try
                    {
                        ctx.Credentials = new NetworkCredential(account, secret, domainname);
                        ctx.Load(ctx.Web);
                        ctx.ExecuteQuery();

                        Uri uri = new Uri(sharepointUrl);
                        string sSpSiteRelativeUrl = uri.AbsolutePath;

                        string filePath = sSpSiteRelativeUrl + parentFolderName + leaveNo + "/" + fileName.Text;

                        var file = ctx.Web.GetFileByServerRelativeUrl(filePath);
                        ctx.Load(file, f => f.Exists);
                        file.DeleteObject();
                        ctx.ExecuteQuery();

                        if (!file.Exists)
                            throw new FileNotFoundException();
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    catch (Exception ex)
                    {
                        // ignored
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //throw;
            }


        }
        protected void riskType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string docType = strategicplanno.SelectedValue.Trim();
            if (docType == "1")
            {
                var nav = new Config().ReturnNav();
                var riskMngt = nav.managementPlans.Where(r => r.Document_Type == "Corporate");
                funcionalworkplan.DataSource = riskMngt;
                funcionalworkplan.DataTextField = "Description";
                funcionalworkplan.DataValueField = "Document_No";
                funcionalworkplan.DataBind();
            }
            else if (docType == "2")
            {
                var nav = new Config().ReturnNav();
                var riskMngt = nav.managementPlans.Where(r => r.Document_Type == "Functional (Directorate)");
                funcionalworkplan.DataSource = riskMngt;
                funcionalworkplan.DataTextField = "Description";
                funcionalworkplan.DataValueField = "Document_No";
                funcionalworkplan.DataBind();
            }
            else if (docType == "3")
            {
                var nav = new Config().ReturnNav();
                var riskMngt = nav.managementPlans.Where(r => r.Document_Type == "Functional (Department)");
                funcionalworkplan.DataSource = riskMngt;
                funcionalworkplan.DataTextField = "Description";
                funcionalworkplan.DataValueField = "Document_No";
                funcionalworkplan.DataBind();
            }
            else if (docType == "4")
            {
                var nav = new Config().ReturnNav();
                var riskMngt = nav.managementPlans.Where(r => r.Document_Type == "Project");
                funcionalworkplan.DataSource = riskMngt;
                funcionalworkplan.DataTextField = "Description";
                funcionalworkplan.DataValueField = "Document_No";
                funcionalworkplan.DataBind();
            }

        }

        protected void funcionalworkplan_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            
            string docType = strategicplanno.SelectedValue.Trim();
            
             
               
            if (docType == "1")
            {
               
                var riskMngt = nav.ManagementPlanLines.Where(r => r.Document_Type == "Corporate");
                annualreportingcode.DataSource = riskMngt;
                annualreportingcode.DataTextField = "Risk_Title";
                annualreportingcode.DataValueField = "Document_No";
                annualreportingcode.DataBind();
            }
            else if (docType == "2")
            {
                
                var riskMngt = nav.ManagementPlanLines.Where(r => r.Document_Type == "Functional (Directorate)");
                annualreportingcode.DataSource = riskMngt;
                annualreportingcode.DataTextField = "Risk_Title";
                annualreportingcode.DataValueField = "Document_No";
                annualreportingcode.DataBind();
            }
            else if (docType == "3")
            {
                
                var riskMngt = nav.ManagementPlanLines.Where(r => r.Document_Type == "Functional (Department)");
                annualreportingcode.DataSource = riskMngt;
                annualreportingcode.DataTextField = "Risk_Title";
                annualreportingcode.DataValueField = "Document_No";
                annualreportingcode.DataBind();
            }
            else if (docType == "4")
            {
                var riskMngt = nav.ManagementPlanLines.Where(r => r.Document_Type == "Project");
                annualreportingcode.DataSource = riskMngt;
                annualreportingcode.DataTextField = "Risk_Title";
                annualreportingcode.DataValueField = "Document_No";
                annualreportingcode.DataBind();
            }


        }
    }
}