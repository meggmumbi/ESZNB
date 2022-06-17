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
    public partial class FleetRequisition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 10;
            if (!IsPostBack)
            {
               List<String> hours = new List<string>();
                for (int i = 1; i < 13; i++)
                {
                    hours.Add(i+"");
                }
                List<String> minutes = new List<string>();
                for (int i = 0; i < 60; i++)
                {
                    minutes.Add(i+"");
                }
                List<String> amAndPm = new List<string>();
                amAndPm.Add("AM");
                amAndPm.Add("PM");
                hour.DataSource = hours;
                hour.DataBind();
                minute.DataSource = minutes;
                minute.DataBind();
                amPM.DataSource = amAndPm;
                amPM.DataBind();
                var nav = new Config().ReturnNav();
                var employees = nav.Employees;
                List<Employee> allEmployees = new List<Employee>();
                foreach (var eachEmployee in employees)
                {
                    Employee emp = new Employee();
                    emp.EmployeeNo=eachEmployee.No;
                    emp.EmployeeName = eachEmployee.First_Name + " " + eachEmployee.Middle_Name + " " +
                                       eachEmployee.Last_Name;
                    allEmployees.Add(emp);
                }
                employee.DataSource = allEmployees;
                employee.DataValueField = "EmployeeNo";
                employee.DataTextField = "EmployeeName";
                employee.DataBind();


            }
            try
            {
                Boolean exists = false;
                var nav = new Config().ReturnNav();
                String requisitionNo = Request.QueryString["requisitionNo"].Trim();
                String employeeNo = Convert.ToString(Session["employeeNo"]);

                if (!String.IsNullOrEmpty(requisitionNo))
                {
                    var transportRequisitions =
                        nav.TransportRequisition.Where(r => r.Transport_Requisition_No == requisitionNo&&r.Employee_No== employeeNo);
                    foreach (var requisition in transportRequisitions)
                    {
                        exists = true;
                        if (!IsPostBack)
                        {
                            from.Text = requisition.Commencement;
                            destination.Text = requisition.Destination;
                            String myDate = Convert.ToDateTime(requisition.Date_of_Trip).ToString("dd/MM/yyyy");
                                //dd/mm/yyyy
                            myDate = myDate.Replace("-", "/");
                            dateofTrip.Text = myDate;
                            journeyRoute.Text = requisition.Journey_Route;
                            purposeOfTrip.Text = requisition.Purpose_of_Trip;
                            comments.Text = requisition.Comments;
                            noOfDays.Text = requisition.No_of_Days_Requested + "";
                            String tTimeOut = requisition.Time_out;
                            String[] nTime = tTimeOut.Split(':');
                            try
                            {
                                int mHour = Convert.ToInt32(nTime[0]);
                                int mMinute = Convert.ToInt32(nTime[1]);
                                if (mHour==0)
                                {
                                    hour.SelectedValue = "12";
                                }
                                if (mHour>11)
                                {
                                    amPM.SelectedValue = "PM";
                                    if (mHour>12)
                                    {
                                        hour.SelectedValue = (mHour-12)+"";
                                    }
                                }
                                if (mHour<=12)
                                {
                                    hour.SelectedValue =mHour + "";
                                }
                                minute.SelectedValue = mMinute + "";
                                // if 00 then its 12 Am

                            }
                            catch (Exception)
                            {
                                
                            }
                            String hourOut = hour.SelectedValue;
                            String minuteOut = minute.SelectedValue;
                            String amPMOut = amPM.SelectedValue;
                        }

                    }
                    if (!exists)
                    {
                        Response.Redirect("FleetRequisition.aspx");
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
                if (String.IsNullOrEmpty(Request.QueryString["requisitionNo"]))
                {
                    Response.Redirect("FleetRequisition.aspx");
                }
            }
            if (!IsPostBack)
            {
                try
                {
                    String reqNo = Request.QueryString["requisitionNo"].Trim();
                String entryNo = Request.QueryString["entry"].Trim();
                if (!String.IsNullOrEmpty(reqNo))
                {
                    
                        int myEntry = Convert.ToInt32(entryNo);
                        String status = Config.ObjNav.RemoveStaffFromTravelRequisition(Convert.ToString(Session["employeeNo"]), reqNo, myEntry);
                        String[] info = status.Split('*');
                        linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }
                }
                catch (Exception)
                {
                }
            }
        }

        protected void next_Click(object sender, EventArgs e)
        {
            try { 
            String tFrom = String.IsNullOrEmpty(from.Text.Trim()) ? "" : from.Text.Trim();
            String tDestination = String.IsNullOrEmpty(destination.Text.Trim()) ? "" : destination.Text.Trim();
            String tDateOfTrip = String.IsNullOrEmpty(dateofTrip.Text.Trim()) ? "" : dateofTrip.Text.Trim();
            String hourOut = hour.SelectedValue;
            String minuteOut = minute.SelectedValue;
            String amPMOut = amPM.SelectedValue;
            String tJourneyRoute = String.IsNullOrEmpty(journeyRoute.Text.Trim()) ? "" : journeyRoute.Text.Trim();
            String tNoOfDays = String.IsNullOrEmpty(noOfDays.Text.Trim()) ? "" : noOfDays.Text.Trim();
            String tPurpose = String.IsNullOrEmpty(purposeOfTrip.Text.Trim()) ? "" : purposeOfTrip.Text.Trim();
            String tComments = String.IsNullOrEmpty(comments.Text.Trim()) ? "" : comments.Text.Trim();
            String requisitionNo = "";
            Boolean newRequisition = false;
                int myHour =Convert.ToInt32(hourOut);
                if (amPMOut == "PM")
                {
                    myHour += 12;
                }
                else if (myHour==12)
                {
                    myHour = 0;
                }
                DateTime travelDate = new DateTime();
                DateTime timeOut = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, myHour, Convert.ToInt32(minuteOut), 0);
                Boolean error = false;
                String message = "";
                Decimal nDays = 0;
                try
                {
                    travelDate = DateTime.ParseExact(tDateOfTrip, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select a valid value for date of trip";
                }
                try
                {
                    nDays = Convert.ToDecimal(tNoOfDays);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select a valid value for number of days";
                }


                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message+ " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else { 
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
                //Convert.ToString(Session["employeeNo"]), */
                    String status = Config.ObjNav.CreateFleetRequisition(Convert.ToString(Session["employeeNo"]),
                        requisitionNo,
                        tFrom, tDestination, travelDate, timeOut, tJourneyRoute, nDays, tPurpose, tComments);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newRequisition)
                    {
                        requisitionNo = info[2];
                    }
                    Response.Redirect("FleetRequisition.aspx?step=2&&requisitionNo=" + requisitionNo);
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

        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=1&&requisitionNo=" + requisitionNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["requisitionNo"];
                // Convert.ToString(Session["employeeNo"]),
                String empNo = Session["employeeNo"].ToString();
                String status = Config.ObjNav.SendFleetRequisitionApproval(empNo,
                    requisitionNo);
                String[] info = status.Split('*');
                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void addTeamMember_Click(object sender, EventArgs e)
        {
            // addFleetRequisitionStaff(employeeNo : Code[50];requisitionNo : Code[50];staffNo : Code[50])
            try
            {
                String tEmployee = employee.SelectedValue;
                String requisitionNo = Request.QueryString["requisitionNo"];
                String status = Config.ObjNav.AddFleetRequisitionStaff(Convert.ToString(Session["employeeNo"]), requisitionNo,tEmployee);
                String[] info = status.Split('*');
                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            bool fileuploadSuccess = false;
            string sUrl = ConfigurationManager.AppSettings["S_URL"];
            string defaultlibraryname = "ERP%20Documents/";
            string customlibraryname = "Kasneb/Fleet Requisition Card";
            string sharepointLibrary = defaultlibraryname + customlibraryname;
            String leaveNo = Request.QueryString["requisitionNo"];
            //string sServername = ConfigurationManager.AppSettings["S_ServerName"];
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
                             "<div class='alert alert-danger'>'"+ex.Message+"'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Fleet Requisition Card/";

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

        public string UploadFleetRequisition(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            leaveNo = Request.QueryString["requisitionNo"];

            string parent_folderName = "Kasneb/Fleet Requisition Card";
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
                    var parentFolderName = @"ERP%20Documents/Kasneb/Fleet Requisition Card/";
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



        //protected void deleteFile_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        String tFileName = fileName.Text.Trim();
        //        String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Fleet Requisition Card/";
        //        String imprestNo = Request.QueryString["requisitionNo"];
        //        imprestNo = imprestNo.Replace('/', '_');
        //        imprestNo = imprestNo.Replace(':', '_');
        //        String documentDirectory = filesFolder + imprestNo + "/";
        //        String myFile = documentDirectory + tFileName;
        //        if (File.Exists(myFile))
        //        {
        //            File.Delete(myFile);
        //            if (File.Exists(myFile))
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

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=3&&requisitionNo=" + requisitionNo);
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=2&&requisitionNo=" + requisitionNo);
        }
    }
}