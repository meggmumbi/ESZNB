using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Apply : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         
         
        }

        protected void applyJob_Click(object sender, EventArgs e)
        {
            String jobId = Request.QueryString["id"];
            var idNo = Session["idNo"].ToString();
            if (String.IsNullOrEmpty(jobId))
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Please select the job you are applying for</div>";
            }
            else
            {
                try
                {
                    //String status = Config.ObjNav.Apply((String)Session["idNo"], jobId);
                    String status = Config.ObjNav.Apply(idNo, jobId);
                    String[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";

                }
                catch (Exception ex)
                {
                    // feedback.InnerHtml = "<div class='alert alert-danger'>An error occured while processing your request. Please try again later</div>";
                    feedback.InnerHtml = ex.Message;
                }
               
            }
        }

        protected void backtoProfile_Click(object sender, EventArgs e)
        {
             Response.Redirect("profile.aspx");
        }
    }
}