using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRPortal.Models
{
    public class ApprovalEntries
    {
        public int SequenceNo { get; set; }
        public string Status { get; set; }
        public string SenderId { get; set; }
        public string ApproverId { get; set; }
        public string Amount { get; set; }
        public String DateSentforApproval { get; set; }
        public String Comment { get; set; }
        public String DueDate { get; set; }

    }
    public class SharePointTModel
    {
        public string FileName { get; set; }
        public string FolderName { get; set; }
    }

    public class ApprovalFilter
    {
        public int TableId { get; set; }
        public String DocumentType { get; set; }
        public String DocumentNo { get; set; }
    }

    public class Users
    {
        public String user { get; set; }
        public String UserName { get; set; }

    }
    public class Item
    {
        public string No { get; set; }
        public String Description { get; set; }
    }
}