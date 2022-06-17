using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class RiskManagementFramework : System.Web.UI.Page
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
                var riskframework = nav.RiskManagement;
                foreach (var risk in riskframework)
                {
                    description.Text = risk.Description;
                    primarypurpose.Text = risk.Primary_Purpose;
                    documentnumber.Text = risk.External_Document_No;
                    responsinbility.Text = risk.Overall_Responsibility;
                    Organizationname.Text = risk.Organization_Name;
                    revisiondate.Text = Convert.ToDateTime(risk.Last_Revision_Date).ToString("dd/MM/yyyy");
                }
            }
        }

        protected void printriskreport_Click(object sender, EventArgs e)
        {
            Response.Redirect("RiskMngtFrameworkReport.aspx");
        }
    }
}