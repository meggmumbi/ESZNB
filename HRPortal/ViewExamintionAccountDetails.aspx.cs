using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ViewExamintionAccountDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                var nav = new Config().ReturnNav();
                String regNo = Request.QueryString["regNo"];
                var students = nav.ExaminationAccounts.Where(r => r.Registration_No == regNo);
                foreach (var student in students)
                {
                    firstName.Text = student.First_Name;
                    middlename.Text = student.Middle_Name;
                    lastName.Text = student.Surname;
                    idnumber.Text = student.ID_No;
                    email.Text = student.Email;
                    phoneNumber.Text = student.Phone_No;
                    address.Text = student.Address;
                    address2.Text = student.Address_2;
                    countys.Text = student.County;
                    postal.SelectedValue = student.Post_Code;
                    city.Text = student.City;
                    RenewalAmount.Text = Convert.ToString(student.Renewal_Amount);
                    renPending.Text = Convert.ToString(student.Renewal_Pending);
                    ReActivation.Text = Convert.ToString(student.Re_Activation_Amount);
                    balance.Text = Convert.ToString(student.Balance_LCY);
                    DropDownList1.SelectedValue = student.Country_Region_Code;

                }

                var today = DateTime.Today;
                var exmcycle = nav.ExamCycle;
                examCycle.DataSource = exmcycle;
                examCycle.DataTextField = "examCycle";
                examCycle.DataValueField = "examCycle";
                examCycle.DataBind();
            }

        }

        protected void resultsSlip_Click(object sender, EventArgs e)
        {
            // <td><a href="ResultSlip.aspx?No=<%=detail.Student_Reg_No%>&&sitting=<%=detail.Examination_Sitting_ID %>" class="btn btn-success"><i class="fa fa-eye"></i>Result Slip</a></td>
            var nav = new Config().ReturnNav();
            string sitting = examCycle.SelectedValue.Trim();
            string No = Request.QueryString["regNo"];
            string IdNumbers = Convert.ToString(Session["idNumber"]);
            string message = "";


            var details = nav.ExaminationResults.Where(r => r.Student_Reg_No == No && r.Examination_Sitting_ID == sitting).ToList();

            if (details.Count > 0)
            {
                Response.Redirect("ResultSlip.aspx?No=" + No + "&&sitting=" + sitting);
            }
            else
            {
                message = "The student did not sit for the " + sitting + " Examination.";
                examResults.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }

        protected void examCycle_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            string sitting = examCycle.SelectedValue.Trim();
            string No = Request.QueryString["regNo"];
            examSitting.Text = sitting;
            string IdNumbers = Convert.ToString(Session["idNumber"]);
            string message = "";


            var details = nav.ExaminationResults.Where(r => r.Student_Reg_No == No && r.Examination_Sitting_ID == sitting).ToList();

            if (details.Count > 0)
            {
                studentAcc.Visible = false;
                SpecificSitting.Visible = true;
            }
            else
            {
                message = "The student did not sit for the " + sitting + " Examination.";
                examResults.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                studentAcc.Visible = true;
                SpecificSitting.Visible = false;
            }

            updPanel1.Update();

        }
    }
}