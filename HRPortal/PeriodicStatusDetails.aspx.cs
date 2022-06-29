using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class PeriodicStatusDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                string DocumentNo = Request.QueryString["DocumentNo"];
                var riskframework = nav.RiskMEHeader.Where(x => x.Document_No == DocumentNo);
                foreach (var risk in riskframework)
                {
                    documentno.Text = risk.Document_No;
                    corporateplan.Text = risk.Risk_Register_Type;
                    yearcode.Text = risk.Risk_Management_Plan_ID;
                    description.Text = risk.Description;
                    documentdate.Text = Convert.ToDateTime(risk.Document_Date).ToString("dd/MM/yyyy");
                }
            }
        }
    }
}