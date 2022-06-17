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
    public partial class imprest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 5;
            int step = 1;
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"]);
                if (step > 5 || step < 1)
                {
                    step = 1;
                }
            }
            catch (Exception)
            {
                step = 1;
            }
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                if (step == 1)
                {
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
                    var fundcodes = nav.FundCode;
                    fundcode.DataSource = fundcodes;
                    fundcode.DataTextField = "Name";
                    fundcode.DataValueField = "Code";
                    fundcode.DataBind();
                    //load details
                } 
                else if (step == 2)
                {
                    var workTypes = nav.WorkTypes;
                    destinationTown.DataSource = workTypes;
                    destinationTown.DataValueField = "Code";
                    destinationTown.DataTextField = "Description";
                    destinationTown.DataBind();

                    editDestinationTown.DataSource = workTypes;
                    editDestinationTown.DataValueField = "Code";
                    editDestinationTown.DataTextField = "Description";
                    editDestinationTown.DataBind();

                    var voteItems = nav.ReceiptAndPaymentTypes.Where(r=>r.Appear_on_Imprest==true);
                    //voteItem.DataSource = voteItems;
                    //voteItem.DataValueField = "Code";
                    //voteItem.DataTextField = "Description";
                    //voteItem.DataBind();
                    //editVoteItem.DataSource = voteItems;
                    //editVoteItem.DataValueField = "Code";
                    //editVoteItem.DataTextField = "Description";
                    //editVoteItem.DataBind();

                    var allResources = nav.Resources.Where(r => r.Type == "Person");
                    List<Employee> resources = new List<Employee>();
                    foreach (var employee in allResources)
                    {
                        Employee emp = new Employee();
                        emp.EmployeeNo = employee.No;
                        emp.EmployeeName = employee.No + " " + employee.Name;
                        resources.Add(emp);
                    }
                    teamMember.DataSource = resources;
                    teamMember.DataValueField = "EmployeeNo";
                    teamMember.DataTextField = "EmployeeName";
                    teamMember.DataBind();
                    editTeamMember.DataSource = resources;
                    editTeamMember.DataValueField = "EmployeeNo";
                    editTeamMember.DataTextField = "EmployeeName";
                    editTeamMember.DataBind();
                } else if (step == 3)
                {
                    var workTypes = nav.WorkTypes;
                    workType.DataSource = workTypes;
                    workType.DataValueField = "Code";
                    workType.DataTextField = "Description";
                    workType.DataBind();
                    editFuelWorkType.DataSource = workTypes;
                    editFuelWorkType.DataValueField = "Code";
                    editFuelWorkType.DataTextField = "Description";
                    editFuelWorkType.DataBind();

                    
                    var allResources = nav.Resources.Where(r => r.Type == "Machine");
                    List<Employee> resources = new List<Employee>();
                    foreach (var employee in allResources)
                    {
                        Employee emp = new Employee();
                        emp.EmployeeNo = employee.No;
                        emp.EmployeeName = employee.No + " " + employee.Name;
                        resources.Add(emp);
                    }
                    resource.DataSource = resources;
                    resource.DataValueField = "EmployeeNo";
                    resource.DataTextField = "EmployeeName";
                    resource.DataBind();
                    editFuelResource.DataSource = resources;
                    editFuelResource.DataValueField = "EmployeeNo";
                    editFuelResource.DataTextField = "EmployeeName";
                    editFuelResource.DataBind();
                }
                else if (step == 4)
                {
                
                    var allResources = nav.Resources.Where(r => r.Type == "Person");
                    List<Employee> resources = new List<Employee>();
                    foreach (var employee in allResources)
                    {
                        Employee emp = new Employee();
                        emp.EmployeeNo = employee.No;
                        emp.EmployeeName = employee.No + " " + employee.Name;
                        resources.Add(emp);
                    }
                    casualsResource.DataSource = resources;
                    casualsResource.DataValueField = "EmployeeNo";
                    casualsResource.DataTextField = "EmployeeName";
                    casualsResource.DataBind();
                    editCasualsResource.DataSource = resources;
                    editCasualsResource.DataValueField = "EmployeeNo";
                    editCasualsResource.DataTextField = "EmployeeName";
                    editCasualsResource.DataBind();
                    List<String> cType= new List<string>();
                    cType.Add("Skilled");
                    cType.Add("Unskilled");
                    casualsType.DataSource = cType;
                    casualsType.DataBind();
                    editCasualsType.DataSource = cType;
                    editCasualsType.DataBind();

                    var workTypes = nav.WorkTypes.Where(r=>r.Category=="Labour");
                    casualsWorkType.DataSource = workTypes;
                    casualsWorkType.DataValueField = "Code";
                    casualsWorkType.DataTextField = "Description";
                    casualsWorkType.DataBind();
                    editCasualsWorkType.DataSource = workTypes;
                    editCasualsWorkType.DataValueField = "Code";
                    editCasualsWorkType.DataTextField = "Description";
                    editCasualsWorkType.DataBind();

                }
                else if (step == 5)
                {
                    var voteItems = nav.ReceiptAndPaymentTypes.Where(r => r.Appear_on_Imprest == true);
                    otherCostsVoteItem.DataSource = voteItems;
                    otherCostsVoteItem.DataValueField = "Code";
                    otherCostsVoteItem.DataTextField = "Description";
                    otherCostsVoteItem.DataBind();
                    editCostVoteItem.DataSource = voteItems;
                    editCostVoteItem.DataValueField = "Code";
                    editCostVoteItem.DataTextField = "Description";
                    editCostVoteItem.DataBind();
                    
                }

                String imprestNo = "";
                try
                {
                    imprestNo = Request.QueryString["imprestNo"];
                }
                catch (Exception)
                {
                    imprestNo = "";
                }
                if (!String.IsNullOrEmpty(imprestNo))
                {
                  //if imprest no is set, ensure it belongs to him, otherwise redirect
                    Boolean exists = false;
                    var imprests = nav.ImprestMemo.Where(
                       r => r.Requestor == Convert.ToString(Session["employeeNo"]) && r.No == imprestNo).ToList();
                    foreach (var imprest in imprests)
                    {
                        exists = true;
                    }
                    if (!exists)
                    {
                     Response.Redirect("Imprest.aspx");   
                    }
                }
                if (step==1&&!String.IsNullOrEmpty(imprestNo))
                {
                    objective.Text = Config.ObjNav.GetImprestObjective(imprestNo,
                        Convert.ToString(Session["employeeNo"]));
                   var imprests= nav.ImprestMemo.Where(
                        r => r.Requestor == Convert.ToString(Session["employeeNo"]) && r.No == imprestNo).ToList();
                    foreach (var imprest in imprests)
                    {
                        subject.Text = imprest.Subject;
                        destinationNarration.Text = imprest.Imprest_Naration;
                         String myDate=Convert.ToDateTime(imprest.Start_Date).ToString("dd/MM/yyyy"); //dd/mm/yyyy
                        myDate= myDate.Replace("-", "/");
                        travelDate.Text = myDate;
                        numberOfDays.Text = imprest.No_of_days+"";
                        try
                        {
                            job.SelectedValue = imprest.Job;
                            LoadJobTasks();
                        }
                        catch (Exception)
                        {
                            
                        } try
                        {
                            //jobTaskno.SelectedValue = imprest.Job_Task;
                        }
                        catch (Exception)
                        {
                            
                        }
                        try
                        {
                            fundcode.SelectedValue = imprest.Shortcut_Dimension_2_Code;
                        }
                        catch (Exception)
                        {
                            
                        }
                        

                    }
                }
            }
        }

        protected void job_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadJobTasks();
        }

        protected void LoadJobTasks()
        {
            var nav = new Config().ReturnNav();
            var myJob = job.SelectedValue;
            var jobTasks = nav.JobTask.Where(r => r.Job_No == myJob);
            //jobTaskno.DataSource = jobTasks;
            //jobTaskno.DataValueField = "Job_Task_No";
            //jobTaskno.DataTextField = "Description";
            //jobTaskno.DataBind();
        }

        protected void addGeneralDetails_Click(object sender, EventArgs e)
        {
            try
            {
                String tSubject = subject.Text.Trim();
                String tObjective = objective.Text.Trim();
                String tNarration = destinationNarration.Text.Trim();
                tNarration = String.IsNullOrEmpty(tNarration) ? "" : tNarration;
                String tTravelDate = travelDate.Text.Trim();
                String tNumberOfDays = numberOfDays.Text.Trim();
                String tJob = job.SelectedValue.Trim();
                String tFundCode = fundcode.SelectedValue.Trim();
               // String tTask = jobTaskno.SelectedValue.Trim();
                tJob = String.IsNullOrEmpty(tJob) ? "" : tJob;
                //tTask = String.IsNullOrEmpty(tTask) ? "" : tTask;
                DateTime myTravelDate = new DateTime();
                Decimal nDays = 0;
                Boolean error = false;
                String message = "";
                if (String.IsNullOrEmpty(tSubject))
                {
                    error = true;
                    message = "Please specify the subject of the imprest memo";
                }
                if (String.IsNullOrEmpty(tObjective))
                {
                    error = true;
                    message+= message.Length > 0 ? "<br/>" : "";
                    message += "Please specify the objective of the imprest memo";
                }
                try
                {
                    myTravelDate = DateTime.ParseExact(tTravelDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please provide a valid date for travel date";
                }
                try
                {
                    nDays = Convert.ToDecimal(tNumberOfDays);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please provide a valid value for number of days";
                }
                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    /*
                    Session["employeeNo"] = user.employeeNo;
                    */
                    String imprestNo = "";
                    Boolean newImprest = false;
                    try
                    {

                        imprestNo = Request.QueryString["imprestNo"];
                        if (String.IsNullOrEmpty(imprestNo))
                        {
                            imprestNo = "";
                            newImprest = true;
                        }
                    }
                    catch (Exception)
                    {
                        
                        imprestNo = "";
                        newImprest = true;
                    }
                    String status = Config.ObjNav.ImprestGeneralDetails(Convert.ToString(Session["employeeNo"]),
                        imprestNo, tSubject, tObjective, tNarration, myTravelDate,
                        nDays, tJob, "", tFundCode);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newImprest)
                        {
                            imprestNo = info[2];
                           
                        }
                        Response.Redirect("Imprest.aspx?step=2&&imprestNo=" + imprestNo);
                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1]+ " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>"+m.Message+ " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            Response.Redirect("Imprest.aspx?step=1&&imprestNo="+imprestNo);
        }

        protected void Unnamed3_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            Response.Redirect("Imprest.aspx?step=3&&imprestNo=" + imprestNo);
        }

        protected void addTeamMember_Click(object sender, EventArgs e)
        {
            try
            {
                String tDestinationTown = destinationTown.SelectedValue;
               // String tVoteItem = voteItem.SelectedValue;
                String tTeamMember = teamMember.SelectedValue;
                String tTeamNumberOfDays = teamNumberOfDays.Text.Trim();
                Decimal mDays = 0;
                Boolean error = false;
                String message = "";

                try
                {
                    mDays = Convert.ToDecimal(tTeamNumberOfDays);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a valid value for number of days";
                }
                if (String.IsNullOrEmpty(tDestinationTown))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select the detination town";
                }
                //if (String.IsNullOrEmpty(tVoteItem))
                //{
                //    error = true;
                //    message += message.Length > 0 ? "<br/>" : "";
                //    message += "Please select the Vote Item";
                //}
                if (String.IsNullOrEmpty(tTeamMember))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select the team member";
                }
                if (error)
                {
                    teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //Convert.ToString(Session["employeeNo"])
                    String imprestNo = Request.QueryString["imprestNo"];
                    String status = Config.ObjNav.AddTeamMember(Convert.ToString(Session["employeeNo"]), imprestNo,tDestinationTown,"",tTeamMember, mDays);
                    String[] info = status.Split('*');
                    teamFeedback.InnerHtml = "<div class='alert alert-"+info[0]+"'>" +info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                
            }
            catch (Exception m)
            {
                teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
            }
        }

        protected void Unnamed4_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            Response.Redirect("Imprest.aspx?step=4&&imprestNo=" + imprestNo);
        }

        protected void Unnamed3_Click1(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            Response.Redirect("Imprest.aspx?step=2&&imprestNo=" + imprestNo);
        }

        protected void addFuel_Click(object sender, EventArgs e)
        {
            try
            {
                String tWorkType = workType.SelectedValue;
                String tResource = resource.SelectedValue;
                String tMileage = Mileage.Text.Trim();
                Decimal mMileage = 0;
                Boolean error = false;
                String message = "";

                try
                {
                    mMileage = Convert.ToDecimal(tMileage);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a valid value for mileage";
                }
                if (String.IsNullOrEmpty(tWorkType))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select the Work Type";
                }
               
                if (String.IsNullOrEmpty(tResource))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select the Resource";
                }
                if (error)
                {
                    fuelFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //Convert.ToString(Session["employeeNo"])
                    String imprestNo = Request.QueryString["imprestNo"];
                    String status = Config.ObjNav.AddFuel(Convert.ToString(Session["employeeNo"]), imprestNo, tWorkType,
                        tResource, mMileage);
                    String[] info = status.Split('*');
                    fuelFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                fuelFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void addCasual_Click(object sender, EventArgs e)
        {
            try
            {
                int tType = casualsType.SelectedIndex;
                String tResource = casualsResource.SelectedValue;
                String tWorkType = casualsWorkType.SelectedValue;
                String tNoRequired = casualsNoRequired.Text.Trim();
                String tNoofDays = casualsNoOfDays.Text.Trim();
                String message = "";
                Boolean error = false;
                Decimal nDays = 0;
                Decimal nRequired = 0;
                try
                {
                    nDays = Convert.ToDecimal(tNoofDays);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a valid value for number of days";
                }
                try
                {
                    nRequired = Convert.ToDecimal(tNoRequired);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter a valid value for No. Required";
                }
                if (String.IsNullOrEmpty(tResource))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select a resource";
                }
                if (String.IsNullOrEmpty(tWorkType))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select a Work Type";
                }
                if (error)
                {
                    casualsFeedBack.InnerHtml = "<div class='alert alert-danger'>" +message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //Convert.ToString(Session["employeeNo"])
                    String imprestNo = Request.QueryString["imprestNo"];
                    String status = Config.ObjNav.AddCasuals(Convert.ToString(Session["employeeNo"]), imprestNo, tType,
                        tResource, tWorkType, nRequired, nDays);
                    String[] info = status.Split('*');
                    casualsFeedBack.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1]+ " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
               
            }
            catch (Exception y)
            {
                casualsFeedBack.InnerHtml = "<div class='alert alert-danger'>" + y.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void Unnamed6_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            Response.Redirect("Imprest.aspx?step=5&&imprestNo=" + imprestNo);
        }

        protected void Unnamed5_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            Response.Redirect("Imprest.aspx?step=3&&imprestNo=" + imprestNo);
        }

        protected void Unnamed8_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            Response.Redirect("Imprest.aspx?step=4&&imprestNo=" + imprestNo);
        }
        protected void addOtherCosts_Click(object sender, EventArgs e)
        {
            //    othercostsfeedback
            try
            {
                String tVoteItem = otherCostsVoteItem.SelectedValue;
                String tRequiredFor = requiredFor.Text.Trim();
                String tquantityRequired = quantityRequired.Text.Trim();
                String tNoofDays = otherCostsNoofDays.Text.Trim();
                String tUnitCost = otherCostsUnitCost.Text.Trim();
                Decimal quantity = 0;
                Decimal nDays = 0;
                Decimal nUnitCost =0;
                String message = "";
                Boolean error = false;
                try
                {
                    nDays = Convert.ToDecimal(tNoofDays);
                }
                catch (Exception)
                {
                    message = "Please enter a valid value for number of days";
                    error = true;
                }
                try
                {
                    quantity = Convert.ToDecimal(tquantityRequired);
                }
                catch (Exception)
                {
                    message += message.Length > 0 ? "<br/>" : "";
                  message += "Please enter a valid value for quantity Required";
                    error = true;
                }
                try
                {
                    nUnitCost = Convert.ToDecimal(tUnitCost);
                }
                catch (Exception)
                {
                    message += message.Length > 0 ? "<br/>" : "";
                  message += "Please enter a valid value for unit cost";
                    error = true;
                }
                if (String.IsNullOrEmpty(tVoteItem))
                {
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter select a vote item";
                    error = true;
                }
                if (String.IsNullOrEmpty(tRequiredFor))
                {
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter a valid value for required for";
                    error = true;
                }
                if (error)
                {
                    othercostsfeedback.InnerHtml = "<div class='alert alert-danger'>" + message+ " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //Convert.ToString(Session["employeeNo"])
                    String imprestNo = Request.QueryString["imprestNo"];
                    String status = Config.ObjNav.AddOtherCosts(Convert.ToString(Session["employeeNo"]), imprestNo,
                        tVoteItem,
                        tRequiredFor, quantity, nDays, nUnitCost);
                    String[] info = status.Split('*');
                    othercostsfeedback.InnerHtml = "<div class='alert alert-"+ info[0]+ "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                othercostsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                //Convert.ToString(Session["employeeNo"])
                String imprestNo = Request.QueryString["imprestNo"];
                String status = Config.ObjNav.SendImprestMemoApproval(Convert.ToString(Session["employeeNo"]), imprestNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removeMember_Click(object sender, EventArgs e)
        {
            try
            {
                String mNo = removeNumber.Text.Trim();
                String mWorkType = removeWorkType.Text.Trim();
                String mEmployeeNo = Convert.ToString(Session["employeeNo"]);
                String imprestNo = Request.QueryString["imprestNo"];
                     String status = Config.ObjNav.RemoveMemberFromImprestMemo(mNo, mWorkType,mEmployeeNo,imprestNo);
                    String[] info = status.Split('*');
                    teamFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
            }
            catch (Exception m)
            {
                teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

            //removeNumber
            //removeWorkType

           

        }
       protected void removeFuel_Click(object sender, EventArgs e)
        {
            try
            {
                String mNo = removeFuelNumber.Text.Trim();
                String mWorkType = removeFuelWorkType.Text.Trim();
                String mEmployeeNo = Convert.ToString(Session["employeeNo"]);
                String imprestNo = Request.QueryString["imprestNo"];
                     String status = Config.ObjNav.RemoveFuelFromImprestMemo(mNo, mWorkType,mEmployeeNo,imprestNo);
                    String[] info = status.Split('*');
                    fuelFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
            }
            catch (Exception m)
            {
                fuelFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

            //removeNumber
            //removeWorkType

           

        }
       //protected void deleteFile_Click(object sender, EventArgs e)
       // {
       //     try
       //     {
       //         String tFileName = fileName.Text.Trim();
       //         String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Memo/";
       //         String imprestNo = Request.QueryString["imprestNo"];
       //         imprestNo = imprestNo.Replace('/', '_');
       //         imprestNo = imprestNo.Replace(':', '_');
       //         String documentDirectory = filesFolder + imprestNo + "/";
       //         String myFile = documentDirectory + tFileName;
       //         if (File.Exists(myFile))
       //         {
       //             File.Delete(myFile);
       //             if (File.Exists(myFile))
       //             {
       //                 documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
       //             }
       //             else
       //             {
       //                 documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
       //             }
       //             }
       //         else
       //         {
       //             documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
       //         }
                
                
                
       //     }
       //     catch (Exception m)
       //     {
       //         documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

       //     }

       //     //removeNumber
       //     //removeWorkType

           

       // }
        protected void removeCasual_Click(object sender, EventArgs e)
        {
            try

            {
                String myType = removeCasualType.Text.Trim();
                String cResource = removeCasualResourceNo.Text.Trim();
                
                String mEmployeeNo = Convert.ToString(Session["employeeNo"]);
                String imprestNo = Request.QueryString["imprestNo"];
                     String status = Config.ObjNav.RemoveCasuals(mEmployeeNo, imprestNo,myType,cResource);
                    String[] info = status.Split('*');
                    casualsFeedBack.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
            }
            catch (Exception m)
            {
                casualsFeedBack.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

            //removeNumber
            //removeWorkType

           

        }
        protected void editTeamMember_Click(object sender, EventArgs e)
        {
            try
            {
                String tDestinationTown = editDestinationTown.SelectedValue;
               // String tVoteItem = editVoteItem.SelectedValue;
                String tTeamMember = editTeamMember.SelectedValue;
                String tTeamNumberOfDays = editNumberOfDays.Text.Trim();
                Decimal mDays = 0;
                Boolean error = false;
                String message = "";

                try
                {
                    mDays = Convert.ToDecimal(tTeamNumberOfDays);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a valid value for number of days";
                }
                if (String.IsNullOrEmpty(tDestinationTown))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select the detination town";
                }
                //if (String.IsNullOrEmpty(tVoteItem))
                //{
                //    error = true;
                //    message += message.Length > 0 ? "<br/>" : "";
                //    message += "Please select the Vote Item";
                //}
                if (String.IsNullOrEmpty(tTeamMember))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select the team member";
                }
                if (error)
                {
                    teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //Convert.ToString(Session["employeeNo"])
                    String tOriginalNumber = originalNo.Text.Trim();
                    String tOriginalWorkType = originalWorkType.Text.Trim();
                    String imprestNo = Request.QueryString["imprestNo"];
                    String status = Config.ObjNav.EditTeamMember(Convert.ToString(Session["employeeNo"]), imprestNo, tDestinationTown, "", tTeamMember, mDays,tOriginalNumber, tOriginalWorkType);
                    String[] info = status.Split('*');
                    teamFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                teamFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
        protected void editFuel_Click(object sender, EventArgs e)
        {
            try
            {
                String tWorkType = editFuelWorkType.SelectedValue;
                String tResource = editFuelResource.SelectedValue;
                String tMileage = editFuelMileage.Text.Trim();
                Decimal mMileage = 0;
                Boolean error = false;
                String message = "";

                try
                {
                    mMileage = Convert.ToDecimal(tMileage);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a valid value for mileage";
                }
                if (String.IsNullOrEmpty(tWorkType))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select the Work Type";
                }

                if (String.IsNullOrEmpty(tResource))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select the Resource";
                }
                if (error)
                {
                    fuelFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //Convert.ToString(Session["employeeNo"])
                    String tOriginalNo = editFuelOriginalNo.Text.Trim();
                    String tOriginalWorkType = editFuelOriginalWorkTye.Text.Trim();
                    String imprestNo = Request.QueryString["imprestNo"];
                    String status = Config.ObjNav.EditFuel(Convert.ToString(Session["employeeNo"]), imprestNo, tWorkType,
                        tResource, mMileage, tOriginalNo, tOriginalWorkType);
                    String[] info = status.Split('*');
                    fuelFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                fuelFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
        protected void editCasual_Click(object sender, EventArgs e)
        {
            try
            {
                int tType = editCasualsType.SelectedIndex;
                String tResource = editCasualsResource.SelectedValue;
                String tWorkType = editCasualsWorkType.SelectedValue;
                String tNoRequired = editCasualsNoRequired.Text.Trim();
                String tNoofDays = editCasualsNoOfDays.Text.Trim();
                String message = "";
                Boolean error = false;
                Decimal nDays = 0;
                Decimal nRequired = 0;
                try
                {
                    nDays = Convert.ToDecimal(tNoofDays);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a valid value for number of days";
                }
                try
                {
                    nRequired = Convert.ToDecimal(tNoRequired);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter a valid value for No. Required";
                }
                if (String.IsNullOrEmpty(tResource))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select a resource";
                }
                if (String.IsNullOrEmpty(tWorkType))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select a Work Type";
                }
                if (error)
                {
                    casualsFeedBack.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //Convert.ToString(Session["employeeNo"])
                    String tOriginalType = originalCasualsType.Text.Trim();
                    String tOriginalResourceNo = originalCasualsResourceNo.Text.Trim();
                    String imprestNo = Request.QueryString["imprestNo"];
                    String status = Config.ObjNav.EditCasuals(Convert.ToString(Session["employeeNo"]), imprestNo, tType,
                        tResource, tWorkType, nRequired, nDays,tOriginalType, tOriginalResourceNo);
                    String[] info = status.Split('*');
                    casualsFeedBack.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception y)
            {
                casualsFeedBack.InnerHtml = "<div class='alert alert-danger'>" + y.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void removeOtherCost_Click(object sender, EventArgs e)
        {
            try

            {

                String mLineNo = costToRemovelineNo.Text.Trim();
                String mEmployeeNo = Convert.ToString(Session["employeeNo"]);
                String imprestNo = Request.QueryString["imprestNo"];
                int mNo = 0;
                Boolean error = false;
                try
                {
                    mNo = Convert.ToInt32(mLineNo);
                }
                catch (Exception)
                {  
                    error = true;
                }
                if (error)
                {
                 
                    othercostsfeedback.InnerHtml = "<div class='alert alert-danger'>The line no could not be found<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    String status = Config.ObjNav.RemoveOtherCosts(imprestNo, mEmployeeNo, mNo);
                    String[] info = status.Split('*');
                    othercostsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                othercostsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

            //removeNumber
            //removeWorkType



        }
        protected void editOtherCosts_Click(object sender, EventArgs e)
        {
            //    othercostsfeedback
            try
            {
                String tVoteItem = editCostVoteItem.SelectedValue;
                String tRequiredFor = editCostRequiredFor.Text.Trim();
                String tquantityRequired = editCostQuantityRequired.Text.Trim();
                String tNoofDays = editCostNoofDays.Text.Trim();
                String tUnitCost = editCostUnitCost.Text.Trim();
                Decimal quantity = 0;
                Decimal nDays = 0;
                Decimal nUnitCost = 0;
                String message = "";
                Boolean error = false;
                try
                {
                    nDays = Convert.ToDecimal(tNoofDays);
                }
                catch (Exception)
                {
                    message = "Please enter a valid value for number of days";
                    error = true;
                }
                try
                {
                    quantity = Convert.ToDecimal(tquantityRequired);
                }
                catch (Exception)
                {
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter a valid value for quantity Required";
                    error = true;
                }
                try
                {
                    nUnitCost = Convert.ToDecimal(tUnitCost);
                }
                catch (Exception)
                {
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter a valid value for unit cost";
                    error = true;
                }
                if (String.IsNullOrEmpty(tVoteItem))
                {
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter select a vote item";
                    error = true;
                }
                if (String.IsNullOrEmpty(tRequiredFor))
                {
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter a valid value for required for";
                    error = true;
                }
                if (error)
                {
                    othercostsfeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //Convert.ToString(Session["employeeNo"])
                    int mLine =Convert.ToInt32(originalLine.Text.Trim());
                    String imprestNo = Request.QueryString["imprestNo"];
                    String status = Config.ObjNav.EditOtherCosts(Convert.ToString(Session["employeeNo"]), imprestNo,
                        tVoteItem,tRequiredFor, quantity, nDays, nUnitCost, mLine);
                    String[] info = status.Split('*');
                    othercostsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                othercostsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void Unnamed10_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            Response.Redirect("Imprest.aspx?step=5&&imprestNo=" + imprestNo);
        }

        protected void Unnamed8_Click1(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            Response.Redirect("Imprest.aspx?step=6&&imprestNo=" + imprestNo);
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

            catch (Exception ex)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //sDocName = string.Empty;
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