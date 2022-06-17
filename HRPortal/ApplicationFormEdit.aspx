<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApplicationFormEdit.aspx.cs" Inherits="HRPortal.ApplicationFormEdit" %>
<%@ Import Namespace="HRPortal" %>
<%@ Import Namespace="System.IO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <% var nav = new Config().ReturnNav();
         // var jobId = Request.QueryString["id"];
         var jobId = Request.QueryString["appNo"] ;
         int step = 1;

         try
         {

             step = Convert.ToInt32(Request.QueryString["step"].ToString());
             if (step == 0)
             {
                 step = 1;
             }
         }
         catch (Exception)
         {
             step = 1;



         }

 %>
      <%
          if(step==1)
          {%>
    <div class = "panel panel-primary">
   <div class = "panel-heading">
      <h3 class = "panel-title">Personal Details</h3>
        </div>
   
   <div class = "panel-body">
       <div runat="server" id="feedback1"></div>
      
       <h3><strong>1.0 Post Applied For:</strong></h3>
    
    <div class="form-group">
           <asp:TextBox runat="server" ID="appliedfor1" ReadOnly="true" CssClass="form-control" placeholder="post applied for"/>
       </div>
       <h3><strong>2.0 Personal Details</strong></h3>
       <div class="row">
       <div class="form-group col-xs-3">
           <label for="Surname">Surname</label>
                <asp:TextBox runat="server" ID="Surname1" CssClass="form-control" placeholder=""/>
            <%--<asp:RequiredFieldValidator runat="server" id="reqName" controltovalidate="Surname" BackColor="Red" errormessage="Please enter your Surname!" />--%>

            </div>
        <div class="form-group col-xs-3">
           <label for="Firstname">Firstname</label>
                <asp:TextBox runat="server" ID="Firstname1" CssClass="form-control" placeholder=""/>
           <%--  <asp:RequiredFieldValidator runat="server"  controltovalidate="Firstname" BackColor="Red" errormessage="Please enter your Firstname!" />--%>

            </div>
        <div class="form-group col-xs-3">
           <label for="Lastname">Lastname</label>
                <asp:TextBox runat="server" ID="Lastname1" CssClass="form-control" placeholder=""/>
          <%--  <asp:RequiredFieldValidator runat="server"  controltovalidate="Lastname" BackColor="Red" errormessage="Please enter your Lastname!" />--%>
            </div>
         <div class="form-group col-xs-3">
           <label for="Title">Title</label>
                <asp:TextBox runat="server" ID="txtTitle1" CssClass="form-control" placeholder=""/>
            <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="txtTitle" BackColor="Red" errormessage="Please enter your Title!" />--%>

            </div>
         </div>

    <div class="row">
        <div class="form-group col-xs-4">
             <label for="DOB">Date of Birth</label>
            <asp:TextBox runat="server" ID="DOB1" CssClass="form-control" placeholder=""/>
          <%--  <asp:RequiredFieldValidator runat="server"  controltovalidate="DOB" BackColor="Red" errormessage="Please enter your Date of Birth!" />--%>
            </div>
        <div class="form-group col-xs-4">
             <label for="Gender">Gender</label>
        <asp:DropDownList ID="Gender1" runat="server" visible="true"  CssClass="form-control select2" 
                    AutoPostBack="false">
             <%--  <asp:ListItem>Select</asp:ListItem>--%>
                      <asp:ListItem Value="0">Male</asp:ListItem>
                      <asp:ListItem Value="1">Female</asp:ListItem>
                      <asp:ListItem Value="2">Both</asp:ListItem>

           </asp:DropDownList> 
           <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="Gender" BackColor="Red" errormessage="Please select  your Gender!" />--%>
        </div>
        <div class="form-group col-xs-4">
             <label for="Ethnicity">Ethnicity</label>
            <asp:TextBox runat="server" ID="Ethnicity1" CssClass="form-control" placeholder=""/>
            <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="Ethnicity" BackColor="Red" errormessage="Please enter your Ethnicity!" />--%>

            </div>


    </div>
   <div class="row">
        <div class="form-group col-xs-6">
             <label for="Disability"> Are you a person living with disability?</label>
            <%--<asp:TextBox runat="server" ID="disability" CssClass="form-control" placeholder=""/>--%>
           <asp:DropDownList ID="disability1" runat="server" visible="true"  CssClass="form-control select2" 
                    AutoPostBack="false">
               <%--<asp:ListItem>Select</asp:ListItem>--%>
                      <asp:ListItem Value="0">Yes</asp:ListItem>
                      <asp:ListItem Value="1">No</asp:ListItem>
                      </asp:DropDownList> 
            <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="disability" BackColor="Red" errormessage="Please enter your disability!" />--%>

        </div>
       
        
        </div>

<div class="row">
             
                 <div class="form-group col-xs-12">
             <label for="">Details of registration with the national council with people with disability (registration no and date).(Not More than 50 characters) </label>
           
             <asp:TextBox id="registrationNo1" CssClass="txt2" TextMode="multiline" MaxLength="2" Columns="50" Rows="10"  runat="server" />
         <br />
            <label id="txt2_WordCount"></label>
         </div>

</div>
<div class="row">
     
          <div class="form-group col-xs-3">
             <Label for="County">County of origin: </Label>
              <asp:DropDownList ID="County1" CssClass="form-control" runat="server"/>
             <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="County" BackColor="Red" errormessage="Please enter your County!" />--%>

            </div>
          <div class="form-group col-xs-3">
             <Label for="Nationality">Nationality: </Label>
              <asp:TextBox runat="server" ID="Nationality1" CssClass="form-control" placeholder=""/>
             <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="Nationality" BackColor="Red" errormessage="Please enter your Nationality!" />--%>

           </div>
        <div class="form-group col-xs-3">
             <Label for="Nationality">Religion: </Label>
           <asp:TextBox runat="server" ID="religion1" CssClass="form-control" placeholder=""/>
           <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="religion" BackColor="Red" errormessage="Please enter your religion!" />--%>
         </div>
         <div class="form-group col-xs-3">
             <Label for="Nationality">Marital status: </Label>
                     <asp:DropDownList ID="Maritalstatus1" CssClass="form-control" runat="server">
                  <%--  <asp:ListItem>Select</asp:ListItem>--%>
                      <asp:ListItem Value="0">Married</asp:ListItem>
                      <asp:ListItem Value="1">Single</asp:ListItem>
                      <asp:ListItem Value="2">Divorced</asp:ListItem>
                      <asp:ListItem Value="3">Separated</asp:ListItem>
                      <asp:ListItem Value="4">Widow(er)</asp:ListItem>
                      <asp:ListItem Value="5">Other</asp:ListItem>
                      </asp:DropDownList> 
             <%-- Single,Married,Separated,Divorced,Widow(er),Other<asp:RequiredFieldValidator runat="server"  controltovalidate="religion" BackColor="Red" errormessage="Please enter your Marital Status!" />
 --%>                </div>
          
             
      </div>     
 <div class="row">
             <div class="form-group col-xs-3">
             <Label for="Nationality">National ID No:  </Label>
           <asp:TextBox runat="server" ID="IdNo1" CssClass="form-control" ReadOnly="true" placeholder=""/>
             <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="IdNo" BackColor="Red" errormessage="Please enter your Id number!" />--%>

             </div>
            <div class="form-group col-xs-3">
             <Label for="NHIF">NHIF: </Label>
           <asp:TextBox runat="server" ID="nhif1" CssClass="form-control" placeholder=""/>
               <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="nhif" BackColor="Red" errormessage="Please enter your Nhif number!" />--%>

             </div>
           <div class="form-group col-xs-3">
             <Label for="NSSF">NSSF: </Label>
           <asp:TextBox runat="server" ID="NSSF1" CssClass="form-control" placeholder=""/>
               <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="NSSF" BackColor="Red" errormessage="Please enter your NSSF number!" />--%>
             </div>

             <div class="form-group col-xs-3">
             <Label for="NSSF">KRA PIN:  </Label>
           <asp:TextBox runat="server" ID="pinNo1" CssClass="form-control" placeholder=""/>
                <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="pinNo" BackColor="Red" errormessage="Please enter your pin number!" />--%>

             </div>

             </div>
<h3><strong>3.0 Communication Details</strong></h3>
    <div class="row">
        <div class="form-group col-xs-3">
           <label for="Mobile Phone No">Mobile Phone No</label>
                <asp:TextBox runat="server" ID="PhoneNo1" CssClass="form-control" placeholder=""/>
            <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="pinNo" BackColor="Red" errormessage="Please enter your phone number!" />--%>
            </div>
        <div class="form-group col-xs-3">
           <label for="Mobile Phone No">Alternative Mobile No: </label>
                <asp:TextBox runat="server" ID="alt_PhoneNo1" CssClass="form-control" placeholder=""/>
            </div>
        <div class="form-group col-xs-3">
           <label for="Email">Email</label>
                <asp:TextBox runat="server" ID="Email1" type="email" CssClass="form-control" placeholder=""/>
           <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="email" BackColor="Red" errormessage="Please enter your email!" />--%>
        </div>
        <div class="form-group col-xs-3">
           <label for="Email">Alternative Email</label>
                <asp:TextBox runat="server" ID="alt_Email1" type="email" CssClass="form-control" placeholder=""/>
            </div> 
    </div>
        <h3><strong>4.0 Employment Details (for internal applicants)</strong></h3>
          <div class="row">
        <div class="form-group col-xs-4">
           <label for="Personal No">Personal No.</label>
                <asp:TextBox runat="server" ID="personalNo1" ReadOnly="true" CssClass="form-control" placeholder=""/>
            </div>
        <div class="form-group col-xs-4">
           <label for="Email">Centre/Department</label>
           
            <asp:DropDownList ID="Center1" runat="server" CssClass="form-control">

            </asp:DropDownList>

            </div>
        <div class="form-group col-xs-4">
           <label for="Email">Present substantive Post</label>
                <asp:TextBox runat="server" ID="currentPost1" CssClass="form-control" placeholder=""/>
           <%-- <asp:RequiredFieldValidator runat="server"  controltovalidate="email" BackColor="Red" errormessage="Please enter present substantive post!" />--%>

            </div>
    </div>
 <div class="row">
        <div class="form-group col-xs-4">
           <label for="Email">Job Group</label>
           <asp:TextBox runat="server" ID="jobGr1" CssClass="form-control" placeholder=""/>
            <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="jobGr" BackColor="Red" errormessage="Please enter Job group!" />--%>

            </div>
             <div class="form-group col-xs-4">
           <label for="Email">Date of first appointment</label>
                <asp:TextBox runat="server" ID="firstofDateappointment1" CssClass="form-control" placeholder=""/>
          <%--  <asp:RequiredFieldValidator runat="server"  controltovalidate="firstofDateappointment" BackColor="Red" errormessage="Please enter date of first appointment!" />--%>

             </div>

           <div class="form-group col-xs-4">
           <label for="Email">Date of current appointment (last promotion)</label>
                <asp:TextBox runat="server" ID="Dateofcurrentappointment1" CssClass="form-control" placeholder=""/>
                <%--<asp:RequiredFieldValidator runat="server"  controltovalidate="Dateofcurrentappointment" BackColor="Red" errormessage="Please enter date of current appointment!" />--%>

            </div>
   </div>
   </div>
        <div class = "panel-footer">
            <asp:Button ID="AddDetails1" runat="server" Text="Next" CausesValidation="false" class="button btn btn-info pull-right" OnClick="AddDetails1_Click"/>
            <asp:Button ID="GoBack" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack_Click"/>

             <%--<asp:Button ID="AddDetails1" runat="server" Text="Next" CausesValidation="false" class="button btn btn-info pull-right" OnClick="AddDetails1_Click" />--%>
            <div class="clearfix"></div>
             </div>
        </div>
      
        <%
        }
        else if(step == 2)
        {%>
          
  <div class = "panel panel-primary">
   <div class = "panel-heading">
      <h3 class = "panel-title"></h3>
        </div>
   
   <div class = "panel-body">
       <div runat="server" id="academicQualification1"></div>
      <h3><strong>5.0 Academic qualifications(starting with highest)</strong></h3>
       
              <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addQualification1">Add Qualification</button>
           <div class="table-responsive">               
             <table class="table table-striped table-bordered">
                 <thead>
                 <tr>
                     
                   <th>From</th>
                     <th>To</th>
                     <th>University/Colleges/ High School attended </th>
                     <th>Award attainment e.g. PhD, Masters, Bachelors, KSCE </th>
                     <th>Specialization/Subject e.g. Epidemiology, Microbiology, Entomology, Finance, Human resource</th>
                    <th>Grade Attained</th>
                      <th>Action</th>
                 </tr>
                 </thead>
                 <tbody>
               
                <%
                    var qualifications = nav.ApplicantsQualification.Where(r => r.Application_No==jobId.ToString()).ToList();
                    foreach (var qual in qualifications)
                    {
                 %>
                      
                   
                 <tr>
                     
                     <td><% =Convert.ToDateTime(qual.From_Date).ToString("dd/MM/yyyy") %></td>
                     <td><% =Convert.ToDateTime(qual.To_Date).ToString("dd/MM/yyyy") %></td>
                     <td><% =qual.Institution_Company %></td>
                     <td><% =qual.Qualification_Description %></td>
                     <td><% =qual.Specialization %></td>
                     <td><% =qual.Course_Grade %></td>
                      
                     <td><label class="btn btn-danger" onclick="DeleteQualification('<%=qual.Code %>','<%=qual.Application_No %>');"><i class="fa fa-trash-o"></i> Delete</label></td>

                  
                 </tr>
                     <%
                    } %>
                 </tbody>
                 </table>
               </div>

             <h3><strong>6.0 Professional/Technical Qualifications/certifications relevant to the post(starting with the Highest)</strong></h3>
             <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addProfessional1">Add Professional</button>
       <div class="table-responsive">               
              <table class="table table-striped table-bordered">
                 <thead>
                 <tr>
                     
                   <th>From</th>
                     <th>To</th>
                     <th>Institution</th>
                      <th>Awards/attainment e.g. Higher Diploma, Diploma, Certificate, Certified Public Accountants etc </th>
                     <th>Specialization/Subject e.g. Epidemiology, Applied Biology, Medical Laboratory services, Clinical Medicine and Surgery, Engineering, Human resource, Accounts etc</th>
                     <th>Class/Grade</th>

                 </tr>
                 </thead>
                 <tbody>
                <% var qualif = nav.ProfessionalQualification.Where(r => r.Application_No==jobId.ToString());
                    foreach (var prof in qualif)
                    {
                 %>
                        
                   
                 <tr>
                     <td><% =Convert.ToDateTime(prof.From_Date).ToString("dd/MM/yyyy") %></td>
                     <td><% =Convert.ToDateTime(prof.To_Date).ToString("dd/MM/yyyy") %></td>
                      <td><% =prof.Institution %></td>
                      <td><% =prof.Attainment %></td>
                       <td><% =prof.Specialization %></td>
                       <td><% =prof.Grade %></td>
                     <td><label class="btn btn-danger" onclick="DeleteProfessional('<%=prof.Code %>','<%=prof.Application_No %>');"><i class="fa fa-trash-o"></i> Delete</label></td>

                </tr>
                     <%
                    } %>
                 </tbody>
                 </table>
           </div>
            <h3><strong>7.0 Relevant courses and training attended lasting not less than one(1) week</strong></h3>
<button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addTraining1">Add Training</button>
              <table class="table table-striped table-bordered">
                 <thead>
                 <tr>
                     
                   <th>FROM</th>
                     <th>To</th>
                     <th>Name of course</th>
                     <th>Institution</th>
                     <th>Awards/attainment</th>
                     <%--<th>Institution/Company</th>--%>
                 </tr>
                 </thead>
                 <tbody>
                <% var trainingAttended = nav.HrTrainingAttended.Where(r => r.Application_No==jobId.ToString());
                    foreach (var attended in trainingAttended)
                    {
                 %>
                        
                   
                 <tr>
                     <td><% =Convert.ToDateTime(attended.From_Date).ToString("dd/MM/yyyy") %></td>
                     <td><% =Convert.ToDateTime(attended.To_Date).ToString("dd/MM/yyyy") %></td>
                      <td><% = attended.Course_Name %></td>
                      <td><% =  attended.Institution %></td>
                      <td><% =attended.Attained %></td>
                     <td><label class="btn btn-danger" onclick="DeleteTraining('<%=attended.Code %>','<%=attended.Application_No %>');"><i class="fa fa-trash-o"></i> Delete</label></td>

                </tr>
                     <%
                    } %>
                 </tbody>
                 </table>

         <h3><strong>8.0	Current registration/membership to profession bodies</strong></h3>
<button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addMembership1">Add Membership</button>
              <table class="table table-striped table-bordered">
                 <thead>
                 <tr>
                     
                   <th>Professional Body</th>
                     <th>Membership/Registration No.</th>
                     <th>Membership type e.g. Associate/Full</th>
                     <th>Date of Renewal</th>
                 </tr>
                 </thead>
                 <tbody>
                <% var body = nav.HrProffessionalBody.Where(r =>  r.Application_No ==jobId.ToString());
                    foreach (var p in body)
                    {
                 %>
                        
                   
                 <tr>
                     <td><% =p.Institution %></td>
                     <td><% =p.Membership_No%></td>
                      <td><% =p.Membership_Type %></td>
                      <td><% =p.Renewal_Date %></td>
                     <td><label class="btn btn-danger" onclick="DeleteProffessionalBody('<%=p.Code %>','<%=p.Application_No %>');"><i class="fa fa-trash-o"></i> Delete</label></td>


                     
                     
                 </tr>
                     <%
                    } %>
                 </tbody>
                 </table>

             <h3><strong>9.0 Employment history</strong></h3>
             <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addEmploymentHistory1">Add Employment History</button>
              <table class="table table-striped table-bordered">
                 <thead>
                 <tr>
                     
                   <th>FROM</th>
                     <th>TO</th>
                     <th>Designation/Position </th>
                     <th>Job Grade</th>
                     <th>Institution</th>
                 </tr>
                 </thead>
                 <tbody>
                <% var EmployeeHistory = nav.ApplicantEmployeeHistory.Where(r =>  r.Application_No==jobId.ToString());
                    foreach (var hist in EmployeeHistory)
                    {
                 %>
                        
                   
                 <tr>
                     <td><% =Convert.ToDateTime(hist.From_Date).ToString("dd/MM/yyyy") %></td>
                     <td><% =Convert.ToDateTime(hist.To_Date).ToString("dd/MM/yyyy") %></td>
                      <td><% = hist.Job_Title %></td>
                      <td><% = hist.Job_Grade %></td>
                     <td><% = hist.Company_Name %></td>
                     <td><label class="btn btn-danger" onclick="DeleteEmployment('<%=hist.Code %>','<%=hist.Application_No %>');"><i class="fa fa-trash-o"></i> Delete</label></td>

                     
                     
                 </tr>
                     <%
                    } %>
                 </tbody>
                 </table>
  </div>
      <div class = "panel-footer">
        <asp:Button ID="Step21" runat="server" Text="Next" class="button btn btn-info pull-right" OnClick="Step21_Click" />
    <asp:Button ID="GoBack1" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack1_Click" />

         <div class="clearfix"></div>

  </div>
   </div>
       
    <%
          }else if(step == 3)
          {%>
    <div class = "panel panel-primary">
   <div class = "panel-heading">
      <h3 class = "panel-title">Job Details</h3>
        </div>
   
   <div class = "panel-body">
       <div runat="server" id="jobDetails1"></div>
      <h3><strong>10.0 Briefly state your current duties, responsibilities and assignments(not more than 250 characters.)</strong></h3>
         <div class="form-group">
             <asp:TextBox id="TextArea1" CssClass="txt1" TextMode="multiline" MaxLength="2" Columns="50" Rows="10"  runat="server" />
         <br />
            <label id="txt1_WordCount"></label>
         </div>
       <div class="form-group">
            <asp:Button ID="AddDuties1" runat="server" Text="Save Duties" class="button btn btn-success pull-left" OnClick="AddDuties1_Click"
                 />
           <div class="clearfix"></div>
         </div>

      <h3><strong>11.0 Description of Accomplishments: Note: Please attach a list details of developed proposals, funded proposals, publications in refereed journals, publications in refereed journals as first author, additional responsibilities at the centre/Departments, provision of Mentorship to other staff and/or students.(Not more than 250 characters)</strong></h3>

       
      
       <div class="form-group">
            <button type="button" class="btn btn-warning btn-lg" data-toggle="modal" data-target="#addAccomplishment">Add Accomplishment</button>

            <%--<asp:Button ID="AddAccomplishment" runat="server" Text="Add Accomplishment" class="button btn btn-info pull-left" OnClick="AddAccomplishment_Click"/>--%>
           <div class="clearfix"></div>
         </div>
       
       
       
       
           <asp:GridView ID="grd_accomplishment1" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
         <Columns>
                                 

                                    <%--<asp:BoundField DataField="PromotionItem" HeaderText="Lookup Code" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" />
                                    <asp:BoundField DataField="PromoHeader" HeaderText="Promo Header" />
                                    --%>
                                    
                                    <asp:TemplateField HeaderText="Indicator Description">
                                        
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDescription1" ReadOnly="true" runat="server" Text='<% #Eval("Indicator_Description") %>'  Width="500px" AutoPostBack="False"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterStyle HorizontalAlign="Right" />
                                         <FooterTemplate>
                                        </FooterTemplate>

                                    </asp:TemplateField>
                                  <asp:TemplateField HeaderText="Indicator Number ">
                                        
                                        <ItemTemplate>
                                            <asp:TextBox ID="Number" runat="server" onkeypress="return isNumber(event)" Text='<% #Eval("Number") %>' type ="number" AutoPostBack="False"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterStyle HorizontalAlign="Right" />
                                         <FooterTemplate>
                                        </FooterTemplate>
                                 </asp:TemplateField>
                               <asp:TemplateField HeaderText="Amount ">
                                        
                                        <ItemTemplate>
                                            <asp:TextBox ID="Amount" runat="server" onkeypress="return isNumber(event)" Text='<% #Eval("Amount") %>' type ="number" AutoPostBack="False"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterStyle HorizontalAlign="Right" />
                                         <FooterTemplate>
                                        </FooterTemplate>
                                 </asp:TemplateField>

                            
                                </Columns>
         <EditRowStyle BackColor="#999999" />
         <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
         <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
         <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
         <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
         <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
         <SortedAscendingCellStyle BackColor="#E9E7E2" />
         <SortedAscendingHeaderStyle BackColor="#506C8C" />
         <SortedDescendingCellStyle BackColor="#FFFDF8" />
         <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

    </asp:GridView>
       
      
       <div class="form-group">
            <asp:Button ID="AddAccomplishment1" runat="server" Text="Update Accomplishment" class="button btn btn-success pull-left" OnClick="AddAccomplishment1_Click"
                 />
           <div class="clearfix"></div>
         </div>
       
        <h3><strong>12.0 Please give details of your abilities,skills,and experience,which you consider relevant to the position applied.This information may include an outline of your most recent achievements and reasons for applying for this post. (Not more than 250 characters)</strong></h3>
          <br />
             <div class="form-group col-xs-12">
          <asp:TextBox id="txtComment1" CssClass="txt" TextMode="multiline" Columns="50" Rows="5" runat="server" onselectstart="return false" onpaste="return false;"
                onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" autocomplete="off" />
                 <br />
            <label id="lblWordCount"></label>
              </div>
       <div class="form-group">
            <asp:Button ID="AddAbility1" runat="server" Text="Save Skills" class="button btn btn-success pull-left" OnClick="AddAbility1_Click"
                 />
           <div class="clearfix"></div>
         </div>

    </div>
    <div class = "panel-footer">
        <asp:Button ID="Step31" runat="server" Text="Next" class="button btn btn-info pull-right" OnClick="Step31_Click" />
        <asp:Button ID="GoBack2" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack2_Click" />

        <div class="clearfix"></div>
     </div>
</div>
    <%

          }else if(step == 4)
          {
             %>
 <div class = "panel panel-primary">
   <div class = "panel-heading">
      <h3 class = "panel-title">Other personal details</h3>
        </div>
   
   <div class = "panel-body">
       <div runat="server" id="otherPersonalDetails1"></div>
       <h3><strong>13.0 Other personal details</strong></h3>
             <h5>i)Have you ever been convicted of any criminal offence or subject to any active ongoing criminal investigation?</h5>
             <div class="form-group col-xs-12">
                 <asp:DropDownList ID="convict1" runat="server" CssClass="form-control">
                  <%--   <asp:ListItem>Select</asp:ListItem>--%>
                      <asp:ListItem Value="0">Yes</asp:ListItem>
                      <asp:ListItem Value="1">No</asp:ListItem>
                 </asp:DropDownList>
             </div>
             <h5>ii)If yes state nature of offense, year and duration(not more than 50 characters)</h5>

              <div class="form-group col-xs-12">
                
                    <asp:TextBox ID="duration1" CssClass="txt3  form-control" TextMode="MultiLine" runat="server"/>
                   <br />
            <label id="txt3_WordCount"></label>
              
              </div>
              <h5>iii)Have you ever been dismissed or otherwise removed from employment?</h5>
             <div class="form-group col-xs-12">
                 <asp:DropDownList ID="Dismissed1" CssClass="form-control" runat="server">
                   <%--  <asp:ListItem>Select</asp:ListItem>--%>
                      <asp:ListItem Value="0">Yes</asp:ListItem>
                      <asp:ListItem Value="1">No</asp:ListItem>
                 </asp:DropDownList>
             </div>
             <h5> iv)4.	If yes, state reason(s) for dismissal/removal (effective date)</h5>
             <div class="form-group col-xs-12">
          <asp:TextBox id="dismissalReasons1" CssClass="txt form-control" TextMode="multiline" Columns="50" Rows="5" runat="server" onselectstart="return false" onpaste="return false;"
                onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" autocomplete="off" />
                 <br />
            <label id="txt1_lblCount"></label>
              </div>
       <h5>v)What is your the highest level of education </h5>
             <div class="form-group col-xs-12">
          <asp:TextBox id="txt_highestLevel1" CssClass="form-control"  runat="server"/>
               </div>
       <div class="form-group">
            <asp:Button ID="SaveOtherPersonalDetails1" runat="server" Text="Save" class="button btn btn-success pull-left" OnClick="SaveOtherPersonalDetails1_Click"
                 />
           <div class="clearfix"></div>
         </div>
             <h3><strong>Declaring the above information will not necessarily bar an applicant from employment in the institute. Each case will be considered on its own merit.</strong></h3>
       
    </div>
    <div class = "panel-footer">
        <asp:Button ID="Step41" runat="server" Text="Next" class="button btn btn-info pull-right" OnClick="Step41_Click" />
        <asp:Button ID="GoBack3" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack3_Click" />

        <div class="clearfix"></div>
     </div>
</div>
        
     <%

          }else if(step == 5)
          { %>
     <div class = "panel panel-primary">
        <div class = "panel-heading">
      <h3 class = "panel-title">Referees Details</h3>
        </div>
   
   <div class = "panel-body">
       <div runat="server" id="referee1"></div>
       <h3><strong>14.0 Referees (People who have interacted with you professionally) </strong></h3>
              <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#addReferee1">Add Referee</button>
              <table class="table table-striped table-bordered">
                 <thead>
                 <tr>
                     
                   <th>Full names</th>
                     <th>Occupation</th>
                     <th>Address </th>
                     <th>Postcode</th>
                     <th>City</th>
                     <th>Mobile Number</th>
                     <th>Email Address</th>
                     <th>Period for which the referee has known you</th>
                 </tr>
                 </thead>
                 <tbody>
                <% var referee = nav.HRApplicantReferees.Where(r => r.Employee_No == Session["employeeNo"].ToString() && r.Job_Application_No == jobId.ToString());
                    foreach (var refer in referee)
                    {
                 %>
                        
                   
                 <tr>
                     <td><% =refer.Names%></td>
                     <td><% =refer.Occupation %></td>
                     <td><% =refer.Address %></td>
                     <td><% =refer.Post_Code %></td>
                      <td><% =refer.City %></td>
                     <td><% =refer.Telephone_No %></td>
                     <td><% =refer.E_Mail %></td>
                     <td><% =refer.Period_Known %></td>
                     <td><label class="btn btn-danger" onclick="DeleteReferee('<%=refer.Code %>','<%=refer.Job_Application_No %>');"><i class="fa fa-trash-o"></i> Delete</label></td>

                        
                 </tr>
                     <%
                    } %>
                 </tbody>
                 </table>

             <h3><strong>Declaration</strong></h3>
             <h5>I certify that the particulars given on this form are correct and understand that any incorrect/misleading information may lead to disqualification and/or legal action.</h5>
     
        <div class="form-group col-xs-6">
             <label for="Disability"> Declare</label>
           
           <asp:DropDownList ID="Declare1" runat="server" visible="true"  CssClass="form-control select2" 
                    AutoPostBack="false">
                      
                      <asp:ListItem Value="0">Yes</asp:ListItem>
                      <asp:ListItem Value="1">No</asp:ListItem>
                      </asp:DropDownList> 
            
        </div>

    </div>
    <div class = "panel-footer">
         <asp:Button ID="Step51" runat="server" Text="Next" class="button btn btn-info pull-right" OnClick="Step51_Click" />
        <asp:Button ID="GoBack4" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack4_Click" />
        <div class="clearfix"></div>
     </div>
</div>
    
       <%

          }else if(step == 6)
          {%>
      <div class="panel panel-primary">
        <div class="panel-heading">Supporting Documents
              <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 6 of 6 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback1"></div>
           <div class="row">
               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                   <div class="form-group">
                       <strong>Attach Supporting documents with correct naming eg Academics-Masters, Proposal-Linguistic Entomology study, Publications - Neuroscience:</strong>
                       <asp:FileUpload runat="server" ID="document1" AllowMultiple="true" CssClass="form-control" style="padding-top: 0px;"/>
                   </div>
               </div>
               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                   <div class="form-group">
                       <br/>
                       <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument1" OnClick="uploadDocument1_Click"/>
                   </div>
               </div>
           </div>
           <table class="table table-bordered table-striped">
               <thead>
               <tr>
                   <th>Document Title</th>
                 <%--  <th>Download</th>--%>
                   <th>Delete</th>
               </tr>
               </thead>
               <tbody>
               <%
                   try
                   {
                       String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                       String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "HR Job Applications Card/";
                      
                       string appNo = Request.QueryString["appNo"].ToString();
                       
                       String documentDirectory = filesFolder + appNo+"/";
                       if (Directory.Exists(documentDirectory))
                       {
                           foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))

                           {
                               String url = documentDirectory;
                               %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>
                      
                     <%--  <td><a href="<%=fileFolderApplication %>\HR Job Applications Card\<% =appNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>--%>
                       <td><label class="btn btn-danger" onclick="deleteFile1('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i> Delete</label></td>
                   </tr>
                   <%
                                }
                            }
                   }
                   catch (Exception)
                   {
                       
                   }%>
               </tbody>
           </table>
        </div>
        <div class="panel-footer">
            <asp:Button ID="GoBack5" runat="server" Text="Previous" class="button btn btn-warning pull-left" OnClick="GoBack5_Click" />
            <asp:Button ID="Finish" runat="server" Text="Finish Application" class="button btn btn-success pull-right" OnClick="Finish_Click"/>

               <div class="clearfix"></div>
        </div>
        </div>
    
    <%
}
          %>



    <div id="addAccomplishment" class="modal fade bd-example-modal-lg" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Accomplishment</h4>
          </div>
          <div class="modal-body">

          <div class="row" style="width: 100%; display: block; margin: auto;">
              
                 <asp:GridView ID="grd_accomplishment" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
         <Columns>
                                 

                                    <asp:TemplateField HeaderText="Indicator Description">
                                        
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDescription" ReadOnly="true" runat="server" Text='<% #Eval("Indicator_Description") %>'  Width="500px" AutoPostBack="False"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterStyle HorizontalAlign="Right" />
                                         <FooterTemplate>
                                        </FooterTemplate>

                                    </asp:TemplateField>
                                  <asp:TemplateField HeaderText="Indicator Number ">
                                        
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtNumber" runat="server" onkeypress="return isNumber(event)" Text='<% #Eval("Number") %>' type ="number" AutoPostBack="False"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterStyle HorizontalAlign="Right" />
                                         <FooterTemplate>
                                        </FooterTemplate>
                                 </asp:TemplateField>

                            <asp:TemplateField HeaderText="Amount ">
                                        
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtAmount" runat="server" onkeypress="return isNumber(event)" Text='<% #Eval("Amount") %>' type ="number" AutoPostBack="False"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterStyle HorizontalAlign="Right" />
                                         <FooterTemplate>
                                        </FooterTemplate>
                                 </asp:TemplateField>

                            
                                </Columns>
         <EditRowStyle BackColor="#999999" />
         <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
         <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
         <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
         <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
         <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
         <SortedAscendingCellStyle BackColor="#E9E7E2" />
         <SortedAscendingHeaderStyle BackColor="#506C8C" />
         <SortedDescendingCellStyle BackColor="#FFFDF8" />
         <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

    </asp:GridView>   
          
      </div>
    
      </div>
      <div class="modal-footer">
       
        <asp:Button ID="Button1" runat="server" Text="Add Accomplishment" class="button btn btn-info pull-left" OnClick="AddAccomplishment_Click"/>
          
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>




  <div id="addQualification1" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Academic Qualification</h4>
          </div>
          <div class="modal-body">

          <div class="row" style="width: 100%; display: block; margin: auto;">
              
              <div class="form-group">
                      <label>From:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                             <asp:Textbox CssClass="form-control" runat="server" placeholder="From" ID="qualificationFrom1" style="width:97%;"/>
                       
                        </div> 
                  </div> 
            
              <div class="form-group">
                      <label> To:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                       <asp:Textbox CssClass="form-control" runat="server" placeholder="To" ID="qualificationTo1" style="width:97%;"/>
                               </div>
                  </div>
              <div class="form-group">
                <label>Institution:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                 <asp:Textbox CssClass="form-control" runat="server" placeholder="Institution/Company" ID="institution1" style="width:97%;"/>
                   </div>
                  </div>

              <div class="form-group">
                <label>Specialization/Subject </label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                 <asp:Textbox CssClass="form-control" runat="server" placeholder="e.g. Epidemiology" ID="specialization1" style="width:97%;"/>
                 
                   </div>
                  </div>
               <div class="form-group">
                      <label>Award Attainment:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="e.g. PhD, Masters, Bachelors, KSCE " ID="Attainment1" style="width:97%;"/>
                         </div>
                  </div>
              
              <div class="form-group">
                      <label> Grade Attained:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="gradeAttained1" style="width:97%;"/>
                        
                   </div>
                  </div>
              
                
              
                 
                
          
      </div>
    
      </div>
      <div class="modal-footer">
        <asp:Button runat="server" CssClass="btn btn-success"  Text="Add Qualificcation" OnClick="addQualification1_Click" ></asp:Button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
   <div id="addProfessional1" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Profession/Certification</h4>
          </div>
          <div class="modal-body">

          <div class="row" style="width: 100%; display: block; margin: auto;">
             
               <div class="form-group">
                      <label>From:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                             <asp:Textbox CssClass="form-control" runat="server" placeholder="From" ID="prof_startDate1" style="width:97%;"/>
                                                </div> 
                  </div> 
            
              <div class="form-group">
                      <label> To:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                       <asp:Textbox CssClass="form-control" runat="server" placeholder="To" ID="prof_endDate1" style="width:97%;"/>
                        </div>
                  </div>
              <div class="form-group">
                      <label>Institution:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="Institution/Company" ID="prof_institution1" style="width:97%;"/>
                        
                   </div>
                  </div>
              <div class="form-group">
                      <label> Specialization/Subject :</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="e.g.Epidemiology" ID="pr_Specialization1" style="width:97%;"/>
                                           </div>
                  </div>
              <div class="form-group">
                      <label> Award/Attainment :</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="e.g. Higher Diploma, Diploma, Certificate, Certified Public Accountants etc" ID="pr_attainment1" style="width:97%;"/>
                                               </div>
                  </div>
              
              <div class="form-group">
                      <label> Grade Attained:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="attainedScore1" style="width:97%;"/>
                                                </div>
                  </div>
                
          
      </div>
    
      </div>
      <div class="modal-footer">
        <asp:Button runat="server" CssClass="btn btn-success"  Text="Add Proffession" OnClick="addProfession1_Click" ></asp:Button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

<div id="addTraining1" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Training</h4>
          </div>
          <div class="modal-body">

          <div class="row" style="width: 100%; display: block; margin: auto;">
             
              <div class="form-group">
                      <label>From:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                      <asp:Textbox CssClass="form-control" runat="server" placeholder="From" ID="tr_StartDate1" style="width:97%;"/>
                                         </div> 
                  </div> 
            
              <div class="form-group">
                      <label> To:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                       <asp:Textbox CssClass="form-control" runat="server" placeholder="To" ID="tr_EndDate1" style="width:97%;"/>
                                              </div>
                  </div>
              <div class="form-group">
                      <label> Course Name:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                       <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="tr_courseName1" style="width:97%;"/>
                                       </div>
                  </div>
              <div class="form-group">
                      <label>Institution:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="Institution/Company" ID="tr_institution1" style="width:97%;"/>
                        
                   </div>
                  </div>
              
              <div class="form-group">
                      <label> Awards/attainment:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="tr_score1" style="width:97%;"/>
                         
                   </div>
                  </div>
                 
                
          
      </div>
    
      </div>
      <div class="modal-footer">
        <asp:Button runat="server" CssClass="btn btn-success"  Text="Add Training" OnClick="addTraining1_Click" ></asp:Button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

 <div id="addMembership1" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Membership</h4>
          </div>
          <div class="modal-body">

          <div class="row" style="width: 100%; display: block; margin: auto;">
             
               <div class="form-group">
                      <label>Professional Body:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                          <asp:Textbox CssClass="form-control" runat="server" placeholder="professional body" ID="m_body1" style="width:97%;"/>
                          </div> 
                  </div> 
            
                  <div class="form-group">
                      <label> Membership/Registration No:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                       <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="m_regNo1" style="width:97%;"/>
                        
                   </div>
                  </div>
              <div class="form-group">
                      <label>Membership type:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                       <asp:Textbox CssClass="form-control" runat="server" placeholder="e.g. Associate/Full" ID="m_Membershiptype1" style="width:97%;"/>
                                         </div>
                  </div>
              
                  <div class="form-group">
                      <label> Date of Renewal:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="To" ID="m_DateofRenewal1" style="width:97%;"/>
                                           </div>
                  </div>
              
          
      </div>
    
      </div>
      <div class="modal-footer">
        <asp:Button runat="server"  CssClass="btn btn-success"   Text="Add Membership" OnClick="addMembership1_Click" ></asp:Button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
 <div id="addEmploymentHistory1" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Employment History</h4>
          </div>
          <div class="modal-body">

          <div class="row" style="width: 100%; display: block; margin: auto;">
             
               <div class="form-group">
                      <label>From:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="From" ID="em_StartDate1" style="width:97%;"/>
                                                </div> 
                  </div> 
            
                  <div class="form-group">
                      <label> To:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                       <asp:Textbox CssClass="form-control" runat="server" placeholder="To" ID="em_EndDate1" style="width:97%;"/>
                         
                   </div>
                  </div>
              
                  <div class="form-group">
                      <label> Position Held:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="em_positionHeld1" style="width:97%;"/>
                         
                   </div>
                  </div>
              <div class="form-group">
                      <label>Institution/Company:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="Institution/Company" ID="em_institution1" style="width:97%;"/>
                        
                   </div>
                  </div>
              <div class="form-group">
                      <label>Job Grade:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="em_JobGrade1" style="width:97%;"/>
                                                     </div>
                  </div>
                 
                
          
      </div>
    
      </div>
      <div class="modal-footer">
        <asp:Button runat="server" CssClass="btn btn-success"   Text="Add Employment History" OnClick="addEmploymentHistory1_Click" ></asp:Button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
   
    
    <div id="addReferee1" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Referee</h4>
          </div>
          <div class="modal-body">

          <div class="row" style="width: 100%; display: block; margin: auto;">
             
               <div class="form-group">
                      <label>Full names:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="ref_name1" style="width:97%;"/>
                            
                   </div> 
                  </div> 
            
                  <div class="form-group">
                      <label> Occupation:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                       <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="ref_Occupation1" style="width:97%;"/>
                                                </div>
                  </div>
              
                  <div class="form-group">
                      <label> Address:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="ref_Address1" style="width:97%;"/>
                                           </div>
                  </div>
              <div class="form-group">
                      <label>Postcode:</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="ref_Postcode1" style="width:97%;"/>
                                                </div>
                  </div>
              <div class="form-group">
                      <label>City</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="ref_City1" style="width:97%;"/>
                          
                   </div>
                  </div>
                 
                <div class="form-group">
                      <label>Mobile Number</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="ref_phone1" style="width:97%;"/>
                                              </div>
                  </div>
              <div class="form-group">
                      <label>Email Address</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="ref_EmailAddress1" style="width:97%;"/>
                                                  </div>
                  </div>

               <div class="form-group">
                      <label>Period for which the referee has known you</label>
                   <div class="input-group mb-10" > <span class="input-group-addon" style="background-color: #FFFFFF;"><i class="fa fa-user fa-fw"></i></span>
                              <asp:Textbox CssClass="form-control" runat="server" placeholder="" ID="ref_period1" style="width:97%;"/>
                      </div>
                  </div>
          
      </div>
    
      </div>
      <div class="modal-footer">
        <asp:Button runat="server" CssClass="btn btn-success"   Text="Add Referee" OnClick="addReferee1_Click" ></asp:Button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

        

      <script>
        
         function deleteFile1(fileName1) {
             document.getElementById("QualificationtoDeleteName").innerText = fileName1;
             document.getElementById("ContentPlaceHolder1_fileName1").value = fileName1;
             $("#deleteFileModal").modal(); 
         }
     </script> 

    
     <div id="deleteFileModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting File</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the file <strong id="QualificationtoDeleteName"></strong> ?</p>
          <asp:TextBox runat="server" ID="fileName1" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" ID="deleteFile1" CssClass="btn btn-danger" Text="Delete" OnClick="deleteFile1_Click"/>
      </div>
    </div>

  </div>
</div>

     <script>
        
         function DeleteQualification(Code,ApplicationNo) {
             document.getElementById("ApplicationNo").innerText = ApplicationNo;
             document.getElementById("ContentPlaceHolder1_Code").value = Code;
             $("#deleteQualificationModal").modal();
         }
     </script> 
   
  <div id="deleteQualificationModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Record</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the file <strong id="ApplicationNo"></strong> ?</p>
          <asp:TextBox runat="server" ID="Code" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" ID="DeleteQualification" CssClass="btn btn-danger" Text="Delete" OnClick="DeleteQualification_Click"/>
      </div>
    </div>

  </div>
</div>

     <script>
        
         function DeleteProfessional(PCode, PNo) {
             document.getElementById("PNo").innerText = PNo;
             document.getElementById("ContentPlaceHolder1_PCode").value = PCode;
             $("#deleteProfessionalModal").modal();
         }
     </script> 
    <div id="deleteProfessionalModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Record</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the file <strong id="PNo"></strong> ?</p>
          <asp:TextBox runat="server" ID="PCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" ID="DeleteProfessional" CssClass="btn btn-danger" Text="Delete" OnClick="DeleteProfessional_Click"/>
      </div>
    </div>

  </div>
</div>

     <script>
        
         function DeleteTraining(TCode, TNo) {
             document.getElementById("TNo").innerText = TNo;
             document.getElementById("ContentPlaceHolder1_TCode").value = TCode;
             $("#deleteTrainingModal").modal();
         }
     </script> 
    <div id="deleteTrainingModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Record</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the record <strong id="TNo"></strong> ?</p>
          <asp:TextBox runat="server" ID="TCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" ID="DeleteTraining" CssClass="btn btn-danger" Text="Delete" OnClick="DeleteTraining_Click"/>
      </div>
    </div>

  </div>
</div>

     <script>
        
         function DeleteProffessionalBody(BCode, BNo) {
             document.getElementById("BNo").innerText = BNo;
             document.getElementById("ContentPlaceHolder1_BCode").value = BCode;
             $("#deletePBodyModal").modal();
         }
     </script> 
     <div id="deletePBodyModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Record</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the record <strong id="BNo"></strong> ?</p>
          <asp:TextBox runat="server" ID="BCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" ID="DeletePBody" CssClass="btn btn-danger" Text="Delete" OnClick="DeletePBody_Click"/>
      </div>
    </div>

  </div>
</div>

      <script>
        
         function DeleteEmployment(ECode, ENo) {
             document.getElementById("ENo").innerText = ENo;
             document.getElementById("ContentPlaceHolder1_ECode").value = ECode;
             $("#deleteEHistoryModal").modal();
         }
     </script>
      <div id="deleteEHistoryModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Record</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the record <strong id="ENo"></strong> ?</p>
          <asp:TextBox runat="server" ID="ECode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" ID="DeleteEmployment" CssClass="btn btn-danger" Text="Delete" OnClick="DeleteEmployment_Click"/>
      </div>
    </div>

  </div>
</div>

     <script>
        
         function DeleteReferee(RCode, RNo) {
             document.getElementById("RNo").innerText = RNo;
             document.getElementById("ContentPlaceHolder1_RCode").value = RCode;
             $("#deleteRefereeModal").modal();
         }
     </script>
      <div id="deleteRefereeModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Record</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the record <strong id="RNo"></strong> ?</p>
          <asp:TextBox runat="server" ID="RCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" ID="DeleteRef" CssClass="btn btn-danger" Text="Delete" OnClick="DeleteRef_Click"/>
      </div>
    </div>

  </div>
</div>

</asp:Content>
