using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class carLoanApplication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {



                var nav = new Config().ReturnNav();
                var vendors = nav.Vendors.ToList();
                loanVendor.DataSource = vendors;
                loanVendor.DataTextField = "Name";
                loanVendor.DataValueField = "No";
                loanVendor.DataBind();

                List<PayPeriods> payperiodz = new List<PayPeriods>();
                var paYperiods = nav.payperiods;
                foreach (var payPeriod in paYperiods)
                {
                    PayPeriods list1 = new PayPeriods();
                    list1.name = payPeriod.Name + " " + Convert.ToDateTime(payPeriod.Starting_Date).ToString("dd/MM/yyyy");
                    list1.startingDate = payPeriod.Starting_Date;
                    payperiodz.Add(list1);

                }
                recoveryStartMonths.DataSource = payperiodz;
                recoveryStartMonths.DataValueField = "startingDate";
                recoveryStartMonths.DataTextField = "name";
                recoveryStartMonths.DataBind();



                divisionCode.Text = Convert.ToString(Session["DivisionCode"]);

                string applicationNo = Request.QueryString["applicationNo"];
                
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                var salaryAdvanceApplication = nav.Payments.Where(r => r.Account_No == employeeNo && r.Payment_Type == "Car Loan" && r.No == applicationNo).ToList();
                if (salaryAdvanceApplication.Count > 0)
                {
                    foreach (var advance in salaryAdvanceApplication)
                    {
                        String startDate = Convert.ToDateTime(advance.Recovery_From).ToString("dd/MM/yyyy"); //dd/mm/yyyy
                        startDate = startDate.Replace("-", "/");

                        loanRequested.Text = Convert.ToString(advance.Salary_Advance);
                        monthsDeducted.Text = Convert.ToString(advance.No_of_months_deducted);
                        purpose.Text = advance.Purpose;
                        recoveryStartMonths.SelectedValue = Convert.ToString(advance.Recovery_Start_Month);
                        //RecoveryStartDate.Text = startDate;
                        loanVendor.SelectedValue = advance.Loan_Vendor;
                        
                    }
                }







            }
        }

        protected void carLoanApplication_Click(object sender, EventArgs e)
        {
            Decimal tloanAmount = Convert.ToDecimal(loanRequested.Text.Trim());
            String tdivisionCode = Convert.ToString(Session["DivisionCode"]);
            String temployeeNo = Convert.ToString(Session["employeeNo"]);
            String tBrancehsCode = Convert.ToString(Session["BranchCode"]);
            int tmonthsDeducted = Convert.ToInt32(monthsDeducted.Text.Trim());
            String Tpurpose = purpose.Text.Trim();
            var trecoveryStartMonth = recoveryStartMonths.SelectedValue.Trim();
          //  String tRecoveryStartDate = RecoveryStartDate.Text.Trim();
            string tloanVendor = loanVendor.SelectedValue.Trim();

            Boolean error = false;
            string message = "";
            DateTime lStartDate = new DateTime();

            CultureInfo culture = new CultureInfo("ru-RU");
            lStartDate = DateTime.Parse(trecoveryStartMonth, culture.DateTimeFormat);




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

                    String status = Config.ObjNav.CarLoanApplication(applicationNo, temployeeNo, tdivisionCode, tBrancehsCode, tloanAmount, tmonthsDeducted, Tpurpose, Convert.ToDateTime(trecoveryStartMonth), tloanVendor);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        Session["applicationNo"] = info[2];
                        applicationNo = info[2];
                        generalFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        approval.Visible = true;
                        //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                        //Response.Redirect("salaryAdvanceApplications.aspx");
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

        protected void approval_Click(object sender, EventArgs e)
        {
            try
            {

                String applicationNo = Convert.ToString(Session["applicationNo"]);
                String status = Config.ObjNav.SendCarLoanApproval(Convert.ToString(Session["employeeNo"]), applicationNo);
                String[] info = status.Split('*');

                if (info[0] == "success")
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('carLoanApplications.aspx') }, 5000);", true);
                    //Response.Redirect("carLoanApplications.aspx");
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
    }
}