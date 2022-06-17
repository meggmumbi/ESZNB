using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Configuration;

namespace HRPortal
{
    public partial class ApplicationForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                //Session["employeeNo"] = user.employeeNo;
                //Session["idNo"] = user.ID_Number;
                //int step = 0;
                var jobId = Request.QueryString["id"].ToString();

                appliedfor.Text = jobId + ":" + Session["desc"].ToString();
                

                //var jobId = Request.QueryString["id"].ToString();
                

                IdNo.Text = Session["idNo"].ToString();
                personalNo.Text = Session["employeeNo"].ToString();
                getDepartments();
                getCounties();
                fillGrid();

            }

        }
        //addMembership
        protected void addQualification_Click(object sender, EventArgs e)
        {
            string appNo = Session["appNo"].ToString();
            string jobId = Request.QueryString["id"].ToString();
            string from = qualificationFrom.Text.ToString();
            string to = qualificationTo.Text.ToString();
            string company = institution.Text.ToString();
            string grade = gradeAttained.Text.ToString();
            string specialty = specialization.Text.ToString();
            string Attain = Attainment.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            DateTime date = new DateTime();
            DateTime date1 = new DateTime();
            Boolean error = false;
            String message = "";

            if(string.IsNullOrEmpty(from))
            {
                error = true;
                message = "Please enter start date!";
            }
            if (string.IsNullOrEmpty(to))
            {
                error = true;
                message = "Please enter end date!";
            }
            if (string.IsNullOrEmpty(company))
            {
                error = true;
                message = "Please enter institution!";
            }
            if (string.IsNullOrEmpty(grade))
            {
                error = true;
                message = "Please enter Grade!";
            }
            if (string.IsNullOrEmpty(specialty))
            {
                error = true;
                message = "Please enter specializationn!";
            }
            if (string.IsNullOrEmpty(Attain))
            {
                error = true;
                message = "Please enter attainment!";
            }
            if(error == true)
            {
                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {

            if (!String.IsNullOrEmpty(from))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date = DateTime.ParseExact(from, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
             if (!String.IsNullOrEmpty(to))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date1 = DateTime.ParseExact(to, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            try
            {
                var status = Config.ObjNav.AddAcademicQualifications(appNo, company, Attain, specialty, grade,
                   empNo, jobId, date, date1);
                if(status=="success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'> Data successfully saved<a href='#' class='close' data-dismiss='success' aria-label='close'>&times;</a></div>";
                    
                }
                

            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'> '"+t.Message+"'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
           


            }

            }



        }
        protected void addProfession_Click(object sender, EventArgs e)
        {
            
            string jobId = Request.QueryString["id"].ToString();
            string from = prof_startDate.Text.ToString();
            string to = prof_endDate.Text.ToString();
            string company = prof_institution.Text.ToString();
            string grade = attainedScore.Text.ToString();
            string spec = pr_Specialization.Text.ToString();
            string attainment = pr_attainment.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
           

            DateTime date = new DateTime();
            DateTime date1 = new DateTime();

            Boolean error = false;
            String message = "";

            if (string.IsNullOrEmpty(from))
            {
                error = true;
                message = "Please enter start date!";
            }
            if (string.IsNullOrEmpty(to))
            {
                error = true;
                message = "Please enter end date!";
            }
            if (string.IsNullOrEmpty(company))
            {
                error = true;
                message = "Please enter institution!";
            }
            if (string.IsNullOrEmpty(spec))
            {
                error = true;
                message = "Please enter Specialization!";
            }
            if (string.IsNullOrEmpty(attainment))
            {
                error = true;
                message = "Please enter attainment!";
            }
            if(error == true)
            {
                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            { 
            if (!String.IsNullOrEmpty(from))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date = DateTime.ParseExact(from, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
             if (!String.IsNullOrEmpty(to))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date1 = DateTime.ParseExact(to, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            try
            {
                var status = Config.ObjNav.AddProffessionalQualifications(appNo, company, attainment, spec, grade, empNo, jobId, date, date1);
                if(status=="success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            
            }
            }

        }
        protected void addTraining_Click(object sender, EventArgs e)
        {
            string jobId = Request.QueryString["id"].ToString();
            string from = tr_StartDate.Text.ToString();
            string to = tr_EndDate.Text.ToString();
            string company = tr_institution.Text.ToString();
            string grade = tr_score.Text.ToString();
            string coursename = tr_courseName.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
            string attained = tr_score.Text.ToString();

            DateTime date = new DateTime();
            DateTime date1 = new DateTime();

            Boolean error = false;
            String message = "";


            if (string.IsNullOrEmpty(from))
            {
                error = true;
                message = "Please enter start date!";
            }
            if (string.IsNullOrEmpty(to))
            {
                error = true;
                message = "Please enter end date!";
            }
            if (string.IsNullOrEmpty(company))
            {
                error = true;
                message = "Please enter institution!";
            }
            if (string.IsNullOrEmpty(grade))
            {
                error = true;
                message = "Please enter grade!";
            }
            if (string.IsNullOrEmpty(coursename))
            {
                error = true;
                message = "Please enter coursename!";
            }

            if(error == true)
            {
                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            { 

            if (!String.IsNullOrEmpty(from))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date = DateTime.ParseExact(from, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
        if (!String.IsNullOrEmpty(to))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date1 = DateTime.ParseExact(to, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            try
            {
                var status = Config.ObjNav.AddTrainingAttended(date, date1,jobId,empNo, company, coursename,appNo,attained);
                if (status == "success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
            }

            }

        }
        protected void addMembership_Click(object sender, EventArgs e)
        {
            string jobId = Request.QueryString["id"].ToString();
            string p_body = m_body.Text.ToString();
            string reg_no = m_regNo.Text.ToString();
            string renewalDate = m_DateofRenewal.Text.ToString();
            string mType = m_Membershiptype.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
            DateTime date = new DateTime();

            Boolean error = false;
            String message = "";

            if (string.IsNullOrEmpty(p_body))
            {
                error = true;
                message = "Please enter body!";
            }
            if (string.IsNullOrEmpty(reg_no))
            {
                error = true;
                message = "Please enter registration number!";
            }
            if (string.IsNullOrEmpty(renewalDate))
            {
                error = true;
                message = "Please enter renewal date!";
            }
            if (string.IsNullOrEmpty(mType))
            {
                error = true;
                message = "Please enter membership type!";
            }

            if(error == true)
            {
                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
            else
            {

            


            if (!String.IsNullOrEmpty(renewalDate))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date = DateTime.ParseExact(renewalDate, "d/M/yyyy", CultureInfo.InvariantCulture);
            }

            try
            {
                var status = Config.ObjNav.AddProfessionalBody(appNo, jobId, empNo, p_body, reg_no,mType, date);
                if (status == "success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>  DataBind successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                   
                }

            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
               
            }

            }
          }
        protected void addEmploymentHistory_Click(object sender, EventArgs e)
        {
            string jobId = Request.QueryString["id"].ToString();
            string from = em_StartDate.Text.ToString();
            string to = em_EndDate.Text.ToString();
            string company = em_institution.Text.ToString();
            string position = em_positionHeld.Text.ToString();
            string grade = em_JobGrade.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
            string idNo = Session["idNo"].ToString();

            DateTime date = new DateTime();
            DateTime date1 = new DateTime();

            Boolean error = false;
            String message = "";

            if (string.IsNullOrEmpty(from))
            {
                error = true;
                message = "Please enter start date!";
            }
            if (string.IsNullOrEmpty(to))
            {
                error = true;
                message = "Please enter end date!";
            }

            if (string.IsNullOrEmpty(company))
            {
                error = true;
                message = "Please enter company!";
            }
            if (string.IsNullOrEmpty(position))
            {
                error = true;
                message = "Please enter position!";
            }
            if (string.IsNullOrEmpty(grade))
            {
                error = true;
                message = "Please enter grade!";
            }

            if(error == true)
            {
                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
            else
            {

           

            if (!String.IsNullOrEmpty(from))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date = DateTime.ParseExact(from, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            if (!String.IsNullOrEmpty(to))
            {
                CultureInfo culture = new CultureInfo("ru-RU");

                date1 = DateTime.ParseExact(to, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            try
            {
                var status = Config.ObjNav.AddEmploymentHistory(idNo,date, date1,company, position, grade,appNo,empNo,jobId);
                if (status == "success")
                {
                    academicQualification.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                academicQualification.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
             
            }
        }
    }
 
        protected void addReferee_Click(object sender, EventArgs e)
        {
            string name = ref_name.Text.ToString();
            string occupation = ref_Occupation.Text.ToString();
            string address = ref_Address.Text.ToString();
            string postcode = ref_Postcode.Text.ToString();
            string city = ref_City.Text.ToString();
            string email = ref_EmailAddress.Text.ToString();
            string period = ref_period.Text.ToString();
            string phone = ref_phone.Text.ToString();
            string jobId = Request.QueryString["id"].ToString();

            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
            string idNo = Session["idNo"].ToString();

            Boolean error = false;
            String message = "";

            if (string.IsNullOrEmpty(name))
            {
                error = true;
                message = "Please enter your name!";
            }
            if (string.IsNullOrEmpty(occupation))
            {
                error = true;
                message = "Please enter occupation!";
            }
            if (string.IsNullOrEmpty(address))
            {
                error = true;
                message = "Please enter address!";
            }
            if (string.IsNullOrEmpty(postcode))
            {
                error = true;
                message = "Please enter postcode!";
            }
            if (string.IsNullOrEmpty(city))
            {
                error = true;
                message = "Please enter city!";
            }
            if (string.IsNullOrEmpty(email))
            {
                error = true;
                message = "Please enter email!";
            }
            if (string.IsNullOrEmpty(period))
            {
                error = true;
                message = "Please enter period!";
            }
            if (string.IsNullOrEmpty(phone))
            {
                error = true;
                message = "Please enter phone!";
            }

            if(error == true)
            {
                referee.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {

            

            try
            {
                var status = Config.ObjNav.CreateReferee(appNo, empNo, name, occupation, address, 
                    postcode, phone, email, period, jobId);
                if (status == "success")
                {
                    referee.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                referee.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
              
            }

            }
        }
        
        protected void AddDetails_Click(object sender, EventArgs e)
        {
            //int step;
            string jobId = Request.QueryString["id"].ToString();
            string surname = Surname.Text.ToString();
            string firstname = Firstname.Text.ToString();
            string lastname = Lastname.Text.ToString();
            string title = txtTitle.Text.ToString();
            string phone = PhoneNo.Text.ToString();
            string altPhone = alt_PhoneNo.Text.ToString();
            string email = Email.Text.ToString();
            string altEmail = alt_Email.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string dpt = Center.SelectedValue.ToString();
            string DateOfBirth = DOB.Text.ToString();
            int gendr = Convert.ToInt32(Gender.SelectedValue.ToString());
            string ethnic = Ethnicity.Text.ToString();
            int disable = Convert.ToInt32(disability.SelectedValue.ToString());
            string regNo = registrationNo.Text.ToString();
            //string regDate = registrationDate.Text.ToString();
            string cnty = County.SelectedValue.ToString();
            string nty = Nationality.Text.ToString();
            string relign = religion.Text.ToString();
            int mStatus = Convert.ToInt32(Maritalstatus.SelectedValue.ToString());
            string IdNumber = Session["idNo"].ToString();
            string nhf = nhif.Text.ToString();
            string nsf = NSSF.Text.ToString();
            string txtPin = pinNo.Text.ToString();
            string crntPosition = currentPost.Text.ToString();
            string jgroup = jobGr.Text.ToString();
            string firstAppointmentDate =firstofDateappointment.Text.ToString();
            string lpromotionDate = Dateofcurrentappointment.Text.ToString();
            DateTime date = new DateTime();
            DateTime date1 = new DateTime();
            DateTime date2 = new DateTime();
            Boolean error = false;
            string Jdescription = "";

                  //var nav = new Config().ReturnNav();
                  //var positions = nav.VacantPositions.Where(r=>r.Job_ID == jobId);
                  //  foreach (var position in positions)
                  //  {
                  //   Jdescription = position.Job_Description;
                  //  }

            String message = "";

            if(string.IsNullOrEmpty(surname))
            {
                error = true;
                message = "please enter surname";
            }
            if (string.IsNullOrEmpty(firstname))
            {
                error = true;
                message = "please enter firstname";
            }
            if (string.IsNullOrEmpty(lastname))
            {
                error = true;
                message = "please enter lastname";
            }
            if (string.IsNullOrEmpty(title))
            {
                error = true;
                message = "please enter title";
            }
            if (string.IsNullOrEmpty(phone))
            {
                error = true;
                message = "please enter phone number";
            }
            if (string.IsNullOrEmpty(email))
            {
                error = true;
                message = "please enter your email";
                //DateOfBirth
            }
            if (string.IsNullOrEmpty(DateOfBirth))
            {
                error = true;
                message = "please enter your date of birth";
            }
            if (string.IsNullOrEmpty(ethnic))
            {
                error = true;
                message = "please enter your ethnic";
            }
           
            if (string.IsNullOrEmpty(nty))
            {
                error = true;
                message = "please enter your nationality";
            }
            if (string.IsNullOrEmpty(relign))
            {
                error = true;
                message = "please enter your religion";
            }
            if (string.IsNullOrEmpty(nhf))
            {
                error = true;
                message = "please enter your NHIF number";
            }
            if (string.IsNullOrEmpty(nsf))
            {
                error = true;
                message = "please enter your NSSF number";
            }
            if (string.IsNullOrEmpty(txtPin))
            {
                error = true;
                message = "please enter your pin number";
            }
            if (string.IsNullOrEmpty(crntPosition))
            {
                error = true;
                message = "please enter your current position";
            }
            if (string.IsNullOrEmpty(jgroup))
            {
                error = true;
                message = "please enter your job group";
            }
            if (string.IsNullOrEmpty(firstAppointmentDate))
            {
                error = true;
                message = "please enter your first appointment date";
            }
            if (string.IsNullOrEmpty(lpromotionDate))
            {
                error = true;
                message = "please enter your last promotion date";
            }

            if (error == true)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
         try
            {

                if (altEmail == "")
                {
                    altEmail = "";
                }
                else if (altPhone == "")
                {
                    altPhone = "";

                }
                else if (regNo == "")
                {
                    regNo = "";

                }
                
                else if (!String.IsNullOrEmpty(DateOfBirth))
                {
                    CultureInfo culture = new CultureInfo("ru-RU");

                    date = DateTime.ParseExact(DateOfBirth, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                else if (!String.IsNullOrEmpty(firstAppointmentDate))
                {
                    CultureInfo culture = new CultureInfo("ru-RU");

                    date1 = DateTime.ParseExact(firstAppointmentDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                else if (!String.IsNullOrEmpty(lpromotionDate))
                {
                    CultureInfo culture = new CultureInfo("ru-RU");

                    date2 = DateTime.ParseExact(lpromotionDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
            }
            catch (Exception)
            {

                throw ;
            }


            try
            {
                    var docNo = "";
                    
                    var status = Config.ObjNav.ApplyinternalHrJobs(docNo, jobId, surname, firstname, lastname,
                        title, date, gendr, disable,
                        regNo, cnty, nty, mStatus, relign, IdNumber, nhf, nsf, txtPin, phone, altPhone,
                       email, altEmail, empNo, dpt, crntPosition, jgroup,
                       date1, date2, ethnic);

                    if (status != "")
                {
                    Session["appNo"] = status;
                    feedback.InnerHtml = "<div class='alert alert-success'> Data successfully saved<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=2",false);

                }
                else
                {
                    error = true;
                    feedback.InnerHtml = "<div class='alert alert-danger'> An error occured during the process of saving.Please try again.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationForm.aspx?id=" + jobId, false);

                }

            }
            catch (Exception t)
            {
                error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
               

            }

            }
            //Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=2");

            //Response.Redirect("ApplicationForm.aspx?id="+ jobId);
        }

        protected void Step2_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=3");

        }
        public void getDepartments()
        {
            
            var nav = new Config().ReturnNav();
            var dpt = nav.ResponsibilityCenters.ToList();
            Center.DataSource = dpt;
            Center.DataValueField = "Code";
            Center.DataTextField = "Name";
            Center.DataBind();


        }
        public void getCounties()
        {
            var nav = new Config().ReturnNav();
            var counties = nav.Locations.ToList();
            County.DataSource = counties;
            County.DataValueField = "Code";
            County.DataTextField = "Name";
            County.DataBind();

        }

        protected void Step3_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=4");
         }

        protected void Step4_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=5");


        }

        protected void Step5_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();

            var appNo = Session["appNo"].ToString();
            

            var declare = Declare1.SelectedValue.ToString();
            Boolean decl = false;
            if (declare == "0")
            {
                decl = true;

            }
            else
            {
                decl = false;
            }
            try
            {
                var status = Config.ObjNav.AddDeclaration(decl, appNo);
                if (status == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception t)
            {

                documentsfeedback.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=6");

            


        }

        protected void SaveOtherPersonalDetails_Click(object sender, EventArgs e)
        {
            
            var jobId = Request.QueryString["id"].ToString();
            string convicted = convict.SelectedValue.ToString();
            string period = duration.Text.ToString();
            string dismiss = Dismissed.Text.ToString();
            string reason = dismissalReasons.Text.ToString();
            string highestLevel = txt_highestLevel.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string appNo = Session["appNo"].ToString();
            Boolean dism = false;
            Boolean conv = false;
            Boolean error = false;
            String message = "";

            if (string.IsNullOrEmpty(highestLevel))
            {
                error = true;
                message = "Please enter highest level!";
            }

            if(error == true)
            {
                otherPersonalDetails.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }else
            {
                
            if (dismiss == "0")
            {
                dism = true;
            }
            else if(dismiss == "1")
            {
                dism = false;
            }else if(convicted =="0")
            {
                conv = true;

            }
            else if(convicted =="1")
            {
                conv = false;

            }

            try
            {
                var status = Config.ObjNav.AddOtherPersonalDetails(appNo,conv, period, dism, reason, highestLevel);
                if (status == "success")
                {
                    otherPersonalDetails.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                 
                }

            }
            catch (Exception t)
            {

                    otherPersonalDetails.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
             
            }
            }
        }

        protected void AddAbility_Click(object sender, EventArgs e)
        {
            string ability = txtComment.Text.ToString();
            string appNo = Session["appNo"].ToString();
            string jobId = Request.QueryString["id"].ToString();

            Boolean error = false;
            String message = "";
            if(string.IsNullOrEmpty(ability))
            {
                message = "please enter your abilities";

            }

            if(error == true)
            {
                jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }else
            {
                
            try
            {
                var status = Config.ObjNav.AddAbilityDetails(ability,appNo);
                if (status == "success")
                {
                    jobDetails.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                    jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //Response.Redirect("ApplicationForm.aspx?id=" + jobId);
            }

            }

        }

        protected void AddDuties_Click(object sender, EventArgs e)
        {
            string duties = TextArea.Text.ToString();
            string appNo = Session["appNo"].ToString();
            string jobId = Request.QueryString["id"].ToString();

            Boolean error = false;
            String message = "";
            if (string.IsNullOrEmpty(duties))
            {
                message = "Please enter your abilities";

            }
            if (error == true)
            {
                jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {

            

            try
            {
                var status = Config.ObjNav.AddDutiesDetails(duties, appNo);
                if (status == "success")
                {
                    jobDetails.InnerHtml = "<div class='alert alert-success'>  Duties successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                    jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
               // Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=3");
            }


            }
        }

        protected void AddAccomplishment_Click(object sender, EventArgs e)
        {
            string jobId = Request.QueryString["id"].ToString();

            foreach (GridViewRow row in grd_accomplishment.Rows)
            {
                string Description = ((TextBox)row.FindControl("txtDescription")).Text;
                int number = Convert.ToInt32(((TextBox)row.FindControl("txtNumber")).Text);
                string empNo = Session["employeeNo"].ToString();
                string appNo = Session["appNo"].ToString();
                string amt = ((TextBox)row.FindControl("Amount")).Text;
                if (number !=0)
                {
                    try
                    {
                        var status = Config.ObjNav.AddApplicantAccomplishment(appNo, empNo,Description,number, jobId,amt);
                        if (status == "success")
                        {
                            jobDetails.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                           
                        }
                        

                    }
                    catch (Exception t)
                    {

                        jobDetails.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        //Response.Redirect("ApplicationForm.aspx?id=" + jobId);
                    }


                }
            }
            jobDetails.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

         





        }

        public void fillGrid()
        {
            // grd_accomplishment
            var nav = new Config().ReturnNav();
            var hrAccomplishment = nav.HrApplicantAccomplishment.ToList();
            grd_accomplishment.DataSource = hrAccomplishment;
            grd_accomplishment.DataBind();



        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (document.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = document.PostedFiles.Count();
                    if (filecount <= 10)
                    {
                        //HttpFileCollection hfc = Request.Files;
                        //for (int i = 0; i < hfc.Count; i++)
                        //{
                        //    HttpPostedFile hpf = hfc[i];
                            //foreach (HttpPostedFile postFiles in document.PostedFiles)
                            //{
                            if (Directory.Exists(filesFolder))
                            {
                                String extension = System.IO.Path.GetExtension(document.FileName);
                                if (new Config().IsAllowedExtension(extension))
                                {
                                    String appNo = Session["appNo"].ToString(); ;
                                    String documentDirectory = filesFolder + appNo + "/";
                                    Boolean createDirectory = true;
                                    try
                                    {
                                        if (!Directory.Exists(documentDirectory))
                                        {
                                            Directory.CreateDirectory(documentDirectory);
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        createDirectory = false;
                                        documentsfeedback.InnerHtml =
                                                                    "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again" +
                                                                    "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        //We could not create a directory for your documents
                                   }

                                    if (createDirectory)
                                    {
                                        string filename = documentDirectory + document.FileName;
                                        if (File.Exists(filename))
                                        {
                                            documentsfeedback.InnerHtml =
                                                                               "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                        }
                                        else
                                        {
                                            document.SaveAs(filename);
                                            if (File.Exists(filename))
                                            {
                                                Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
                                                documentsfeedback.InnerHtml =
                                                    "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            }
                                            else
                                            {
                                                documentsfeedback.InnerHtml =
                                                    "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            }

                                        }

                                    }





                                    }
                                else
                                {
                                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }


                            }
                            else
                            {
                                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                       // }

                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

           

        }

        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";
               
                String appNo = Session["appNo"].ToString();
                String documentDirectory = filesFolder + appNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            
            string appNo = Session["appNo"].ToString();
            string jobId = Request.QueryString["id"].ToString();
            //Response.Redirect("leaveapplication.aspx?step=1&&leaveno=" + imprestNo);
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=1"+"JobNo="+ appNo);
        }

        protected void GoBack_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("JobDetails.aspx?id=" + jobId);

        }

        protected void GoBack1_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=1");

        }

        protected void GoBack2_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=2");

        }

        protected void GoBack3_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=3");

        }

        protected void GoBack4_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=4");

        }

        protected void GoBack5_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["id"].ToString();
            Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=5");

        }

        protected void Finish_Click(object sender, EventArgs e)
        {
            Response.Redirect("myapplications.aspx");
          
        }
    }
}