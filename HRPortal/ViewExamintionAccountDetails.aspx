<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewExamintionAccountDetails.aspx.cs" Inherits="HRPortal.ViewExamintionAccountDetails" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
     
        <ol class="breadcrumb">
            <li><a href="Dashboard.aspx"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Examination Account</li>
        </ol>
    </section>

    <div class="panel panel-default">


        <div class="panel-heading">
            Examination Account Details<div class="pull-right"></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#activity" data-toggle="tab">Examination Account</a></li>
                        <li><a href="#timeline" data-toggle="tab">Booked Examinations</a></li>
                        <li><a href="#settings" data-toggle="tab">Exempted examinations </a></li>
                        <li><a href="#deffered" data-toggle="tab">Deferred Papers</a></li>
                        <li><a href="#withdrawn" data-toggle="tab">Examinations Withdrawals</a></li>
                        <li><a href="#SubjectNotPassed" data-toggle="tab">Subject Not Passed</a></li>
                        <li><a href="#History" data-toggle="tab">Examination History</a></li>
                         <li><a href="#StudentRemarks" data-toggle="tab">Student Remarks</a></li>
                         <li><a href="#Receipts" data-toggle="tab">Student Receipts</a></li>
                        <li><a href="#Timetable" data-toggle="tab">Timetable</a></li>
                           <li><a href="#Results" data-toggle="tab">Examinations Results</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="active tab-pane" id="activity">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Personal Information
                                      <span class="pull-right"><i class="fa fa-chevron-left">profile</i> <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
                                </div>

                                <div class="panel-body">
                                    <div runat="server" id="Div4"></div>
                                    <section class="content">
                                        <div class="box box-default">
                                            <div class="box-header with-border">
                                                <h3 class="box-title">Personal Details</h3>

                                            </div>
                                            <!-- /.box-header -->
                                            <div class="box-body">
                                                <div id="Div5" runat="server"></div>
                                                <div id="Div6" runat="server"></div>
                                                <div runat="server" id="Div8"></div>
                                                <br />


                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="firstName">First name</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="firstName" ReadOnly></asp:TextBox>
                                                    </div>
                                                    <!-- /.form-group -->


                                                    <div class="form-group">
                                                        <label for="lastname">Last Name</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="lastName" ReadOnly></asp:TextBox>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="postal">Postal Code</label>
                                                        <asp:DropDownList runat="server" CssClass="form-control" ID="postal"  Enabled="false"></asp:DropDownList>

                                                    </div>

                                                    <div class="form-group">
                                                        <label for="county">City</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="city" Enabled="false"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="postalAddres">Address 2</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="address2" Enabled="false"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="county">Country</label>
                                                        <asp:DropDownList runat="server" CssClass="form-control" ID="DropDownList1" Enabled="false"></asp:DropDownList>
                                                    </div>
                                                     <div class="form-group">
                                                        <label for="county">Renewal Amount</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="RenewalAmount" Enabled="false"></asp:TextBox>
                                                    </div>
                                                     <div class="form-group">
                                                        <label for="county">Renewal Pending</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="renPending" Enabled="false"></asp:TextBox>
                                                    </div>



                                                </div>


                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="middlename">Middle name</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="middlename" ReadOnly></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="idnumber">ID/Passport Number</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" MaxLength="11" ID="idnumber" ReadOnly></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="email address">Email address</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="email" Enabled="false"></asp:TextBox>
                                                    </div>
                                                    <!-- /.form-group -->
                                                    <div class="form-group">
                                                        <label for="phoneNumber">Phone Number</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="phoneNumber" Enabled="false"></asp:TextBox>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="postalAddres">Address</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="address" Enabled="false"></asp:TextBox>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="county">County</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="countys" ReadOnly></asp:TextBox>
                                                    </div>
                                                     <div class="form-group">
                                                        <label for="county">Re-activation Amount</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="ReActivation" Enabled="false"></asp:TextBox>
                                                    </div>
                                                     <div class="form-group">
                                                        <label for="county">Unapplied Amount</label>
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="balance" Enabled="false"></asp:TextBox>
                                                    </div>


                                                    <!-- /.form-group -->
                                                </div>
                                                <!-- /.col -->



                                            </div>
                                           
                                        </div>
                                    </section>
                                </div>
                            </div>

                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="timeline">
                            <div class="panel panel-primary">
                                <div class="box">
                                    <div class="box-header">
                                        <h3 class="box-title">Booked Examinations</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <div class="table-responsive">
                                            <table id="example2" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                     
                                                      
                                                        <th>Level</th>
                                                        <th>Paper</th>
                                                        <th>Examination</th>
                                                        <th>Examination Sitting</th>
                                                        <th>Examination Center</th>
                                                      

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav1 = new Config().ReturnNav();

                                                        String regNo = Request.QueryString["regNo"];
                                                        var program = nav1.ExamBookingEntries.Where(r => r.Student_Reg_No == regNo && r.Blocked == false && r.Status == "Open");
                                                        foreach (var programz in program)
                                                        {

                                                    %>
                                                    <tr>
                                                       
                                                       
                                                        <td><%=programz.Part %></td>
                                                        <td><%=programz.Paper %></td>
                                                        <td><%=programz.Description %></td>
                                                         <td><%=programz.Exam_Sitting %></td>
                                                        <td><%=programz.Center_Name %></td>

                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->

                        <div class="tab-pane" id="settings">
                            <div class="panel panel-primary">
                                <div class="box">
                                    <div class="box-header">
                                        <h3 class="box-title">Exempted Papers</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <div class="table-responsive">
                                            <table id="example3" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                   
                                                        <th>Paper</th>
                                                        <th>Examination </th>
                                                     
                                                       
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav2 = new Config().ReturnNav();
                                                        var exemptions = nav2.ExemptionEntries.Where(r => r.Stud_Reg_No == regNo);
                                                        foreach (var exemption in exemptions)
                                                        {

                                                    %>
                                                    <tr>
                                                     
                                                         <td><%=exemption.No %></td>
                                                        <td><%=exemption.Name %></td>
                                                      
                                                        
                                                      

                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                            </div>


                        </div>

                        <div class="tab-pane" id="deffered">
                            <div class="panel panel-primary">
                                <div class="box">
                                    <div class="box-header">
                                        <h3 class="box-title">Deferred Papers</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <div class="table-responsive">
                                            <table id="example7" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Registration No:</th>
                                                        <th>Student Name</th>
                                                        <th>Examination ID</th>
                                                        <th>Part</th>
                                                        <th>Examination</th>
                                                        <th>Fee Amount</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav3 = new Config().ReturnNav();
                                                        var deffereement = nav2.ExamBookingEntries.Where(r => r.Student_Reg_No == regNo && r.Status == "Defered");
                                                        foreach (var deffer in deffereement)
                                                        {

                                                    %>
                                                    <tr>
                                                        <td><%=deffer.Student_Reg_No %></td>
                                                        <td><%=deffer.Student_Name %></td>
                                                        <td><%=deffer.Examination %></td>
                                                        <td><%=deffer.Part %></td>
                                                        <td><%=deffer.Description %></td>
                                                        <td><%=deffer.Fee_Amount %></td>
                                                        <td><%=deffer.Status %></td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                            </div>


                        </div>

                        <div class="tab-pane" id="withdrawn">
                            <div class="panel panel-primary">
                                <div class="box">
                                    <div class="box-header">
                                        <h3 class="box-title">Examination withdrawals</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <div class="table-responsive">
                                            <table id="example5" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Registration No:</th>
                                                        <th>Student Name</th>
                                                        <th>Examination</th>
                                                        <th>Part</th>
                                                        <th>Examination</th>
                                                        <th>Fee Amount</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav4 = new Config().ReturnNav();
                                                        var withdrawn = nav2.ExamBookingEntries.Where(r => r.Student_Reg_No == regNo && r.Status == "Withdrawn");
                                                        foreach (var withdraw in withdrawn)
                                                        {

                                                    %>
                                                    <tr>
                                                        <td><%=withdraw.Student_Reg_No %></td>
                                                        <td><%=withdraw.Student_Name %></td>
                                                        <td><%=withdraw.Examination %></td>
                                                        <td><%=withdraw.Part %></td>
                                                        <td><%=withdraw.Description %></td>
                                                        <td><%=withdraw.Fee_Amount %></td>
                                                        <td><%=withdraw.Status %></td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                            </div>


                        </div>
                         <div class="tab-pane" id="SubjectNotPassed">
                            <div class="panel panel-primary">
                                <div class="box">
                                    <div class="box-header">
                                        <h3 class="box-title">Subject Not Passed</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <div class="table-responsive">
                                            <table id="example7" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                       
                                                        <th>Paper Code</th>
                                                        <th>Examination Description</th>
                                                                                                         
                                                       
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav6 = new Config().ReturnNav();
                                                        var SubjectNotPassed = nav2.ExamBookingEntries.Where(r => r.Student_Reg_No == regNo && r.Status == "Failed" && r.Blocked==false).ToList();
                                                        foreach (var withdraw in SubjectNotPassed)
                                                        {

                                                    %>
                                                    <tr>
                                                     
                                                        <td><%=withdraw.Paper %></td>
                                                        <td><%=withdraw.Description %></td>
                                                                                                        
                                                       
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                            </div>


                        </div>
                         <div class="tab-pane" id="History">
                            <div class="panel panel-primary">
                                <div class="box">
                                    <div class="box-header">
                                        <h3 class="box-title">Examination History</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <div class="table-responsive">
                                            <table id="example5" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Registration No:</th>
                                                        <th>Student Name</th>
                                                        <th>Examination</th>
                                                        <th>Part</th>
                                                        <th>Examination</th>
                                                        <th>Fee Amount</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav7 = new Config().ReturnNav();
                                                        var studentsHistory = nav2.ExaminationHistory.Where(r => r.Student_Reg_No == regNo);
                                                        foreach (var withdraw in withdrawn)
                                                        {

                                                    %>
                                                    <tr>
                                                        <td><%=withdraw.Student_Reg_No %></td>
                                                        <td><%=withdraw.Student_Name %></td>
                                                        <td><%=withdraw.Examination %></td>
                                                        <td><%=withdraw.Part %></td>
                                                        <td><%=withdraw.Description %></td>
                                                        <td><%=withdraw.Fee_Amount %></td>
                                                        <td><%=withdraw.Status %></td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                            </div>


                        </div>
                         <div class="tab-pane" id="StudentRemarks">
                            <div class="panel panel-primary">
                                <div class="box">
                                    <div class="box-header">
                                        <h3 class="box-title">Student Remarks</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <div class="table-responsive">
                                            <table id="example5" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>                                                        
                                                        <th>Remark</th>
                                                        <th>Description</th>
                                                        
                                                      
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        int remarks = 0;
                                                        var studentRemarks = nav2.StudentRemarks.Where(r => r.Registration_No == regNo);
                                                        foreach (var studentRemark in studentRemarks)
                                                        {
                                                            remarks++;

                                                    %>
                                                    <tr>
                                                        <td><%=remarks %></td>                                                        
                                                        <td><%=studentRemark.Remark_Description %></td>
                                                        <td><%=studentRemark.Details %></td>
                                                        
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                            </div>


                        </div>
                        <div class="tab-pane" id="Receipts">
                            <div class="panel panel-primary">
                                <div class="box">
                                    <div class="box-header">
                                        <h3 class="box-title">Student's Receipts</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <h5><u>Receipts</u></h5>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="table-responsive">
                                                    <table class="table table-striped table-bordered" style="width: 100%" id="example4">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Process Type</th>
                                                                <th>Examination ID</th>
                                                                <th>Examination</th>
                                                                <th>Application Amount</th>
                                                                <th>Booking Amount</th>
                                                                <th>Exemption Amount</th>
                                                                <th></th>

                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% 


                                                               
                                                               
                                                                var receiptsData = nav2.StudentProcessing.Where(r => r.Student_Reg_No == regNo && r.Posted == true);
                                                                int receiptCounter = 0;
                                                                foreach (var detail in receiptsData)
                                                                {
                                                                    receiptCounter++;
                                                            %>
                                                            <tr>
                                                                <td><%=receiptCounter %></td>
                                                                <td><%=detail.Document_Type %></td>
                                                                <td><%=detail.Examination_ID %></td>
                                                                <td><%=detail.Examination_Description %></td>
                                                                <td><%=detail.Application_Amount %></td>
                                                                <td><%=detail.Booking_Amount %></td>
                                                                <td><%=detail.Exemption_Amount %></td>
                                                                <td><a href="Receipt.aspx?applicationNo=<%=detail.No%>&&documentType=<%=detail.Document_Type %>" class="btn btn-success">View Receipt</a></td>

                                                            </tr>
                                                            <%  
                        } %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>





                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="Timetable">
                            <div class="panel panel-primary">
                                <div class="box">
                                    <div class="box-header">
                                        <h3 class="box-title">Booked Examinations</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <h5><u>Booked Examinations</u></h5>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="table-responsive">
                                                    <table class="table table-striped table-bordered" style="width: 100%" id="example4">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Student Name</th>
                                                                <th>Examination Id</th>
                                                                <th>Examination Description</th>
                                                                <th>Examination Center </th>
                                                                <th>Examination Sitting</th>
                                                                <th>Booking Amount</th>
                                                                <th>Timetable</th>
                                                               

                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% 

                                                                
                                                                var nav = new Config().ReturnNav();                                                                
                                                                var details = nav.StudentProcessing.Where(r => r.Student_Reg_No == regNo && r.Document_Type == "Booking" && r.Posted == true && r.Cancelled==false);                                                              
                                                                int programesCounter = 0;
                                                                foreach (var detail in details)
                                                                {
                                                                    programesCounter++;
                                                            %>
                                                            <tr>
                                                                <td><%=programesCounter %></td>
                                                                <td><%=detail.Student_Name %></td>
                                                                <td><%=detail.Examination_ID%></td>
                                                                <td><%=detail.Examination_Description %></td>
                                                                <td><%=detail.Examination_Center %></td>
                                                                <td><%=detail.Examination_Sitting %></td>
                                                                <td><%=detail.Booking_Amount %></td>
                                                                <td><a href="studentTimetable.aspx?&&application=<%=detail.No%>" class="btn btn-success"><i class="fa fa-eye"></i>View Timetable</a></td>
                                                                
                                                            </tr>
                                                            <%  
                                                            } %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>





                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="Results">
                            <asp:ScriptManager ID="ScriptManger1" runat="Server" />
                            <asp:UpdatePanel ID="updPanel1" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div runat="server" id="examResults"></div>
                                    <div class="row filter-row" id="ifYes">
                                        <div class="col-md-4" style="display: none">
                                            <div class="form-group form-focus">
                                                <label class="control-label">Examination</label>
                                                <asp:TextBox Style="color: #FFFFFF; display: inline" runat="server" ID="regNo"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-focus">
                                                <label class="control-label">Examination Sitting</label>
                                                <asp:DropDownList runat="server" CssClass="form-control select2" ID="examCycle" OnSelectedIndexChanged="examCycle_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-md-6" style="display: inline">
                                            <div class="form-group">
                                                <br />
                                                <asp:Button runat="server" CssClass="btn btn-success" Text="Result Slip" ID="resultsSlip" OnClick="resultsSlip_Click" />
                                            </div>
                                        </div>
                                    </div>


                                    <div id="studentAcc" runat="server" visible="true">
                                        <div class="panel panel-primary">
                                            <div class="box">
                                                <div class="box-header">
                                                    <h3 class="box-title">Examination Results</h3>
                                                </div>



                                                <!-- /.box-header -->
                                                <div class="box-body">
                                                    <div class="table-responsive">
                                                        <table id="example" class="table table-bordered table-striped">
                                                            <thead>
                                                                <tr>
                                                                    <th>#</th>
                                                                    <th>Student Name</th>
                                                                    <th>Examination</th>
                                                                    <th>Examination Description</th>
                                                                    <th>Grade </th>
                                                                    <th>Examination Sitting</th>
                                                                    <th>Issue Date</th>
                                                                    <%-- <th>Results</th>--%>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% 

                                                                    string IdNumbers = Convert.ToString(Session["idNumber"]);
                                                                    var nav = new Config().ReturnNav();
                                                                    string regNos = Request.QueryString["regNo"];
                                                                    var details = nav.ExaminationResults.Where(r => r.Student_Reg_No == regNos);
                                                                    //string university = Convert.ToString(Session["UniversityCode"]);
                                                                    int programesCounter = 0;
                                                                    foreach (var detail in details)
                                                                    {
                                                                        programesCounter++;
                                                                %>
                                                                <tr>
                                                                    <td><%=programesCounter %></td>
                                                                    <td><%=detail.Student_Name %></td>
                                                                    <td><%=detail.Paper%></td>
                                                                    <td><%=detail.Paper_Name %></td>
                                                                    <td><%=detail.Grade %></td>
                                                                    <td><%=detail.Examination_Sitting_ID%></td>
                                                                    <td><%=Convert.ToDateTime(detail.Issue_Date).ToString("yy/MM/dd") %></td>
                                                                    <%-- <td><a href="ResultSlip.aspx?No=<%=detail.Student_Reg_No%>&&sitting=<%=detail.Examination_Sitting_ID %>" class="btn btn-success"><i class="fa fa-eye"></i>Result Slip</a></td>--%>
                                                                </tr>
                                                                <%  
                                                                    } %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <!-- /.box-body -->


                                            </div>
                                        </div>
                                    </div>
                                    <div id="SpecificSitting" runat="server" visible="false">
                                        <div class="panel panel-primary">
                                            <div class="box">
                                                <div class="box-header">
                                                    <h3 class="box-title">Examination Results</h3>
                                                </div>

                                                <!-- /.box-header -->
                                                <div class="box-body">
                                                    <asp:TextBox runat="server" CssClass="form-control" ID="examSitting" Visible="false"></asp:TextBox>
                                                    <div class="table-responsive">
                                                        <table id="example" class="table table-bordered table-striped">
                                                            <thead>
                                                                <tr>
                                                                    <th>#</th>
                                                                    <th>Student Name</th>
                                                                    <th>Examination</th>
                                                                    <th>Examination Description</th>
                                                                    <th>Grade </th>
                                                                    <th>Examination Sitting</th>
                                                                    <th>Issue Date</th>
                                                                    <%-- <th>Results</th>--%>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% 
                                                                    string regNos = Request.QueryString["regNo"];
                                                                    string IdNumbers = Convert.ToString(Session["idNumber"]);
                                                                    var nav = new Config().ReturnNav();
                                                                    string examsittings = examSitting.Text.Trim();
                                                                    var details = nav.ExaminationResults.Where(r => r.Student_Reg_No == regNos && r.Examination_Sitting_ID == examsittings);
                                                                    //string university = Convert.ToString(Session["UniversityCode"]);
                                                                    int programesCounter = 0;
                                                                    foreach (var detail in details)
                                                                    {
                                                                        programesCounter++;
                                                                %>
                                                                <tr>
                                                                    <td><%=programesCounter %></td>
                                                                    <td><%=detail.Student_Name %></td>
                                                                    <td><%=detail.Paper%></td>
                                                                    <td><%=detail.Paper_Name %></td>
                                                                    <td><%=detail.Grade %></td>
                                                                    <td><%=detail.Examination_Sitting_ID %></td>
                                                                    <td><%=Convert.ToDateTime(detail.Issue_Date).ToString("yy/MM/dd") %></td>
                                                                    <%-- <td><a href="ResultSlip.aspx?No=<%=detail.Student_Reg_No%>&&sitting=<%=detail.Examination_Sitting_ID %>" class="btn btn-success"><i class="fa fa-eye"></i>Result Slip</a></td>--%>
                                                                </tr>
                                                                <%  
                                                                    } %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <!-- /.box-body -->


                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>


                        <!-- /.tab-content -->
                    </div>

                    <!-- /.nav-tabs-custom -->

                    <!-- /.col -->
                </div>
            </div>
        </div>

        <div class="panel-footer">
            <a href="Enquiries.aspx?regNo=<%=Request.QueryString["regNo"]%>" class="btn btn-success"><i class="fa fa-arrow-left"></i>Back to Enquiry Page</a>
            <div class="clearfix"></div>
        </div>
    </div>



</asp:Content>
