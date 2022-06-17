using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ImprestSurrender : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 5;
            var nav = new Config().ReturnNav();

            string appliesToDocNo = Request.QueryString["ImprestMemo"];

            var receipts = nav.receipts.Where(r => r.Applies_to_Doc_No == appliesToDocNo && r.Account_No == Convert.ToString(Session["employeeNo"])).ToList();

           

            if (!IsPostBack)
            {
                var openImprests =
                    nav.Payments.Where(
                        r =>
                            r.Payment_Type == "Imprest" && r.Posted == true && r.Surrendered == false 
                           // &&  r.Selected == false 
                            && r.Account_No == Convert.ToString(Session["employeeNo"]));
                imprest.DataSource = openImprests;
                imprest.DataValueField = "No";
                imprest.DataTextField = "No";
                imprest.DataBind();
               
            }
            string name = Convert.ToString(Session["name"]);
            String surrenderNo = "";
            Boolean existingSurrender = false;
            try
            {
                surrenderNo = Request.QueryString["surrenderNo"];
                {
                    //existingSurrender = true;
                    if (!String.IsNullOrEmpty(surrenderNo))
                    {
                        var imprestSurrenders = nav.Payments.Where(
                            r =>
                                r.Payment_Type == "Surrender" && r.Document_Type == "Surrender" &&
                                r.Account_No == Convert.ToString(Session["employeeNo"]) && r.No == surrenderNo);
                        foreach (var surrender in imprestSurrenders)
                        {
                            existingSurrender = true;
                            if (!IsPostBack)
                            {
                                imprest.SelectedValue = surrender.Imprest_Issue_Doc_No;
                            }
                        }
                        if (!existingSurrender)
                        {
                          Response.Redirect("ImprestSurrender.aspx");  
                        }
                    }
                }
            }
            catch (Exception)
            {
                surrenderNo = "";
            }

            if (existingSurrender)
            {
            try
            {
               
                var imprestLines = nav.ImprestLines.Where(r => r.No == surrenderNo).ToList();
                foreach (var line in imprestLines)
                {
                    HtmlTableRow row = new HtmlTableRow();
                    //Account Type 	Account No 	Account Name 	Amount 	Actual Spent 	Receipt No
                    HtmlTableCell accountType = new HtmlTableCell();
                    accountType.InnerText = line.Account_Type;

                    HtmlTableCell accountNo = new HtmlTableCell();
                    accountNo.InnerText = line.Account_No;

                    HtmlTableCell accountName = new HtmlTableCell();
                    accountName.InnerText = line.Account_Name;

                    HtmlTableCell amountCell = new HtmlTableCell();
                    amountCell.InnerText = String.Format("{0:n}", Convert.ToDouble(line.Amount) );

                    HtmlTableCell actualSpent = new HtmlTableCell();
                    TextBox amountSpent = new TextBox();
                    amountSpent.CssClass = "form-control actualSpent";
                    amountSpent.ID = "amountSpent" + line.Line_No;
                    actualSpent.Controls.Add(amountSpent);
                    amountSpent.Text = line.Actual_Spent + "";

                    HtmlTableCell receipt = new HtmlTableCell();
                    DropDownList receiptNo = new DropDownList();

                        List<String> receiptNos = new List<string>();
                        receiptNos.Add("");
                        foreach (var myReceipt in receipts)
                        {
                            receiptNos.Add(myReceipt.No);
                        }

                        receiptNo.DataSource = receiptNos;
                        receiptNo.DataBind();
                        receiptNo.CssClass = "form-control";
                        receiptNo.ID = "receipt" + line.Line_No;
                        receipt.Controls.Add(receiptNo);
                        try
                        {
                            receiptNo.SelectedValue = line.Receipt_No;
                        }
                        catch (Exception)
                        {

                        }


                        row.Cells.Add(accountType);
                    row.Cells.Add(accountNo);
                    row.Cells.Add(accountName);
                    row.Cells.Add(amountCell);
                    row.Cells.Add(actualSpent);
                    row.Cells.Add(receipt);


                    linesTable.Rows.Add(row);
                }
            }
            catch (Exception)
            {

            }
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            String surrenderNo = Request.QueryString["surrenderNo"];
            Response.Redirect("ImprestSurrender.aspx?step=1&&surrenderNo=" + surrenderNo);
        }

        protected void sendForApproval_Click(object sender, EventArgs e)
        {
            if (SaveLines())
            {
                try
                {
                    //Convert.ToString(Session["employeeNo"])
                    String surrenderNo = Request.QueryString["surrenderNo"];
                    String status = Config.ObjNav.SendImprestSurrenderApproval(Convert.ToString(Session["employeeNo"]), surrenderNo);
                    String[] info = status.Split('*');
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                catch (Exception t)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }
        protected void save_Click(object sender, EventArgs e)
        {
            if (SaveLines())
            {
                linesFeedback.InnerHtml = "<div class='alert alert-success'>Your Imprest Surrender was successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            bool fileuploadSuccess = false;
            string sUrl = ConfigurationManager.AppSettings["S_URL"];
            string defaultlibraryname = "ERP%20Documents/";
            string customlibraryname = "Kasneb/Imprest Surrender";
            string sharepointLibrary = defaultlibraryname + customlibraryname;
            String leaveNo = Request.QueryString["surrenderNo"];

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

                    var sDocName = UploadImprestSurrender(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                    string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                    if (!string.IsNullOrEmpty(sDocName))
                    {
                        var status = Config.ObjNav.AddImprestSurrenderSharepointLinks(leaveNo, uploadfilename, sharepointlink);
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


                }
            }
            catch (Exception ex)
            {

                documentsfeedback.InnerHtml =
                               "<div class='alert alert-danger'>'" + ex.Message+ "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Surrender/";

            //if (document.HasFile)
            //{
            //    try
            //    {
            //        if (Directory.Exists(filesFolder)) 
            //        {
            //            String extension = System.IO.Path.GetExtension(document.FileName);
            //            if (new Config().IsAllowedExtension(extension))
            //            {
            //                String imprestNo = Request.QueryString["surrenderNo"];
            //                string imprest = imprestNo;
            //                imprestNo = imprestNo.Replace('/', '_');
            //                imprestNo = imprestNo.Replace(':', '_');
            //                String documentDirectory = filesFolder + imprestNo + "/";
            //                Boolean createDirectory = true;
            //                try
            //                {
            //                    if (!Directory.Exists(documentDirectory))
            //                    {
            //                        Directory.CreateDirectory(documentDirectory);
            //                    }
            //                }
            //                catch (Exception)
            //                {
            //                    createDirectory = false;
            //                    documentsfeedback.InnerHtml =
            //                                                    "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
            //                                                    "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //                }
            //                if (createDirectory)
            //                {
            //                    string filename = documentDirectory + document.FileName;
            //                    if (File.Exists(filename))
            //                    {
            //                        documentsfeedback.InnerHtml =
            //                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //                    }
            //                    else
            //                    {
            //                        document.SaveAs(filename);
            //                        if (File.Exists(filename))
            //                        {
            //                            Config.navExtender.AddLinkToRecord("Imprest Surrender", imprest, filename, "");
            //                            documentsfeedback.InnerHtml =
            //                                "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                        }
            //                        else
            //                        {
            //                            documentsfeedback.InnerHtml =
            //                                "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                        }
            //                    }
            //                }
            //            }
            //            else
            //            {
            //                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //            }

            //        }
            //        else
            //        {
            //            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }

            //    }
            //    catch (Exception ex)
            //    {
            //        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'"+ex.Message+"'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        //The document could not be uploaded
            //    }
            //}
            //else
            //{
            //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            //}


        }

        public string UploadImprestSurrender(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            leaveNo = Request.QueryString["surrenderNo"];

            string parent_folderName = "Kasneb/Imprest Surrender";
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
        protected void deleteFile_Click(object sender, EventArgs e)
        {


            var sharepointUrl = ConfigurationManager.AppSettings["S_URL"]; try
            {
                using (ClientContext ctx = new ClientContext(sharepointUrl))
                {

                    string password = ConfigurationManager.AppSettings["S_PWD"];
                    string account = ConfigurationManager.AppSettings["S_USERNAME"];
                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                    var secret = new SecureString();
                    var parentFolderName = @"ERP%20Documents/Kasneb/Imprest Surrender/";
                    var leaveNo = Request.QueryString["surrenderNo"];

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

            //try
            //{
            //    String tFileName = fileName.Text.Trim();
            //    String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Surrender/";
            //    String imprestNo = Request.QueryString["surrenderNo"];
            //    imprestNo = imprestNo.Replace('/', '_');
            //    imprestNo = imprestNo.Replace(':', '_');
            //    String documentDirectory = filesFolder + imprestNo + "/";
            //    String myFile = documentDirectory + tFileName;
            //    if (File.Exists(myFile))
            //    {
            //        File.Delete(myFile);
            //        if (File.Exists(myFile))
            //        {
            //            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }
            //        else
            //        {
            //            documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }
            //    }
            //    else
            //    {
            //        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //    }



            //}
            //catch (Exception m)
            //{
            //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //}

            //removeNumber
            //removeWorkType



        }



        //protected void deleteFile_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        String tFileName = fileName.Text.Trim();
        //        String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Surrender/";
        //        String imprestNo = Request.QueryString["surrenderNo"];
        //        imprestNo = imprestNo.Replace('/', '_');
        //        imprestNo = imprestNo.Replace(':', '_');
        //        String documentDirectory = filesFolder + imprestNo + "/";
        //        String myFile = documentDirectory + tFileName;
        //        if (File.Exists(myFile))
        //        {
        //            File.Delete(myFile);
        //            if (File.Exists(myFile))
        //            {
        //                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //            else
        //            {
        //                documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //        }
        //        else
        //        {
        //            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }



        //    }
        //    catch (Exception m)
        //    {
        //        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //    }

        //    //removeNumber
        //    //removeWorkType



        //}

        public Boolean SaveLines()
        {
            Boolean error = false;
            String message = "";
            List<SurrenderLine> allValues = new List<SurrenderLine>();
            HtmlTableRowCollection allRows = linesTable.Rows;
           // int size = allRows.Count
            foreach (HtmlTableRow row in allRows)
            {
                SurrenderLine myLine = new SurrenderLine();
                //DropDownList
                Decimal mAmountSpent = 0;
                String receiptNo = "";
                int tLineNo = 0;
                HtmlTableCellCollection allCells = row.Cells;
                foreach (HtmlTableCell myCell in allCells)
                {
                    ControlCollection myControls = myCell.Controls;
                    foreach (Control control in myControls)
                    {
                        String controlType = control.GetType().ToString().Trim();
                       
                        if (controlType == "System.Web.UI.WebControls.DropDownList")
                        {
                            DropDownList tReceipt = (DropDownList)control;
                            receiptNo = tReceipt.SelectedValue;
                            myLine.receiptNo = receiptNo;
                        }
                        else if (controlType == "System.Web.UI.WebControls.TextBox")
                        {

                            TextBox tAmountSpent = (TextBox)control;
                            String tSpentAmount = tAmountSpent.Text;
                            String textBoxId = tAmountSpent.ID;
                            String lineNo = textBoxId.Replace("amountSpent", "");
                           
                            try
                            {
                                int mLineNo = Convert.ToInt32(lineNo);
                                tLineNo = mLineNo;
                                myLine.lineNo = tLineNo;
                                try
                                {
                                    Decimal sAmount = Convert.ToDecimal(tSpentAmount);
                                    myLine.amount = sAmount;
                                }
                                catch (Exception)
                                {
                                    error = true;
                                    message =
                                        "Invalid Amount*Some values you have entered for spent amount are wrong. Please try again*error";
                                    break;
                                }
                            }
                            catch (Exception)
                            {
                                error = true;
                                message = "Wrong Line No*The line number you have entered is wrong*error";
                                break;
                            }
                            
                           
                          

                        }
                       
                    }

                }
                allValues.Add(myLine);

            }
            if (error)
            {
               /* error = true;
                String values = "";
                foreach (SurrenderLine value in allValues)
                {
                    values +=  value.lineNo +" Amount"+ value.amount + value.receiptNo+"<br/>";
                }*/
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {
                foreach (SurrenderLine value in allValues)
                {
                    if (value.lineNo > 0)
                    {


                        try
                        {
                            //Convert.ToString(Session["employeeNo"])
                           string branchCode = Convert.ToString(Session["BranchCode"]);
                            string divisionCode=Convert.ToString(Session["DivisionCode"]);
                            String surrenderNo = Request.QueryString["surrenderNo"];
                            int myLineNo = value.lineNo;
                            String status =
                                Config.ObjNav.UpdateSurrenderLine(Convert.ToString(Session["employeeNo"]),
                                    surrenderNo, value.lineNo, value.amount, value.receiptNo,branchCode,divisionCode);
                            String[] info = status.Split('*');
                            if (info[0] == "danger")
                            {
                                error = true;
                                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] +
                                                          " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                break;

                            }
                        }
                        catch (Exception r)
                        {
                            error = true;
                            linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + r.Message +
                                                      " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }
                }
            }
            return !error;
        }
        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                //Convert.ToString(Session["employeeNo"])
                String surrenderNo = "";
                Boolean newSurrender = false;
                try
                {
                    surrenderNo = Request.QueryString["surrenderNo"];
                    if (String.IsNullOrEmpty(surrenderNo))
                    {
                        surrenderNo = "";
                        newSurrender = true;
                    }
                }
                catch (Exception)
                {
                    newSurrender = true;
                    surrenderNo = "";
                }
                String tImprestNo = String.IsNullOrEmpty(imprest.SelectedValue.Trim())
                    ? ""
                    : imprest.SelectedValue.Trim();
                String status = Config.ObjNav.CreateImprestSurrender(Convert.ToString(Session["employeeNo"]), tImprestNo,
                    surrenderNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newSurrender)
                    {
                        surrenderNo = info[2];
                    }
                    Response.Redirect("ImprestSurrender.aspx?step=2&&surrenderNo=" + surrenderNo);
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            if (SaveLines())
            {
                String surrenderNo = Request.QueryString["surrenderNo"];
                Response.Redirect("ImprestSurrender.aspx?step=3&&surrenderNo=" + surrenderNo);
            }
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String surrenderNo = Request.QueryString["surrenderNo"];
            Response.Redirect("ImprestSurrender.aspx?step=2&&surrenderNo=" + surrenderNo);
        }
    }
}