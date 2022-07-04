using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class SalaryAdvanceApplication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                divisionCode.Text = Convert.ToString(Session["DivisionCode"]);

                string applicationNo = Request.QueryString["applicationNo"];
                var nav = new Config().ReturnNav();
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                var salaryAdvanceApplication = nav.Payments.Where(r =>r.Account_No == employeeNo && r.Document_Type == "Salary Advance" && r.No== applicationNo).ToList();
                if (salaryAdvanceApplication.Count > 0)
                {
                    foreach (var advance in salaryAdvanceApplication)
                    {
                        String startDate = Convert.ToDateTime(advance.Recovery_From).ToString("dd/MM/yyyy"); //dd/mm/yyyy
                        startDate = startDate.Replace("-", "/");                    

                        salaryAdvance.Text = Convert.ToString(advance.Salary_Advance);
                        monthsDeducted.Text = Convert.ToString(advance.No_of_months_deducted);
                        purpose.Text = advance.Purpose;
                        recoveryStartMonth.Text = Convert.ToString(advance.Recovery_Start_Month);
                        RecoveryStartDate.Text = startDate;

                       
                    }
                }
                
            }

        }

        protected void approval_Click(object sender, EventArgs e)
        {
            try
            {
                
                String applicationNo = Convert.ToString(Session["applicationNo"]);
                String status = Config.ObjNav.SendSalaryAdvanceApproval(Convert.ToString(Session["employeeNo"]), applicationNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('salaryAdvanceApplications.aspx') }, 5000);", true);
                    //Response.Redirect("salaryAdvanceApplications.aspx");
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception t)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void salaryAdvanceApp_Click(object sender, EventArgs e)
        {
            Decimal tSalaryAdvance = Convert.ToDecimal(salaryAdvance.Text.Trim());
            String tdivisionCode = Convert.ToString(Session["DivisionCode"]);
            String temployeeNo = Convert.ToString(Session["employeeNo"]);
            String tBrancehsCode = Convert.ToString(Session["BranchCode"]);
            int tmonthsDeducted = Convert.ToInt32(monthsDeducted.Text.Trim());
            String Tpurpose = purpose.Text.Trim();
            String trecoveryStartMonth = recoveryStartMonth.Text.Trim();
            String tRecoveryStartDate = RecoveryStartDate.Text.Trim();
           
            Boolean error = false;
            string message = "";
            DateTime lStartDate = new DateTime(); 
                   
            CultureInfo culture = new CultureInfo("ru-RU");
            lStartDate = DateTime.Parse(tRecoveryStartDate, culture.DateTimeFormat);

            
        
            
            if (error == true)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

            else
            {
                //apply for leave
                try
                {
                    String applicationNo = "";
                    try
                    {
                        applicationNo = Request.QueryString["applicationNo"];
                        applicationNo = String.IsNullOrEmpty(applicationNo) ? "" : applicationNo;
                    }
                    catch (Exception)
                    {
                        applicationNo = "";
                    }
              
                         String status = Config.ObjNav.SalaryAdvanceApplication(applicationNo, temployeeNo, tdivisionCode, tBrancehsCode, tSalaryAdvance, tmonthsDeducted, Tpurpose, trecoveryStartMonth, lStartDate);
                        String[] info = status.Split('*');                       
                        if (info[0] == "success")
                        {
                        Session["applicationNo"] = info[2];
                        applicationNo = info[2];
                        generalFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        approval.Visible = true;
                      
                        }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }                

                }
                catch (Exception t)
                {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }
     
    }
}