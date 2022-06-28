using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class RiskOwnership : System.Web.UI.Page
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

                var responsibility = nav.ResponsibilityCenters.Where(r=>r.Operating_Unit_Type== "Department/Center");
                responsibilityCenter.DataSource = responsibility;
                responsibilityCenter.DataValueField = "Code";
                responsibilityCenter.DataTextField = "Name";
                responsibilityCenter.DataBind();
                responsibilityCenter.Items.Insert(0, new ListItem("--select--", ""));
            }
        }

        protected void resikResp_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;

                string doctype = Request.QueryString["DocumentType"];
                int riskId = Convert.ToInt32(Request.QueryString["RiskId"]);
               

                string tresponsibilityCenter = responsibilityCenter.SelectedValue.Trim();
                string tOfficer = Officer.SelectedValue.Trim();


                if (hasError)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                   
                    String requisitionNo = Request.QueryString["DocumentNo"];
                    String status = Config.ObjNav.FnAddRiskOwnership(requisitionNo, riskId, tresponsibilityCenter, tOfficer);
                    String[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            string TapplicationNo = Convert.ToString(Request.QueryString["DocumentNo"]);
            Response.Redirect("DivisionRiskApp.aspx?step=2&&requisitionNo=" + TapplicationNo);
           
        }
    }
}
