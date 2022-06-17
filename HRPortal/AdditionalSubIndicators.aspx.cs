using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class AdditionalSubIndicators : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var u = nav.UnitofMeasure;
                uom.DataSource = u;
                uom.DataTextField = "Description";
                uom.DataValueField = "Code";
                uom.DataBind();

                edituom.DataSource = u;
                edituom.DataTextField = "Description";
                edituom.DataValueField = "Code";
                edituom.DataBind();
            }
        }
        protected void apply_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String ScoreCardId = Convert.ToString(Request.QueryString["IndividualPCNo"]);
                string ActivityNo = Convert.ToString(Request.QueryString["ActivityNo"]);
                string tsubinitiative = subinitiative.Text.Trim();
                string tsubindicator = subindicator.Text.Trim();
                string tuom = uom.SelectedValue;
                int ttarget = Convert.ToInt32(target.Text.Trim());
                string ystartdate = startdate.Text.Trim();
                decimal nassweight = Convert.ToDecimal(nassignedweight.Text.Trim());
                string assignedweight = Request.QueryString["AssignedWeight"];
                decimal tAssignedWeight = Convert.ToDecimal(assignedweight);
                DateTime tstartdates = new DateTime();
                if (ystartdate.Length > 1)
                {
                    tstartdates = DateTime.ParseExact(ystartdate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                }

                var nav = new Config().ReturnNav();
                var sp = nav.SubPCObjective.Where(r => r.Initiative_No == ActivityNo && r.Workplan_No == ScoreCardId);
                decimal LineTotalWeights = 0;
                decimal Totalweights = 0;
                foreach (var item in sp)
                {
                   // LineTotalWeights += Convert.ToDecimal(item.Assigned_Weight);
                }
                Totalweights = LineTotalWeights + nassweight;
                if (Totalweights <= tAssignedWeight)
                {
                    String status = Config.ObjNav.FnNewIndividualCardSubActivities(ScoreCardId, ActivityNo, tsubinitiative, tsubindicator, tuom, ttarget, tstartdates, nassweight);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>The Total sub indicator assigned weights (<b>" + Totalweights + "</b>) cannot be greater than additional initiative assigned weight (<b>" + tAssignedWeight + "</b>), kindly use a lower value!!<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void deleteSubActity_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String ScoreCardId = Convert.ToString(Request.QueryString["IndividualPCNo"]);
                string ActivityNo = Convert.ToString(Request.QueryString["ActivityNo"]);
                int tsubinitiativeEntry = Convert.ToInt32(subactivityEntryNo.Text.Trim());
                String status = Config.ObjNav.FnDeleteIndividualCardSubActivities((String)Session["employeeNo"], ScoreCardId, ActivityNo, tsubinitiativeEntry);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                              "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void PreviousPage_Click(object sender, EventArgs e)
        {
            var csp = Convert.ToString(Session["StrategicPlanNo"]);
            var AnnualCode = Convert.ToString(Session["AnnualCode"]);
            var IndividualPCNo = Convert.ToString(Session["IndividualPCNo"]);
            var SeniorPCNo = Convert.ToString(Session["SeniorPCNo"]);

            Response.Redirect("NewIndividualScoreCard.aspx?step=3&&IndividualPCNo=" + IndividualPCNo + "&&StrategicPlanNo=" + csp + "&&SeniorPCNo=" + SeniorPCNo + "&&AnnualCode=" + AnnualCode);
        }

        protected void editsubindicatorbutton_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String ScoreCardId = Convert.ToString(Request.QueryString["IndividualPCNo"]);
                int tsubinitiativeEntry = Convert.ToInt32(originalLine.Text.Trim());
                string ActivityNo = initiativeno.Text;
                string tsubinitiative = editsubinitiative.Text.Trim();
                string tsubindicator = editsubindicator.Text.Trim();
                string tuom = edituom.SelectedValue;
                int ttarget = Convert.ToInt32(edittarget.Text.Trim());
                string ystartdate = editcompletiondate.Text.Trim();
                decimal nassweight = Convert.ToDecimal(nassignedweight1.Text.Trim());
                string assignedweight = Request.QueryString["AssignedWeight"];
                decimal tAssignedWeight = Convert.ToDecimal(assignedweight);
                DateTime tstartdates = new DateTime();
                if (ystartdate.Length > 1)
                {
                    //tstartdates = DateTime.ParseExact(ystartdate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    tstartdates = DateTime.ParseExact(ystartdate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                }

                var nav = new Config().ReturnNav();
                var sp = nav.SubPCObjective.Where(r => r.Initiative_No == ActivityNo && r.Workplan_No == ScoreCardId);
                decimal LineTotalWeights = 0;
                decimal Totalweights = 0;
                foreach (var item in sp)
                {
                   // LineTotalWeights += Convert.ToDecimal(item.Assigned_Weight);
                }
                decimal lineTarget = 0;
                var LT = nav.SubPCObjective.Where(x => x.Entry_Number == tsubinitiativeEntry).ToList();
                foreach (var item in LT)
                {
                   // lineTarget = Convert.ToDecimal(item.Assigned_Weight);
                }
                Totalweights = (LineTotalWeights + nassweight) - lineTarget;

                if (Totalweights <= tAssignedWeight)
                {

                    String status = Config.ObjNav.FnEditIndividualCardSubActivities(ScoreCardId, ActivityNo, tsubinitiativeEntry, tsubinitiative, tsubindicator, tuom, ttarget, tstartdates, nassweight);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>The total sub indicator assigned weights (<b>" + Totalweights + "</b>) cannot be greater than core initiative assigned weight (<b>" + tAssignedWeight + "</b>), kindly use a lower value!!<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}