using System;
using System.Collections.Generic;
using System.Diagnostics.Eventing.Reader;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ForgotPass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
               
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
            catch (Exception)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>No internet connection to verify capcha code</div>";
            }
            return false;
        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            //if (IsValidCaptcha())
            //{
                try
                {
                    String tUsername = username.Text.Trim();
                    String status = Config.ObjNav.ResetPassword(tUsername);
                    String[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        username.Text = "";
                    }
                }
                catch (Exception t)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                         "r<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            //}
            //else
            //{
            //    feedback.InnerHtml = "<div class='alert alert-danger'>Provide a valid captcha. Prove that you are not a robot</div>";
            //}
        }
    }
}