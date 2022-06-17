using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ResolveHelpdesk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ResolveRequest_Click(object sender, EventArgs e)
        {
            var jobNo = "";
            if (Request.QueryString["requestno"] != null)
            {
                 jobNo = Request.QueryString["requestno"].ToString();
            }
            var desc = Description.Text.ToString();
            try
            {
                var status = Config.ObjNav.ResolveHelpdeskRequest(jobNo, desc);
                string[] info = status.Split('*');
                if(info[0] == "success")
                {
                    ictFeedback.InnerHtml = "<div class='alert alert-success'> '" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("AssigneeHelpdeskRequests.aspx");

                }
                

            }
            catch (Exception ex)
            {
                ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
            }

        }
    }
}