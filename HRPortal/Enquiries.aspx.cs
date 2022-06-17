using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Enquiries : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var courses = nav.ExamSittingCycle.Where(r => r.Sitting_Status == "Active");
                int counter = 0;
                foreach (var Coursez in courses)
                {
                    //Cycle.Text = Coursez.Sitting_Cycle;
                    //projectCode.Text = Coursez.Examination_Project_ID;

                }

                var Examcourses = nav.Courses;
                examinationIDs.DataSource = Examcourses;
                examinationIDs.DataTextField = "Code";
                examinationIDs.DataValueField = "No_Series";
                examinationIDs.DataBind();
                examinationIDs.Items.Insert(0, new ListItem("--select--", ""));
            }
        }

        protected void studentAccounts_Click(object sender, EventArgs e)
        {
            try
            {


                var nav = new Config().ReturnNav();
                string courseId = examinationIDs.SelectedValue.Trim();
                string NUmericRegNo = RegistrationNo.Text.Trim();
                string RegNo = courseId + "/" + NUmericRegNo;
                ExamId.Text = courseId;
                ExamRegNo.Text = NUmericRegNo;

                var examinationAccounts = nav.ExaminationAccounts.Where(r => r.Registration_No == RegNo).ToList();

                if (examinationAccounts.Count > 0)
                {
                    studentsAccount.Visible = true;
                    PaymentsMpesa.InnerHtml = "<div class='alert alert-success'>One record found <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    studentsAccount.Visible = false;
                    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>Sorry, The Examination Account with the given number does not exist in the system. Kindly Contact Examination department  for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                studentsAccount.Visible = false;
                PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>Sorry, The Examination Account with the given number does not exist in the system. Kindly Contact Examination department  for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        
        }

        protected void idsearch_Click(object sender, EventArgs e)
        {
            try
            {


                var nav = new Config().ReturnNav();
                string tIdNumber = IdNumber.Text.Trim();
                
             

                var examinationAccounts = nav.ExaminationAccounts.Where(r => r.ID_No == tIdNumber).ToList();

                if (examinationAccounts.Count > 0)
                {
                    try
                    {

                        studentAcc.Visible = true;
                        PaymentsMpesa.InnerHtml = "<div class='alert alert-success'>One record found <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    catch (Exception ex)
                    {

                        PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    studentAcc.Visible = false;
                    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>Sorry, The Examination Account with the given number does not exist in the system. Kindly Contact Examination department  for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                studentAcc.Visible = false;
                PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>Sorry, The Examination Account with the given number does not exist in the system. Kindly Contact Examination department  for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}