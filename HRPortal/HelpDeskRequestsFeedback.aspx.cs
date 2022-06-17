using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class HelpDeskRequestsFeedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                editRequest();
                //getCategories();
            }

        }
        
        private void editRequest()
        {
            var nav = new Config().ReturnNav();
            var appNo = Request.QueryString["jobNo"].ToString();

            var query = nav.MyHeldeskRequests.Where(x => x.Job_No == appNo).ToList();
            foreach(var item in query)
            {
               // category.Text = item.ICT_Issue_Category;
               // Description.Text = item.Description_of_the_issue;
            }
        }

        protected void GiveFeedBack_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            string message = "";
            var appNo = Request.QueryString["jobNo"].ToString();

            string desc = Description.Text.ToString();

            if (string.IsNullOrEmpty(desc))
            {
                error = true;
                message = "Please enter description ";

            }
            if (error == true)
            {
                ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
                try
                {

                    var status = Config.ObjNav.ProvideIctfeedback(appNo, desc);

                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        ictFeedback.InnerHtml = "<div class='alert alert-success'> '" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                        Response.Redirect("MyHelpDeskRequests.aspx");
                    }




                }
                catch (Exception ex)
                {

                    ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }


            }

        }

        protected void reopen_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            string message = "";
            string desc = Description.Text.ToString();
            if(string.IsNullOrEmpty(desc))
            {
                error = true;
                message = "Please enter description";
                return;
            }

            if(error == true)
            {

                ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
            else
            {
                
                try
                {
                    var jobno = Request.QueryString["jobNo"].ToString();
                    var status = Config.ObjNav.ReopenHelpdeskRequest(jobno, desc);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        ictFeedback.InnerHtml = "<div class='alert alert-success'> '" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("ClosedICTRequests.aspx");
                    }
                }
                catch (Exception ex)
                {

                    ictFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }
    }
}