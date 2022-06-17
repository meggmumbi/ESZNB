<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OSHManagementPlan.aspx.cs" Inherits="HRPortal.OSHManagementPlan" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="content container-fluid">
        <div class="row">
            <div class="card">
                <div class="card-header text-center" data-background-color="darkgreen">
                    <h5 class="title"><i><strong>Welcome to Innovation portal</strong></i></h5>
                </div>
                <br />
            </div>
        </div>
        <p>
            Operation Health Safety Management plan 

        </p>
        <div class="row" style="background-color: #D3D3D3">
            <div class="col-xs-4">
                <h6><strong><u>Innovation General Details</u></strong></h6>
            </div>
            <div class="col-xs-8 text-right m-b-30">

                <a href="ResearchandInnovationApplication.aspx?invitationNo=<%=Request.QueryString["innovationNumber"] %>" class="btn btn-success"><i class="fa fa-plus"></i>Management Plan Report</a>
                <%-- <a href="#" onclick="RespondRFQ('@Url.Action("SubmitQuotationResponse", "Home", new { tendernumber = @tenderdetail.Code })','tendernumber = @tenderdetail.Code')" class="btn btn-primary pull-right rounded"><i class="fa fa-plus"></i>Repond to this Quotation</a>--%>
            </div>
        </div>

        <div id="responsesfeedback" style="display: none" data-dismiss="alert"></div>
        <div class="panel-body">
            <ul class="nav nav-tabs">
                <li class="active" style="background-color: #D3D3D3">
                    <a href="#tab_overview" data-toggle="tab">
                        <p style="color: black"><strong>General</strong> </p>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#tab_purchase_items" data-toggle="tab">
                        <p style="color: black"><strong>Hazard Identification & Analysis</strong></p>
                    </a>
                </li>
              <%--  <li style="background-color: #D3D3D3">
                    <a href="#tab_tender_documents" data-toggle="tab">
                        <p style="color: black"><strong>Objective</strong></p>
                    </a>
                </li>--%>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="tab_overview">

                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6><strong><u>OHS General Details</u></strong></h6>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">plan Id:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="managementplanId" name="tendernotice" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Plan Type:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="planType" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Rik Management Plan Id:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="riskplan" name="RiskId" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Description:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="description" name="RiskId" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Department:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="department" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Primary Mission:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="primaryMission" name="RiskId" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Planning Start Date:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="submissionstartDate" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Planning End Date:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="submissionEndDate" ReadOnly />
                            </div>
                        </div>
                    




                    </div>
                </div>

                <div class="tab-pane fade " id="tab_purchase_items">
                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6 class="panel-title"><strong><u>Hazard Identification & Analysis</u></strong></h6>
                        </div>
                      <%--  <p>
                            The user shall be required to provide overview of their idea. Please note the following:<br />
                            1. The user must fill in the overview of their idea.<br />
                            2. The user must fill in the Goals for the idea.<br />
                            3) The last part , the user is required to fill in additional comments to support their idea and attch a document if any. .
                        </p>--%>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <table class="table table-striped custom-table datatable">
                                        <thead>
                                            <tr>

                                                <th>Plan Id</th>
                                                <th>Hazard Type</th>
                                                <th>Description</th>
                                                <th>Hazard Category</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var empNo = Session["employeeNo"].ToString();
                                                var nav = new Config().ReturnNav();
                                                var planId = Request.QueryString["planId"];
                                                var requests = nav.HSPmanagementlines.Where(x => x.Plan_ID==planId).ToList();
                                                //var requests = "";
                                                foreach (var request in requests)
                                                {
                                            %>
                                            <tr>
                                                <td>
                                                    <%=request.Plan_ID %>
                                                </td>
                                                <td>
                                                    <%=request.Hazard_Type %>
                                                </td>
                                                 <td>
                                                    <%=request.Description %>
                                                </td>
                                                 <td>
                                                    <%=request.Hazard_Category %>
                                                </td>


                                            </tr>
                                            <%

                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
               <%-- <div class="tab-pane fade " id="tab_tender_documents">
                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6 class="panel-title"><strong><u>Objectives</u></strong></h6>
                        </div>
                        <p>
                            The user shall be required to provide overview of their idea. Please note the following:<br />
                            1. The user must fill in the overview of their idea.<br />
                            2. The user must fill in the Goals for the idea.<br />
                            3) The last part , the user is required to fill in additional comments to support their idea and attch a document if any. .
                        </p>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <table class="table table-striped custom-table datatable">
                                        <thead>
                                            <tr>

                                                <th>Document No</th>
                                                <th>Description</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var empNo1 = Session["employeeNo"].ToString();
                                                var nav1 = new Config().ReturnNav();
                                                var invitationNos = Request.QueryString["innovationNumber"];
                                                var requestss = nav1.InnovationSolicitationLines.Where(x => x.Document_No == invitationNo && x.Record_Type == "Objective" && x.Document_Type == "Innovation Invitation").ToList();
                                                //var requests = "";
                                                foreach (var request in requestss)
                                                {
                                            %>
                                            <tr>
                                                <td>
                                                    <%=request.Document_No %>
                                                </td>
                                                <td>
                                                    <%=request.Description %>
                                                </td>



                                            </tr>
                                            <%

                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>--%>


                <div class="form-actions">
                    <div class="row">
                        <div class="col-md-offset-5 col-md-8">
                            <a href="ResearchandInnovation.aspx" class="btn btn-primary pull-left"><i class="fas fa fa-angle-left"></i>&nbsp;Back </a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>


</asp:Content>
