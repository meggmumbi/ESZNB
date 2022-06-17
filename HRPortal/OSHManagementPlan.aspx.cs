using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class OSHManagementPlan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var planId = Request.QueryString["planId"];
                var managementPlanLines = nav.HSPmanagement.Where(r => r.Plan_ID == planId);
                foreach(var planLines in managementPlanLines)
                {
                    managementplanId.Text = planLines.Plan_ID;
                    planType.Text = planLines.Plan_Type;
                    riskplan.Text = planLines.Risk_Management_Plan_ID;
                    description.Text = planLines.Description;
                    department.Text = planLines.Department_ID;
                    primaryMission.Text = planLines.Primary_Mission;
                    submissionstartDate.Text = Convert.ToString(planLines.Planning_Start_Date);
                    submissionEndDate.Text = Convert.ToString(planLines.Planning_End_Date);
                }
            }

        }
    }
}