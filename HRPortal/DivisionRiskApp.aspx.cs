using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class DivisionRiskApp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["employeeNo"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                var nav = new Config().ReturnNav();
                

                var riskCategory = nav.AllCsps.Where(r=>r.Implementation_Status== "Ongoing");
                csp.DataSource = riskCategory;
                csp.DataValueField = "Code";
                csp.DataTextField = "Description";
                csp.DataBind();
                csp.Items.Insert(0, new ListItem("--select--", ""));


                var tconsolidated = nav.managementPlans.Where(r => r.Document_Type == "Corporate");
                consolidated.DataSource = tconsolidated;
                consolidated.DataValueField = "Document_No";
                consolidated.DataTextField = "Description";
                consolidated.DataBind();
                consolidated.Items.Insert(0, new ListItem("--select--", ""));

                

                var tyearCode = nav.FinancialYearCode;
                yearCode.DataSource = tyearCode;
                yearCode.DataValueField = "Code";
                yearCode.DataTextField = "Code";
                yearCode.DataBind();
                yearCode.Items.Insert(0, new ListItem("--select--", ""));

                var allResources = nav.Resources.Where(r => r.Type == "Person");
                List<Employee> resources = new List<Employee>();
                foreach (var employee in allResources)
                {
                    Employee emp = new Employee();
                    emp.EmployeeNo = employee.No;
                    emp.EmployeeName = employee.No + " " + employee.Name;
                    resources.Add(emp);
                }

                Officer.DataSource = resources;
                Officer.DataValueField = "EmployeeNo";
                Officer.DataTextField = "EmployeeName";
                Officer.DataBind();
                Officer.Items.Insert(0, new ListItem("--select--", ""));

                var riskCategoryz = nav.RiskCategory;
                riskCat.DataSource = riskCategoryz;
                riskCat.DataValueField = "Code";
                riskCat.DataTextField = "Description";
                riskCat.DataBind();
                riskCat.Items.Insert(0, new ListItem("--select--", ""));

                var riskActualRating = nav.RiskRatingScaleLine.Where(r => r.Risk_Rating_Scale_Type == "Likelihood Rating");
                risklikelihoodCode.DataSource = riskActualRating;
                risklikelihoodCode.DataValueField = "Code";
                risklikelihoodCode.DataTextField = "Code";
                risklikelihoodCode.DataBind();
                risklikelihoodCode.Items.Insert(0, new ListItem("--select--", ""));

                var RiskImpact = nav.RiskRatingScaleLine.Where(r => r.Risk_Rating_Scale_Type == "Impact Rating");
                impactType.DataSource = RiskImpact;
                impactType.DataValueField = "Code";
                impactType.DataTextField = "Code";
                impactType.DataBind();
                impactType.Items.Insert(0, new ListItem("--select--", ""));

                var RiskAppetite = nav.RiskRatingScaleLine.Where(r => r.Risk_Rating_Scale_Type == "Risk Appetite Rating");
                riskappetite.DataSource = RiskAppetite;
                riskappetite.DataValueField = "Code";
                riskappetite.DataTextField = "Description";
                riskappetite.DataBind();
                riskappetite.Items.Insert(0, new ListItem("--select--", ""));

                var riskImpact = nav.RiskImpacts;
                impactCodes.DataSource = riskImpact;
                impactCodes.DataValueField = "Code";
                impactCodes.DataTextField = "Description";
                impactCodes.DataBind();
                impactCodes.Items.Insert(0, new ListItem("--select--", ""));

                var Pillars = nav.StrategicPillars.Where(r => r.Blocked == false);
                startPillars.DataSource = Pillars;
                startPillars.DataValueField = "Source_ID";
                startPillars.DataTextField = "Description";
                startPillars.DataBind();
                startPillars.Items.Insert(0, new ListItem("--select--", ""));



            }
        }
        protected void next_Click(object sender, EventArgs e)
        {

            try
            {

                String requisitionNo = "";
                Boolean newRequisition = false;
                try
                {
                    requisitionNo = Request.QueryString["requisitionNo"];
                    if (String.IsNullOrEmpty(requisitionNo))
                    {
                        requisitionNo = "";
                        newRequisition = true;
                    }
                }
                catch (Exception)
                {
                    newRequisition = true;
                    requisitionNo = "";
                }
                String tcsp = String.IsNullOrEmpty(csp.SelectedValue.Trim()) ? "" : csp.SelectedValue.Trim();
                String tconsolidated = String.IsNullOrEmpty(consolidated.SelectedValue.Trim()) ? "" : consolidated.SelectedValue.Trim();
                String tyearCode = String.IsNullOrEmpty(yearCode.SelectedValue.Trim()) ? "" : yearCode.SelectedValue.Trim();
                String tOfficer = String.IsNullOrEmpty(Officer.SelectedValue.Trim()) ? "" : Officer.SelectedValue.Trim();
                String empNo = Convert.ToString(Session["employeeNo"]);
                String DivisionCode = Convert.ToString(Session["DivisionCode"]);


                String status = Config.ObjNav.CreateRiskRegisterDivision(requisitionNo,DivisionCode, tcsp, tconsolidated, tyearCode, tOfficer);
                String[] info = status.Split('*');                
                if (info[0] == "success")
                {
                    try
                    {
                        if (newRequisition)
                        {
                            requisitionNo = info[2];
                        }
                        Response.Redirect("DivisionRiskApp.aspx?step=2&&requisitionNo=" + requisitionNo);


                    }
                    catch (Exception ex)
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void riskActual_SelectedIndexChanged(object sender, EventArgs e)
        {
            string TriskActual = risklikelihoodCode.SelectedValue.Trim();
            var nav = new Config().ReturnNav();
            var actualRating = nav.RiskRatingActualScale.Where(r => r.Risk_Rating_Scale_Type == "Likelihood Rating" && r.Code == TriskActual);

            riskActual.DataSource = actualRating;
            riskActual.DataValueField = "Actual_Rating";
            riskActual.DataTextField = "Actual_Rating";
            riskActual.DataBind();
            riskActual.Items.Insert(0, new ListItem("--select--", ""));

            updPanel1.Update();


        }

        protected void impactType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string TimpactType = impactType.SelectedValue.Trim();
            var nav = new Config().ReturnNav();
            var actualRating = nav.RiskRatingActualScale.Where(r => r.Risk_Rating_Scale_Type == "Impact Rating" && r.Code == TimpactType);

            impactRating.DataSource = actualRating;
            impactRating.DataValueField = "Actual_Rating";
            impactRating.DataTextField = "Actual_Rating";
            impactRating.DataBind();
            impactRating.Items.Insert(0, new ListItem("--select--", ""));

            updPanel1.Update();
        }
        protected void RiskImpactTyp_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            int TimpactType = Convert.ToInt32(RiskImpactTyp.SelectedValue.Trim());
            if (TimpactType == 1)
            {
                var responses = nav.RiskResponceStrategy.Where(r => r.Risk_Impact_Type == "Negative");
                GenRiskStrat.DataSource = responses;
                GenRiskStrat.DataValueField = "Strategy_ID";
                GenRiskStrat.DataTextField = "Description";
                GenRiskStrat.DataBind();
                GenRiskStrat.Items.Insert(0, new ListItem("--select--", ""));

            }
            else if (TimpactType == 2)
            {
                var responses = nav.RiskResponceStrategy.Where(r => r.Risk_Impact_Type == "Positive");
                GenRiskStrat.DataSource = responses;
                GenRiskStrat.DataValueField = "Strategy_ID";
                GenRiskStrat.DataTextField = "Description";
                GenRiskStrat.DataBind();
                GenRiskStrat.Items.Insert(0, new ListItem("--select--", ""));
            }
        }
        protected void resikResp_Click(object sender, EventArgs e)
        {
            string triskCat = riskCat.SelectedValue.Trim();
            string tstartPillars = startPillars.SelectedValue.Trim();
            string triskDesc = riskDesc.Text.Trim();
            string trisklikelihoodCode = risklikelihoodCode.SelectedValue.Trim();
            Decimal triskActual = Convert.ToDecimal(riskActual.SelectedValue.Trim());
            string timpactType = impactType.SelectedValue.Trim();
            Decimal timpactRating = Convert.ToDecimal(impactRating.SelectedValue.Trim());
            int tRiskImpactTyp = Convert.ToInt32(RiskImpactTyp.SelectedValue.Trim());
            string triskappetite = riskappetite.SelectedValue.Trim();
            string timpactCodes = impactCodes.SelectedValue.Trim();
            string tGenRiskStrat = GenRiskStrat.SelectedValue.Trim();


            Boolean error = false;
            string message = "";


            if (error == true)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

            else
            {
                //apply for leave
                try
                {
                    String applicationNo = "";
                    try
                    {
                        applicationNo = Request.QueryString["requisitionNo"];
                        applicationNo = String.IsNullOrEmpty(applicationNo) ? "" : applicationNo;
                    }
                    catch (Exception)
                    {
                        applicationNo = "";
                    }

                    String status = Config.ObjNav.FnAddRiskRegister(applicationNo, triskCat, tstartPillars, triskDesc, trisklikelihoodCode, triskActual, timpactType, timpactRating, tRiskImpactTyp, triskappetite, timpactCodes, tGenRiskStrat);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        generalFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "HidePopup", "$('#editTeamMemberModal').modal('hide');window.location.reload()", true);
                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception t)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {

            Boolean error = false;
            string message = "";
            string TapplicationNo = Convert.ToString(Request.QueryString["requisitionNo"]);

            if (error == true)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

            else
            {
                //apply for leave
                try
                {
                  
                    

                    var status = Config.ObjNav.PostDivisionRegister(TapplicationNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        
                    }
                    else
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception t)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            string TapplicationNo = Convert.ToString(Request.QueryString["requisitionNo"]);
            Response.Redirect("DivisionRiskApp.aspx?step=1&&requisitionNo=" + TapplicationNo);
        }
    }
}