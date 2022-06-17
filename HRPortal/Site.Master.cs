using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String Name = (String) Session["name"];
            String EmployeeNo = (String) Session["employeeNo"];
            String idNo = (String) Session["idNo"];
            if (String.IsNullOrEmpty(Name)&&(String.IsNullOrEmpty(EmployeeNo)||String.IsNullOrEmpty(idNo)))
            {
                Response.Redirect("Login.aspx");
            }
           

        }
    }
}