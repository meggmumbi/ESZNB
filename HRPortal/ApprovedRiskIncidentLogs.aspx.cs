using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ApprovedRiskIncidentLogs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                string requisitionNo = Request.QueryString["DocumentNo"];
                var incidentLogs = nav.RiskIncidentLogsQ.Where(r => r.Incident_ID == requisitionNo).ToList();
                if (incidentLogs.Count > 0)
                {
                    foreach (var incident in incidentLogs)
                    {
                        strategicplanno.Text = incident.Risk_Register_Type;
                        funcionalworkplan.Text = incident.Risk_Management_Plan_ID;
                        RiskId.Text = Convert.ToString(incident.Risk_ID);
                        RiskDescription.Text = incident.Risk_Description;
                        riskVategory.Text = incident.Risk_Incident_Category;
                        severityLevel.Text = incident.Severity_Level;
                        dateIncident.Text = Convert.ToString(incident.Incident_Date);
                        timeIncident.Text = Convert.ToString(incident.Incident_Time);
                        OccurrenceType.Text = incident.Occurrence_Type;
                        incidentLocations.Text = incident.Incident_Location_Details;
                        primTrigger.Text = Convert.ToString(incident.Primary_Trigger_ID);
                        rootCauseSumm.Text = incident.Root_Cause_Summary;
                        categoryOfPerson.Text = incident.Category_of_Person_Reporting;
                        reportedBy.Text = incident.Reported_By_Name;
                        responsibilityCenter.Text = incident.Department_ID;
                        EscalationOfficer.Text = incident.Escalate_to_Officer_No;


                    }

                }
            }
        }

        protected void printriskreport_Click(object sender, EventArgs e)
        {
            string DocumentNo = Request.QueryString["DocumentNo"];
            Response.Redirect("IncidentLogPrintout.aspx?&&DocumentNo=" + DocumentNo);
        }
    }
}