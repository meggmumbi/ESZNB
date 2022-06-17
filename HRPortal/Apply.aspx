<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Apply.aspx.cs" Inherits="HRPortal.Apply" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% var nav = new Config().ReturnNav();
      var jobId = Request.QueryString["id"]; %>
      <div class="row" style="margin: 10px;">
                     <% 
                      var jobDetails = nav.VacantPositions.Where(r => r.Job_ID == jobId);
                       foreach (var jobDetail in jobDetails)
                      {
                      %>
                   
           <div class="span12"><h3><i><a href="JobDetails.aspx?id=<%=jobId %>"><%=jobId %></a>&nbsp;<%=jobDetail.Job_Description %>&nbsp;<%=jobDetail.Grade %></i></h3>
                   <% 
                      }
                  %> 

           </div> 
      </div> 
   
    <div class="row" style="margin: 10px;">
       <div id="feedback" runat="server"></div>
   
     <div class="span6">
     <div >
     <div class="widget">
            <div class="widget-header"> <i class="icon-file"></i>
              <h3> Job Application Details</h3>
            </div>
         <div class="widget-content" style="overflow: auto;">
             <% 
                 var idNo = Session["idNo"].ToString();
                 var empNo = Session["employeeNo"].ToString();
                // var hrJobApplicant = nav.HrJobApplicants.Where(r => r.ID_Number == idNo && r.Employee_No == empNo);
                  var hrJobApplicant = nav.HrJobApplicants.Where(r => r.ID_Number == idNo);
                 foreach (var applicant in hrJobApplicant)
                 {
               %>

             
             <table class="table table-striped table-bordered">
                 <tr><th>First Name</th><td><%=applicant.First_Name %></td></tr>
                 <tr><th>Middle Name</th><td><%=applicant.Middle_Name %></td></tr>
                 <tr><th>Last Name</th><td><%=applicant.Last_Name %></td></tr>
                 <tr><th>Initials</th><td><%=applicant.Initials %></td></tr>
                  <%--<tr><th>Firt Language</th><td>
                      <%=applicant.First_Language_R_W_S %>
                      <table>
                        <tr><td>Read</td><td>Write</td><td>Speak</td></tr>
                          <tr><td><%=applicant.First_Language_Read %></td><td><%=applicant.First_Language_Write %></td><td><%=applicant.First_Language_Speak %></td></tr>
                      </table>
                  </td></tr>--%>
                <%-- <tr><th>Second Language</th><td>
                      <%=applicant.Second_Language_R_W_S %>
                      <table>
                          <tr><td>Read</td><td>Write</td><td>Speak</td></tr>
                          <tr><td><%=applicant.Second_Language_Read %></td><td><%=applicant.Second_Language_Write %></td><td><%=applicant.Second_Language_Speak %></td></tr>
                      </table>
                  </td></tr>
                  <tr><th>Additional Language</th><td><%=applicant.Additional_Language %></td></tr>
                    --%>
                  <tr><th>Id Number</th><td><%=applicant.ID_Number %></td></tr>
                  <tr><th>Gender</th><td><%=applicant.Gender %></td></tr>
                  <tr><th>Citizenship</th><td><%=applicant.Citizenship %></td></tr>
                 </table>

             
         
         </div>
         </div>
         </div>
          
             </div>
     <div class="span6">
     <div class="widget">
            <div class="widget-header"> <i class="icon-file"></i>
              <h3> Personal Details</h3>
            </div>
         <div class="widget-content" style="overflow: auto;">
             <table class="table table-striped table-bordered">
                   <tr><th>Marital Status</th><td><%=applicant.Marital_Status %></td></tr>
                   <tr><th>Ethnic Origin</th><td><%=applicant.Ethnic_Origin %></td></tr>
                   <tr><th>Disabled</th><td><%=applicant.Disabled %></td></tr>
                   <tr><th>Health Assessment</th><td><%=applicant.Health_Assesment %></td></tr>
                   <tr><th>Health Assessment Date</th><td><%=applicant.Health_Assesment_Date %></td></tr>
                   <tr><th>Date of Birth</th><td><%=applicant.Date_Of_Birth %></td></tr>
                 </table>
             </div>
             </div>
             </div>
          
           <div class="span6">
     <div class="widget">
            <div class="widget-header"> <i class="icon-file"></i>
              <h3> Communication Details</h3>
            </div>
         <div class="widget-content" style="overflow: auto;">
             <table class="table table-striped table-bordered">
                   <tr><th>Home Phone Number</th><td><%=applicant.Home_Phone_Number %></td></tr>
                   <tr><th>Postal Address</th><td><%=applicant.Postal_Address %></td></tr>
                   <tr><th>Postal Address 2</th><td><%=applicant.Postal_Address2 %></td></tr>
                   <tr><th>Postal Address 3</th><td><%=applicant.Postal_Address3 %></td></tr>
                   <tr><th>Post Code</th><td><%=applicant.Post_Code %></td></tr>
                   <tr><th>Residential Address</th><td><%=applicant.Residential_Address %></td></tr>
                   <tr><th>Residential Address 2</th><td><%=applicant.Residential_Address2 %></td></tr>
                   <tr><th>Residential Address 3</th><td><%=applicant.Residential_Address3 %></td></tr>
                   <tr><th>Post Code 2</th><td><%=applicant.Post_Code2 %></td></tr>
                   <tr><th>Cell Phone Number</th><td><%=applicant.Cell_Phone_Number %></td></tr>
                   <tr><th>Work Phone Number</th><td><%=applicant.Work_Phone_Number %></td></tr>
                   <%--<tr><th>Extension</th><td><%=applicant.Ext %></td></tr>--%>
                   <tr><th>Email</th><td><%=applicant.E_Mail %></td></tr>
                   <%--<tr><th>Fax Number</th><td><%=applicant.Fax_Number %></td></tr>--%>
                 </table>
             </div>
             </div>
             </div>   
        <%
                } %> 
        <div class="span12">
     <div class="widget">
            <div class="widget-header"> <i class="icon-file"></i>
              <h3> Qualifications</h3>
            </div>
         <div class="widget-content" style="overflow: auto;">
             <table class="table table-striped table-bordered">
                 <thead>
                 <tr>
                  
                     <th>Qualification Code</th>
                     <th>Qualification Description</th>
                     <th>From Date</th>
                     <th>To Date</th>
                     <th>Institution/Company</th>
                 </tr>
                 </thead>
                   <tbody>
                <% var qualifications = nav.JobApplicantQualifications.Where(r => r.Id_No == (String) Session["idNo"]);
                    foreach (var qualification in qualifications)
                    {
                 %>
                        
                   
                 <tr>
                     <td><% =qualification.Qualification_Code %></td>
                     <td><% =qualification.Qualification_Description %></td>
                     <td><% =Convert.ToDateTime(qualification.From_Date).ToString("dd/MM/yyyy") %></td>
                     <td><% =Convert.ToDateTime(qualification.To_Date).ToString("dd/MM/yyyy") %></td>
                     <td><% =qualification.Institution_Company %></td>
                     
                     
                 </tr>
                     <%
                    } %>
                 </tbody>
                 </table>
             </div>
             </div>
             </div>  
        <div >
     <div class="widget">
            <div class="widget-header"> <i class="icon-file"></i>
              <h3> Hobies</h3>
            </div>
         <div class="widget-content" style="overflow: auto;">
            <ol>
                <!-- get hobies-->
                <% var hobies = nav.JobApplicantHobies.Where(r => r.Id_No == (String) Session["idNo"]);
                   foreach (var hobby in hobies)
                   {
                       %>
                        <li><%=hobby.Hobby %></li>       
                <%
                   }
                     %>
             
            </ol>
             </div>
             </div>
             </div>
              <div class="span12">
     <div class="widget">
            <div class="widget-header"> <i class="icon-file"></i>
              <h3> Referees</h3>
            </div>
         <div class="widget-content" style="overflow: auto;">
             <table class="table table-striped table-bordered">
                 <thead>
                 <tr>
                     <th>Name</th>
                     <th>Designation</th>
                     <th>Institution</th>
                     <th>Address</th>
                     <th>Telephone No.</th>
                     <th>Email</th>
                 </tr>
                 </thead>
                 <tbody>
                 <% var referees = nav.JobApplicantReferees.Where(r => r.Id_Number == (String) Session["idNo"]);
                    foreach (var referee in referees)
                    {
                 %>
                        
                   
                 <tr>
                     <td><% =referee.Names %></td>
                     <td><% =referee.Designation %></td>
                     <td><% =referee.Institution %></td>
                     <td><% =referee.Address %></td>
                     <td><% =referee.Telephone_No %></td>
                     <td><% =referee.E_Mail %></td>
                 </tr>
                     <%
                    } %>
                 </tbody>
                 </table>
             </div>
             </div>
             </div>
              
       
           </div>
    <div class="row" style="margin: 10px;">
          <asp:LinkButton ID="applyJob" CssClass="button btn btn-success btn-large pull-right" runat="server" OnClick="applyJob_Click">Submit Application</asp:LinkButton>
        <asp:LinkButton ID="backtoProfile" CssClass="button btn btn-info btn-large pull-left" runat="server" OnClick="backtoProfile_Click">Back To Profile</asp:LinkButton>
    </div>
</asp:Content>
