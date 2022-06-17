using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRPortal.Nav;

namespace HRPortal
{
    public partial class signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            if (!IsPostBack)
            {
                List<String> genders = new List<string>();
                genders.Add("Male");
                genders.Add("Female");
                gender.DataSource=genders;
                gender.DataBind();
                var nations = nav.Countries;
                citizenship.DataSource = nations;
                citizenship.DataTextField = "Name";
                citizenship.DataValueField = "Code";
                citizenship.DataBind();
            }
        }

        protected void register_Click(object sender, EventArgs e)
        {
         
            String tfirstname = firstname.Text.Trim();
            String tmiddle = middle.Text.Trim();
            String tlastname = lastname.Text.Trim();
            String temail = email.Text.Trim();
            String tphone = phone.Text.Trim();
            String tidNumber = idNumber.Text.Trim();
            String tcitizenship = citizenship.SelectedValue;
            String tgender = gender.SelectedValue;
            Boolean tagree = agree.Checked;
            //check that email is provided and valid
            //check that id number is provided and valid
            if (String.IsNullOrEmpty(temail))
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide an email address</div>";
            }
            else if (!temail.Contains('@'))
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid email address</div>";
            }
            else if (String.IsNullOrEmpty(tidNumber))
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide ID/Passport Number</div>";
            }
           //try to create an account
            else
            {
                String status = Config.ObjNav.Register(tfirstname, tmiddle, tlastname, temail, tphone, tidNumber,
                    tcitizenship, tgender);
                String[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-"+info[0]+"'>"+info[1]+"</div>";
            }




        }
    }
}