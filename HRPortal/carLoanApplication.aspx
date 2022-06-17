<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="carLoanApplication.aspx.cs" Inherits="HRPortal.carLoanApplication" %>
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
                        <strong>Loan Requested:</strong>
                         <asp:TextBox runat="server" ID="loanRequested" TextMode="Number" CssClass="form-control" />
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator1" ControlToValidate="loanRequested" ErrorMessage="Please enter the loan Amount!" ForeColor="Red" />
                         <asp:RangeValidator  Display="dynamic" ID="RangeValidator2" runat="server" ErrorMessage="Value cannot be negative or 0" forecolor="Red" ControlExtender="numberFilterMaskedEditExtender" controltovalidate="loanRequested" minimumvalue="1"  maximumvalue="20000000" type="Double"></asp:RangeValidator> 
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
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator2" ControlToValidate="monthsDeducted" ErrorMessage="Please enter no of months to be deducted!" ForeColor="Red" />
                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Purpose:</strong>
                         <asp:TextBox runat="server" ID="purpose" CssClass="form-control" placeholder="Purpose" />
                           <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator3" ControlToValidate="purpose" ErrorMessage="Please enter the purpose for the car loan!" ForeColor="Red" />
                    </div>
                </div>

            </div>



            <div class="row">

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Recovery Month:</strong>
                  <%--      <asp:textbox runat="server" id="recoveryStartMonth" textmode="Month" cssclass="form-control" />--%>
                           <asp:dropdownlist runat="server" id="recoveryStartMonths" appenddatabounditems="true" cssclass="form-control select2">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:dropdownlist>
                        <asp:requiredfieldvalidator display="dynamic" runat="server" id="Requiredfieldvalidator5" controltovalidate="recoveryStartMonths" initialvalue="--Select--" errormessage="Please select Recovery start Month, it cannot be empty!" forecolor="Red" />
                    </div>                      
                    </div>
               

<%--                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Recovert Start Date:</strong>
                        <asp:textbox runat="server" id="RecoveryStartDate" textmode="Date" cssclass="form-control" />
                           <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="RequiredFieldValidator5" ControlToValidate="RecoveryStartDate" ErrorMessage="Please enter the recovery Start date!" ForeColor="Red" />
                    </div>
                </div>--%>
                
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Loan Vendor:</strong>
                        <asp:dropdownlist runat="server" id="loanVendor" appenddatabounditems="true" cssclass="form-control select2">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:dropdownlist>
                        <asp:requiredfieldvalidator display="dynamic" runat="server" id="validatecountry" controltovalidate="loanVendor" initialvalue="--Select--" errormessage="Please select loan Vendor, it cannot be empty!" forecolor="Red" />
                    </div>
                </div>



            </div>
      
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Request for car Loan" ID="carLoanApplication" OnClick="carLoanApplication_Click" />
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
