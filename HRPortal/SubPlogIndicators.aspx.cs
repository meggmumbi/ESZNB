using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class SubPlogIndicators : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Unnamed_Click(object sender, EventArgs e)
        {

            string CSPNo = Request.QueryString["CSPNo"];
            string ScoreCardNo = Request.QueryString["PCID"];
            String PlogNo = Request.QueryString["PlogNo"];
            Response.Redirect("PerformanceLog.aspx?step=2&&PerformanceLogNo=" + PlogNo + "&&CSPNo=" + CSPNo + "&&ScoreCardNo=" + ScoreCardNo);
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertSubPlogLines(List<SubPlogLineData> primarydetails)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                if (primarydetails == null)
                {
                    primarydetails = new List<SubPlogLineData>();
                }
                foreach (SubPlogLineData primarydetail in primarydetails)
                {
                    var achievedtarget = Convert.ToDecimal(primarydetail.achievedTarget);

                    int entrynumber = Convert.ToInt32(primarydetail.entryNo);

                    if (string.IsNullOrEmpty(primarydetail.comments))
                    {
                        results = "Kindly enter the comment to proceed!";
                    }

                    String status = Config.ObjNav.FnInsertPlogSubActivities2(entrynumber, primarydetail.plogNo, primarydetail.initiativeNo, primarydetail.pcId, achievedtarget, primarydetail.comments);
                    String[] info = status.Split('*');
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
    }
}