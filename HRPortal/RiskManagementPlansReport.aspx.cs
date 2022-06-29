using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class RiskManagementPlansReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                try
                {
                    feedback.InnerHtml = "";
                    string DocumentNo = Request.QueryString["DocumentNo"];
                   
                   
                    String status = Config.ObjNav.GenerateManagementPlanSummery(DocumentNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        payslipFrame.Attributes.Add("src", ResolveUrl(info[2 ]));
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch (Exception t)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "</div>";
                }
            }
        }
    }
}