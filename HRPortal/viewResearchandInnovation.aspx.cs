using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class viewResearchandInnovation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var today = DateTime.Today;
                var innovations = nav.InnovationSolicitation.Where(r => r.Document_Type == "Innovation Invitation" && r.Status == "Released" && r.Idea_Submission_End_Date >= today);
                foreach (var innovation in innovations)
                {
                    noticeNo.Text = innovation.Document_No;
                    innovationDescription.Text = innovation.Description;
                    category.Text = innovation.Innovation_Category;
                    department.Text = innovation.Department_ID;
                    submissionstartDate.Text = Convert.ToDateTime(innovation.Idea_Submission_Start_Date).ToString("dd/MM/yyyy");
                    submissionEndDate.Text = Convert.ToDateTime(innovation.Idea_Submission_End_Date).ToString("dd/MM/yyyyy");
                    executiveSummery.Text = innovation.Executive_Summary;
                }
            }
        }
    }
}