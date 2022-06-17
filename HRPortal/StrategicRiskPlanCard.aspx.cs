using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class StrategicRiskPlanCard : System.Web.UI.Page
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
                string DocumentNo = Request.QueryString["DocumentNo"];
                var riskframework = nav.managementPlans.Where(x => x.Document_No == DocumentNo);
                foreach (var risk in riskframework)
                {
                    documentno.Text = risk.Document_No;
                    corporateplan.Text = risk.Corporate_Strategic_Plan_ID;
                    yearcode.Text = risk.Year_Code;
                    description.Text = risk.Description;
                    documentdate.Text = Convert.ToDateTime(risk.Document_Date).ToString("dd/MM/yyyy");
                }
            }
        }

        protected void printriskreport_Click1(object sender, EventArgs e)
        {
            string DocumentNo = Request.QueryString["DocumentNo"];
            string DocType = Request.QueryString["DocType"];
            Response.Redirect("RiskManagementPlansReport.aspx?&&DocumentNo=" + DocumentNo + "DocType=" + DocType);
        }
    }
}