﻿using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class StoreRequisition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 8;
            var nav = new Config().ReturnNav();
            if (!IsPostBack)
            {
                var locations = nav.Locations;
                location.DataSource = locations;
                location.DataTextField = "Name";
                location.DataValueField = "Code";
                location.DataBind();

                var allFundCodes = nav.FundCode;
                fundCode.DataSource = allFundCodes;
                fundCode.DataTextField = "Name";
                fundCode.DataValueField = "Code";
                fundCode.DataBind();

                
                var br = nav.branchcode;
                branch.DataSource = br;
                branch.DataTextField = "Name";
                branch.DataValueField = "Code";
                branch.DataBind();


                var jobs = nav.jobs.ToList().OrderBy(r => r.Description);
                List<Employee> allJobs = new List<Employee>();
                foreach (var myJob in jobs)
                {
                    Employee employee = new Employee();
                    employee.EmployeeNo = myJob.No;
                    employee.EmployeeName = myJob.No + " - " + myJob.Description;
                    allJobs.Add(employee);
                }
                job.DataSource = allJobs;
                job.DataValueField = "EmployeeNo";
                job.DataTextField = "EmployeeName";
                job.DataBind();
                LoadJobTasks();
                try
                {
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    if (!String.IsNullOrEmpty(requisitionNo))
                    {
                        Boolean exists = false;
                        var requsition =
                            nav.PurchaseHeader.Where(
                                r =>
                                    (r.Document_Type == "Purchase Requisition" || r.Document_Type == "Store Requisition") && r.No == requisitionNo && r.Request_By_No == Convert.ToString(Session["employeeNo"]));
                        foreach (var myRequisition in requsition)
                        {
                            exists = true;
                            fundCode.SelectedValue = myRequisition.Shortcut_Dimension_2_Code;
                            location.SelectedValue = myRequisition.Location_Code;
                            description.Text = myRequisition.Description;
                            job.SelectedValue = myRequisition.Job;
                            branch.SelectedValue = myRequisition.Shortcut_Dimension_1_Code;
                            LoadJobTasks();
                            //jobTaskno.SelectedValue = myRequisition.Job_Task_No;
                        }
                        if (!exists)
                        {
                            Response.Redirect("StoreRequisition.aspx");
                        }
                    }
                }
                catch (Exception)
                {

                }
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
                if (step == 2)
                {

                    var itemCategories = nav.ItemCategories;
                    

                    itemCategory.DataSource = itemCategories;
                    itemCategory.DataValueField = "Code";
                    itemCategory.DataTextField = "Description";
                    itemCategory.DataBind();
                    LoadItems();

                }
            }
        }
        protected void job_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadJobTasks();
        }

        protected void LoadJobTasks()
        {
            //var nav = new Config().ReturnNav();
            //var myJob = job.SelectedValue;
            //var jobTasks = nav.JobTask.Where(r => r.Job_No == myJob);
            //jobTaskno.DataSource = jobTasks;
            //jobTaskno.DataValueField = "Job_Task_No";
            //jobTaskno.DataTextField = "Description";
            //jobTaskno.DataBind();
        }
        protected void next_Click(object sender, EventArgs e)
        {
            try
            {

                String requisitionNo = "";
                Boolean newRequisition = false;
                try
                {
                    requisitionNo = Request.QueryString["requisitionNo"];
                    if (String.IsNullOrEmpty(requisitionNo))
                    {
                        requisitionNo = "";
                        newRequisition = true;
                    }
                }
                catch (Exception)
                {
                    newRequisition = true;
                    requisitionNo = "";
                }
                String tLocation = String.IsNullOrEmpty(location.SelectedValue.Trim()) ? "" : location.SelectedValue.Trim();
                String tFundCode = String.IsNullOrEmpty(fundCode.SelectedValue.Trim()) ? "" : fundCode.SelectedValue.Trim();
                String tbranch = String.IsNullOrEmpty(branch.SelectedValue.Trim()) ? "" : branch.SelectedValue.Trim();
                String tJob = String.IsNullOrEmpty(job.SelectedValue.Trim()) ? "" : job.SelectedValue.Trim();
               // String tJobTask = String.IsNullOrEmpty(jobTaskno.SelectedValue.Trim()) ? "" : jobTaskno.SelectedValue.Trim();
                String tDescription = String.IsNullOrEmpty(description.Text.Trim()) ? "" : description.Text.Trim();
                Session["location"] = tLocation;
                String status = Config.ObjNav.CreatePurchaseStoreRequisition(Convert.ToString(Session["employeeNo"]), requisitionNo, tLocation, tDescription, 1, tFundCode,tbranch, tJob, "");
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newRequisition)
                    {
                        requisitionNo = info[2];
                    }
                    String redirectLocation = "StoreRequisition.aspx?step=2&&requisitionNo=" + requisitionNo;
                    Response.Redirect(redirectLocation);

                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("StoreRequisition.aspx?step=1&&requisitionNo=" + requisitionNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["requisitionNo"];
                // Convert.ToString(Session["employeeNo"]),
                String status = Config.ObjNav.SendStoreRequisitionApproval(Convert.ToString(Session["employeeNo"]),
                    requisitionNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

       
        protected void LoadItems()
        {
            try
            {
                var nav = new Config().ReturnNav();
                String postingGroup = itemCategory.SelectedValue;
                var items = nav.Items.Where(r => r.Item_Category_Code == postingGroup);
                //var items = nav.ProductsPerRegion.Where(x=>x.Item_Category_Code == postingGroup && x.Location_Filter == Session["location"].ToString());
      

                item.DataSource = items;
                item.DataValueField = "No";
                item.DataTextField = "Description";
                item.DataBind();
            }
            catch (Exception)
            {

            }
        }

        protected void itemCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadItems();
        }

       

        protected void deleteLine_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String employeeName = Convert.ToString(Session["employeeNo"]);
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    String status = Config.ObjNav.DeleteRequisitionLine(employeeName, requisitionNo, tLineNo, 6);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void addItem_Click(object sender, EventArgs e)
        {
            try
            {
              
                String tItemCategory = String.IsNullOrEmpty(itemCategory.SelectedValue.Trim())
                    ? ""
                    : itemCategory.SelectedValue.Trim();
                String tItem = String.IsNullOrEmpty(item.SelectedValue.Trim()) ? "" : item.SelectedValue.Trim();
                String tQuantity = String.IsNullOrEmpty(quantityRequested.Text.Trim())
                    ? ""
                    : quantityRequested.Text.Trim();
                Decimal nQuantity = 0;
                Boolean error = false;
                try
                {
                    nQuantity = Convert.ToDecimal(tQuantity);
                }
                catch (Exception)
                {
                    error = true;
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>Please enter a correct value for quantity<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                
                if (!error)
                {
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    String status = Config.ObjNav.CreateStoreRequisitionLine(Convert.ToString(Session["employeeNo"]),
                        requisitionNo,
                         tItemCategory, tItem, nQuantity);
                    String[] info = status.Split('*');
                    //try adding the line
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            bool fileuploadSuccess = false;
            string sUrl = ConfigurationManager.AppSettings["S_URL"];
            string defaultlibraryname = "ERP%20Documents/";
            string customlibraryname = "Kasneb/Store Requisitions";
            string sharepointLibrary = defaultlibraryname + customlibraryname;
            String leaveNo = Request.QueryString["requisitionNo"];

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

                    var sDocName = UploadStoreRequisition(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                    string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                    if (!string.IsNullOrEmpty(sDocName))
                    {
                        var status = Config.ObjNav.AddStoreRequsitionSharepointLinks(leaveNo, uploadfilename, sharepointlink);
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
                                "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }




            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Non-Project Store Requisition/";
            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Store Requisition/";

            //if (document.HasFile)
            //{
            //    try
            //    {
            //        if (Directory.Exists(filesFolder))
            //        {
            //            String extension = System.IO.Path.GetExtension(document.FileName);
            //            if (new Config().IsAllowedExtension(extension))
            //            {
            //                String imprestNo = Request.QueryString["requisitionNo"];

            //                String documentDirectory = filesFolder + imprestNo + "/";
            //                Boolean createDirectory = true;
            //                try
            //                {
            //                    if (!Directory.Exists(documentDirectory))
            //                    {
            //                        Directory.CreateDirectory(documentDirectory);
            //                    }
            //                }
            //                catch (Exception)
            //                {
            //                    createDirectory = false;
            //                    documentsfeedback.InnerHtml =
            //                                                    "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
            //                                                    "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //                }
            //                if (createDirectory)
            //                {
            //                    string filename = documentDirectory + document.FileName;
            //                    if (File.Exists(filename))
            //                    {
            //                        documentsfeedback.InnerHtml =
            //                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //                    }
            //                    else
            //                    {
            //                        document.SaveAs(filename);
            //                        if (File.Exists(filename))
            //                        {
            //                            Config.navExtender.AddLinkToRecord("Store Requisition", imprestNo, filename, "");
            //                            documentsfeedback.InnerHtml =
            //                                "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                        }
            //                        else
            //                        {
            //                            documentsfeedback.InnerHtml =
            //                                "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                        }
            //                    }
            //                }
            //            }
            //            else
            //            {
            //                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //            }

            //        }
            //        else
            //        {
            //            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }

            //    }
            //    catch (Exception ex)
            //    {
            //        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    }
            //}
            //else
            //{
            //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            //}


        }


        public string UploadStoreRequisition(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {

            string sDocName = string.Empty;
            leaveNo = Request.QueryString["requisitionNo"];

            string parent_folderName = "Kasneb/Store Requisitions";
            string subFolderName = leaveNo;
            string filelocation = sLibraryName + "/" + subFolderName;
            try
            {
                // if a folder doesn't exists, create it
                var listTitle = "ERP Documents";
                if (!FolderExists(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName))
                    // CreateFolder(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName);
                    CreateFolder(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName);

                if (Config.SPWeb != null)
                {
                    var sFileUrl = string.Format("{0}/{1}/{2}", sSpSiteRelativeUrl, filelocation, sFileName);
                    Microsoft.SharePoint.Client.File.SaveBinaryDirect(Config.SPClientContext, sFileUrl, fs, true);
                    Config.SPClientContext.ExecuteQuery();
                    sDocName = sFileName;
                }
            }

            catch (Exception ex)
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
                    var parentFolderName = @"ERP%20Documents/Kasneb/Store Requisitions/";
                    var leaveNo = Request.QueryString["requisitionNo"];

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


        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("StoreRequisition.aspx?step=3&&requisitionNo=" + requisitionNo);
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("StoreRequisition.aspx?step=2&&requisitionNo=" + requisitionNo);
        }

        protected void item_SelectedIndexChanged(object sender, EventArgs e)
        {

            UpdateCity();
        }

        public void UpdateCity()
        {
            var nav = new Config().ReturnNav();
            var cities = nav.Items.Where(r => r.No == item.SelectedValue);
            foreach (var myCity in cities)
            {
                
                baseUnits.Text = myCity.Base_Unit_of_Measure;
            }
        }

    }
}