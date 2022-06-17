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
    public partial class leaveapplication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 2;
            
           
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var leaveTypes = nav.LeaveTypes;
                leaveType.DataSource = leaveTypes;
                leaveType.DataValueField = "Code";
                leaveType.DataTextField = "Description";
                leaveType.DataBind();
                String leaveNo = "";
                try
                {
                    leaveNo = Request.QueryString["leaveno"];
                    }
                catch (Exception)
                {
                    
                }
                if (!String.IsNullOrEmpty(leaveNo))
                {
                    //check exists
                    Boolean exists = false;
                    var leaves = nav.LeaveApplications.Where(r => r.Employee_No == (String)Session["employeeNo"]&&r.Application_Code== leaveNo);
                    foreach (var leave in leaves)
                    {
                        exists = true;
                        leaveType.SelectedValue = leave.Leave_Type;
                        daysApplied.Text = leave.Days_Applied.ToString();
                        String myDate = Convert.ToDateTime(leave.Start_Date).ToString("dd/MM/yyyy"); //dd/mm/yyyy
                        myDate = myDate.Replace("-", "/");
                        leaveStartDate.Text = myDate;
                        phoneNumber.Text = leave.Cell_Phone_Number;
                        emailAddress.Text = leave.E_mail_Address;
                        examDetails.Text = leave.Details_of_Examination;
                        String examDate = Convert.ToDateTime(leave.Date_of_Exam).ToString("dd/MM/yyyy"); //dd/mm/yyyy
                        examDate = myDate.Replace("-", "/");
                        dateOfExam.Text = examDate;
                        previousAttempts.Text = leave.Number_of_Previous_Attempts.ToString();
                       // Reliever.SelectedValue = leave.Reliever;
                    }

                    if (!exists)
                    {
                      Response.Redirect("leaveapplication.aspx");  
                    }
                }
                
                string departmentCode = Convert.ToString(Session["DepartmentCode"]);
                var employees = nav.Employees.Where(r => r.Status == "Active" && r.Department_Code == departmentCode).ToList();
                List<Employee> RelieverList = new List<Employee>();
                foreach (var employee in employees)
                {
                    Employee list1 = new Employee();
                    list1.EmployeeNo = employee.No;
                    list1.EmployeeName = employee.First_Name +" "+ employee.Middle_Name +" "+ employee.Last_Name;
                    RelieverList.Add(list1);
                }

                Reliever.DataSource = RelieverList;
                Reliever.DataTextField = "EmployeeName";
                Reliever.DataValueField = "EmployeeNo";
                Reliever.DataBind();
                Reliever.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));



            }
        }
        protected void apply_Click(object sender, EventArgs e)
        {
            String tLeaveType = leaveType.SelectedValue;
            String mAnnualLeaveType = annualLeaveType.SelectedValue;
            String tDaysApplied = daysApplied.Text.Trim();
            String tLeaveStartDate = leaveStartDate.Text.Trim();
            String tPhoneNumber = phoneNumber.Text.Trim();
            String tEmailAddress = emailAddress.Text.Trim();
            String tExamDetails = examDetails.Text.Trim();
            String tDateOfExam = dateOfExam.Text.Trim();
            String tPreviousAttempts = previousAttempts.Text.Trim();
            String tReliever = Reliever.SelectedValue;

            if(tLeaveType != "ANNUAL")
            {
                //mAnnualLeaveType.hi
                annualLeaveType.Visible = false;

            }
          
            Boolean error = false;
            string message = "";
            int dApplied = 0, pAttempts = 0;
            DateTime lStartDate = new DateTime(),
            dOfExam = new DateTime();
           
                //if (String.IsNullOrEmpty(tReliever))
                //{
                //    error = true;
                //    message = "Please select you Reliever during your leave days";
                //}

           
            try
            {
                dApplied = Convert.ToInt32(tDaysApplied);
                if (dApplied < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid number of days applied<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            try
            {
                if (!String.IsNullOrEmpty(tPreviousAttempts))
                {
                    pAttempts = Convert.ToInt32(tPreviousAttempts);
                }
            }
            catch (Exception)
            {
                error = true;
                feedback.InnerHtml =
                    "<div class='alert alert-danger'>Please provide a valid number of previous attempts<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            try
            {
                CultureInfo culture = new CultureInfo("ru-RU");
                lStartDate = DateTime.ParseExact(tLeaveStartDate, "d/M/yyyy", CultureInfo.InvariantCulture);

            }
            catch (Exception)
            {
                error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid leave start date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            try
            {
                if (!String.IsNullOrEmpty(tDateOfExam))
                {
                    CultureInfo culture = new CultureInfo("ru-RU");
                    dOfExam = DateTime.ParseExact(tDateOfExam, "d/M/yyyy", CultureInfo.InvariantCulture);
                }

            }
            catch (Exception)
            {
                error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid exam date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            if (error == true)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + message+ "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

          else
            {
                //apply for leave
                try
                {
                    String myLeaveNo = "";
                    try
                    {
                        myLeaveNo = Request.QueryString["leaveno"];
                        myLeaveNo = String.IsNullOrEmpty(myLeaveNo) ? "" : myLeaveNo;
                    }
                    catch (Exception)
                    {
                        myLeaveNo = "";
                    }
                    if(tLeaveType == "ANNUAL")
                    {
                        String status = Config.ObjNav.LeaveApplication(myLeaveNo, (String)Session["employeeNo"], tLeaveType, Convert.ToInt32(mAnnualLeaveType), dApplied,
                         lStartDate, tPhoneNumber, tEmailAddress, tExamDetails, dOfExam, pAttempts,tReliever);
                        String[] info = status.Split('*');
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        if (info[0] == "success")
                        {
                            String leaveNo = info[2];
                            Response.Redirect("leaveapplication.aspx?leaveno=" + leaveNo + "&step=2");
                        }
                    }
                    else
                    {
                        int annual_leave_type = 0;
                        String status = Config.ObjNav.LeaveApplication(myLeaveNo, (String)Session["employeeNo"], tLeaveType, annual_leave_type, dApplied,
                         lStartDate, tPhoneNumber, tEmailAddress, tExamDetails, dOfExam, pAttempts,tReliever);
                        String[] info = status.Split('*');
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        if (info[0] == "success")
                        {
                            String leaveNo = info[2];
                            
                            Response.Redirect("leaveapplication.aspx?leaveno=" + leaveNo + "&step=2&leavetype="+tLeaveType);
                        }

                    }
                    
                }
                catch (Exception t)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String leaveNo = Request.QueryString["leaveno"];
                String tLeaveNo = leaveNo;
                String status = Config.ObjNav.SendRecordForApproval((String)Session["employeeNo"], tLeaveNo, "leave");
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            bool fileuploadSuccess = false;
            string sUrl = ConfigurationManager.AppSettings["S_URL"];
            string defaultlibraryname = "ERP%20Documents/";
            string customlibraryname = "Kasneb/Leave Application";
            string sharepointLibrary = defaultlibraryname + customlibraryname;
            String leaveNo = Request.QueryString["leaveNo"];

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

                    var sDocName = UploadLeave(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                    string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                    if (!string.IsNullOrEmpty(sDocName))
                    {
                        var status = Config.ObjNav.AddLeaveSharepointLinks(leaveNo, uploadfilename, sharepointlink);
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


                }
                else
                {
                    documentsfeedback.InnerHtml =
                               "<div class='alert alert-danger'>Sorry, There was an Issue on Uploading the Attachment to the Electronic Documents Managament System.Contact ICT for More Information <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml =
                                "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Leave Application Card/";

            //if (document.HasFile)
            //{
            //    try
            //    {
            //        if (Directory.Exists(filesFolder))
            //        {
            //            String extension = System.IO.Path.GetExtension(document.FileName);
            //            if (new Config().IsAllowedExtension(extension))
            //            {
            //                String imprestNo = Request.QueryString["leaveNo"];
            //                imprestNo = imprestNo.Replace('/', '_');
            //                imprestNo = imprestNo.Replace(':', '_');
            //                String documentDirectory = filesFolder + imprestNo + "/";
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
            //                                                "<div class='alert alert-danger'>'"+ex.Message+"'. Please try again" +
            //                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                    //We could not create a directory for your documents

            //                }
            //                if (createDirectory)
            //                {
            //                    string filename = documentDirectory + document.FileName;
            //                    if (System.IO.File.Exists(filename))
            //                    {
            //                        documentsfeedback.InnerHtml =
            //                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //                    }
            //                    else
            //                    {
            //                        document.SaveAs(filename); 
            //                        if (System.IO.File.Exists(filename))
            //                        {
            //                            Config.navExtender.AddLinkToRecord("Leave Application Card", imprestNo, filename, "");
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
            //        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'"+ex.Message+"'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        //The document could not be uploaded
            //    }
            //}
            //else
            //{
            //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            //}


        }

        public string UploadLeave(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            leaveNo = Request.QueryString["leaveNo"];

            string parent_folderName = "Kasneb/Leave Application";
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
            var sharepointUrl = ConfigurationManager.AppSettings["S_URL"];

            try
            {
                using (ClientContext ctx = new ClientContext(sharepointUrl))
                {

                    string password = ConfigurationManager.AppSettings["S_PWD"];
                    string account = ConfigurationManager.AppSettings["S_USERNAME"];
                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                    var secret = new SecureString();
                    var parentFolderName = @"ERP%20Documents/Kasneb/Leave Application/";
                    var leaveNo = Request.QueryString["leaveNo"];

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

            //try
            //{
            //    String tFileName = fileName.Text.Trim();
            //    String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Staff Claim/";
            //    String imprestNo = Request.QueryString["claimNo"];
            //    imprestNo = imprestNo.Replace('/', '_');
            //    imprestNo = imprestNo.Replace(':', '_');
            //    String documentDirectory = filesFolder + imprestNo + "/";
            //    String myFile = documentDirectory + tFileName;
            //    if (File.Exists(myFile))
            //    {
            //        File.Delete(myFile);
            //        if (File.Exists(myFile))
            //        {
            //            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }
            //        else
            //        {
            //            documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }
            //    }
            //    else
            //    {
            //        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //    }



            //}
            //catch (Exception m)
            //{
            //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //}

            //removeNumber
            //removeWorkType



        }
        //protected void deleteFile_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        String tFileName = fileName.Text.Trim();
        //        String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Leave Application Card/";
        //        String imprestNo = Request.QueryString["leaveNo"];
        //        imprestNo = imprestNo.Replace('/', '_');
        //        imprestNo = imprestNo.Replace(':', '_');
        //        String documentDirectory = filesFolder + imprestNo + "/";
        //        String myFile = documentDirectory + tFileName;
        //        if (System.IO.File.Exists(myFile))
        //        {
        //            System.IO.File.Delete(myFile);
        //            if (System.IO.File.Exists(myFile))
        //            {
        //                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //            else
        //            {
        //                documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //        }
        //        else
        //        {
        //            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }



        //    }
        //    catch (Exception m)
        //    {
        //        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //    }

        //    //removeNumber
        //    //removeWorkType



        //}

        protected void Unnamed10_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["leaveno"];
            Response.Redirect("leaveapplication.aspx?step=1&&leaveno=" + imprestNo);
        }

        protected void leaveType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(leaveType.SelectedValue =="ANNUAL")
            {
                annualLeaveType.Visible = true;
            }
            else
            {
                annualLeaveType.Visible = false;
            }

            if (leaveType.SelectedValue == "STUDY")
            {
                examDetails.Visible = true;
                dateOfExam.Visible = true;
                previousAttempts.Visible = true;
                attempts.Visible = true;
                examDate.Visible = true;
                examDetail.Visible = true;


            }
            else
            {
                examDetails.Visible = false;
                dateOfExam.Visible = false;
                previousAttempts.Visible = false;

                attempts.Visible = false;
                examDate.Visible = false;
                examDetail.Visible = false;

            }

            if(leaveType.SelectedValue == "OFF_DAY")
            {
                var nav = new Config().ReturnNav();
                var employees = nav.Employees.Where(r => r.No == (String)Session["employeeNo"]);
                foreach (var employee in employees)
                {
                    if(employee.Annual_Leave_Account>15)
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>Kindly utilize you Annual leave days instead <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
             }
            if (leaveType.SelectedValue == "COMPASSIONATE")
            {
                var nav = new Config().ReturnNav();
                var employees = nav.Employees.Where(r => r.No == (String)Session["employeeNo"]);
                foreach (var employee in employees)
                {
                    if (employee.Annual_Leave_Account > 0)
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>Kindly utilize you Annual leave days instead<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }



        }

        protected void downloadFile_Click(object sender, EventArgs e)
        {
            var fileName = fileName1.Text;
            var sharepointUrl = ConfigurationManager.AppSettings["S_URL"];
           var localTempLocation = @"C:\";
            var filePath = "";
            try
            {
                using (ClientContext ctx = new ClientContext(sharepointUrl))
                {

                    string password = ConfigurationManager.AppSettings["S_PWD"];
                    string account = ConfigurationManager.AppSettings["S_USERNAME"];
                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                    var secret = new SecureString();
                    var parentFolderName = @"KASNEB%20ESS/KASNEB/Leave Application/";
                    var leaveNo = Request.QueryString["leaveNo"];

                    foreach (char c in password)
                    { secret.AppendChar(c); }

                    try
                    {
                        ctx.Credentials = new NetworkCredential(account, secret, domainname);
                        ctx.Load(ctx.Web);
                        ctx.ExecuteQuery();

                        Uri uri = new Uri(sharepointUrl);
                        string sSpSiteRelativeUrl = uri.AbsolutePath;

                        // string filePath1 = sSpSiteRelativeUrl + parentFolderName + leaveNo + "/" + fileName1.Text;
                        string filePath1 = sSpSiteRelativeUrl + parentFolderName + leaveNo + "/";
                        //var files = ctx.Web.GetFileByServerRelativeUrl(filePath);

                      

                        FileCollection files = ctx.Web.GetFolderByServerRelativeUrl(filePath1).Files;
                       


                        ctx.Load(files);
                        if (ctx.HasPendingRequest)
                        {
                            ctx.ExecuteQuery();
                        }
                        foreach (Microsoft.SharePoint.Client.File file in files)
                        {
                            FileInformation fileInfo = Microsoft.SharePoint.Client.File.OpenBinaryDirect(ctx, file.ServerRelativeUrl);
                            ctx.ExecuteQuery();

                             filePath = localTempLocation + "\\" + file.Name;
                            System.IO.FileStream fileStream = new System.IO.FileStream(filePath, System.IO.FileMode.OpenOrCreate, System.IO.FileAccess.ReadWrite, System.IO.FileShare.ReadWrite);

                            fileInfo.Stream.CopyTo(fileStream);

                        }

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
        public static byte[] DownloadFile(ClientContext ctx, string fileUrl)
        {
            var fileInfo = Microsoft.SharePoint.Client.File.OpenBinaryDirect(ctx, fileUrl);
            using (var ms = new MemoryStream())
            {
                fileInfo.Stream.CopyTo(ms);
                return ms.ToArray();
            }
        }
    }
}