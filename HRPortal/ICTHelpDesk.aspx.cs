using System;
using System.Linq;
using System.Web.UI.WebControls;
using Microsoft.SharePoint.Client;
using System.Configuration;
using System.IO;
using System.Net;
using System.Security;

namespace HRPortal
{
    public partial class ICTHelpDesk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                getCategories();

               // var selectedcategory = category.SelectedValue.Trim();
                string empNo = Session["employeeNo"].ToString();
                var nav = new Config().ReturnNav();
                var asstes = nav.Assets.Where(r =>r.Blocked == false && r.Current_Assigned_Employee == empNo).ToList();
                asset.DataSource = asstes;
                asset.DataValueField = "Code";
                asset.DataTextField = "Description";
                asset.DataBind();
                asset.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
            }

        }

        protected void addICTHelpDeskRequest_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            string message = "";
            string ictCategories = category.SelectedValue.Trim();
            string tassets = asset.SelectedValue.Trim();
            string desc = Description.Text.ToString();
            string tsubcategory = subcategory.SelectedValue.Trim();

            String requisitionNo = "";
            Boolean newRequisition = false;
            if (string.IsNullOrEmpty(desc))
            {
                error = true;
                message = "Please enter description ";

            }
            if (string.IsNullOrEmpty(ictCategories))
            {
                error = true;
                message = "Please select ict category ";

            }
            if (string.IsNullOrEmpty(tsubcategory))
            {
                error = true;
                message = "Please select sub category ";

            }
            if (error == true)
            {
                ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
                try
                {
                    string empNo = Session["employeeNo"].ToString();

                    var status = Config.ObjNav.CreateIctRequest(empNo, desc, ictCategories,tassets,tsubcategory);

                    string[] info = status.Split('*');
                    if(info[0]=="success")
                        if (newRequisition)
                        {
                            requisitionNo = info[2];
                        }
                    String redirectLocation = "ICTHelpDesk.aspx?step=2&&applicationNo=" + requisitionNo;
                    Response.Redirect(redirectLocation);





                }
                catch (Exception ex)
                {

                    ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }



            }



        }

        public void getCategories()
        {
            var nav = new Config().ReturnNav();
            var categories = nav.ICTHelpDeskCategory.ToList();
            category.DataSource = categories;
            category.DataValueField = "Code";
            category.DataTextField = "Description";
            category.DataBind();
            category.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

        }
         protected void uploadDocument_Click(object sender, EventArgs e)
        {
            bool fileuploadSuccess = false;
            string sUrl = ConfigurationManager.AppSettings["S_URL"];
            string defaultlibraryname = "ERP%20Documents/";
            string customlibraryname = "Kasneb/ICTHelpDesk";
            string sharepointLibrary = defaultlibraryname + customlibraryname;
            String leaveNo = Request.QueryString["applicationNo"];

            string username = ConfigurationManager.AppSettings["S_USERNAME"];
            string password = ConfigurationManager.AppSettings["S_PWD"];
            string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];

            bool bbConnected = Config.Connect(sUrl, username, password, domainname);

            try
            {
                if (bbConnected)
                {
                    Uri uri = new Uri(sUrl);
                    string sSpSiteRelativeUrl = uri.AbsolutePath;
                    string uploadfilename = leaveNo + "_" + document.FileName;
                    Stream uploadfileContent = document.FileContent;

                    var sDocName = UploadStaffClaim(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                    string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                    if (!string.IsNullOrEmpty(sDocName))
                    {
                        var status = Config.ObjNav.AddStaffClaimSharepointLinks(leaveNo, uploadfilename, sharepointlink);
                        string[] info = status.Split('*');
                        if (info[0] == "success")
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                        else
                        {
                            documentsfeedback.InnerHtml =
                                "<div class='alert alert-danger'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    }
                    else
                    {
                        documentsfeedback.InnerHtml =
                               "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }


                }
                else
                {
                    documentsfeedback.InnerHtml =
                               "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml =
                                "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }          

        
    }
        public string UploadStaffClaim(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            leaveNo = Request.QueryString["applicationNo"];

            string parent_folderName = "Kasneb/ICTHelpDesk";
            string subFolderName = leaveNo;
            string filelocation = sLibraryName + "/" + subFolderName;
            try
            {
                // if a folder doesn't exists, create it
                var listTitle = "ERP Documents";
                if (!FolderExists(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName))
                    CreateFolder(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName);

                if (Config.SPWeb != null)
                {
                    var sFileUrl = string.Format("{0}/{1}/{2}", sSpSiteRelativeUrl, filelocation, sFileName);
                    Microsoft.SharePoint.Client.File.SaveBinaryDirect(Config.SPClientContext, sFileUrl, fs, true);
                    Config.SPClientContext.ExecuteQuery();
                    sDocName = sFileName;
                }
            }

            catch (Exception)
            {
                sDocName = string.Empty;
            }
            return sDocName;
        }
        public static bool FolderExists(Web web, string listTitle, string folderUrl)
        {
            var list = web.Lists.GetByTitle(listTitle);
            var folders = list.GetItems(CamlQuery.CreateAllFoldersQuery());
            web.Context.Load(list.RootFolder);
            web.Context.Load(folders);
            web.Context.ExecuteQuery();
            var folderRelativeUrl = string.Format("{0}/{1}", list.RootFolder.ServerRelativeUrl, folderUrl);
            return Enumerable.Any(folders, folderItem => (string)folderItem["FileRef"] == folderRelativeUrl);
        }

        private static void CreateFolder(Web web, string listTitle, string folderName)
        {
            var list = web.Lists.GetByTitle(listTitle);
            var folderCreateInfo = new ListItemCreationInformation
            {
                UnderlyingObjectType = FileSystemObjectType.Folder,
                LeafName = folderName
            };
            var folderItem = list.AddItem(folderCreateInfo);
            folderItem.Update();
            web.Context.ExecuteQuery();
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            var sharepointUrl = ConfigurationManager.AppSettings["S_URL"]; try
            {
                using (ClientContext ctx = new ClientContext(sharepointUrl))
                {

                    string password = ConfigurationManager.AppSettings["S_PWD"];
                    string account = ConfigurationManager.AppSettings["S_USERNAME"];
                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                    var secret = new SecureString();
                    var parentFolderName = @"ERP%20Documents/Kasneb/ICTHelpDesk/";
                    var leaveNo = Request.QueryString["applicationNo"];

                    foreach (char c in password)
                    { secret.AppendChar(c); }
                    try
                    {
                        ctx.Credentials = new NetworkCredential(account, secret, domainname);
                        ctx.Load(ctx.Web);
                        ctx.ExecuteQuery();

                        Uri uri = new Uri(sharepointUrl);
                        string sSpSiteRelativeUrl = uri.AbsolutePath;

                        string filePath = sSpSiteRelativeUrl + parentFolderName + leaveNo + "/" + fileName.Text;

                        var file = ctx.Web.GetFileByServerRelativeUrl(filePath);
                        ctx.Load(file, f => f.Exists);
                        file.DeleteObject();
                        ctx.ExecuteQuery();

                        if (!file.Exists)
                            throw new FileNotFoundException();
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    catch (Exception ex)
                    {
                        // ignored
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //throw;
            }

           



        }

        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["applicationNo"];
            Response.Redirect("ICTHelpDesk.aspx?step=1&&applicationNo=" + requisitionNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            Response.Redirect("MyHelpDeskRequests.aspx");
        }

        protected void category_SelectedIndexChanged(object sender, EventArgs e)
        {
            var selectedcategory = category.SelectedValue.Trim();
            string empNo = Session["employeeNo"].ToString();
            var nav = new Config().ReturnNav();
            var Helpdesksubcategory = nav.HelpDeskSubcategories.Where(r => r.Category == selectedcategory).ToList();
            subcategory.DataSource = Helpdesksubcategory;
            subcategory.DataValueField = "Code";
            subcategory.DataTextField = "Description";
            subcategory.DataBind();
            subcategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
        }

        //protected void category_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    var selectedcategory = category.SelectedValue.Trim();
        //    string empNo = Session["employeeNo"].ToString();
        //    var nav = new Config().ReturnNav();
        //    var asstes = nav.Assets.Where(r=>r.ICT_Asset_Category ==selectedcategory && r.Blocked == false && r.Current_Assigned_Employee == empNo ).ToList();
        //    asset.DataSource = asstes;
        //    asset.DataValueField = "Code";
        //    asset.DataTextField = "Description";
        //    asset.DataBind();
        //    asset.Items.Insert(0, new ListItem("--select--", ""));

        //}
    }
}