using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class PostedImprestMemo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 3;
            var nav = new Config().ReturnNav();
            if (!IsPostBack)
            {
          
                try
                {

                    // String status = Config.ObjNav.GeneratepostedImprestMemo("IM-20-21_00019");
                    String status = "";
                    // Convert.ToDateTime(selecetdPayPeriod,culture));
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        payslipFrame.Attributes.Add("src", ResolveUrl(info[2]));
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch (Exception t)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>Your payslip could not be generated " + t.Message + "</div>";
                }
            }
        }

        //protected void payperiod_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        feedback.InnerHtml = "";
        //        var selecetdPayPeriod = payperiod.SelectedValue;
        //        CultureInfo culture = new CultureInfo("ru-RU");
        //        String status = Config.ObjNav.GeneratePayslip((String)Session["employeeNo"],
        //           Convert.ToDateTime(selecetdPayPeriod));
        //        String[] info = status.Split('*');
        //        if (info[0] == "success")
        //        {
        //            payslipFrame.Attributes.Add("src", ResolveUrl(info[2]));
        //        }
        //        else
        //        {
        //            feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
        //                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //    }
        //    catch (Exception t)
        //    {
        //        feedback.InnerHtml = "<div class='alert alert-danger'>Your payslip could not be generated" + t.Message + "</div>";
        //    }

        //}

        //protected void generatePayslip_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        feedback.InnerHtml = "";
        //        var selecetdPayPeriod = payperiod.SelectedValue;
        //        CultureInfo culture = new CultureInfo("ru-RU");
        //        String status = Config.ObjNav.GeneratePayslip((String)Session["employeeNo"],
        //           Convert.ToDateTime(selecetdPayPeriod));
        //        String[] info = status.Split('*');
        //        if (info[0] == "success")
        //        {
        //            payslipFrame.Attributes.Add("src", ResolveUrl(info[2]));
        //        }
        //        else
        //        {
        //            feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
        //                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //    }
        //    catch (Exception t)
        //    {
        //        feedback.InnerHtml = "<div class='alert alert-danger'>Your payslip could not be generated" + t.Message + "</div>";
        //    }

        //}
    
}
}