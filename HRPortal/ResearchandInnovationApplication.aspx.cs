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
    public partial class ResearchandInnovationApplication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var today = DateTime.Today;
                var innovations = nav.InnovationSolicitation.Where(r => r.Document_Type == "Innovation Invitation" && r.Status == "Released" && r.Idea_Submission_End_Date >= today);
                foreach (var innovation in innovations)
                {
                    noticeNo.Text = innovation.Document_No;
                    category.Text = innovation.Innovation_Category;

                }

                var appNo = Request.QueryString["InnovationIdea"];
                //var empNo = Session["employeeNo"].ToString();
                var innovationResponsess = nav.InnovationSolicitation.Where(r => r.Document_Type == "Idea Response" && r.Document_No == appNo && r.Status == "Open" && r.Portal_Status == "Draft");
                foreach (var innovationResp in innovationResponsess)
                {
                    noticeNo.Text = innovationResp.Invitation_ID;
                    category.Text = innovationResp.Innovation_Category;
                    department.Text = innovationResp.Department_ID;
                    innovationDescription.Text = innovationResp.Description;
                    executiveSummery.Text = innovationResp.Executive_Summary;
                }

                var ResponsibilityCenter = nav.ResponsibilityCenters.Where(r => r.Operating_Unit_Type == "Department/Center");
                department.DataSource = ResponsibilityCenter;
                department.DataTextField = "Code";
                department.DataValueField = "Code";
                department.DataBind();
                department.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                //innovationOverviewIdea.Text = Convert.ToString(Session["applicationNo"]);
                innovationOverviewIdea.Text = Request.QueryString["applicationNo"];
                innovationCategory.Text = Request.QueryString["applicationNo"];
                ObjectiveNo.Text = Request.QueryString["applicationNo"];
                innovationObjective.Text = Request.QueryString["applicationNo"];
                additionNo.Text = Request.QueryString["applicationNo"];






            }
        }

        protected void save_Click(object sender, EventArgs e)
        {
            try
            {




                string tinnovationNo = noticeNo.Text.Trim();
                string tcategory = category.Text.Trim();
                string tdepartment = department.SelectedValue.Trim();
                string tdescription = innovationDescription.Text.Trim();
                string texecutivesummery = executiveSummery.Text.Trim();
                string empNo = Convert.ToString(Session["employeeNo"]);


                Boolean error = false;
                String message = "";

                if (string.IsNullOrEmpty(tdepartment))
                {
                    error = true;
                    message = "Please select Department";
                }

                if (string.IsNullOrEmpty(tdescription))
                {
                    error = true;
                    message = "Please Enter Description";
                }
                if (string.IsNullOrEmpty(texecutivesummery))
                {
                    error = true;
                    message = "Please provide an executive summery of your idea";
                }


                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    String applicationNo = "";
                    Boolean newapplicationNo = false;
                    try
                    {

                        applicationNo = Request.QueryString["InnovationIdea"];
                        if (String.IsNullOrEmpty(applicationNo))
                        {
                            applicationNo = "";
                            newapplicationNo = true;

                        }
                    }
                    catch (Exception)
                    {

                        applicationNo = "";
                        newapplicationNo = true;
                    }

                    string response = Config.ObjNav.FnAddInnovationResponse(applicationNo, tinnovationNo, tcategory, tdepartment, tdescription, texecutivesummery, empNo);

                    String[] info = response.Split('*');
                    if (info[0] == "success")
                    {
                        if (newapplicationNo)
                        {
                            applicationNo = info[2];
                            Session["applicationNo"] = applicationNo;


                        }

                        //string feedback = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        //string url = "ResearchandInnovationApplication.aspx?ideaNo=" + applicationNo;
                        //string script = "window.onload = function(){ alert('";
                        //script += feedback;
                        //script += "');";
                        //script += "window.location = '";
                        //script += url;
                        //script += "'; }";
                        //ClientScript.RegisterStartupScript(this.GetType(), "Redirect", script, true);
                        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Your Innovation General Ideas have been captured successfully');window.location='ResearchandInnovationApplication.aspx?ideaNo=';", true);

                        generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("ResearchandInnovationApplication.aspx?step=2&&applicationNo=" + applicationNo);

                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }




        }


        protected void submitOverview_Click(object sender, EventArgs e)
        {
            try
            {
                String tapplicationNo = innovationOverviewIdea.Text.Trim();
                string empNo = Convert.ToString(Session["employeeNo"]);
                string tdescription = overviewDescription.Text.Trim();
                Boolean error = false;
                String message = "";

                if (string.IsNullOrEmpty(tdescription))
                {
                    error = true;
                    message = "Please provide an overview of your idea";
                }

                String status = Config.ObjNav.FnAddInnovationResponseLines(tapplicationNo, tdescription, empNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    overviewFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    overviewFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                overviewFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }


        protected void previousstep_Click(object sender, EventArgs e)
        {
            int num1;
            string str;
            try
            {
                num1 = Convert.ToInt32(Request.QueryString["step"].Trim());
                str = Request.QueryString["applicationNo"].Trim();

            }
            catch (Exception ex)
            {
                num1 = 0;
                str = "";
            }
            int num2 = num1 - 1;
            Response.Redirect("ResearchandInnovationApplication.aspx?applicationNo=" + str + "&step=" + num2);
        }
        protected void nextstep_Click(object sender, EventArgs e)
        {
            int num1;
            string str;
            try
            {
                num1 = Convert.ToInt32(Request.QueryString["step"].Trim());
                str = Request.QueryString["applicationNo"].Trim();

            }
            catch (Exception ex)
            {
                num1 = 0;
                str = "";
            }
            int num2 = num1 + 1;
            Response.Redirect("ResearchandInnovationApplication.aspx?applicationNo=" + str + "&step=" + num2);
        }

        protected void submitIdea_Click(object sender, EventArgs e)
        {
            try
            {
                string tapplicationNo = Request.QueryString["applicationNo"];
                String status = Config.ObjNav.FnSubmitResponse(tapplicationNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    submitFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    submitFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                submitFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void objectives_Click(object sender, EventArgs e)
        {
            try
            {
                String tapplicationNo = ObjectiveNo.Text.Trim();
                string empNo = Convert.ToString(Session["employeeNo"]);
                string tdescription = Objectivedescription.Text.Trim();
                Boolean error = false;
                String message = "";

                if (string.IsNullOrEmpty(tdescription))
                {
                    error = true;
                    message = "Please provide an overview of your idea";
                }

                String status = Config.ObjNav.FnAddInnovationObjectiveResponseLines(tapplicationNo, tdescription, empNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    ObjectivesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    ObjectivesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception t)
            {
                ObjectivesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void additionalNotes_Click(object sender, EventArgs e)
        {
            try
            {
                String tapplicationNo = additionNo.Text.Trim();
                string empNo = Convert.ToString(Session["employeeNo"]);
                string tdescription = InnovationAddition.Text.Trim();
                Boolean error = false;
                String message = "";

                if (string.IsNullOrEmpty(tdescription))
                {
                    error = true;
                    message = "Please provide an overview of your idea";
                }

                String status = Config.ObjNav.FnAddInnovationAdditionalResponseLines(tapplicationNo, tdescription, empNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void editOverview_Click(object sender, EventArgs e)
        {
            try
            {
                String tdocumentNo = documenttype.Text;
                String tdescription = editDescription.Text;
                string empNo = Convert.ToString(Session["employeeNo"]);
                int tLineNo = Convert.ToInt32(lineNo.Text);
                Boolean error = false;
                String message = "";

                if (String.IsNullOrEmpty(tdescription))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter Description";
                }


                if (error)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    String status = Config.ObjNav.EditInnovationOverview(tdocumentNo, tdescription, empNo, tLineNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }

            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }


        protected void removeOverview_Click(object sender, EventArgs e)
        {
            try
            {
                String tapplicationNo = removeFuelNumber.Text.Trim();
                int tLineNo = Convert.ToInt32(lineNumber.Text.Trim());
                String mEmployeeNo = Convert.ToString(Session["employeeNo"]);
                String status = Config.ObjNav.DeleteInnovationResponseLine(mEmployeeNo, tapplicationNo, tLineNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            bool fileuploadSuccess = false;
            string sUrl = ConfigurationManager.AppSettings["S_URL"];
            string defaultlibraryname = "ERP%20Documents/";
            string customlibraryname = "Kasneb/Imprest Memo";
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

                    var sDocName = UploadImprest(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                    string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                    if (!string.IsNullOrEmpty(sDocName))
                    {
                        var status = Config.ObjNav.AddImprestSharepointLinks(leaveNo, uploadfilename, sharepointlink);
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
            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"]+ "Imprest Memo/";
            ////String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Staff Claim/";

            //if (document.HasFile)
            //{
            //    try
            //    {
            //        if (Directory.Exists(filesFolder))
            //        {
            //            String extension = System.IO.Path.GetExtension(document.FileName);
            //            if (new Config().IsAllowedExtension(extension))
            //            {
            //                String imprestNo = Request.QueryString["imprestNo"];
            //                string imprest = imprestNo;
            //                imprestNo = imprestNo.Replace('/', '_');
            //                imprestNo = imprestNo.Replace(':', '_');
            //                String documentDirectory = filesFolder + imprestNo+"/";
            //                Boolean createDirectory = true;
            //                try
            //                {
            //                    if (!Directory.Exists(documentDirectory))
            //                    {
            //                        Directory.CreateDirectory(documentDirectory);
            //                    }
            //                }
            //                catch (Exception ex)
            //                {
            //                    createDirectory = false;
            //                    documentsfeedback.InnerHtml =
            //                                                    "<div class='alert alert-danger'>'"+ex.Message+"'. Please try again" +
            //                                                    "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                    //We could not create a directory for your documents
            //                }
            //                if (createDirectory)
            //                {
            //                string filename = documentDirectory + document.FileName;
            //                if (File.Exists(filename))
            //                {
            //                    documentsfeedback.InnerHtml =
            //                                                       "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //                }
            //                else
            //                {
            //                    document.SaveAs(filename);
            //                    if (File.Exists(filename))
            //                    {

            //                            //Config.navExtender.AddLinkToRecord("Imprest Memo", imprestNo, filename, "");
            //                            Config.navExtender.AddLinkToRecord("Imprest Memo",imprest, filename, "");
            //                            documentsfeedback.InnerHtml =
            //                            "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                    }
            //                    else
            //                    {
            //                        documentsfeedback.InnerHtml =
            //                            "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                    }
            //                }
            //            }
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
            //        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'"+ex.Message+"'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        //The document could not be uploaded
            //    }
            //}
            //else
            //{
            //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            //}


        }

        public string UploadImprest(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            leaveNo = Request.QueryString["imprestNo"];

            string parent_folderName = "Kasneb/Imprest Memo";
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
                    var parentFolderName = @"ERP%20Documents/Kasneb/Imprest Memo/";
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
    }
}