using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class NewIndividualScoreCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var query = nav.PerfomanceContractHeader.Where(r => r.Document_Type == "Individual Scorecard" && r.Approval_Status == "Released" && r.Score_Card_Type != "Staff");
                List<Item> list = new List<Item>();
                foreach (var item in query)
                {
                    Item itm = new Item();
                    itm.Description = item.Description + " :" + item.Employee_Name;
                    itm.No = item.No;
                    list.Add(itm);
                }
                seniorOfficerPC.DataSource = list;
                seniorOfficerPC.DataTextField = "Description";
                seniorOfficerPC.DataValueField = "No";
                seniorOfficerPC.DataBind();

                String IndividualPCNo = "";
                try
                {
                    IndividualPCNo = Request.QueryString["IndividualPCNo"];
                }
                catch (Exception)
                {
                    IndividualPCNo = "";
                }
                if (!String.IsNullOrEmpty(IndividualPCNo))
                {
                    var pc = nav.PerfomanceContractHeader.Where(x => x.No == IndividualPCNo);
                    foreach (var item in pc)
                    {
                        strategicplanno.Text = item.Strategy_Plan_ID;
                        contractYear.Text = item.Annual_Reporting_Code;
                        startDate.Text = Convert.ToDateTime(item.Start_Date).ToString("d/MM/yyyy");
                        endDate.Text = Convert.ToDateTime(item.End_Date).ToString("d/MM/yyyy");
                        description.Text = item.Description;
                        seniorOfficerPC.SelectedValue = item.Directors_PC_ID;
                    }
                }
            }
        }

        protected void seniorOfficerPC_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                String tseniorOfficerPc = seniorOfficerPC.SelectedValue;
                String tDesc = description.Text.Trim();
                String IndividualPCNo = "";
                try
                {

                    IndividualPCNo = Request.QueryString["IndividualPCNo"];

                    if (String.IsNullOrEmpty(IndividualPCNo))
                    {
                        IndividualPCNo = "";
                    }

                }
                catch (Exception)
                {

                    IndividualPCNo = "";
                }
                String status = Config.ObjNav.FnNewStaffPerformanceContract(IndividualPCNo, Convert.ToString(Session["employeeNo"]), tDesc, tseniorOfficerPc);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    Response.Redirect("NewIndividualScoreCard.aspx?IndividualPCNo=" + info[2]);

                    var nav = new Config().ReturnNav();
                    var pO = nav.PerfomanceContractHeader.Where(x => x.No == info[2]).ToList();
                    foreach (var item in pO)
                    {
                        strategicplanno.Text = item.Strategy_Plan_ID;
                        contractYear.Text = item.Annual_Reporting_Code;
                        startDate.Text = Convert.ToDateTime(item.Start_Date).ToString("d/MM/yyyy");
                        endDate.Text = Convert.ToDateTime(item.End_Date).ToString("d/MM/yyyy");
                    }
                }
                else
                {
                    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void SaveGeneralDetails_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string flag = "";
                String tseniorOfficerPc = seniorOfficerPC.SelectedValue;
                String tDesc = description.Text.Trim();
                String IndividualPCNo = Request.QueryString["IndividualPCNo"];

                if (string.IsNullOrEmpty(tDesc))
                {
                    error = true;
                    descriptionValidation.Visible = true;
                }
                else
                {
                    error = false;
                    descriptionValidation.Visible = false;
                }
                if (!error)
                {
                    String status = Config.ObjNav.FnNewStaffPerformanceContract(IndividualPCNo, Convert.ToString(Session["employeeNo"]), tDesc, tseniorOfficerPc);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        Session["IndividualPCNo"] = info[2];
                        Session["StrategicPlanNo"] = info[3];
                        Session["SeniorPCNo"] = info[4];
                        Session["AnnualCode"] = info[5];

                        Response.Redirect("NewIndividualScoreCard.aspx?step=2&&IndividualPCNo=" + info[2] + "&&StrategicPlanNo=" + info[3] + "&&SeniorPCNo=" + info[4] + "&&AnnualCode=" + info[5]);
                    }
                    else
                    {
                        generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SubmitSelectedCoreInitiatives(List<SelectedCoreInitiatives> targetNumber)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (targetNumber == null)
                {
                    targetNumber = new List<SelectedCoreInitiatives>();
                }
                foreach (SelectedCoreInitiatives target in targetNumber)
                {
                    var StrategicPlanNo = HttpContext.Current.Session["StrategicPlanNo"].ToString();
                    var IndividualPCNo = HttpContext.Current.Session["IndividualPCNo"].ToString();
                    var SeniorPCNo = HttpContext.Current.Session["SeniorPCNo"].ToString();
                    string InitiativeNumber = target.TargetNumber;
                    var status = Config.ObjNav.FnSubmitSelectedCoreInitiatives(StrategicPlanNo, IndividualPCNo, SeniorPCNo, InitiativeNumber);
                    string[] info = status.Split('*');
                    NewControl.ID = "feedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertCoreInitiatives(List<CoreInitiatives> primarydetails)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (primarydetails == null)
                {
                    primarydetails = new List<CoreInitiatives>();
                }
                foreach (CoreInitiatives primarydetail in primarydetails)
                {

                    int entrynumber = Convert.ToInt32(primarydetail.entrynumber);
                    DateTime startdate = new DateTime();
                    string tstartdate = primarydetail.startdate;
                    if (tstartdate.Length > 1)
                    {
                        startdate = DateTime.ParseExact(tstartdate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    }
                    DateTime enddate = new DateTime();
                    string tenddate = primarydetail.enddate;
                    if (tenddate.Length > 1)
                    {
                        enddate = DateTime.ParseExact(tenddate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    }
                    decimal agreedtarget = 0;
                    if (primarydetail.agreedtarget.Length > 1)
                    {
                        agreedtarget = Convert.ToDecimal(primarydetail.agreedtarget);
                    }
                    decimal assignedweight = 0;
                    if (primarydetail.assignedweight.Length > 1)
                    {
                        assignedweight = Convert.ToDecimal(primarydetail.assignedweight);
                    }
                    var userCode = HttpContext.Current.Session["employeeNo"].ToString();
                    String status = Config.ObjNav.FnSaveCoreInitiatives(entrynumber, startdate, enddate, agreedtarget, assignedweight, primarydetail.comments);
                    String[] info = status.Split('*');
                    NewControl.ID = "feedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SubmitSelectedAdditionalActivities(List<SelectedCoreInitiatives> targetNumber)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (targetNumber == null)
                {
                    targetNumber = new List<SelectedCoreInitiatives>();
                }
                foreach (SelectedCoreInitiatives target in targetNumber)
                {
                    var StrategicPlanNo = HttpContext.Current.Session["StrategicPlanNo"].ToString();
                    var IndividualPCNo = HttpContext.Current.Session["IndividualPCNo"].ToString();
                    var AnnualCode = HttpContext.Current.Session["AnnualCode"].ToString();
                    string InitiativeNumber = target.TargetNumber;
                    var status = Config.ObjNav.FnInsertSelectedAdditionalActivities(StrategicPlanNo, AnnualCode, IndividualPCNo, InitiativeNumber);
                    string[] info = status.Split('*');
                    NewControl.ID = "feedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertAdditionalActivities(List<AdditionalInitiatives> primarydetailsData)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (primarydetailsData == null)
                {
                    primarydetailsData = new List<AdditionalInitiatives>();
                }
                foreach (AdditionalInitiatives primarydetail in primarydetailsData)
                {
                    int entrynumber = Convert.ToInt32(primarydetail.entrynumber);
                    DateTime startdate = new DateTime();
                    string tstartdate = primarydetail.startdate;
                    if (tstartdate.Length > 1)
                    {
                        startdate = DateTime.ParseExact(tstartdate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    }
                    DateTime enddate = new DateTime();
                    string tenddate = primarydetail.enddate;
                    if (tenddate.Length > 1)
                    {
                        enddate = DateTime.ParseExact(tenddate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    }
                    decimal agreedtarget = 0;
                    if (primarydetail.agreedtarget.Length > 1)
                    {
                        agreedtarget = Convert.ToDecimal(primarydetail.agreedtarget);
                    }
                    decimal assignedweight = 0;
                    if (primarydetail.assignedweight.Length > 1)
                    {
                        assignedweight = Convert.ToDecimal(primarydetail.assignedweight);
                    }

                    var userCode = HttpContext.Current.Session["employeeNo"].ToString();
                    String status = Config.ObjNav.FnSaveAditionalInitiatives(entrynumber, agreedtarget, assignedweight, startdate, enddate, primarydetail.comments);
                    String[] info = status.Split('*');
                    NewControl.ID = "feedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertJDTergets(List<JDTargets> primiarydetails)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (primiarydetails == null)
                {
                    primiarydetails = new List<JDTargets>();
                }
                foreach (JDTargets JDTarget in primiarydetails)
                {

                    var entrynumber = JDTarget.entrynumber;
                    var tannualtarget = Convert.ToInt32(JDTarget.annualtarget);
                    var tassignedweight = Convert.ToInt32(JDTarget.assignedweight);
                    var userCode = HttpContext.Current.Session["employeeNo"].ToString();
                    var tworkplan = JDTarget.workplanno;
                    String status = Config.ObjNav.FnInsertJDTargets(entrynumber, tworkplan, tannualtarget, tassignedweight);
                    String[] info = status.Split('*');
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        protected void NextToStep3_Click(object sender, EventArgs e)
        {
            var csp = Request.QueryString["StrategicPlanNo"];
            var AnnualCode = Request.QueryString["AnnualCode"];
            var IndividualPCNo = Request.QueryString["IndividualPCNo"];
            var SeniorPCNo = Request.QueryString["SeniorPCNo"];

            Response.Redirect("NewIndividualScoreCard.aspx?step=3&&IndividualPCNo=" + IndividualPCNo + "&&StrategicPlanNo=" + csp + "&&SeniorPCNo=" + SeniorPCNo + "&&AnnualCode=" + AnnualCode);
        }

        protected void BackToStep1_Click(object sender, EventArgs e)
        {
            var IndividualPCNo = Request.QueryString["IndividualPCNo"];
            Response.Redirect("NewIndividualScoreCard.aspx?step=1&&IndividualPCNo=" + IndividualPCNo);
        }

        protected void NextToStep4_Click(object sender, EventArgs e)
        {
            var csp = Request.QueryString["StrategicPlanNo"];
            var AnnualCode = Request.QueryString["AnnualCode"];
            var IndividualPCNo = Request.QueryString["IndividualPCNo"];
            var SeniorPCNo = Request.QueryString["SeniorPCNo"];

            Response.Redirect("NewIndividualScoreCard.aspx?step=4&&IndividualPCNo=" + IndividualPCNo + "&&StrategicPlanNo=" + csp + "&&SeniorPCNo=" + SeniorPCNo + "&&AnnualCode=" + AnnualCode);
        }

        protected void BackToStep2_Click(object sender, EventArgs e)
        {
            var csp = Request.QueryString["StrategicPlanNo"];
            var AnnualCode = Request.QueryString["AnnualCode"];
            var IndividualPCNo = Request.QueryString["IndividualPCNo"];
            var SeniorPCNo = Request.QueryString["SeniorPCNo"];

            Response.Redirect("NewIndividualScoreCard.aspx?step=2&&IndividualPCNo=" + IndividualPCNo + "&&StrategicPlanNo=" + csp + "&&SeniorPCNo=" + SeniorPCNo + "&&AnnualCode=" + AnnualCode);
        }

        protected void NextToStep5_Click(object sender, EventArgs e)
        {
            var csp = Request.QueryString["StrategicPlanNo"];
            var AnnualCode = Request.QueryString["AnnualCode"];
            var IndividualPCNo = Request.QueryString["IndividualPCNo"];
            var SeniorPCNo = Request.QueryString["SeniorPCNo"];

            Response.Redirect("NewIndividualScoreCard.aspx?step=5&&IndividualPCNo=" + IndividualPCNo + "&&StrategicPlanNo=" + csp + "&&SeniorPCNo=" + SeniorPCNo + "&&AnnualCode=" + AnnualCode);
        }

        protected void BackToStep3_Click(object sender, EventArgs e)
        {
            var csp = Request.QueryString["StrategicPlanNo"];
            var AnnualCode = Request.QueryString["AnnualCode"];
            var IndividualPCNo = Request.QueryString["IndividualPCNo"];
            var SeniorPCNo = Request.QueryString["SeniorPCNo"];

            Response.Redirect("NewIndividualScoreCard.aspx?step=3&&IndividualPCNo=" + IndividualPCNo + "&&StrategicPlanNo=" + csp + "&&SeniorPCNo=" + SeniorPCNo + "&&AnnualCode=" + AnnualCode);
        }

        protected void BackTostep4_Click(object sender, EventArgs e)
        {
            var csp = Request.QueryString["StrategicPlanNo"];
            var AnnualCode = Request.QueryString["AnnualCode"];
            var IndividualPCNo = Request.QueryString["IndividualPCNo"];
            var SeniorPCNo = Request.QueryString["SeniorPCNo"];

            Response.Redirect("NewIndividualScoreCard.aspx?step=4&&IndividualPCNo=" + IndividualPCNo + "&&StrategicPlanNo=" + csp + "&&SeniorPCNo=" + SeniorPCNo + "&&AnnualCode=" + AnnualCode);
        }
        protected void submitPC_Click(object sender, EventArgs e)
        {
            try
            {
                string IndividualPCNo = Request.QueryString["IndividualPCNo"];
                String status = Config.ObjNav.FnSendStaffPerformanceContractApproval(IndividualPCNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void revove_Click(object sender, EventArgs e)
        {
            try
            {
                string IndividualPCNo = Request.QueryString["IndividualPCNo"];
                int lineno = Convert.ToInt32(approvedocNo.Text);
                String status = Config.ObjNav.FnRemoveCoreInitiatives(IndividualPCNo, lineno);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    coreinitiativefeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    coreinitiativefeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                //coreinitiativefeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removeadditionalinitiative_Click(object sender, EventArgs e)
        {
            try
            {
                string IndividualPCNo = Request.QueryString["IndividualPCNo"];
                int lineno = Convert.ToInt32(approvedocNo1.Text);
                String status = Config.ObjNav.FnRemoveAditionalInitiative(IndividualPCNo, lineno);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    additionalfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    additionalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                //additionalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void print_Click(object sender, EventArgs e)
        {
            string IndividualPCNo = Request.QueryString["IndividualPCNo"];
            Response.Redirect("NewIndividualScoreCardReport.aspx?IndividualPCNo=" + IndividualPCNo);
        }

        protected void printsubindicators_Click(object sender, EventArgs e)
        {
            string IndividualPCNo = Request.QueryString["IndividualPCNo"];
            Response.Redirect("NewIndividualScoreCardSubIndicatorReport.aspx?IndividualPCNo=" + IndividualPCNo);
        }
    }
}