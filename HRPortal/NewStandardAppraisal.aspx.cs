using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class NewStandardAppraisal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            var nav = new Config().ReturnNav();
            if (!IsPostBack)
            {
                var csp = nav.CorporateStrategicPlans.Where(x => x.Approval_Status == "Released" && x.Implementation_Status == "Ongoing");
                strategyplan.DataSource = csp;
                strategyplan.DataTextField = "Description";
                strategyplan.DataValueField = "Code";
                strategyplan.DataBind();

                var pmp = nav.PerformanceManagementPlan;
                performancemngplan.DataSource = pmp;
                performancemngplan.DataTextField = "Description";
                performancemngplan.DataValueField = "No";
                performancemngplan.DataBind();

                var personalSC = nav.PerfomanceContractHeader.Where(x => x.Document_Type == "Individual Scorecard" && x.Responsible_Employee_No == Convert.ToString(Session["employeeNo"]) && x.Status == "Signed");
                personalscorecard.DataSource = personalSC;
                personalscorecard.DataTextField = "Description";
                personalscorecard.DataValueField = "No";
                personalscorecard.DataBind();

                var senior = nav.Employees.ToList();
                List<Item> list = new List<Item>();
                foreach (var item in senior)
                {
                    Item itm = new Item();
                    itm.Description = item.First_Name + " " + item.Last_Name;
                    itm.No = item.No;
                    list.Add(itm);
                }
                supervisorname.DataSource = list;
                supervisorname.DataTextField = "Description";
                supervisorname.DataValueField = "No";
                supervisorname.DataBind();

                String IndividualPCNo = "";
                try
                {
                    IndividualPCNo = Request.QueryString["docNo"];
                }
                catch (Exception)
                {
                    IndividualPCNo = "";
                }
                if (!String.IsNullOrEmpty(IndividualPCNo))
                {
                    var plog = nav.PerfomanceEvaluation.Where(x => x.No == IndividualPCNo).ToList();
                    foreach (var item in plog)
                    {
                        description.Text = item.Description;
                        strategyplan.SelectedValue = item.Strategy_Plan_ID;
                        personalscorecard.SelectedValue = item.Personal_Scorecard_ID;
                        supervisorname.SelectedValue = item.Supervisor_Staff_No;
                        try
                        {
                            performancemngplan.SelectedValue = item.Performance_Mgt_Plan_ID;
                            LoadData();
                        }
                        catch
                        {

                        }
                    }
                }

                //if (step == 2)
                //{
                //    try
                //    {
                //        string docNo = Request.QueryString["docNo"];
                //        String status = Config.ObjNav.FnGenerateStandardAppraisalReport(docNo);
                //        String[] info = status.Split('*');
                //        if (info[0] == "success")
                //        {
                //            p9form.Attributes.Add("src", ResolveUrl(info[2]));
                //        }
                //        else
                //        {
                //            feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                //                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //        }
                //    }
                //    catch (Exception t)
                //    {
                //        feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                //                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //    }
                //}

            }
        }

        protected void LoadData()
        {
            var nav = new Config().ReturnNav();
            string tperformancemngplan = performancemngplan.SelectedValue;
            var task = nav.PerformancePlanTask.Where(x => x.Task_Category == "Performance Review" && x.Performance_Mgt_Plan_ID == tperformancemngplan).ToList();
            List<Item> list = new List<Item>();
            foreach (var item in task)
            {
                Item itm = new Item();
                itm.Description = item.Performance_Mgt_Plan_ID + "_" + item.Description;
                itm.No = item.Task_Code;
                list.Add(itm);
            }
            performancetask.DataSource = list;
            performancetask.DataTextField = "Description";
            performancetask.DataValueField = "No";
            performancetask.DataBind();
        }

        protected void performancemngplan_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            string tperformancemngplan = performancemngplan.SelectedValue;
            var task = nav.PerformancePlanTask.Where(x => x.Task_Category == "Performance Review" && x.Performance_Mgt_Plan_ID == tperformancemngplan).ToList();
            List<Item> list = new List<Item>();
            foreach (var item in task)
            {
                Item itm = new Item();
                itm.Description = item.Performance_Mgt_Plan_ID + "_" + item.Description;
                itm.No = item.Task_Code;
                list.Add(itm);
            }
            performancetask.DataSource = list;
            performancetask.DataTextField = "Description";
            performancetask.DataValueField = "No";
            performancetask.DataBind();
        }

        protected void addgeneraldetails_Click(object sender, EventArgs e)
        {
            try
            {
                string tstrategicplan = strategyplan.SelectedValue;
                string tpmp = performancemngplan.SelectedValue;
                string tTask = performancetask.SelectedValue;
                string tsupervisor = supervisorname.SelectedValue;
                string tpersonalpc = personalscorecard.SelectedValue;
                string tDesc = description.Text.Trim();
                string temployeeNo = Convert.ToString(Session["employeeNo"]);
                string docNo = "";
                try
                {
                    docNo = Request.QueryString["docNo"];
                    if (string.IsNullOrEmpty(docNo))
                    {
                        docNo = "";
                    }
                }
                catch
                {
                    docNo = "";
                }

                string status = Config.ObjNav.FnNewStandardAppraisal(docNo, temployeeNo, tstrategicplan, tpmp, tTask, tsupervisor, tDesc, tpersonalpc);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    docNo = info[2];

                    Response.Redirect("NewStandardAppraisal.aspx?step=2&&docNo=" + docNo);
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

        protected void Sendapproval_Click(object sender, EventArgs e)
        {
            try
            {
                string docNo = Request.QueryString["docNo"];
                string status = Config.ObjNav.FnSubmitStandardAppraisal(docNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                }
                else
                {
                    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("NewStandardAppraisal.aspx?step=1&&docNo=" + docNo);
        }
    }
}