using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Settings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            //try ressetting the password
            try
            {
                String tCurrentPassword = currentPassword.Text.Trim();
                String tNewPassword = newPassword.Text.Trim();
                String tConfirmPassword = confirmPassword.Text.Trim();
                String message = "";
                Boolean error = false;
                if (tCurrentPassword.Length<4)
                {
                    error = true;
                    message = "Please enter a valid current password. Atleast 4 charaters";
                }
                if (tNewPassword.Length<4)
                {
                    error = true;
                    message += message.Length > 0 ? "<br\\>" : "";
                    message += "Please enter a valid new password. Atleast 4 charaters";
                }
                if (tNewPassword!= tConfirmPassword)
                {
                    error = true;
                    message += message.Length > 0 ? "<br\\>" : "";
                    message += "New Password and Confirm new password do not match.";
                }

                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String employeeName = Convert.ToString(Session["employeeNo"]);
                    String status = Config.ObjNav.ChangePassword(employeeName, tCurrentPassword, tNewPassword, tConfirmPassword);
                    String[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}