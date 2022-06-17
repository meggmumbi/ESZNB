<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="HRPortal.Dashboard" %>

<%@ Import Namespace="System.Runtime.InteropServices" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <% var nav = new Config().ReturnNav();
        int userType = 0;
    %>
    <div class="main">
        <div class="main-inner">
            <div class="container">
                <div class="row" style="width: 98%;">
                    <div class="col-md-6 col-lg-6">


                        <div class="widget">
                            <div class="widget-header">
                                <i class="icon-file"></i>
                                <h3>Welcome <%=Session["name"]%></h3>
                            </div>
                            <!-- /widget-header -->
                            <div class="widget-content">
                                <div style="width: 100%; display: block; margin: auto;">
                                    <img src="images/hr-img.png" />
                                </div>
                                <table class="table table-striped table-bordered">

                                    <tbody>
                                        <%
                                            try
                                            {

                                                userType = Convert.ToInt32(Session["type"]);
                                            }
                                            catch (Exception t) { }
                                            if (userType == 1)
                                            {

                                                var employees = nav.Employees.Where(r => r.No == (String)Session["employeeNo"]);
                                                foreach (var employee in employees)
                                                {

                                        %>
                                        <tr>
                                            <td>Employee Number:</td>
                                            <td><%= employee.No %></td>
                                        </tr>
                                        <tr>
                                            <td>Name:</td>
                                            <td><%= Session["name"] %></td>
                                        </tr>
                                        <tr>
                                            <td>ID Number:</td>
                                            <td><%= employee.ID_Number %> </td>
                                        </tr>
                                        <tr>
                                            <td>Email:</td>
                                            <td><%= employee.Company_E_Mail %> </td>
                                        </tr>
                                        <tr>
                                            <td>Phone Number:</td>
                                            <td><%= employee.Phone_No %> </td>
                                        </tr>


                                        <%
                                                    break;
                                                }



                                            }
                                            else
                                            {
                                                try
                                                {
                                                    String idNumber = (String)Session["idNo"];
                                                    var applicants = nav.HRJobApplicants.Where(r => r.ID_Number == idNumber);
                                                    foreach (var applicant in applicants)
                                                    {

                                        %>

                                        <tr>
                                            <td>Name:</td>
                                            <td><%= Session["name"] %></td>
                                        </tr>
                                        <tr>
                                            <td>ID Number:</td>
                                            <td><%= applicant.ID_Number %> </td>
                                        </tr>
                                        <tr>
                                            <td>Email:</td>
                                            <td><%= applicant.E_Mail %> </td>
                                        </tr>
                                        <tr>
                                            <td>Phone Number:</td>
                                            <td><%= applicant.Cell_Phone_Number %> </td>
                                        </tr>
                                        <%
                                                        break;
                                                    }
                                                }
                                                catch (Exception)
                                                {

                                                }
                                            }
                                        %>
                                    </tbody>
                                </table>
                                <strong>--Next Of Kin Details--</strong>
                                <br />   
                                  <div class="table-responsive">                           
                                <table id="example1" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>RelationShip</th>
                                            <th>Name</th>
                                            <th>ID Number</th>
                                            <th>Telephone Number</th>
                                            <th>Address</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var nav1 = new Config().ReturnNav();
                                            var nextOfKins = nav1.HrNextOfKin.Where(r => r.Type == "Next of Kin" && r.Employee_Code == (String)Session["employeeNo"]);
                                            foreach (var nextofKin in nextOfKins)
                                            {
                                        %>
                                        <tr>
                                            <td><%=nextofKin.Relationship %></td>
                                            <td><%=nextofKin.SurName + " " + nextofKin.Other_Names %></td>
                                            <td><%=nextofKin.ID_No_Passport_No %></td>
                                            <td><%=nextofKin.Office_Tel_No %></td>
                                            <td><%=nextofKin.Address %></td>

                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                                      </div>
                            </div>
                            <!-- /widget-content -->
                        </div>
                        <!-- /widget -->
                    </div>
                    <div class="col-md-6 col-lg-6">


                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-aqua">
                                <div class="inner">
                                    <h3>
                                        <% var employeesLeaves = nav.Employees.Where(r => r.No == (String)Session["employeeNo"]);
                                            Decimal leaveBalance = 0;
                                            try
                                            {
                                                foreach (var employee in employeesLeaves)
                                                {
                                                    leaveBalance = Convert.ToDecimal(employee.Leave_Outstanding_Bal);

                                                    break;
                                                }
                                            }
                                            catch (Exception)
                                            {
                                                leaveBalance = 0;
                                            }
                                        %>
                                        <% = leaveBalance %>
                                    </h3>

                                    <p>Outstanding Leave Balance</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-sign-out"></i>
                                </div>
                                <a href="leavebalances.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-green">
                                <div class="inner">
                                    <h3>
                                        <% String employeeNo = Convert.ToString(Session["employeeNo"]);
                                            var imprests = nav.ImprestMemo.Where(r => r.Status == "Released" && r.Requestor == employeeNo && r.Posted == false); ;
                                            int approvedImprestMemos = 0;
                                            try
                                            {
                                                foreach (var imprest in imprests)
                                                {
                                                    approvedImprestMemos++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedImprestMemos = 0;
                                            }
                                        %>
                                        <% = approvedImprestMemos %>
                                    </h3>

                                    <p>Approved Imprest Memo</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-money"></i>
                                </div>
                                <a href="ImprestMemo.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-yellow">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            var payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No == employeeNo && r.Posted == false && r.Payment_Type == "Imprest");
                                            int approvedImprestRequisitions = 0;
                                            try
                                            {
                                                foreach (var imprest in payments)
                                                {
                                                    approvedImprestRequisitions++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedImprestRequisitions = 0;
                                            }
                                        %>
                                        <% = approvedImprestRequisitions %>
                                    </h3>

                                    <p>Approved Imprest Requisition</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-money"></i>
                                </div>
                                <a href="ImprestRequisition.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-red">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No == employeeNo && r.Posted == false && r.Payment_Type == "Surrender");
                                            int approvedImprestSurrenders = 0;
                                            try
                                            {
                                                foreach (var imprest in payments)
                                                {
                                                    approvedImprestSurrenders++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedImprestSurrenders = 0;
                                            }
                                        %>
                                        <% = approvedImprestSurrenders %>
                                    </h3>

                                    <p>Approved Imprest Surrender</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-money"></i>
                                </div>
                                <a href="ImprestSurrenders.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-aqua">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            var headers = nav.PurchaseHeader.Where(r => r.Status == "Released" && r.Document_Type == "Purchase Requisition" && r.Request_By_No == employeeNo);
                                            int approvedPurchaseReq = 0;
                                            try
                                            {
                                                foreach (var header in headers)
                                                {
                                                    approvedPurchaseReq++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedPurchaseReq = 0;
                                            }
                                        %>
                                        <% = approvedPurchaseReq %>
                                    </h3>

                                    <p>Approved Purchase Requisition</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-shopping-cart"></i>
                                </div>
                                <a href="PurchaseRequisitions.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-green">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            headers = nav.PurchaseHeader.Where(r => r.Status == "Released" && r.Document_Type == "Store Requisition" && r.Request_By_No == employeeNo);
                                            int approvedStoreReq = 0;
                                            try
                                            {
                                                foreach (var header in headers)
                                                {
                                                    approvedStoreReq++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedStoreReq = 0;
                                            }
                                        %>
                                        <% = approvedStoreReq %>
                                    </h3>

                                    <p>Approved Store Requisition</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-building"></i>
                                </div>
                                <a href="StoreRequisitions.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-yellow">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            var transportReq = nav.TransportRequisition.Where(r => r.Status == "Approved");
                                            int approvedFleetReq = 0;
                                            try
                                            {
                                                foreach (var header in transportReq)
                                                {
                                                    approvedFleetReq++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                approvedFleetReq = 0;
                                            }
                                        %>
                                        <% = approvedFleetReq %>
                                    </h3>

                                    <p>Approved Fleet Requisition</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-car"></i>
                                </div>
                                <a href="FleetRequisitions.aspx?status=approved" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                        <!-- ./col -->
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <!-- small box -->
                            <div class="small-box bg-red">
                                <div class="inner">
                                    <h3>
                                        <% 
                                            var positions = nav.VacantPositions;
                                            int openPositions = 0;
                                            try
                                            {
                                                foreach (var position in positions)
                                                {
                                                    openPositions++;

                                                }
                                            }
                                            catch (Exception)
                                            {
                                                openPositions = 0;
                                            }
                                        %>
                                        <% = openPositions %>
                                    </h3>

                                    <p>Open Positions</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-folder-open"></i>
                                </div>
                                <a href="openpositions.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>


                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /main-inner -->
    </div>
    <!-- /main -->
</asp:Content>
