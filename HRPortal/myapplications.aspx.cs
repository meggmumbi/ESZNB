using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class myapplications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 7;
            if(!IsPostBack)
            {
               /// getTotal();

            }
        }

        private void getTotal()
        {
            var nav = new Config().ReturnNav();
            int count = 0;
            int totalCount = 0;
            var positions = nav.MyJobApplications.Where(r => r.Application_No == Session["ApplicationNo"].ToString());
            foreach (var item in positions)
            {

                Session["jobId"] = item.Job_Applied_For;

            }
            var position = nav.MyJobApplications.Where(r => r.Job_Applied_For == Session["jobId"].ToString());
            foreach (var item in position)
            {
                count++;
            }
            totalCount = count;
            Session["count"] = totalCount;

        }
    }

   
}