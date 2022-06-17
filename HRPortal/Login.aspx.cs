using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            //if (IsValidCaptcha())
            //{

            try
            {
                String tUsername = username.Text.Trim();
                String tPassword = password.Text.Trim();
                var nav = new Config().ReturnNav();
                var users = nav.HRPortalUsers.Where(r => r.employeeNo == tUsername && r.password == tPassword);
                Boolean exists = false;
                foreach (var user in users)
                {
                    exists = true;
                    Session["name"] = user.First_Name + " " + user.Middle_Name + " " + user.Last_Name;
                    Session["employeeNo"] = user.employeeNo;
                    Session["idNo"] = user.ID_Number;
                    Session["region"] = user.Region;
                    Session["admin"] = user.ICT_Help_Desk_Admin;
                    Session["DepartmentCode"] = user.Department_Code;
                    Session["BranchCode"] = user.Global_Dimension_1_Code;
                    Session["DivisionCode"] = user.Global_Dimension_2_Code;

                    var assigned = nav.HelpDeskAssignee.Where(x => x.Employee_No == user.employeeNo && x.Help_Desk_Category != null).ToList();
                    foreach (var item in assigned)
                    {
                        Session["empNo"] = item.Employee_No;
                    }


                }
                if (!exists)
                {

                    var users1 = nav.HRPortalUsers.Where(r => r.IdNo == tUsername && r.password == tPassword);
                    foreach (var user in users1)
                    {
                        exists = true;
                        Session["name"] = user.First_Name + " " + user.Middle_Name + " " + user.Last_Name;
                        if (String.IsNullOrEmpty(Convert.ToString(Session["name"]).Trim()))
                            Session["name"] = user.fName + " " + user.mName + " " + user.lName;
                        Session["employeeNo"] = user.employeeNo;
                        // Session["password"] = user.password;
                        Session["idNo"] = user.IdNo;
                    }
                }
                if (!exists)
                {
                    feedback.InnerHtml =
                        "<div class='alert alert-danger'>A user with the entered credentials does not exist<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    username.Text = "";
                    password.Text = "";
                    //determine if its an employee or an applicant
                    Session["type"] = "0";
                    try
                    {
                        var employees = nav.Employees.Where(r => r.ID_Number == Convert.ToString(Session["idNo"]));
                        foreach (var employee in employees)
                        {
                            Session["type"] = "1"; //user is an employee
                        }
                    }
                    catch (Exception t)
                    {
                    }
                    Response.Redirect("Dashboard.aspx");
                }
            }
            catch (Exception ex)
            {

                feedback.InnerHtml = "<div class='alert alert-danger'>"+ex.Message+"</div>";
            }
            //}
            //else
            //{
            //    feedback.InnerHtml = "<div class='alert alert-danger'>Provide a valid captcha. Prove that you are not a robot</div>";
            //}
        }
        bool IsValidCaptcha()
        {
            try
            {
                string resp = Request["g-recaptcha-response"];
                var req = (HttpWebRequest)WebRequest.Create
                    ("https://www.google.com/recaptcha/api/siteverify?secret=6Ld4LScUAAAAAMFS3LPFmHywnoRFpywiUiMBDS9n&response=" +
                     resp);
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();
                        JavaScriptSerializer js = new JavaScriptSerializer();
                        // Deserialize Json
                        CaptchaResult data = js.Deserialize<CaptchaResult>(jsonResponse);
                        if (Convert.ToBoolean(data.success))
                        {
                            return true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>'"+ex.Message+"'</div>";
                //No internet connection to verify capcha code
            }
            return false;
        }
    }
}