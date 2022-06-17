using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class payslip : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 3;
            var nav = new Config().ReturnNav();
            DateTime year;
            string yearS = "";
            if (!IsPostBack)
            {
                List<PayPeriods> payperiodz = new List<PayPeriods>();
                var paYperiods = nav.payperiods;
                foreach(var payPeriod in paYperiods)
                {
                    PayPeriods list1 = new PayPeriods();
                    list1.name = payPeriod.Name + " " + Convert.ToDateTime(payPeriod.Starting_Date).ToString("dd/MM/yyyy");
                    list1.startingDate = payPeriod.Starting_Date;
                    payperiodz.Add(list1);

                }
                payperiod.DataSource = payperiodz;
                payperiod.DataValueField = "startingDate";
                payperiod.DataTextField = "name";
                payperiod.DataBind();
                try
                {
                    CultureInfo culture = new CultureInfo("ru-RU");
                    var selecetdPayPeriod = payperiod.SelectedValue;
                    String status = Config.ObjNav.GeneratePayslip((String) Session["employeeNo"], Convert.ToDateTime(selecetdPayPeriod));
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
                    feedback.InnerHtml = "<div class='alert alert-danger'>Your payslip could not be generated "+t.Message+"</div>";
                }
            }
        }

        protected void payperiod_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                feedback.InnerHtml = "";
                var selecetdPayPeriod = payperiod.SelectedValue;
                CultureInfo culture = new CultureInfo("ru-RU");
                String status = Config.ObjNav.GeneratePayslip((String)Session["employeeNo"],
                   Convert.ToDateTime(selecetdPayPeriod));
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
                feedback.InnerHtml = "<div class='alert alert-danger'>Your payslip could not be generated" + t.Message + "</div>";
            }

        }

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