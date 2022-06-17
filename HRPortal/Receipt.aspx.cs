using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Receipt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string documentType = Request.QueryString["documentType"];
                string status = "";
                try
                {
                    //String status = new Config().ObjNav().GenerateTimetable();
                    string code = Request.QueryString["applicationNo"];
                    if (documentType == "Registration")
                    {
                        status = Config.ObjNav.PrintReceipt(code);
                    }
                    else if (documentType == "Booking")
                    {
                        status = Config.ObjNav.PrintReceiptBookin(code);
                    }
                    else if (documentType == "Exemption")
                    {
                        status = Config.ObjNav.PrintReceiptExemption(code);
                    }
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        p9form.Attributes.Add("src", ResolveUrl(info[1]));
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