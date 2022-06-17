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
    public partial class ApplicationFormEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            

            if (!IsPostBack)
            {
                
                getDepartments();
                getCounties();
                

                editApplication();
                fillGrid();
                loadAccomplishment();
                
            }

        }


        private void editApplication()
        {
            var appno = Request.QueryString["appNo"].ToString();
            var nav = new Config().ReturnNav();
            var positions = nav.MyJobApplications.Where(r => r.Application_No == appno);
            foreach(var item in positions)
            {
                appliedfor1.Text =item.Job_Applied_For;
                Surname1.Text = item.First_Name;
                Firstname1.Text = item.Middle_Name;
                Lastname1.Text = item.Last_Name;
                txtTitle1.Text = item.Initials;
                PhoneNo1.Text = item.Cell_Phone_Number;
                alt_PhoneNo1.Text = item.Altenative_Phone_Number;
                Email1.Text = item.E_Mail;
                alt_Email1.Text = item.Alternative_Email;
                personalNo1.Text = item.Employee_No;
                Center1.Text = item.Department_Code;
                DOB1.Text = Convert.ToDateTime(item.Date_Of_Birth).ToString("dd/MM/yyyy");
                
                if(item.Gender== "Male")
                {
                    Gender1.Text = "0";
                }else if(item.Gender == "Female")
                {
                    Gender1.Text = "1";
                }else if(item.Gender == "Both")
                {
                    Gender1.Text = "2";
                }
                Ethnicity1.Text = item.Ethnic_Origin;
                if (item.Disabled == "No")
                {
                    disability1.Text = "1";
                }else if(item.Disabled == "Yes")
                {
                    disability1.Text = "0";
                }
                
               /// disability1.Text = item.Disabled;

                registrationNo1.Text = item.Disability_Details;
               
                County1.Text = item.County;
                Nationality1.Text = item.Citizenship;
                religion1.Text = item.Religion;
                

                if(item.Marital_Status == "Married")
                {
                    Maritalstatus1.Text = "0";
                }
                else if (item.Marital_Status == "Single")
                {
                    Maritalstatus1.Text = "1";
                }
                else if (item.Marital_Status == "Divorced")
                {
                    Maritalstatus1.Text = "2";
                }
                else if (item.Marital_Status == "Separated")
                {
                    Maritalstatus1.Text = "3";
                }
                else if (item.Marital_Status == "Widow(er)")
                {
                    Maritalstatus1.Text = "4";
                }
                else if(item.Marital_Status == "Other")
                {
                    Maritalstatus1.Text = "5";
                }

                IdNo1.Text = item.ID_Number;
                nhif1.Text = item.NHIF;
                NSSF1.Text = item.NSSF;
                pinNo1.Text = item.PIN_Number;
                currentPost1.Text = item.Position_held;
                jobGr1.Text = item.Job_Group;
                firstofDateappointment1.Text = Convert.ToDateTime(item.First_Appointment_Date).ToString("dd/MM/yyyy");
                Dateofcurrentappointment1.Text = Convert.ToDateTime(item.Last_Appointment_Date).ToString("dd/MM/yyyy"); 

                //SaveOtherPersonalDetails1_Click

                if(item.Convicted == true)
                {
                    convict1.Text = "0";
                }
                else if (item.Convicted == false)
                {
                    convict1.Text = "1";
                }
                if(item.Dismissal == true)
                {
                    Dismissed1.Text = "0";
                }else if (item.Dismissal == false)
                {
                    Dismissed1.Text = "1";
                }

                duration1.Text = item.Conviction_Description;
                
                dismissalReasons1.Text = item.Dismissal_Description;
                txt_highestLevel1.Text = item.Highest_Education_Level;

                Declare1.Text = item.Declaralation.ToString();

                //AddAbility1
                txtComment1.Text = item.Abilites_Skills;

                //AddDuties1
                TextArea1.Text = item.Current_Duties;

                //AddAccomplishment1_Click
                

              if(item.Declaralation == true)
                {
                    Declare1.Text = "0";
                }else if (item.Declaralation == false)
                {
                    Declare1.Text = "1";
                }







            }

        }

        protected void AddDetails1_Click(object sender, EventArgs e)
        {
            //int step;
            var appNo = Request.QueryString["appNo"].ToString();
            string jobId = appliedfor1.Text.ToString();
            string surname = Surname1.Text.ToString();
            string firstname = Firstname1.Text.ToString();
            string lastname = Lastname1.Text.ToString();
            string title = txtTitle1.Text.ToString();
            string phone = PhoneNo1.Text.ToString();
            string altPhone = alt_PhoneNo1.Text.ToString();
            string email = Email1.Text.ToString();
            string altEmail = alt_Email1.Text.ToString();
            string empNo = personalNo1.Text.ToString();
            string dpt = Center1.SelectedValue.ToString();
            string DateOfBirth = DOB1.Text.ToString();
            int gendr = Convert.ToInt32(Gender1.SelectedValue.ToString());
            string ethnic = Ethnicity1.Text.ToString();
            int disable = Convert.ToInt32(disability1.SelectedValue.ToString());
            string regNo = registrationNo1.Text.ToString();
            
            string cnty = County1.SelectedValue.ToString();
            string nty = Nationality1.Text.ToString();
            string relign = religion1.Text.ToString();
            int mStatus = Convert.ToInt32(Maritalstatus1.SelectedValue.ToString());
            string IdNumber = IdNo1.Text.ToString();
            string nhf = nhif1.Text.ToString();
            string nsf = NSSF1.Text.ToString();
            string txtPin = pinNo1.Text.ToString();
            string crntPosition = currentPost1.Text.ToString();
            string jgroup = jobGr1.Text.ToString();
            string firstAppointmentDate = firstofDateappointment1.Text.ToString();
            string lpromotionDate = Dateofcurrentappointment1.Text.ToString();
            DateTime date = new DateTime();
            DateTime date1 = new DateTime();
            DateTime date2 = new DateTime();
            Boolean error = false;

            String message = "";

            if (string.IsNullOrEmpty(surname))
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
                feedback1.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
                try
                {

                    if (altEmail == "")
                    {
                        altEmail = "";
                    }
                  if (altPhone == "")
                    {
                        altPhone = "";

                    }
                    if (regNo == "")
                    {
                        regNo = "";

                    }
                    
                    if (!String.IsNullOrEmpty(DateOfBirth))
                    {
                        CultureInfo culture = new CultureInfo("ru-RU");

                        date =  DateTime.ParseExact(DateOfBirth, "d/M/yyyy", CultureInfo.InvariantCulture);
                    }
                   if (!String.IsNullOrEmpty(firstAppointmentDate))
                    {
                        CultureInfo culture = new CultureInfo("ru-RU");

                        date1 = DateTime.ParseExact(firstAppointmentDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                    }
                     if (!String.IsNullOrEmpty(lpromotionDate))
                    {
                        CultureInfo culture = new CultureInfo("ru-RU");

                        date2 = DateTime.ParseExact(lpromotionDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                    }
                }
                catch (Exception)
                {

                    throw;
                }


                try
                {
                    var docNo = appNo;
                    var status = Config.ObjNav.ApplyinternalHrJobs(docNo, jobId, surname, firstname, lastname,
                        title, date, gendr, disable,
                        regNo, cnty, nty, mStatus, relign, IdNumber, nhf, nsf, txtPin, phone, altPhone,
                       email, altEmail, empNo, dpt, crntPosition, jgroup,
                       date1, date2,ethnic);
                    //feedback.InnerHtml = "<div class='alert alert-success'> Data successfully saved<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";



                    if (status == "success")
                    {
                        academicQualification1.InnerHtml = "<div class='alert alert-success'> Record successfully updated<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2", false);

                    }
                    else
                    {
                        error = true;
                        feedback1.InnerHtml = "<div class='alert alert-danger'> An error occured during the process of saving.Please try again.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo, false);

                    }

                }
                catch (Exception t)
                {
                    error = true;
                    feedback1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }

            }
            //Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=2");

            //Response.Redirect("ApplicationForm.aspx?id="+ jobId);
        }


        protected void addQualification1_Click(object sender, EventArgs e)
        {
            string appNo = Request.QueryString["appNo"].ToString();
            string jobId = appliedfor1.Text.ToString();
            string from = qualificationFrom1.Text.ToString();
            string to = qualificationTo1.Text.ToString();
            string company = institution1.Text.ToString();
            string grade = gradeAttained1.Text.ToString();
            string specialty = specialization1.Text.ToString();
            string Attain = Attainment1.Text.ToString();
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
                academicQualification1.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
                    academicQualification1.InnerHtml = "<div class='alert alert-success'> Data successfully saved<a href='#' class='close' data-dismiss='success' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2", false);
                    }
                

            }
            catch (Exception t)
            {

                academicQualification1.InnerHtml = "<div class='alert alert-danger'> '"+t.Message+"'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                


                }

            }



        }
        protected void addProfession1_Click(object sender, EventArgs e)
        {
            
          
            string from = prof_startDate1.Text.ToString();
            string to = prof_endDate1.Text.ToString();
            string company = prof_institution1.Text.ToString();
            string grade = attainedScore1.Text.ToString();
            string spec = pr_Specialization1.Text.ToString();
            string attainment = pr_attainment1.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
           
            string appNo = Request.QueryString["appNo"].ToString();
            string jobId = appliedfor1.Text.ToString();


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
                academicQualification1.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
                    academicQualification1.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                    }

            }
            catch (Exception t)
            {

                academicQualification1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }
            }

        }
        protected void addTraining1_Click(object sender, EventArgs e)
        {
            string appNo = Request.QueryString["appNo"].ToString();
            string jobId = appliedfor1.Text.ToString();
            string from = tr_StartDate1.Text.ToString();
            string to = tr_EndDate1.Text.ToString();
            string company = tr_institution1.Text.ToString();
            string grade = tr_score1.Text.ToString();
            string coursename = tr_courseName1.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string attained = tr_score1.Text.ToString();

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
                academicQualification1.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
                    academicQualification1.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                academicQualification1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
            }

            }

        }
        protected void addMembership1_Click(object sender, EventArgs e)
        {
            string appNo = Request.QueryString["appNo"].ToString();
            string jobId = appliedfor1.Text.ToString();
            string p_body = m_body1.Text.ToString();
            string reg_no = m_regNo1.Text.ToString();
            string renewalDate = m_DateofRenewal1.Text.ToString();
            string mType = m_Membershiptype1.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            
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
                academicQualification1.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


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
                    academicQualification1.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                academicQualification1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
               
            }

            }
          }
        protected void addEmploymentHistory1_Click(object sender, EventArgs e)
        {
            string appNo = Request.QueryString["appNo"].ToString();
            string jobId = appliedfor1.Text.ToString();
            string from = em_StartDate1.Text.ToString();
            string to = em_EndDate1.Text.ToString();
            string company = em_institution1.Text.ToString();
            string position = em_positionHeld1.Text.ToString();
            string grade = em_JobGrade1.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
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
                academicQualification1.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


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
                    academicQualification1.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                   
                }

            }
            catch (Exception t)
            {

                academicQualification1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
             
            }
        }
    }
 
        protected void addReferee1_Click(object sender, EventArgs e)
        {
            string name = ref_name1.Text.ToString();
            string occupation = ref_Occupation1.Text.ToString();
            string address = ref_Address1.Text.ToString();
            string postcode = ref_Postcode1.Text.ToString();
            string city = ref_City1.Text.ToString();
            string email = ref_EmailAddress1.Text.ToString();
            string period = ref_period1.Text.ToString();
            string phone = ref_phone1.Text.ToString();
            string appNo = Request.QueryString["appNo"].ToString();
            string jobId = appliedfor1.Text.ToString();

            string empNo = Session["employeeNo"].ToString();
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
                referee1.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {

            

            try
            {
                var status = Config.ObjNav.CreateReferee(appNo, empNo, name, occupation, address, 
                    postcode, phone, email, period, jobId);
                if (status == "success")
                {
                    referee1.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    
                }

            }
            catch (Exception t)
            {

                referee1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
               // Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=5");
            }

            }
        }
        
      
        protected void Step21_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["appNo"].ToString();
            Response.Redirect("ApplicationFormEdit.aspx?appNo=" + jobId + "&step=3");

        }
        public void getDepartments()
        {
            
            var nav = new Config().ReturnNav();
            var dpt = nav.ResponsibilityCenters.ToList();
            Center1.DataSource = dpt;
            Center1.DataValueField = "Code";
            Center1.DataTextField = "Name";
            Center1.DataBind();


        }
        public void getCounties()
        {
            var nav = new Config().ReturnNav();
            var counties = nav.Locations.ToList();
            County1.DataSource = counties;
            County1.DataValueField = "Code";
            County1.DataTextField = "Name";
            County1.DataBind();

        }

        protected void Step31_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["appNo"].ToString(); 
            Response.Redirect("ApplicationFormEdit.aspx?appNo=" + jobId + "&step=4");
         }

        protected void Step41_Click(object sender, EventArgs e)
        {
            var jobId = Request.QueryString["appNo"].ToString();
            Response.Redirect("ApplicationFormEdit.aspx?appNo=" + jobId + "&step=5");


        }

        protected void Step51_Click(object sender, EventArgs e)
        {
            var appNo = Request.QueryString["appNo"].ToString();
            Boolean error = false;
            var message = "";
            
            var declare = Declare1.SelectedValue.ToString();
            Boolean decl = false;
            if(declare == "0")
            {
                decl = true;

            }else
            {
                decl = false;
            }
            try
            {
                    var status = Config.ObjNav.AddDeclaration(decl,appNo);
                    if (status == "success")
                    {
                        documentsfeedback1.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }

                }
            catch (Exception t)
            {

                documentsfeedback1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            
            Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=6");
            

        }

        protected void SaveOtherPersonalDetails1_Click(object sender, EventArgs e)
        {
            
            var jobId = appliedfor1.Text.ToString();
            string convicted = convict1.SelectedValue.ToString();
            string period = duration1.Text.ToString();
            string dismiss = Dismissed1.Text.ToString();
            string reason = dismissalReasons1.Text.ToString();
            string highestLevel = txt_highestLevel1.Text.ToString();
            string empNo = Session["employeeNo"].ToString();
            string appNo = Request.QueryString["appNo"].ToString();
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
                otherPersonalDetails1.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
                    otherPersonalDetails1.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                   
                }

            }
            catch (Exception t)
            {

                    otherPersonalDetails1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
             
            }
            }
        }

        protected void AddAbility1_Click(object sender, EventArgs e)
        {
            string ability = txtComment1.Text.ToString();
            string appNo = Request.QueryString["appNo"].ToString();
            string jobId = appliedfor1.Text.ToString();

            Boolean error = false;
            String message = "";
            if(string.IsNullOrEmpty(ability))
            {
                message = "please enter your abilities";

            }

            if(error == true)
            {
                academicQualification1.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }else
            {
                
            try
            {
                var status = Config.ObjNav.AddAbilityDetails(ability,appNo);
                if (status == "success")
                {
                    jobDetails1.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=3");
                }

            }
            catch (Exception t)
            {

                    jobDetails1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //Response.Redirect("ApplicationForm.aspx?id=" + jobId);
            }

            }

        }

        protected void AddDuties1_Click(object sender, EventArgs e)
        {
            string duties = TextArea1.Text.ToString();
            string appNo = Request.QueryString["appNo"].ToString();
            string jobId = appliedfor1.Text.ToString();

            Boolean error = false;
            String message = "";
            if (string.IsNullOrEmpty(duties))
            {
                message = "Please enter your abilities";

            }
            if (error == true)
            {
                jobDetails1.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {

            

            try
            {
                var status = Config.ObjNav.AddDutiesDetails(duties, appNo);
                if (status == "success")
                {
                    jobDetails1.InnerHtml = "<div class='alert alert-success'>  Duties successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=3", false);
                }

            }
            catch (Exception t)
            {

                    jobDetails1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
               // Response.Redirect("ApplicationForm.aspx?id=" + jobId + "&step=3");
            }


            }
        }

        protected void AddAccomplishment1_Click(object sender, EventArgs e)
        {
            string jobId =appliedfor1.Text.ToString();
            string appNo = Request.QueryString["appNo"].ToString();

            foreach (GridViewRow row in grd_accomplishment1.Rows)
            {
                string Description = ((TextBox)row.FindControl("txtDescription1")).Text;
                int number = Convert.ToInt32(((TextBox)row.FindControl("Number")).Text);
                string amt = ((TextBox)row.FindControl("Amount")).Text;
                string empNo = Session["employeeNo"].ToString();
               
                

                if (number !=0)
                {
                    try
                    {
                        var status = Config.ObjNav.AddApplicantAccomplishment(appNo, empNo,Description, number, jobId,amt);
                        string[] info = status.Split('*');
                        if (info[0] == "success")
                        {
                            //jobDetails1.InnerHtml = "<div class='alert alert-success'>  '"+ info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                           
                        }
                        

                    }
                    catch (Exception t)
                    {

                        jobDetails1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        //Response.Redirect("ApplicationForm.aspx?id=" + jobId);
                    }


                }
            }

            jobDetails1.InnerHtml = "<div class='alert alert-success'>  Data updated successfully <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
           





        }
        protected void loadAccomplishment()
        {
            // grd_accomplishment
            var nav = new Config().ReturnNav();
            var hrAccomplishment = nav.HrApplicantAccomplishment.ToList();
            grd_accomplishment.DataSource = hrAccomplishment;
            grd_accomplishment.DataBind();



        }
        protected void fillGrid()
        {
            // grd_accomplishment
            var nav = new Config().ReturnNav();
            string appNo = Request.QueryString["appNo"].ToString();
            var hrAccomplishment = nav.ApplicantAccomplishment.Where(x=>x.Job_Application_No== appNo).ToList();
            foreach(var item in hrAccomplishment)
            {
                string desc = item.Indicator_Description;
                int number = Convert.ToInt32( item.Number);
            }
            grd_accomplishment1.DataSource = hrAccomplishment;
            grd_accomplishment1.DataBind();
            



        }

        protected void uploadDocument1_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";

            try
            {
                if (document1.HasFile)
                {
                    int filecount = 0;
                    //check No of Files Selected  
                    filecount = document1.PostedFiles.Count();
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
                                String extension = System.IO.Path.GetExtension(document1.FileName);
                                if (new Config().IsAllowedExtension(extension))
                                {
                                    String appNo = Request.QueryString["appNo"].ToString(); ;
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
                                        documentsfeedback1.InnerHtml =
                                                                    "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again" +
                                                                    "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        //We could not create a directory for your documents
                                   }

                                    if (createDirectory)
                                    {
                                        string filename = documentDirectory + document1.FileName;
                                        if (File.Exists(filename))
                                        {
                                            documentsfeedback1.InnerHtml =
                                                                               "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                        }
                                        else
                                        {
                                            document1.SaveAs(filename);
                                            if (File.Exists(filename))
                                            {
                                                Config.navExtender.AddLinkToRecord("HR Job Applications Card", appNo, filename, "");
                                                documentsfeedback1.InnerHtml =
                                                    "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            }
                                            else
                                            {
                                                documentsfeedback1.InnerHtml =
                                                    "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            }

                                        }

                                    }





                                    }
                                else
                                {
                                    documentsfeedback1.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }


                            }
                            else
                            {
                                documentsfeedback1.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                       // }

                    }
                    else
                    {
                        documentsfeedback1.InnerHtml = "<div class='alert alert-danger'>Files cannot be more than ten(10) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
                else
                {
                    documentsfeedback1.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception ex)
            {
                throw;
            }

           

        }

        protected void deleteFile1_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName1.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";
               
                String appNo = Request.QueryString["appNo"].ToString();
                String documentDirectory = filesFolder + appNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsfeedback1.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback1.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsfeedback1.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                documentsfeedback1.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }

      
        protected void DeleteQualification_Click(object sender, EventArgs e)
        {
            int id =Convert.ToInt32(Code.Text);
            var appNo = Request.QueryString["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteAcademicLine(id, appNo);
                string[] info = status.Split('*');
                if(info[0] == "success")
                {
                    academicQualification1.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2",false);
                }


            }
            catch (Exception t)
            {

                academicQualification1.InnerHtml = "<div class='alert alert-danger'>'"+t.Message+"' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            
        }

        protected void DeleteProfessional_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(PCode.Text);
            var appNo = Request.QueryString["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteProfessionalLine(id, appNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    academicQualification1.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2", false);
                }


            }
            catch (Exception t)
            {

                academicQualification1.InnerHtml = "<div class='alert alert-danger'>'" + t.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void DeleteTraining_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(TCode.Text);
            var appNo = Request.QueryString["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteTrainingLine(id, appNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    academicQualification1.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2", false);
                }


            }
            catch (Exception t)
            {

                academicQualification1.InnerHtml = "<div class='alert alert-danger'>'" + t.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void DeletePBody_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(BCode.Text);
            var appNo = Request.QueryString["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteProffessionalBodyLine(id, appNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    academicQualification1.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2", false);
                }


            }
            catch (Exception t)
            {

                academicQualification1.InnerHtml = "<div class='alert alert-danger'>'" + t.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void DeleteEmployment_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(ECode.Text);
            var appNo = Request.QueryString["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteEmploymentHistoryLine(id, appNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    academicQualification1.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2", false);
                }


            }
            catch (Exception t)
            {

                academicQualification1.InnerHtml = "<div class='alert alert-danger'>'" + t.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void DeleteRef_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(RCode.Text);
            var appNo = Request.QueryString["appNo"].ToString();
            try
            {
                var status = Config.ObjNav.DeleteRefereeLine(id, appNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    referee1.InnerHtml = "<div class='alert alert-success'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=5", false);
                }


            }
            catch (Exception t)
            {

                referee1.InnerHtml = "<div class='alert alert-danger'>'" + t.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void GoBack4_Click(object sender, EventArgs e)
        {
            string appNo = Request.QueryString["appNo"].ToString();
            Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=4");

        }

        protected void GoBack5_Click(object sender, EventArgs e)
        {
            string appNo = Request.QueryString["appNo"].ToString();
            Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=5");

        }

        protected void GoBack3_Click(object sender, EventArgs e)
        {
            string appNo = Request.QueryString["appNo"].ToString();
            Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=3");

        }

        protected void GoBack2_Click(object sender, EventArgs e)
        {
            string appNo = Request.QueryString["appNo"].ToString();
            Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=2");

        }

        protected void GoBack1_Click(object sender, EventArgs e)
        {

            string appNo = Request.QueryString["appNo"].ToString();
            Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=1");

        }

        protected void GoBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("myapplications.aspx");
        }

        protected void Finish_Click(object sender, EventArgs e)
        {
            Response.Redirect("myapplications.aspx");
        }

        protected void AddAccomplishment_Click(object sender, EventArgs e)
        {
            string appNo = Request.QueryString["appNo"].ToString();

            try
            {
                string jobId = appliedfor1.Text;
                

                foreach (GridViewRow row in grd_accomplishment.Rows)
                {
                    string Description = ((TextBox)row.FindControl("txtDescription")).Text;
                    int number = Convert.ToInt32(((TextBox)row.FindControl("txtNumber")).Text);
                    string empNo = Session["employeeNo"].ToString();
                    
                   // int amt = Convert.ToInt32(((TextBox)row.FindControl("txtAmount")).Text);
                    string amt = ((TextBox)row.FindControl("Amount")).Text;
                    var nav = new Config().ReturnNav();
                  
                    if (number != 0)
                    {
                        try
                        {
                            var status = Config.ObjNav.AddApplicantAccomplishment(appNo, empNo, Description, number, jobId, amt);
                            if (status == "success")
                            {
                                jobDetails1.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }


                        }
                        catch (Exception t)
                        {

                            jobDetails1.InnerHtml = "<div class='alert alert-danger'> '" + t.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            //Response.Redirect("ApplicationForm.aspx?id=" + jobId);
                        }


                    }
                   
                }
            }
            catch (Exception t)
            {
                jobDetails1.InnerHtml = "<div class='alert alert-danger'>'"+t.Message+"'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            jobDetails1.InnerHtml = "<div class='alert alert-success'>  Data successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            Response.Redirect("ApplicationFormEdit.aspx?appNo=" + appNo + "&step=3");

        }
}
}