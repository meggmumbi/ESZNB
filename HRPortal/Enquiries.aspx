<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Enquiries.aspx.cs" Inherits="HRPortal.Enquiries" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="card">
            <div class="card-header text-center" data-background-color="darkgreen">
                <h3 class="title"><strong>Enquiries</strong></h3>
            </div>
        </div>
    </div>
    <center class="center-item"><p style="color:black"><strong>Enquiries Page</strong></p></center>
    <h5><u>Examination Accounts</u></h5>
    <div runat="server" id="PaymentsMpesa" />
   <div class="panel-body">
      <label>Search By? <span class="text-danger">*</span></label>
    <select onchange="yesnoCheck(this);" id="cars" class="form-group" style="width: 100%; min-width: 15ch; max-width: 30ch; border: 1px solid; border-radius: 0.25em; padding: 0.25em 0.5em; font-size: 1.25rem; cursor: pointer; line-height: 1.1; background-color: #fff; background-image: linear-gradient(to top, #f9f9f9, #fff 33%);">
        
        <option value="yes">Student Registration Number</option>
        <option value="No">ID Number</option>

    </select>
        </div>
    <div class="row filter-row" id="ifYes">
        <div class="col-md-4">
            <div class="form-group form-focus">            
                <label class="control-label">Examination</label>
                <asp:DropDownList runat="server" CssClass="form-control select2" ID="examinationIDs"></asp:DropDownList>
            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group form-focus">
                <label class="control-label">Registration Number</label>
                <asp:TextBox runat="server" TextMode="Number" CssClass="form-control" ID="RegistrationNo"></asp:TextBox>
            </div>
        </div>
        <div class="col-md-4" style="display: inline">
            <div class="form-group">
                <br />
                <asp:Button runat="server" CssClass="btn btn-success" Text="Search Examination Account" ID="studentAccounts" OnClick="studentAccounts_Click" />
            </div>
        </div>
    </div>
  
    <div  class="row" id="IDNumber" style="display:none">
     
        <div class="col-md-4">
            <div class="form-group form-focus">
                <label class="control-label">ID Number</label>
                <asp:TextBox runat="server" TextMode="Number" CssClass="form-control" ID="IdNumber"></asp:TextBox>
            </div>
        </div>
        <div class="col-md-4" style="display: inline">
            <div class="form-group">
                <br />
                <asp:Button runat="server" CssClass="btn btn-success" Text="Search Student By Id" ID="idsearch" OnClick="idsearch_Click" />
            </div>
        </div>
 
    </div>
    <div id="studentsAccount" runat="server" visible="false">

        <div class="row">
            <div class="col-md-12">
                <div class="panel-body">
                    <div class="row" style="display: none">
                        <div class="col-md-3">
                            <div class="form-group">
                                <strong>Examination :</strong>
                                <asp:TextBox runat="server" ID="ExamId" CssClass="form-control  ExamPapers" />
                            </div>
                        </div>
                    </div>
                    <div class="row" style="display: none">
                        <div class="col-md-3">
                            <div class="form-group">
                                <strong>Examination Registration No</strong>
                                <asp:TextBox runat="server" ID="ExamRegNo" CssClass="form-control  ApplicationNo" />
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div runat="server" id="generalfeedbacks"></div>
                        <input type="hidden" value="<% =Convert.ToString(Session["idNumber"]) %>" id="txtLevel" />
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped selectedprequalificationsWorks" id="example3">
                                <thead>
                                    <tr>
                                        <th>Registration No</th>
                                        <th>Name</th>
                                        <th>Examination Id</th>
                                        <th>Examination</th>
                                        <th>Renewal Amount</th>
                                        <th>Reactivation Amount</th>
                                        <th>Renewal Pending</th>
                                        <th>Examination Account status</th>
                                        <th>View Details</th>

                                    </tr>
                                </thead>
                                <tbody>

                                    <% 
                                        var nav = new Config().ReturnNav();
                                        string examId = Request.QueryString["courseid"];
                                        string tcourseId = ExamId.Text.Trim();
                                        string tregNo = ExamRegNo.Text.Trim();
                                        string RegNo = tcourseId + "/" + tregNo;
                                        var examAccounts = nav.ExaminationAccounts.Where(x => x.Registration_No == RegNo).ToList();
                                        foreach (var nbpaperz in examAccounts)

                                        {
                                    %>
                                    <tr>

                                        <td><% =nbpaperz.Registration_No %></td>
                                        <td><% =nbpaperz.Name %></td>
                                        <td><% =nbpaperz.Course_ID %></td>
                                        <td><% =nbpaperz.Course_Description %></td>
                                        <td><% =nbpaperz.Renewal_Amount %></td>
                                        <td><% =nbpaperz.Re_Activation_Amount %></td>
                                        <td><% =nbpaperz.Renewal_Pending %></td>
                                        <td><% =nbpaperz.Status %></td>
                                        <td><a href="ViewExamintionAccountDetails.aspx?regNo=<%=nbpaperz.Registration_No%>" class="btn btn-success"><i class="fa fa-eye"></i>View Details</a></td>



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
     <div id="studentAcc" runat="server" visible="false">

        <div class="row">
            <div class="col-md-12">
                <div class="panel-body">
                  

                    <div class="row">
                        <div runat="server" id="Div2"></div>
                        <input type="hidden" value="<% =Convert.ToString(Session["idNumber"]) %>" id="txtLevel" />
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped selectedprequalificationsWorks" id="example3">
                                <thead>
                                    <tr>
                                        <th>Registration No</th>
                                        <th>Name</th>
                                        <th>Examination Id</th>
                                        <th>Examination</th>
                                        <th>Renewal Amount</th>
                                        <th>Reactivation Amount</th>
                                        <th>Renewal Pending</th>
                                        <th>Examination Account status</th>
                                        <th>View Details</th>

                                    </tr>
                                </thead>
                                <tbody>

                                    <% 
                                        var nav = new Config().ReturnNav();
                                        string tIdNumber = IdNumber.Text.Trim();
                                        var examAccounts = nav.ExaminationAccounts.Where(x => x.ID_No == tIdNumber).ToList();
                                        foreach (var nbpaperz in examAccounts)

                                        {
                                    %>
                                    <tr>

                                        <td><% =nbpaperz.Registration_No %></td>
                                        <td><% =nbpaperz.Name %></td>
                                        <td><% =nbpaperz.Course_ID %></td>
                                        <td><% =nbpaperz.Course_Description %></td>
                                        <td><% =nbpaperz.Renewal_Amount %></td>
                                        <td><% =nbpaperz.Re_Activation_Amount %></td>
                                        <td><% =nbpaperz.Renewal_Pending %></td>
                                        <td><% =nbpaperz.Status %></td>
                                        <td><a href="ViewExamintionAccountDetails.aspx?regNo=<%=nbpaperz.Registration_No%>" class="btn btn-success"><i class="fa fa-eye"></i>View Details</a></td>



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


       <script type="text/javascript">
        function yesnoCheck(that) {
            if (that.value == "yes") {               
                document.getElementById("ifYes").style.display = "block";
                document.getElementById("IDNumber").style.display = "none";
            } else {
               
                document.getElementById("IDNumber").style.display = "block";
                document.getElementById("ifYes").style.display = "none";
            }
        }
    </script>

</asp:Content>
