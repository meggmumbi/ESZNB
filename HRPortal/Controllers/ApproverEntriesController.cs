using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace HRPortal.Controllers
{
    public class ApproverEntriesController : ApiController
    {

         // POST: api/ApprovalEntries
        public List<ApprovalEntries> Post([FromBody]ApprovalFilter value)
        {
            List<ApprovalEntries> allEntries = new List<ApprovalEntries>();
            var nav = new Config().ReturnNav();
            var myEntries = nav.ApprovalEntries.Where(r => r.Table_ID == value.TableId && r.Document_Type == value.DocumentType && r.Document_No == value.DocumentNo);
            foreach (var entry in myEntries)
            {
                ApprovalEntries aEntry = new ApprovalEntries();
                aEntry.SequenceNo = Convert.ToInt32(entry.Sequence_No);
                aEntry.Status = entry.Status;
                aEntry.SenderId = entry.Sender_ID;
                aEntry.ApproverId = entry.Approver_ID;
                aEntry.Amount = String.Format("{0:n}", Convert.ToDouble(entry.Amount));
                aEntry.DateSentforApproval = Convert.ToDateTime(entry.Date_Time_Sent_for_Approval).ToString();
                //
                //aEntry.Comment = entry.Comment.ToString();
                aEntry.DueDate = Convert.ToDateTime(entry.Due_Date).ToString();
                String comment = "";
                if (Convert.ToBoolean(entry.Comment) == false || Convert.ToBoolean(entry.Comment) == true)

                {
                    //Table ID=FIELD(Table ID),Record ID to Approve=FIELD(Record ID to Approve),Workflow Step Instance ID=FIELD(Workflow Step Instance ID)))
                    var comments = nav.ApprovalCommentLine.Where(r => r.Table_ID == entry.Table_ID && r.Record_ID_to_Approve == entry.Record_ID_to_Approve && r.Workflow_Step_Instance_ID == entry.Workflow_Step_Instance_ID
                    && r.Workflow_Step_Instance_ID == entry.Workflow_Step_Instance_ID && r.User_ID == entry.Approver_ID);
                    foreach (var myComment in comments)
                    {
                        comment += comment.Length < 1 ? "<ul>" : "";
                        comment += "<li>" + myComment.Comment + "</li>";
                    }
                    comment += comment.Length > 0 ? "</ul>" : "";
                }
                aEntry.Comment = comment;
                allEntries.Add(aEntry);

            }
            return allEntries;
        }


    }
}
