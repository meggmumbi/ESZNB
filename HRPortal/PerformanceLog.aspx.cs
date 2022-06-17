using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class PerformanceLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            if (!IsPostBack)
            {
                var workplans = nav.PerfomanceContractHeader.Where(x => x.Approval_Status == "Released" && x.Responsible_Employee_No == Convert.ToString(Session["employeeNo"]) && x.Document_Type == "Individual Scorecard").ToList();
                List<Item> list = new List<Item>();
                foreach (var item in workplans)
                {
                    Item itm = new Item();
                    itm.Description = item.No + " :" + item.Description;
                    itm.No = item.No;
                    list.Add(itm);
                }
                personalscorecardno.DataSource = list;
                personalscorecardno.DataValueField = "No";
                personalscorecardno.DataTextField = "Description";
                personalscorecardno.DataBind();

                String IndividualPCNo = "";
                try
                {
                    IndividualPCNo = Request.QueryString["PerformanceLogNo"];
                    if (string.IsNullOrEmpty(IndividualPCNo))
                    {
                        IndividualPCNo = "";
                    }
                }
                catch (Exception)
                {
                    IndividualPCNo = "";
                }
                if (!String.IsNullOrEmpty(IndividualPCNo))
                {
                    var plog = nav.PerformanceDiaryLog.Where(x => x.No == IndividualPCNo).ToList();
                    foreach (var item in plog)
                    {
                        startDate.Text = Convert.ToDateTime(item.Activity_Start_Date).ToString("d/MM/yyyy");
                        endDate.Text = Convert.ToDateTime(item.Activity_End_Date).ToString("d/MM/yyyy");
                        awp.Text = item.AWP_ID;
                        csp.Text = item.CSP_ID;
                        description.Text = item.Description;
                        yr.Text = item.Year_Reporting_Code;
                        personalscorecardno.SelectedValue = item.Personal_Scorecard_ID;
                    }
                }
                try
                {
                    //String status = new Config().ObjNav().GenerateTimetable();
                    string code = Request.QueryString["PerformanceLogNo"];
                    string status = Config.ObjNav.FnGeneratePlogReport2(code);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        p9form.Attributes.Add("src", ResolveUrl(info[2]));
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch (Exception t)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
        }
        protected void apply_Click(object sender, EventArgs e)
        {
            try
            {

                string tpersonalscorecardno = personalscorecardno.SelectedValue.Trim();
                string docNo = Request.QueryString["PerformanceLogNo"];
                string tDesc = description.Text;

                if (string.IsNullOrEmpty(tDesc))
                {
                    generalfeedback.InnerHtml = "<div class='alert alert-success'> Kindly enter description to proceed <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

                String status = Config.ObjNav.FnNewPerformanceLogEntry2(docNo, Convert.ToString(Session["employeeNo"]), tpersonalscorecardno, tDesc);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    generalfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("PerformanceLog.aspx?step=2&&PerformanceLogNo=" + info[2] + "&&CSPNo=" + info[3] + "&&ScoreCardNo=" + info[4]);
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
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SubmitSelectedPlogCategories(List<Targets> targetNumber1)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;

            try
            {
                if (targetNumber1 == null)
                {
                    targetNumber1 = new List<Targets>();
                }
                foreach (Targets target in targetNumber1)
                {

                    var ttPerformanceLogNo = HttpContext.Current.Session["PerformanceLogNo"].ToString();
                    var tStrategicPlanNumber = HttpContext.Current.Session["CSPNo"].ToString();
                    var tScoreCardNumber = HttpContext.Current.Session["ScoreCardNo"].ToString();
                    string InitiativeNumber = target.TargetNumber;

                    var status = Config.ObjNav.FnSubmitSelectedPLogCategories2(tStrategicPlanNumber, tScoreCardNumber, ttPerformanceLogNo, InitiativeNumber);
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

        protected void NextToStep3_Click(object sender, EventArgs e)
        {
            string CSPNo = Request.QueryString["CSPNo"];
            string ScoreCardNo = Request.QueryString["ScoreCardNo"];
            string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
            Response.Redirect("PerformanceLog.aspx?step=3&&PerformanceLogNo=" + PerformanceLogNo + "&&CSPNo=" + CSPNo + "&&ScoreCardNo=" + ScoreCardNo);
        }

        protected void BackToStep1_Click(object sender, EventArgs e)
        {
            string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
            Response.Redirect("PerformanceLog.aspx?step=1&&PerformanceLogNo=" + PerformanceLogNo);
        }

        protected void BackToStep2_Click(object sender, EventArgs e)
        {

            // Response.Redirect("PerformanceLog.aspx?step=2&&PerformanceLogNo=" + info[2] + "&&CSPNo=" + info[3] + "&&ScoreCardNo=" + info[4]);
            string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
            string CSPNo = Request.QueryString["CSPNo"];
            string ScoreCardNo = Request.QueryString["ScoreCardNo"];
            Response.Redirect("PerformanceLog.aspx?step=2&&PerformanceLogNo=" + PerformanceLogNo + "&&CSPNo=" + CSPNo + "&&ScoreCardNo=" + ScoreCardNo);
        }

        protected void personalscorecardno_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {

                string tpersonalscorecardno = personalscorecardno.SelectedValue.Trim();
                string docNo = "";
                String status = Config.ObjNav.FnNewPerformanceLogEntry2(docNo, Convert.ToString(Session["employeeNo"]), tpersonalscorecardno, "");
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    Response.Redirect("PerformanceLog.aspx?PerformanceLogNo=" + info[2]);
                    var nav = new Config().ReturnNav();
                    var plog = nav.PerformanceDiaryLog.Where(x => x.No == info[2]).ToList();
                    foreach (var item in plog)
                    {
                        startDate.Text = Convert.ToDateTime(item.Activity_Start_Date).ToString("d/MM/yyyy");
                        endDate.Text = Convert.ToDateTime(item.Activity_End_Date).ToString("d/MM/yyyy");
                        awp.Text = item.AWP_ID;
                        csp.Text = item.CSP_ID;
                        description.Text = item.Description;
                        yr.Text = item.Year_Reporting_Code;
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

        protected void SubmitPlogs_Click(object sender, EventArgs e)
        {
            try
            {
                string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
                String status = Config.ObjNav.FnSendPlogApproval2(PerformanceLogNo);
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

        protected void revovePlogLine_Click(object sender, EventArgs e)
        {
            try
            {
                string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
                int lineno = Convert.ToInt32(approvedocNo.Text);
                String status = Config.ObjNav.FnRemovePerformanceLogLine2(PerformanceLogNo, lineno);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                //feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        //protected void print_Click(object sender, EventArgs e)
        //{
        //    string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
        //    Response.Redirect("PLogReport.aspx?PerformanceLogNo=" + PerformanceLogNo);
        //}

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
                    string InitiativeNumber = target.TargetNumber;
                    var status = Config.ObjNav.FnSubmitSelectedPLogCategories(target.plogNo, InitiativeNumber);
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
        public static string SubmitSelectedAddInitiatives(List<SelectedCoreInitiatives> targetNumber)
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
                    string InitiativeNumber = target.TargetNumber;
                    var status = Config.ObjNav.FnSubmitSelectedAddPLogCategories(target.plogNo, InitiativeNumber);
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
        public static string SubmitSelectedJDInitiatives(List<SelectedCoreInitiatives> targetNumber)
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
                    string InitiativeNumber = target.TargetNumber;
                    var status = Config.ObjNav.FnSubmitSelectedJDPLogCategories(target.plogNo, InitiativeNumber);
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

        protected void savePlogLine_Click(object sender, EventArgs e)
        {
            try
            {
                string msg = "";
                bool err = false;
                string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
                string nlineno = txtLineNo.Text.Trim();
                string nachievedtarget = txtAchieved_Target.Text.Trim();
                string ncomments = txtComments.Text.Trim();
                string ninitiativeno = txtInitiativeNo.Text.Trim();

                string accreditationNo = Request.QueryString["PerformanceLogNo"].Trim();
                accreditationNo = accreditationNo.Replace('/', '_');
                accreditationNo = accreditationNo.Replace(':', '_');
                string path1 = Config.FilesLocation() + "Performance Logs Card/";
                string str1 = Convert.ToString(accreditationNo);
                string folderName = path1 + str1 + "/";

                if (string.IsNullOrEmpty(nachievedtarget))
                {
                    err = true;
                    msg = "Please enter achieved target";
                }
                if (string.IsNullOrEmpty(ncomments))
                {
                    err = true;
                    msg = "Please enter comments";
                }
                //if (!txtfileupload.HasFile)
                //{
                //    err = true;
                //    msg = "Please attach document";
                //}
                if (err)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String status = Config.ObjNav.FnUpdatePerformanceTargetLinesDetails2(PerformanceLogNo, Convert.ToInt32(nlineno), Convert.ToDecimal(nachievedtarget), ncomments);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        //try
                        //{
                        //    if (txtfileupload.HasFile)
                        //    {
                        //        string extension = System.IO.Path.GetExtension(txtfileupload.FileName);
                        //        if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                        //        {
                        //            string filename = accreditationNo + "_INITIATIVE_NO_" + ninitiativeno + extension;
                        //            if (!Directory.Exists(folderName))
                        //            {
                        //                Directory.CreateDirectory(folderName);
                        //            }
                        //            if (File.Exists(folderName + filename))
                        //            {
                        //                File.Delete(folderName + filename);
                        //            }
                        //            txtfileupload.SaveAs(folderName + filename);
                        //            if (File.Exists(folderName + filename))
                        //            {
                        //                feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        //            }
                        //        }
                        //        else
                        //        {
                        //            feedback.InnerHtml = "<div class='alert alert-danger'>The file was not uploaded, kindly try pdf files! <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        //        }

                        //    }
                        //    else
                        //    {
                        //        feedback.InnerHtml = "<div class='alert alert-danger'>The file was not uploaded, kindly make sure you attach a document! <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                        //    }
                        //}
                        //catch (Exception ex)
                        //{
                        //    feedback.InnerHtml = "<div class='alert alert-danger'>The file was not uploaded, kindly try again! " + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        //}

                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deletefile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Performance Logs Card/";
                String imprestNo = Request.QueryString["PerformanceLogNo"];
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                String documentDirectory = filesFolder + imprestNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
    }
}