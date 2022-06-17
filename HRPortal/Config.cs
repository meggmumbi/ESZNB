using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Web;

namespace HRPortal
{
    public class Config
    {
        public static ClientContext SPClientContext { get; set; }
        public static Web SPWeb { get; set; }
        public static string SPErrorMsg { get; set; }
        public Nav.NAV ReturnNav()
        {

            Nav.NAV nav = new Nav.NAV(new Uri(ConfigurationManager.AppSettings["ODATA_URI"]))
            {
                Credentials =
                    new NetworkCredential(ConfigurationManager.AppSettings["W_USER"],
                        ConfigurationManager.AppSettings["W_PWD"], ConfigurationManager.AppSettings["DOMAIN"])
            };
            return nav;
        }
        public static HRPortal.HRPortal ObjNav
        {
            get
            {
                var ws = new HRPortal.HRPortal();

                try
                {
                    var credentials = new NetworkCredential(ConfigurationManager.AppSettings["W_USER"],
                        ConfigurationManager.AppSettings["W_PWD"], ConfigurationManager.AppSettings["DOMAIN"]);
                    ws.Credentials = credentials;
                    ws.PreAuthenticate = true;

                }
                catch (Exception ex)
                {
                    ex.Data.Clear();
                }
                return ws;
            }
        }

        public static NavExtender.NavXtender navExtender
        {
            get { 
            var res = new NavExtender.NavXtender();
            try
            {
                var credential = new NetworkCredential(ConfigurationManager.AppSettings["W_USER"],
                    ConfigurationManager.AppSettings["W_PWD"], ConfigurationManager.AppSettings["DOMAIN"]);
                res.Credentials = credential;
                res.PreAuthenticate = true;

            }
            catch (Exception  ex)
            {

                ex.Data.Clear();
            }

            return res;
            }
        }

        public Boolean IsAllowedExtension(String extension)
        {
            Boolean check = Convert.ToBoolean(ConfigurationManager.AppSettings["CheckFileExtensions"]);
            if (check)
            {
                String allowedFileTypes = ConfigurationManager.AppSettings["AllowedFileExtensions"];
                String[] info = allowedFileTypes.Split(',');
                extension = extension.Replace('.', ' ');
                extension = extension.Trim();
                extension = extension.ToLower();
                foreach (String fileExtension in info)
                {
                    String myExtension = fileExtension;
                    myExtension = myExtension.Replace('.', ' ');
                    myExtension = myExtension.Trim();
                    myExtension = myExtension.ToLower();
                    if (myExtension==extension)
                    {
                        return true;
                    }
                }

            }
            else
            {
                return true;
            }
            return false;
        }

        public static bool Connect(string SPURL, string SPUserName, string SPPassWord, string SPDomainName)
        {

            bool bConnected = false;

            try
            {
                ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;



                SPClientContext = new ClientContext(SPURL);

                SPClientContext.Credentials = new NetworkCredential(SPUserName, SPPassWord, SPDomainName);

                SPClientContext.RequestTimeout = 1800000;

                SPWeb = SPClientContext.Web;

                SPClientContext.Load(SPWeb);

                SPClientContext.ExecuteQuery();

                bConnected = true;




                bConnected = true;

            }

            catch (Exception ex)
            {

                bConnected = false;

                SPErrorMsg = ex.Message;

            }

            return bConnected;

        }

        public static string FilesLocation()
        {
            return ConfigurationManager.AppSettings["FilesLocation"];
        }

    }
}