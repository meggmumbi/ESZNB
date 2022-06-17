using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class AssignHelpDeskRequests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                AssignRequests();
            }

        }

        protected void addAssignee_Click(object sender, EventArgs e)
        {
            var jobNo = "";
            if (Request.QueryString["requestno"] != null)
            {
                 jobNo = Request.QueryString["requestno"].ToString();
            }else
            {
                Response.Redirect("OpenHelpDeskItems.aspx");
            }
            try
            {
                var assigned = Assignee.SelectedValue.ToString();
                var status = Config.ObjNav.AssignHelpdeskRequest(jobNo, assigned);
                string[] info = status.Split('*');
                if(info[0] == "success")
                {
                    ictFeedback.InnerHtml = "<div class='alert alert-success'> '" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("OpenHelpDeskItems.aspx");
                }

                //ictFeedback.InnerHtml = "<div class='alert alert-success'> '"+info[1]+"' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception ex)
            {

                ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }


        }

        private void AssignRequests()
        {
            //Assignee
            List<Users> usr = new List<Users>();
            var nav = new Config().ReturnNav();
            var assigned = nav.HelpDeskAssignee.Where(x=>x.Employee_No != "" && x.Help_Desk_Category != "" && x.Region_Code !="").ToList();
            foreach(var item in assigned)
            {
                string emp = item.Employee_No;
                string cat = item.Help_Desk_Category;
                string region = item.Region_Code;
                Users u = new Users();
                u.user = item.UserName + " :" + item.Help_Desk_Category + " :" + item.Region_Code;
                u.UserName = item.UserName;
                usr.Add(u);
               
            }
            Assignee.DataSource = usr;
            Assignee.DataValueField = "UserName";
            Assignee.DataTextField = "user";
            Assignee.DataBind();


        }
    }
}