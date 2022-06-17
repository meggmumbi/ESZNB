using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            Session["active"] = 11;
            if (!IsPostBack)
            {
              //populate drop down lists
                var languages = nav.languages;
                firstLanguage.DataSource = languages;
                firstLanguage.DataValueField = "Code";
                firstLanguage.DataTextField = "Name";
                firstLanguage.DataBind();
                secondlanguage.DataSource = languages;
                secondlanguage.DataValueField = "Code";
                secondlanguage.DataTextField = "Name";
                secondlanguage.DataBind();
                additionalLanguage.DataSource = languages;
                additionalLanguage.DataValueField = "Code";
                additionalLanguage.DataTextField = "Name";
                additionalLanguage.DataBind();
                var countries = nav.Countries;
                citizenship.DataSource = countries;
                citizenship.DataValueField = "Code";
                citizenship.DataTextField = "Name";
                citizenship.DataBind();
                var postCodes = nav.postcodes;
                postCode.DataSource = postCodes;
                postCode.DataValueField = "Code";
                postCode.DataTextField = "Code";
                postCode.DataBind();
                postCode2.DataSource = postCodes;
                postCode2.DataValueField = "Code";
                postCode2.DataTextField = "Code";
                postCode2.DataBind();
             
                //marital status, gender, ethnic origin, disabled, 
                List<String> maritalStatuses = new List<string>();
                maritalStatuses.Add("");
                maritalStatuses.Add("Single");
                maritalStatuses.Add("Married");
                maritalStatuses.Add("Separated");
                maritalStatuses.Add("Divorced");
                maritalStatuses.Add("Widow(er)");
                maritalStatuses.Add("Other");
                maritalStatus.DataSource = maritalStatuses;
                maritalStatus.DataBind();
                List<String> genders = new List<string>();
                genders.Add("");
                genders.Add("Male");
                genders.Add("Female");
                gender.DataSource = genders;
                gender.DataBind();
                List<String> disableds = new List<string>();
                disableds.Add("");
                disableds.Add("No");
                disableds.Add("Yes");
                disabled.DataSource = disableds;
                disabled.DataBind();
                List<String> ethnicOrigins = new List<string>();
                ethnicOrigins.Add("African");
                ethnicOrigins.Add("Indian");
                ethnicOrigins.Add("White");
                ethnicOrigins.Add("Coloured");
                ethnicOrigin.DataSource = ethnicOrigins;
                ethnicOrigin.DataBind();
                /* var qualifications = nav.JobApplicantQualifications;
              qualificationDescription.DataSource = qualifications;
              qualificationDescription.DataValueField = "Code";
              qualificationDescription.DataTextField = "Description";
              qualificationDescription.DataBind();*/

               /* var hrJobApplicant = nav.HrJobApplicants.Where(r => r.ID_Number == (String)Session["idNo"]);
                foreach (var applicant in hrJobApplicant)
                {
                    fName.Text = applicant.First_Name;
                    middleName.Text = applicant.Middle_Name;
                    lastName.Text = applicant.Last_Name;
                    initials.Text = applicant.Initials;
                    firstLanguage.SelectedValue = applicant.First_Language_R_W_S;
                    firstLanguageRead.Checked = Convert.ToBoolean(applicant.First_Language_Read);
                    firstLanguageWrite.Checked = Convert.ToBoolean(applicant.First_Language_Write);
                    firstLanguageSpeak.Checked = Convert.ToBoolean(applicant.First_Language_Speak);
                    secondlanguage.SelectedValue = applicant.Second_Language_R_W_S;
                    secondLanguageRead.Checked = Convert.ToBoolean(applicant.Second_Language_Read);
                    secondLanguageWrite.Checked = Convert.ToBoolean(applicant.Second_Language_Write);
                    secondLanguageSpeak.Checked = Convert.ToBoolean(applicant.Second_Language_Speak);
                    additionalLanguage.SelectedValue = applicant.Additional_Language;
                    idNumber.Text = applicant.ID_Number;
                    gender.SelectedValue = applicant.Gender;
                    citizenship.SelectedValue = applicant.Citizenship;
                    postCode.SelectedValue = applicant.Post_Code;
                    postCode2.SelectedValue = applicant.Post_Code2;
                    maritalStatus.SelectedValue = applicant.Marital_Status;
                    ethnicOrigin.SelectedValue = applicant.Ethnic_Origin;
                    disabled.SelectedValue = applicant.Disabled;
                    healthAssessment.Checked = Convert.ToBoolean(applicant.Health_Assesment);
                    healthAssessmentDate.Text = Convert.ToDateTime(applicant.Health_Assesment_Date).ToString("dd/MM/yyyy");
                    dateOfBirth.Text = Convert.ToDateTime(applicant.Date_Of_Birth).ToString("dd/MM/yyyy");
                    homePhoneNumber.Text = applicant.Home_Phone_Number;
                    postalAddress.Text = applicant.Postal_Address;
                    postalAddress2.Text = applicant.Postal_Address2;
                    postalAddress3.Text = applicant.Postal_Address3;
                    residentialAddress.Text = applicant.Residential_Address;
                    residentialAddress2.Text = applicant.Residential_Address2;
                    residentialAddress3.Text = applicant.Residential_Address3;
                    cellPhoneNumber.Text = applicant.Cell_Phone_Number;
                    workPhoneNumber.Text = applicant.Work_Phone_Number;
                    extension.Text = applicant.Ext;
                    email.Text = applicant.E_Mail;
                    fax.Text = applicant.Fax_Number;
                }*/

            }
        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            //add Hobby
            String tText = hobby.Text.Trim();
            if (String.IsNullOrEmpty(tText))
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a hobby. </div>";
            }
            else
            {
                try
                {
                    String status = Config.ObjNav.AddHobby((String)Session["idNo"], tText);
                    String[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-"+info[0]+"'>"+info[1]+"</div>";
                    hobby.Text = "";
                }
                catch (Exception)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>An error occured while processing your request. Please try again later</div>";
                }
              
            }
        }

        protected void updateGeneralDetails_Click(object sender, EventArgs e)
        {
            String tFirstName = fName.Text.Trim();
            String tMiddleName = middleName.Text.Trim();
            String tLastName = lastName.Text.Trim();
            if (String.IsNullOrEmpty(tFirstName))
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide your first name</div>";
            }
            else if(String.IsNullOrEmpty(tLastName))
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide your last name</div>";
            }
            else
            {
                try
                {
                    String status = Config.ObjNav.UpdateGeneralDetails((String) Session["idNo"], tFirstName, tMiddleName,
                        tLastName, initials.Text.Trim(), firstLanguage.SelectedValue, firstLanguageRead.Checked,
                        firstLanguageWrite.Checked,
                        firstLanguageSpeak.Checked, secondlanguage.SelectedValue, secondLanguageRead.Checked,
                        secondLanguageWrite.Checked, secondLanguageSpeak.Checked, additionalLanguage.SelectedValue,
                        gender.SelectedValue, citizenship.SelectedValue);
                    String[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";

                }
                catch (Exception)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>An error occured while processing your request. Please try again later</div>";
                }
                
            }
        }

        protected void updatePersonalDetails_Click(object sender, EventArgs e)
        {
            DateTime medicalAssessmentDate = new DateTime();
            try
            {
                CultureInfo culture = new CultureInfo("ru-RU");
                DateTime tDateOfBirth = Convert.ToDateTime(dateOfBirth.Text.Trim(), culture);
                try
                {
                    String healthAssess = healthAssessmentDate.Text.Trim();
                    if (!String.IsNullOrEmpty(healthAssess))
                    {
                        medicalAssessmentDate = Convert.ToDateTime(healthAssess, culture);
                        //add to the database
                        String status = Config.ObjNav.UpdatePersonalDetails((String)Session["idNo"],
                            maritalStatus.SelectedValue, ethnicOrigin.SelectedValue,
                            disabled.SelectedValue, healthAssessment.Checked, medicalAssessmentDate, tDateOfBirth);
                        String[] info = status.Split('*');
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";


                    }
                }
                catch (Exception)
                {

                    feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid health assessment date</div>";
                }
              
            }
            catch (Exception)
            {

                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid date of birth</div>";
            }
           
        }

        protected void updateCommunication_Click(object sender, EventArgs e)
        {
           String tHomePhoneNumber=  homePhoneNumber.Text.Trim(),
           tPostalAddress =postalAddress.Text.Trim(),
            tPostalAddress2 = postalAddress2.Text.Trim(),
            tPostalAddress3 = postalAddress3.Text.Trim(),
            tResdidentialAddress = residentialAddress.Text.Trim(),
            tResidentialAddress2 = residentialAddress2.Text.Trim(),
           tResidentialAddress3 =  residentialAddress3.Text.Trim(),
           tCellPhoneNumber = cellPhoneNumber.Text.Trim(),
           tWorkPhoneNumber =  workPhoneNumber.Text.Trim(),
           tExtension =  extension.Text.Trim(),
           tFax = fax.Text.Trim(),
           tPostCode = postCode.SelectedValue,
           tPostCode2 = postCode2.SelectedValue;
            try
            {
                String status = Config.ObjNav.UpdateCommunicationDetails((String) Session["idNo"], tHomePhoneNumber,
                    tPostalAddress,
                    tPostalAddress2, tPostalAddress3, tResdidentialAddress, tResidentialAddress2, tResidentialAddress3,
                    tCellPhoneNumber,
                    tWorkPhoneNumber, tExtension, tFax, tPostCode, tPostCode2);
                String[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";

            }
            catch (Exception)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>An error occured while processing your request. Please try again later</div>";
            }
        }

        protected void addReferee_Click(object sender, EventArgs e)
        {
            String tRefName = refName.Text.Trim(),
                tRefDesignationn = refDesignation.Text.Trim(),
                tRefInstitution = refInstitution.Text.Trim(),
                tRefAddress = refAddress.Text.Trim(),
                tRefTelephone = refTelephoneNo.Text.Trim(),
                tRefEmail = refEmail.Text.Trim();
            try
            {
                String status = Config.ObjNav.AddReferee((String) Session["idNo"], tRefName, tRefDesignationn,
                    tRefInstitution, tRefAddress, tRefTelephone, tRefEmail);
                String[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";

            }
            catch (Exception)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>An error occured while processing your request. Please try again later</div>";
            }
        }
        protected void addQualification_Click(object sender, EventArgs e)
        {
            String tQualificationType = "",//qualificationType.Text.Trim(),
                tQualificationDescription = qualificationDescription.SelectedValue,
                tQualificationFrom = qualificationFrom.Text.Trim(),
                tQualificationTo = qualificationTo.Text.Trim(),
                tInstitution = institution.Text.Trim();
            Boolean error = false;
            DateTime from = new DateTime();
            DateTime to = new DateTime();
            CultureInfo culture = new CultureInfo("ru-RU");
            try
            {
                

                from = Convert.ToDateTime(tQualificationFrom,culture);
            }
            catch (Exception)
            {
                error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid qualification from date</div>";
            }
            try
            {
                to = Convert.ToDateTime(tQualificationTo,culture);
            }
            catch (Exception)
            {
                error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid qualification to date</div>";
            }
            if (!error)
            {
                try
                {
                    String status = Config.ObjNav.AddQualification((String) Session["idNo"], tQualificationType,
                        tQualificationDescription, from, to, tInstitution);
                    String[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";

                }
                catch (Exception)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>An error occured while processing your request. Please try again later</div>";
                }
            }

        }
    }
}