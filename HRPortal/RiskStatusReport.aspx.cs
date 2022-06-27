using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class RiskStatusReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
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
                Officer.Items.Insert(0, new ListItem("--select--", ""));

            }
        }

        protected void riskType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string docType = riskType.SelectedValue.Trim();
            if (docType == "1")
            {
                var nav = new Config().ReturnNav();
                var riskMngt = nav.managementPlans.Where(r => r.Document_Type == "Corporate");
                riskMngtPlan.DataSource = riskMngt;
                riskMngtPlan.DataTextField = "Description";
                riskMngtPlan.DataValueField = "Document_No";
                riskMngtPlan.DataBind();
            }
            else if (docType == "2")
            {
                var nav = new Config().ReturnNav();
                var riskMngt = nav.managementPlans.Where(r => r.Document_Type == "Functional (Directorate)");
                riskMngtPlan.DataSource = riskMngt;
                riskMngtPlan.DataTextField = "Description";
                riskMngtPlan.DataValueField = "Document_No";
                riskMngtPlan.DataBind();
            }
            else if (docType == "3")
            {
                var nav = new Config().ReturnNav();
                var riskMngt = nav.managementPlans.Where(r => r.Document_Type == "Functional (Department)");
                riskMngtPlan.DataSource = riskMngt;
                riskMngtPlan.DataTextField = "Description";
                riskMngtPlan.DataValueField = "Document_No";
                riskMngtPlan.DataBind();
            }
            else if (docType == "4")
            {
                var nav = new Config().ReturnNav();
                var riskMngt = nav.managementPlans.Where(r => r.Document_Type == "Project");
                riskMngtPlan.DataSource = riskMngt;
                riskMngtPlan.DataTextField = "Description";
                riskMngtPlan.DataValueField = "Document_No";
                riskMngtPlan.DataBind();
            }

        }

        protected void addRiskTReport_Click(object sender, EventArgs e)
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
                String triskRegisterType= String.IsNullOrEmpty(riskType.SelectedValue.Trim()) ? "" : riskType.SelectedValue.Trim();
                String tRiskMngt = String.IsNullOrEmpty(riskMngtPlan.SelectedValue.Trim()) ? "" : riskMngtPlan.SelectedValue.Trim();               
                String empNo = Convert.ToString(Session["employeeNo"]);
               
                
                String status = Config.ObjNav.CreateRiskStatusReport(requisitionNo, empNo, Convert.ToInt32(triskRegisterType), tRiskMngt);
                String[] info = status.Split('*');               
                if (info[0] == "success")
                {
                    try
                    {
                        if (newRequisition)
                        {
                            requisitionNo = info[2];
                        }
                        Response.Redirect("RiskStatusReport.aspx?step=2&&requisitionNo=" + requisitionNo);


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

        protected void post_Click(object sender, EventArgs e)
        {

        }

        protected void back_Click(object sender, EventArgs e)
        {

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
                    String status = Config.ObjNav.CloseRisk(employeeName, requisitionNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void editTeamMember_Click(object sender, EventArgs e)
        {
            try
            {
                String tmitigationStrat = mitigationStrat.Text;                
                String triskAction = riskAction.Text;
                String tOfficer = Officer.SelectedValue.Trim();
                Decimal mDays = 0;
                Boolean error = false;
                String message = "";

            
                if (String.IsNullOrEmpty(tmitigationStrat))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter Mitigation Strategy";
                }
             
                if (String.IsNullOrEmpty(tOfficer))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select the responsible Officer";
                }
                if (String.IsNullOrEmpty(triskAction))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter Risk Response Taken";
                }
                if (error)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //Convert.ToString(Session["employeeNo"])
                    String tOriginalNumber = originalNo.Text.Trim();
                    String tOriginalWorkType = originalWorkType.Text.Trim();
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    String status = Config.ObjNav.AddRiskResponse(Convert.ToString(Session["employeeNo"]), requisitionNo, tOriginalNumber, Convert.ToInt32(tOriginalWorkType), tmitigationStrat, triskAction, tOfficer);
                    String[] info = status.Split('*');
                    mitigationStrat.Text = "";
                    riskAction.Text = "";
                    Officer.SelectedValue = "";

                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
    }
}