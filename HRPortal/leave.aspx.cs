using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class leave : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
          var nav = new Config().ReturnNav();
            Session["active"] = 2;
            if (!IsPostBack)
            {
                
                try
                {
                    if (!String.IsNullOrEmpty(Request.QueryString["leave"].Trim()))
                    {
                        try
                        {
                            String leaveNo = Request.QueryString["leave"].Trim();
                            //generate leave report
                            String status = Config.ObjNav.GenerateLeaveForm((String) Session["employeeNo"], leaveNo);
                            String[] info = status.Split('*');
                            if (info[0] == "success")
                            {
                                String fileName = info[1];
                                leaveForm.Attributes.Add("src", ResolveUrl(fileName));
                                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "showLeaveForm()", true);
                            }
                            else
                            {
                                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                        }
                        catch (Exception t)
                        {
                            feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }
                }
                catch (Exception)
                {
                    
                }
            }
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String tLeaveNo = leavNoToApprove.Text.Trim();
                String status = Config.ObjNav.SendRecordForApproval((String)Session["employeeNo"], tLeaveNo,"leave");
                String[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-"+info[0]+"'>" + info[1] +
                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void cancelApproval_Click(object sender, EventArgs e)
                {
                    try
                    {
                        String tLeaveNo = cancelLeaveNo.Text.Trim();
                        String status = Config.ObjNav.CancelRecordApproval((String)Session["employeeNo"], tLeaveNo,"leave");
                        String[] info = status.Split('*');
                        feedback.InnerHtml = "<div class='alert alert-"+info[0]+"'>" + info[1] +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                    catch (Exception t)
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

    }
}