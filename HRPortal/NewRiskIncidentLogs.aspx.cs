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

               

                var responsibility = nav.ResponsibilityCenters.Where(r => r.Operating_Unit_Type == "Department/Center");
                responsibilityCenter.DataSource = responsibility;
                responsibilityCenter.DataValueField = "Code";
                responsibilityCenter.DataTextField = "Name";
                responsibilityCenter.DataBind();
                responsibilityCenter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var allResources = nav.Resources.Where(r => r.Type == "Person");
                List<Employee> resources = new List<Employee>();
                foreach (var employee in allResources)
                {
                    Employee emp = new Employee();
                    emp.EmployeeNo = employee.No;
                    emp.EmployeeName = employee.No + " " + employee.Name;
                    resources.Add(emp);
                }

                Officer.DataSource = resources;
                Officer.DataValueField = "EmployeeNo";
                Officer.DataTextField = "EmployeeName";
                Officer.DataBind();
                Officer.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                EscalationOfficer.DataSource = resources;
                EscalationOfficer.DataValueField = "EmployeeNo";
                EscalationOfficer.DataTextField = "EmployeeName";
                EscalationOfficer.DataBind();
                EscalationOfficer.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                string requisitionNo = Request.QueryString["requisitionNo"];
                var incidentLogs = nav.RiskIncidentLogsQ.Where(r => r.Incident_ID == requisitionNo).ToList();
                if (incidentLogs.Count > 0)
                {
                    foreach(var incident in incidentLogs)
                    {
                        strategicplanno.SelectedValue = incident.Risk_Register_Type;
                        funcionalworkplan.SelectedValue = incident.Risk_Management_Plan_ID;
                        RiskId.SelectedValue = Convert.ToString(incident.Risk_ID);
                        RiskDescription.Text = incident.Risk_Description;
                        riskVategory.SelectedValue = incident.Risk_Incident_Category;
                        severityLevel.SelectedValue = incident.Severity_Level;
                        dateIncident.Text = Convert.ToString(incident.Incident_Date);
                        timeIncident.Text = Convert.ToString(incident.Incident_Time);
                        OccurrenceType.SelectedValue = incident.Occurrence_Type;
                        incidentLocations.Text = incident.Incident_Location_Details;
                        primTrigger.SelectedValue = Convert.ToString(incident.Primary_Trigger_ID);
                        rootCauseSumm.Text = incident.Root_Cause_Summary;
                        categoryOfPerson.SelectedValue = incident.Category_of_Person_Reporting;
                        reportedBy.Text = incident.Reported_By_Name;
                        responsibilityCenter.SelectedValue = incident.Department_ID;
                        EscalationOfficer.SelectedValue = incident.Escalate_to_Officer_No;


                    }
                    
                }



            }
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            //// string filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Memo/";
            ////if (document.HasFile)
            ////    bool fileuploadSuccess = false;
            //string sUrl = ConfigurationManager.AppSettings["S_URL"];
            //string defaultlibraryname = "ERP%20Documents/";
            //string customlibraryname = "Kasneb/Risk";
            //string sharepointLibrary = defaultlibraryname + customlibraryname;
            //String leaveNo = Request.QueryString["imprestNo"];

            //string username = ConfigurationManager.AppSettings["S_USERNAME"];
            //string password = ConfigurationManager.AppSettings["S_PWD"];
            //string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];

            //bool bbConnected = Config.Connect(sUrl, username, password, domainname);

            //try
            //{
            //    if (bbConnected)
            //    {
            //        Uri uri = new Uri(sUrl);
            //        string sSpSiteRelativeUrl = uri.AbsolutePath;
            //        string uploadfilename = leaveNo + "_" + document.FileName;
            //        Stream uploadfileContent = ""; /*document.FileContent;*/

            //        var sDocName = UploadFleetRequisition(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

            //        string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

            //        if (!string.IsNullOrEmpty(sDocName))
            //        {
            //            var status = Config.ObjNav.AddFleetRequisitionSharepointLinks(leaveNo, uploadfilename, sharepointlink);
            //            string[] info = status.Split('*');
            //            if (info[0] == "success")
            //            {
            //                linesFeedback.InnerHtml = "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //            }
            //            else
            //            {
            //                linesFeedback.InnerHtml =
            //                    "<div class='alert alert-danger'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //            }

            //        }
            //        else
            //        {
            //            linesFeedback.InnerHtml =
            //                  "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //        }


            //    }
            //    else
            //    {
            //        linesFeedback.InnerHtml =
            //                  "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    }
            //}
            //catch (Exception ex)
            //{

            //    linesFeedback.InnerHtml =
            //                 "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //}

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
                        linesFeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    catch (Exception ex)
                    {
                        // ignored
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }
            catch (Exception ex)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
            
            string docType = funcionalworkplan.SelectedValue.Trim();

            var mngtPlanLines = nav.ManagementPlanLines.Where(r => r.Document_No == docType);
            RiskId.DataSource = mngtPlanLines;
            RiskId.DataTextField = "Risk_Category";
            RiskId.DataValueField = "Risk_ID";
            RiskId.DataBind();
            RiskId.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

          
            




        }

        protected void addIncidentLog_Click(object sender, EventArgs e)
        {
            try
            {
                int timpactType = Convert.ToInt32(String.IsNullOrEmpty(impactType.SelectedValue.Trim()) ? "0" : impactType.SelectedValue.Trim());
                String tdescription = String.IsNullOrEmpty(description.Text.Trim())? "": description.Text.Trim();
                int tpersonReporting = Convert.ToInt32(String.IsNullOrEmpty(personReporting.SelectedValue.Trim()) ? "0": personReporting.SelectedValue.Trim());
                String tOfficer = String.IsNullOrEmpty(Officer.SelectedValue.Trim()) ? "" : Officer.SelectedValue.Trim();
                String tcontactDetails = String.IsNullOrEmpty(contactDetails.Text.Trim())? "" : contactDetails.Text.Trim();
                string tadditionalComments = string.IsNullOrEmpty(additionalComments.Text.Trim()) ? "" : additionalComments.Text.Trim();
                string tpoliceReport = string.IsNullOrEmpty(policeReport.Text.Trim()) ? "" : policeReport.Text.Trim();
                DateTime treportDate = Convert.ToDateTime(string.IsNullOrEmpty(reportDate.Text.Trim()) ? "" : reportDate.Text.Trim());
                string tpoliceStation = string.IsNullOrEmpty(policeStation.Text.Trim()) ? "" : policeStation.Text.Trim();
                string tReportingOfficer = string.IsNullOrEmpty(ReportingOfficer.Text.Trim()) ? "" : ReportingOfficer.Text.Trim();
               
                Boolean error = false;
             
              
              
                if (!error)
                {
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    
                    String status = Config.ObjNav.CreateIncidentSummery(Convert.ToString(Session["employeeNo"]),  requisitionNo, timpactType, tdescription, tpersonReporting, tOfficer, tcontactDetails, tadditionalComments, tpoliceReport, treportDate, tpoliceStation, tReportingOfficer);
                    String[] info = status.Split('*');
                    impactType.SelectedValue = "";
                    description.Text = "";
                    personReporting.SelectedValue = "";
                    Officer.SelectedValue = "";
                    contactDetails.Text = "";
                    additionalComments.Text = "";
                    policeReport.Text = "";
                    reportDate.Text = "";
                    policeStation.Text = "";
                    ReportingOfficer.Text = "";
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
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
                int tstrategicplanno =Convert.ToInt32(string.IsNullOrEmpty(strategicplanno.SelectedValue.Trim()) ? "0" : strategicplanno.SelectedValue.Trim());
                String tfuncionalworkplan = string.IsNullOrEmpty(funcionalworkplan.SelectedValue.Trim()) ? "" : funcionalworkplan.SelectedValue.Trim();
                int tRiskId = Convert.ToInt32(string.IsNullOrEmpty(RiskId.SelectedValue.Trim()) ? "0" : RiskId.SelectedValue.Trim());
                string tRiskDescription = String.IsNullOrEmpty(RiskDescription.Text.Trim()) ? "" : RiskDescription.Text.Trim();
                String triskVategory = string.IsNullOrEmpty(riskVategory.SelectedValue.Trim()) ? "" : riskVategory.SelectedValue.Trim();
                String empNo = Convert.ToString(Session["employeeNo"]);
                String tseverityLevel = String.IsNullOrEmpty(severityLevel.SelectedValue.Trim()) ? "" : severityLevel.SelectedValue.Trim();
                DateTime tdateIncident = Convert.ToDateTime(String.IsNullOrEmpty(dateIncident.Text.Trim()) ? "" : dateIncident.Text.Trim());
                DateTime ttimeIncident = Convert.ToDateTime(String.IsNullOrEmpty(timeIncident.Text.Trim()) ? "" : timeIncident.Text.Trim());
                int tOccurrenceType = Convert.ToInt32(String.IsNullOrEmpty(OccurrenceType.SelectedValue.Trim()) ? "0" : OccurrenceType.SelectedValue.Trim());
                String tincidentLocations = String.IsNullOrEmpty(incidentLocations.Text.Trim()) ? "" : incidentLocations.Text.Trim();
                int tprimTrigger = Convert.ToInt32(String.IsNullOrEmpty(primTrigger.SelectedValue.Trim()) ? "0" : primTrigger.SelectedValue.Trim());
                String trootCauseSumm = String.IsNullOrEmpty(rootCauseSumm.Text.Trim()) ? "" : rootCauseSumm.Text.Trim();
                int tcategoryOfPerson = Convert.ToInt32(String.IsNullOrEmpty(categoryOfPerson.SelectedValue.Trim()) ? "0" : categoryOfPerson.SelectedValue.Trim());
                String treportedBy = String.IsNullOrEmpty(reportedBy.Text.Trim()) ? "" : reportedBy.Text.Trim();
                String tresponsibilityCenter = String.IsNullOrEmpty(responsibilityCenter.SelectedValue.Trim()) ? "" : responsibilityCenter.SelectedValue.Trim();
                string tEscalationOfficer = String.IsNullOrEmpty(EscalationOfficer.SelectedValue.Trim()) ? "" : EscalationOfficer.SelectedValue.Trim();






                String status = Config.ObjNav.CreateNewIncodentLog(empNo, requisitionNo, tstrategicplanno, tfuncionalworkplan, tRiskId, tRiskDescription,triskVategory, tseverityLevel, tdateIncident, ttimeIncident, tOccurrenceType, tincidentLocations,
                    tprimTrigger, trootCauseSumm, tcategoryOfPerson, treportedBy, tresponsibilityCenter, tEscalationOfficer);
                String[] info = status.Split('*');
                
                if (info[0] == "success")
                {
                    try
                    {
                        if (newRequisition)
                        {
                            requisitionNo = info[2];
                        }
                        Response.Redirect("NewRiskIncidentLogs.aspx?step=2&&requisitionNo=" + requisitionNo);


                    }
                    catch (Exception ex)
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
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
                    String status = Config.ObjNav.DeleteIncidentLine(requisitionNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("NewRiskIncidentLogs.aspx?step=1&&requisitionNo=" + requisitionNo);

        }

        protected void RiskId_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();

            string docType = RiskId.SelectedItem.Text;

            var mngtPlanLines = nav.ManagementPlanLines.Where(r => r.Risk_Category == docType);
            riskVategory.DataSource = mngtPlanLines;
            riskVategory.DataTextField = "Risk_Title";
            riskVategory.DataValueField = "Risk_Category";
            riskVategory.DataBind();
            riskVategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
        }

        protected void riskVategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();

            string triskVategory = riskVategory.SelectedValue.Trim();

            
            var trigger = nav.RiskCategoryTrig.Where(r=>r.Risk_Category_ID== triskVategory);
            primTrigger.DataSource = trigger;
            primTrigger.DataValueField = "Trigger_ID";
            primTrigger.DataTextField = "Description";
            primTrigger.DataBind();
            primTrigger.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
        }

        protected void post_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            string message = "";
            string TapplicationNo = Convert.ToString(Request.QueryString["requisitionNo"]);

            if (error == true)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

            else
            {
                //apply for leave
                try
                {



                    var status = Config.ObjNav.PostIncidentLogs(TapplicationNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('OpenRiskIncidentLogs.aspx?status=approved') }, 5000);", true);


                    }
                    else
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception t)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }
    }
}