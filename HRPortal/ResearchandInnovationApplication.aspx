<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResearchandInnovationApplication.aspx.cs" Inherits="HRPortal.ResearchandInnovationApplication" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="HRPortal.Models" %>
<%@ Import Namespace="System.Security" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <script>
        $(document).ready(function () {
            $("button#generalnextBtn").css("display", "block");


        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <%
        int step = 1;
        var applicationNo = Request.QueryString["applicationNo"];
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 6 || step < 1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        if (step == 1)
        {
    %>
    <div class="content">
        <div class="card-box tab-box">
            <div class="row">
                <div class="card">
                    <div class="card-header text-center" data-background-color="darkgreen">
                        <h5 class="title"><i>Innovation Response Form</i></h5>
                    </div>
                </div>
            </div>
            <%--  <div class="row user-tabs">
                <div class="col-lg-10 col-md-10 col-sm-10 line-tabs">
                    <div class="stepwizard">
                        <div class="stepwizard-row setup-panel">
                            <div class="stepwizard-step col-xs-2">
                                <a href="#step-1" type="button" class="btn btn-success btn-circle">1</a>
                                <p><small>General</small></p>
                            </div>
                            <div class="stepwizard-step col-xs-2">
                                <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
                                <p><small>Overview </small></p>
                            </div>
                            <div class="stepwizard-step col-xs-2">
                                <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled="disabled">3</a>
                                <p><small>Objectives</small></p>
                            </div>
                            <div class="stepwizard-step col-xs-2">
                                <a href="#step-4" type="button" class="btn btn-default btn-circle" disabled="disabled">5</a>
                                <p><small>Additional Comments</small></p>
                            </div>
                            <div class="stepwizard-step col-xs-2">
                                <a href="#step-5" type="button" class="btn btn-default btn-circle" disabled="disabled">5</a>
                                <p><small>Documents Attachment</small></p>
                            </div>

                        </div>
                        <div id="bideresponsesubmissionfeedback" style="display: none" data-dismiss="alert"></div>
                    </div>
                </div>
            </div>--%>
        </div>
        <%-- <div class="modal-body" style="width: 100%">
            <form class="m-b-30" role="form">
                <div class="panel-primary setup-content" id="step-1">
                    <div class="panel-heading">
                        <h5 class="panel-title">General Details</h5>
                    </div>

                    <div id="linesFeedback" runat="server"></div>
                    <div id="generalFeedback" runat="server"></div>
                    <div id="bideresponsefeedback" style="display: none" data-dismiss="alert"></div>
                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="tab_1_1">--%>

        <div class="panel panel-primary">
            <div class="panel-heading">
                General Details
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
           
            <div id="generalFeedback" runat="server"></div>
             
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label">Notice No:<span class="text-danger">*</span></label>

                            <asp:TextBox runat="server" class="form-control" type="text" ID="noticeNo" name="tendernotice" ReadOnly />
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
                            <label class="control-label">Department No:<span class="text-danger">*</span></label>

                            <asp:DropDownList runat="server" class="form-control select2" ID="department" />
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label">Innovation Description:<span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" class="form-control" type="text" ID="innovationDescription" />
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="control-label">Executive Summery:<span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" TextMode="MultiLine" class="form-control" ID="executiveSummery" Rows="3"></asp:TextBox>

                        </div>
                    </div>


                </div>

                <center>
                            <asp:Button runat="server" class="btn btn-primary pull-left saveresponce" ID="save" Text="Save Details" OnClick="save_Click"></asp:Button>
                         

                        </center>
                <div class="panel-footer">
                    <%-- <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />--%>
                    <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" Style="display: none;" Text="Next" OnClick="nextstep_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>

    <%
        }
        else if (step == 2)
        {
    %>
    <div class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Overview
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>
            <div class="panel-body">

                <%-- <div class="panel-primary setup-content" id="step-2">
                    <div class="panel-heading">
                        <h5 class="panel-title">Overview</h5>
                    </div>--%>
                <%-- <div class="panel-body">  <div id="linesFeedback" runat="server"></div> --%>
                 <div id="overviewFeedback" runat="server"></div>
                
                <div class="col-xs-8 text-right m-b-30">
                    <a href="#" class="btn btn-primary pull-right rounded" data-toggle="modal" data-target="#add_banks"><i class="fa fa-plus"></i>Add Idea Overview</a>
                </div>


                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label">Innovation Idea No:<span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" class="form-control" type="text" ID="innovationOverviewIdea" ReadOnly />
                        </div>


                        <div class="form-group">
                            <label class="control-label">Innovation Overview Description:<span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" class="form-control" TextMode="MultiLine" Rows="4" ID="overviewDescription" name="innovationCategory" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <asp:Button runat="server" class="btn btn-primary saveresponce" ID="submitOverview" OnClick="submitOverview_Click" Text="Submit Overview" />
                    </div>
                </div>
                </form>

                        <div class="col-md-12">
                            <div class="table-responsive">
                                <table class="table table-striped custom-table datatable" id="tbl_bidpricing_details">
                                    <thead>
                                        <tr>

                                            <th>Document No</th>
                                            <th>Record Type</th>
                                            <th>Description</th>
                                            <th>Edit</th>
                                            <th>Delete</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var empNo = Session["employeeNo"].ToString();
                                            var nav = new Config().ReturnNav();
                                            var annNos = Request.QueryString["applicationNo"];
                                            var innovationLines = nav.InnovationSolicitationLines.Where(x => x.Document_No == annNos && x.Record_Type == "Overview" && x.Document_Type == "Idea Response").ToList();
                                            var requests = "";
                                            foreach (var overview in innovationLines)
                                            {
                                        %>
                                        <tr>
                                            <td>
                                                <%=overview.Document_No %>
                                            </td>
                                            <td>
                                                <%=overview.Record_Type %>
                                            </td>
                                            <td><%=overview.Description %></td>
                                            <td>
                                                <label class="btn btn-success" onclick="editOverview('<%=overview.Document_No %>', '<%=overview.Description %>','<%=overview.Line_No %>');"><i class="fa fa-edit"></i>Edit</label></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="removeOverview('<%=overview.Document_No %>','<%=overview.Description %>','<%=overview.Line_No %>');"><i class="fa fa-trash-o"></i>Remove</label></td>


                                        </tr>
                                        <%

                                            }
                                        %>
                                    </tbody>
                                </table>
                                <div class="panel-footer">
                                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
                                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" />
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
            </div>
        </div>
    </div>

    </div>
    </div>
        </div>
    <div id="add_banks" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog" style="width: 50%">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <div class="modal-content modal-lg" style="width: 96%">
                <div class="modal-header">
                    <h5 class="modal-title">Add Idea Overview</h5>
                </div>
                <div class="modal-body">
                    <form class="m-b-30">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="control-label">Innovation Idea No:<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" class="form-control" type="text" ID="innovationCategory" name="innovationCategory" ReadOnly />
                                </div>

                                <div class="form-group">
                                    <label class="control-label">Innovation Overview Description:<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" class="form-control" TextMode="MultiLine" Rows="4" ID="TextBox2" name="innovationCategory" />
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="m-t-20 text-center">
                        <asp:Button runat="server" class="btn btn-primary" ID="Button2" OnClick="submitOverview_Click" Text="Submit Overview" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        }
        else if (step == 3)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Objectives
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">

            <%--  <div class="panel-primary setup-content" id="step-3">
                    <div class="panel-heading">
                        <h5 class="panel-title">Objective</h5>
                    </div>
                    <div class="panel-body">--%>
            <div id="ObjectivesFeedback" runat="server"/>
            <div id="pricingfeedback" style="display: none" data-dismiss="alert"></div>
            <div class="col-xs-8 text-right m-b-30">
                <a href="#" class="btn btn-primary pull-right rounded" data-toggle="modal" data-target="#add_banks"><i class="fa fa-plus"></i>Add Idea Overview</a>
            </div>



            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="control-label">Innovation Idea No:<span class="text-danger">*</span></label>
                        <asp:TextBox runat="server" class="form-control" type="text" ID="ObjectiveNo" ReadOnly />
                    </div>


                    <div class="form-group">
                        <label class="control-label">Innovation Objective Description:<span class="text-danger">*</span></label>
                        <asp:TextBox runat="server" class="form-control" TextMode="MultiLine" Rows="4" ID="Objectivedescription" name="innovationCategory" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <asp:Button runat="server" class="btn btn-primary saveresponce" ID="objectives" OnClick="objectives_Click" Text="Submit Objectives" />
                </div>
            </div>
            </form>

                        <div class="col-md-12">
                            <div class="table-responsive">
                                <table class="table table-striped custom-table datatable" id="tbl_bidpricing_details">
                                    <thead>
                                        <tr>

                                            <th>Document No</th>
                                            <th>Record Type</th>
                                            <th>Description</th>
                                            <th>Edit</th>
                                            <th>Delete</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var empNo = Session["employeeNo"].ToString();
                                            var nav = new Config().ReturnNav();
                                            // var applicationNo = Convert.ToString(Session["applicationNo"]);
                                            var innovationLines = nav.InnovationSolicitationLines.Where(x => x.Document_No == applicationNo && x.Record_Type == "Objective" && x.Document_Type == "Idea Response").ToList();
                                            //var requests = "";
                                            foreach (var overview in innovationLines)
                                            {
                                        %>
                                        <tr>
                                            <td>
                                                <%=overview.Document_No %>
                                            </td>
                                            <td>
                                                <%=overview.Record_Type %>
                                            </td>
                                            <td><%=overview.Description %></td>
                                            <td>
                                                <label class="btn btn-success" onclick="editOverview('<%=overview.Document_No %>', '<%=overview.Description %>','<%=overview.Line_No %>');"><i class="fa fa-edit"></i>Edit</label></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="removeOverview('<%=overview.Document_No %>','<%=overview.Description %>','<%=overview.Line_No %>');"><i class="fa fa-trash-o"></i>Remove</label></td>



                                        </tr>
                                        <%

                                            }
                                        %>
                                    </tbody>
                                </table>
                                <%--  <div class="panel-footer">
                                    <br />
                                    <asp:Button runat="server" type="button" ID="Button2" class="btn btn-success pull-right" value="next" />
                                </div>--%>
                            </div>
                        </div>
        </div>
    </div>

    <div class="panel-footer">
        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" />
        <div class="clearfix"></div>
    </div>
    </div>
    </div>
    <div id="add_banks" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog" style="width: 50%">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <div class="modal-content modal-lg" style="width: 96%">
                <div class="modal-header">
                    <h5 class="modal-title">Add Idea Objective</h5>
                </div>
                <div class="modal-body">
                    <form class="m-b-30">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="control-label">Innovation Idea No:<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" class="form-control" ID="innovationObjective" name="innovationCategory" ReadOnly />
                                </div>

                                <div class="form-group">
                                    <label class="control-label">Innovation Objective Description:<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" class="form-control" TextMode="MultiLine" Rows="4" ID="TextBox6" name="innovationCategory" />
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="m-t-20 text-center">
                        <asp:Button runat="server" class="btn btn-primary" ID="Button1" OnClick="objectives_Click" Text="Submit Objectives" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        }
        else if (step == 4)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Additional Notes
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">

            <%-- <div class="panel-primary setup-content" id="step-4">
                    <div class="panel-heading">
                        <h5 class="panel-title">Additional Notes</h5>
                    </div>
                    <div class="panel-body">--%>
            <div runat="server" id="linesFeedback" />

            <div id="pricingfeedback" style="display: none" data-dismiss="alert"></div>
            <div class="col-xs-8 text-right m-b-30">
                <a href="#" class="btn btn-primary pull-right rounded" data-toggle="modal" data-target="#add_banks"><i class="fa fa-plus"></i>Add Idea Overview</a>
            </div>


            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="control-label">Innovation Idea No:<span class="text-danger">*</span></label>
                        <asp:TextBox runat="server" class="form-control" type="text" ID="additionNo" ReadOnly />
                    </div>


                    <div class="form-group">
                        <label class="control-label">Innovation Additional Notes:<span class="text-danger">*</span></label>
                        <asp:TextBox runat="server" class="form-control" TextMode="MultiLine" Rows="4" ID="InnovationAddition" name="innovationCategory" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <asp:Button runat="server" class="btn btn-primary saveresponce" ID="additionalNotes" OnClick="additionalNotes_Click" Text="Submit AdditionalNotes" />
                </div>
            </div>
            </form>

                        <div class="col-md-12">
                            <div class="table-responsive">
                                <table class="table table-striped custom-table datatable" id="tbl_bidpricing_details">
                                    <thead>
                                        <tr>

                                            <th>Document No</th>
                                            <th>Record Type</th>
                                            <th>Description</th>
                                            <th>Edit</th>
                                            <th>Delete</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var empNos = Session["employeeNo"].ToString();
                                            var nav1 = new Config().ReturnNav();

                                            var innovationLinesss = nav1.InnovationSolicitationLines.Where(x => x.Document_No == applicationNo && x.Record_Type == "Additional Notes" && x.Document_Type == "Idea Response").ToList();
                                            //var requests = "";
                                            foreach (var overview in innovationLinesss)
                                            {
                                        %>
                                        <tr>
                                            <td>
                                                <%=overview.Document_No %>
                                            </td>
                                            <td>
                                                <%=overview.Record_Type %>
                                            </td>
                                            <td><%=overview.Description %></td>
                                            <td>
                                                <label class="btn btn-success" onclick="editOverview('<%=overview.Document_No %>', '<%=overview.Description %>','<%=overview.Line_No %>');"><i class="fa fa-edit"></i>Edit</label></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="removeOverview('<%=overview.Document_No %>','<%=overview.Description %>','<%=overview.Line_No %>');"><i class="fa fa-trash-o"></i>Remove</label></td>




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
    <div class="panel-footer">
        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" />
        <div class="clearfix"></div>
    </div>
    </div>
    </div>
    <div id="add_banks" class="modal custom-modal fade" role="dialog">
        <div class="modal-dialog" style="width: 50%">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <div class="modal-content modal-lg" style="width: 96%">
                <div class="modal-header">
                    <h5 class="modal-title">Add Additional Notes</h5>
                </div>
                <div class="modal-body">
                    <form class="m-b-30">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="control-label">Innovation Idea No:<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" class="form-control" type="text" ID="TextBox9" name="innovationCategory" ReadOnly />
                                </div>

                                <div class="form-group">
                                    <label class="control-label">Innovation Additional Notes:<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" class="form-control" TextMode="MultiLine" Rows="4" ID="TextBox10" name="innovationCategory" />
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="m-t-20 text-center">
                        <asp:Button runat="server" class="btn btn-primary" ID="Button3" OnClick="additionalNotes_Click" Text="Submit AdditionalNotes" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        }
        else if (step == 5)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Document Attachment
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 5 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <%--   <div class="panel-primary setup-content" id="step-5">
                        <div class="panel-heading">
                            <h5 class="panel-title">Upload mandatory Documents</h5>
                        </div>
                        <div class="panel-body">--%>
            <div id="submitFeedback" runat="server"></div>
            <ul class="nav nav-tabs">
                <%--  <li class="active" style="background-color:gray">
                            <a href="#tab_1_documents" data-toggle="tab"><p style="color:black"><strong>Required Documents</strong> </p></a>
                        </li>--%>
                <li class="active" style="background-color: gray">
                    <a href="#tab_1_attach" data-toggle="tab">
                        <p style="color: black">Attach Document </p>
                    </a>
                </li>
                <li style="background-color: gray">
                    <a href="#tab_1_attached" data-toggle="tab">
                        <p style="color: black">Attached Document </p>
                    </a>
                </li>
            </ul>
            <div class="tab-content">
                <%--   <div class="tab-pane fade active in" id="tab_1_documents">
                            <div class="row">
                                <p>You are required to submit scanned copies of the following sets of documents, as part of your Registration process. Click on the Attach Documents Link, when ready to attach the supporting documents.</></p>
                                <div class="col-md-12">
                                    
                                </div>
                            </div>
                        </div>--%>

                <div class="tab-pane fade active in" id="tab_1_attach">
                    <div class="row">
                        <p>This Section enables you to upload scanned copies of the supporting documents.</p>
                        <!-- The global progress bar -->
                        <div class="progress progress-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                            <div class="progress-bar progress-bar-success" style="width: 0%;"></div>
                        </div>


                        <div runat="server" id="Div1"></div>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <strong>Select file to upload:</strong>
                                <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="form-group">
                                <br />
                                <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button4" OnClick="uploadDocument_Click" />
                            </div>
                        </div>

                    </div>

                </div>

                <div class="tab-pane fade " id="tab_1_attached">
                    <div runat="server" id="documentsfeedback"></div>
                       <div class="table-responsive">  
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Document Title</th>
                                <%-- <th>Download</th>--%>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                                try
                                {%>
                            <%  using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["S_URL"]))
                                {

                                    String leaveNo = Request.QueryString["imprestNo"];
                                    string password = ConfigurationManager.AppSettings["S_PWD"];
                                    string account = ConfigurationManager.AppSettings["S_USERNAME"];
                                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                                    var secret = new SecureString();



                                    foreach (char c in password)
                                    {
                                        secret.AppendChar(c);
                                    }

                                    ctx.Credentials = new NetworkCredential(account, secret, domainname);
                                    ctx.Load(ctx.Web);
                                    ctx.ExecuteQuery();
                                    List list = ctx.Web.Lists.GetByTitle("ERP Documents");

                                    //Get Unique rfiNumber
                                    string uniqueLeaveNumber = leaveNo;

                                    ctx.Load(list);
                                    ctx.Load(list.RootFolder);
                                    ctx.Load(list.RootFolder.Folders);
                                    ctx.Load(list.RootFolder.Files);
                                    ctx.ExecuteQuery();

                                    FolderCollection allFolders = list.RootFolder.Folders;
                                    foreach (Folder folder in allFolders)
                                    {
                                        if (folder.Name == "Kasneb")
                                        {
                                            ctx.Load(folder.Folders);
                                            ctx.ExecuteQuery();
                                            var uniquerfiNumberFolders = folder.Folders;

                                            foreach (Folder folders in uniquerfiNumberFolders)
                                            {
                                                if (folders.Name == "Imprest Memo")
                                                {
                                                    ctx.Load(folders.Folders);
                                                    ctx.ExecuteQuery();
                                                    var uniquevendorNumberSubFolders = folders.Folders;

                                                    foreach (Folder vendornumber in uniquevendorNumberSubFolders)
                                                    {
                                                        if (vendornumber.Name == uniqueLeaveNumber)
                                                        {
                                                            ctx.Load(vendornumber.Files);
                                                            ctx.ExecuteQuery();

                                                            FileCollection vendornumberFiles = vendornumber.Files;
                                                            foreach (Microsoft.SharePoint.Client.File file in vendornumberFiles)
                                                            {%>
                            <% ctx.ExecuteQuery();
                                alldocuments.Add(new SharePointTModel { FileName = file.Name });
                            %>


                            <% }%>


                            <% 
                                foreach (var item in alldocuments)
                                {%>
                            <tr>
                                <td><% =item.FileName %></td>
                                <td>
                                    <label class="btn btn-danger" onclick="deleteFile('<%=item.FileName %>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                            </tr>
                            <% }
                            %>



                            <%  }

                                                        }


                                                    }
                                                }

                                            }
                                        }

                                    }

                                }
                                catch (Exception t)
                                {

                                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                      "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }

                            %>
                        </tbody>
                    </table>
                           </div>
                   
                </div>

                </div>
        
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" ID="submitIdea" Text="Submit Innovation Idea" OnClick="submitIdea_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <%
            }
        %>
         
    <script>
        $("body").delegate(" .saveresponce", "click", function (event) {

            document.querySelector('.btn2').style.display = 'block';


        });
    </script>
    <script>
        function editOverview(DocumentNo, Description,LineNo) {
            document.getElementById("ContentPlaceHolder1_documenttype").value = DocumentNo;
            document.getElementById("ContentPlaceHolder1_editDescription").value = Description;
            document.getElementById("ContentPlaceHolder1_lineNo").value = LineNo;


            $("#editCasualsModal").modal();
        }
    </script>
    <script>

        function removeOverview(DocumentNo, description, LineNO) {
            document.getElementById("fueltoRemoveName").innerText = description;
            document.getElementById("ContentPlaceHolder1_removeFuelNumber").value = DocumentNo;
            document.getElementById("ContentPlaceHolder1_lineNumber").value = LineNO;
            $("#removeOverviewModal").modal();
        }
    </script>
    <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("ContentPlaceHolder1_fileName").value = fileName;
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
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="editCasualsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="documenttype" type="hidden" />
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />

                    <div class="form-group">
                        <strong>Description</strong>
                        <asp:TextBox TextMode="MultiLine" Rows="3" runat="server" CssClass="form-control" ID="editDescription" />
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Edit" ID="editOverview" OnClick="editOverview_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="removeOverviewModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Delete</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the fuel <strong id="fueltoRemoveName"></strong>from the Idea Innovation Overview</p>
                    <asp:TextBox runat="server" ID="removeFuelNumber" type="hidden" />
                    <asp:TextBox runat="server" ID="lineNumber" type="hidden" />

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete" ID="removeOverview" OnClick="removeOverview_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
