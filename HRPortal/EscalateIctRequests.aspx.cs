using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class EscalateIctRequests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                escalate();
            }

        }

        protected void Escalate_Click(object sender, EventArgs e)
        {
            //requestno
            var jobNo = "";
            if (Request.QueryString["requestno"] != null)
            {
                jobNo = Request.QueryString["requestno"].ToString();
            }
            else
            {
                Response.Redirect("AssigneeHelpdeskRequests.aspx");
            }
            try
            {
                var desc = Description.Text.ToString();
                var assigned = txtEscalate.SelectedValue.ToString();
                var status = Config.ObjNav.EscalatedHelpdeskRequest(jobNo, assigned, desc);
                string[] info = status.Split('*');
                if (info[0] == "success")
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

        private void escalate()
        {
            var nav = new Config().ReturnNav();
            var assigned = nav.EscalateTo.Where(x=>x.Reports_To_Officer_Name!="").ToList();
            List<Users> list = new List<Users>();
            foreach (var item in assigned)
            {
                Users usr = new Users();
                usr.UserName = item.Reports_To_Officer_Name;
                usr.user = item.Officer_Name + " :" + item.Reports_To_Officer_Name;
                list.Add(usr);

            }
            
            txtEscalate.DataSource = list;
            txtEscalate.DataValueField = "UserName";
            txtEscalate.DataTextField = "user";
            txtEscalate.DataBind();
        }
    }
}