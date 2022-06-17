using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class p9 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 4;
        }

        protected void generate_Click(object sender, EventArgs e)
        {
            feedback.InnerHtml = "";
             String tStartDate = startDate1.Text.Trim();
             String tEndDate = endDate2.Text.Trim();
            Boolean Error = false; 
            //DateTime mStartDate = new DateTime();
            //DateTime mEndDate = new DateTime();
            var date = Convert.ToDateTime(tStartDate);
            var date1 = Convert.ToDateTime(tEndDate);


            try
            {

                if (date >= date1)
                {
                    Error = true;
                    feedback.InnerHtml = "<div class='alert alert-danger'>Start date cannot be greater than end date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {

                feedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            
            //try
            //{
            //    CultureInfo culture = new CultureInfo("ru-RU");
            //    mStartDate = DateTime.ParseExact(tStartDate, "d/M/yyyy", CultureInfo.InvariantCulture);
           
            //}
            //catch (Exception)
            //{
            //    Error = true;
            //    feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid start date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
            //try
            //{
            //    CultureInfo culture = new CultureInfo("ru-RU");
            //    mEndDate = DateTime.ParseExact(tEndDate, "d/M/yyyy", CultureInfo.InvariantCulture);  
            //}
            //catch (Exception)
            //{
            //    Error = true;
            //    feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid end date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
            if (!Error)
            {
                try
                {
                    String status = Config.ObjNav.GenerateP9((String) Session["employeeNo"],
                        date, date1);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        p9form.Attributes.Add("src", ResolveUrl(info[2]));
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
    }
}