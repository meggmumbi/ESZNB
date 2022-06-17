using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class StandardAppraisalSubIndicators : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void previous_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("NewStandardAppraisal.aspx?step=2&&docNo=" + docNo);
        }
    }
}