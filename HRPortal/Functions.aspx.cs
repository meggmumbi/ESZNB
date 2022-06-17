using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Functions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }
        
        [System.Web.Services.WebMethod]
        public static string GetCurrentTime(string name)
        {
            return "Hello " + name + Environment.NewLine + "The Current Time is: "
                + DateTime.Now.ToString();
        }
        [System.Web.Services.WebMethod]
        public String GetApprovalEntries()
        {
            return "Hello Victor";
        }
    }
}