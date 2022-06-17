<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalaryAdvanceApplication.aspx.cs" Inherits="HRPortal.SalaryAdvanceApplication" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



     <div class="panel panel-primary">
        <div class="panel-heading">
            General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i><i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Salary Advance Amount:</strong>
                         <asp:TextBox runat="server" ID="salaryAdvance" TextMode="Number" CssClass="form-control" />
                           <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator1" ControlToValidate="salaryAdvance" ErrorMessage="Please enter the salary advance amount!" ForeColor="Red"  />
                          <asp:RangeValidator  Display="dynamic" ID="RangeValidator2" runat="server" ErrorMessage="Value cannot be negative or 0" forecolor="Red" ControlExtender="numberFilterMaskedEditExtender" controltovalidate="salaryAdvance" minimumvalue="1"  maximumvalue="20000000" type="Double"></asp:RangeValidator> 
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Division/Units:</strong>
                          <asp:TextBox runat="server" ID="divisionCode" CssClass="form-control" ReadOnly />
                    </div>
                </div>

            </div>

            <div class="row">


                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>No of Months Deducted:</strong>
                        <asp:TextBox runat="server" ID="monthsDeducted" TextMode="Number" CssClass="form-control" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator2" ControlToValidate="monthsDeducted" ErrorMessage="Please enter no of months to be deducted! (Value must be between 1 and 12 months)" ForeColor="Red" />
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Value must be between 1 and 12 months" forecolor="Red" ControlExtender="numberFilterMaskedEditExtender" controltovalidate="monthsDeducted" minimumvalue="1" maximumvalue="12" type="Double"></asp:RangeValidator> 
                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Purpose:</strong>
                         <asp:TextBox runat="server" ID="purpose" CssClass="form-control" placeholder="Purpose" />
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator3" ControlToValidate="purpose" ErrorMessage="Please enter the purpose for the Salary Advance!" ForeColor="Red" />
                    </div>
                </div>

            </div>



            <div class="row">

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Recovery Start Month:</strong>
                        <asp:TextBox runat="server" ID="recoveryStartMonth" TextMode="Month" CssClass="form-control" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator4" ControlToValidate="recoveryStartMonth" ErrorMessage="Please enter the recovery Start Month!" ForeColor="Red" />
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Recovert Start Date:</strong>
                        <asp:TextBox runat="server" ID="RecoveryStartDate" TextMode="Date" CssClass="form-control" />
                          <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator5" ControlToValidate="RecoveryStartDate" ErrorMessage="Please enter the recovery Start date!" ForeColor="Red" />
                    </div>
                </div>



            </div>
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Request for Salary Advance" ID="salaryAdvanceApp" OnClick="salaryAdvanceApp_Click" />
                    </div>
                </div>
            </div>

            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send For Approval" ID="approval" OnClick="approval_Click" Visible="false" />
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</asp:Content>
