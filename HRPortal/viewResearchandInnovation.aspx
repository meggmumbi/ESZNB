<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="viewResearchandInnovation.aspx.cs" Inherits="HRPortal.viewResearchandInnovation" %>
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
            The innovation Portal enables the users to view all Active Invitation For innovation Notices,  and allow for online submission of their Ideas.

        </p>
        <div class="row" style="background-color: #D3D3D3">
            <div class="col-xs-4">
                <h6><strong><u>Innovation General Details</u></strong></h6>
            </div>
            <div class="col-xs-8 text-right m-b-30">

                <a href="ResearchandInnovationApplication.aspx?invitationNo=<%=Request.QueryString["innovationNumber"] %>" class="btn btn-success"><i class="fa fa-plus"></i>Innovation Response</a>
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
                        <p style="color: black"><strong>Overview</strong></p>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#tab_tender_documents" data-toggle="tab">
                        <p style="color: black"><strong>Objective</strong></p>
                    </a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="tab_overview">

                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6><strong><u>Innovation General Details</u></strong></h6>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Notice No:<span class="text-danger">*</span></label>

                                <asp:TextBox runat="server" class="form-control" type="text" ID="noticeNo" name="tendernotice" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Innovation Description:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="innovationDescription" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Innvovation Category No:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="category" name="innovationCategory" ReadOnly />
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
                                <label class="control-label">Submission Start Date:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="submissionstartDate" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Submission End Date:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="submissionEndDate" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label">Executive Summery:<span class="text-danger">*</span></label>
                                <asp:TextBox runat="server" TextMode="MultiLine" class="form-control" ID="executiveSummery" Rows="3" ReadOnly></asp:TextBox>

                            </div>
                        </div>





                    </div>
                </div>

                <div class="tab-pane fade " id="tab_purchase_items">
                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6 class="panel-title"><strong><u>Overview</u></strong></h6>
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
                                                var empNo = Session["employeeNo"].ToString();
                                                var nav = new Config().ReturnNav();
                                                var invitationNo = Request.QueryString["innovationNumber"];
                                                var requests = nav.InnovationSolicitationLines.Where(x => x.Document_No == invitationNo && x.Record_Type == "Overview" && x.Document_Type == "Innovation Invitation").ToList();
                                                //var requests = "";
                                                foreach (var request in requests)
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
                </div>
                <div class="tab-pane fade " id="tab_tender_documents">
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
                </div>


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
