<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubmittedInnovationResearch.aspx.cs" Inherits="HRPortal.SubmittedInnovationResearch" %>
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
                    <h5 class="title"><i>Welcome to Innovation portal</i></h5>
                </div>
            </div>
        </div>
        <p>The innovation Portal enables the users to view all Active Invitation For innovation Notices,  and allow for online submission of their Ideas.</p>
        <h5><u>Submitted Innovation Responses</u></h5>
        <%--    <div class="row filter-row">
        <div class="col-sm-4 col-xs-6">
            <div class="form-group form-focus">
                <label class="control-label">Seacrh by  Procurement Method</label>
                <input type="text" class="form-control floating" />
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <div class="form-group form-focus">
                <label class="control-label">Search by Regions</label>
                <input type="text" class="form-control floating" />
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <a href="#" class="btn btn-success btn-block"> Search </a>
        </div>
    </div>--%>
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered" style="width: 100%" id="example5">
                        <thead>
                            <tr>
                                <th>Response No</th>
                                <th>Description</th>
                                <th>Innvovation Category</th>
                                <th>Document Date</th>
                                 <th>Approval Status</th>
                                <th>Document Status</th>
                                <th>Report</th>


                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var empNo = Session["employeeNo"].ToString();
                                var nav = new Config().ReturnNav();
                                var today = DateTime.Today;
                                var innovations = nav.InnovationSolicitation.Where(r => r.Document_Type == "Idea Response" && r.Idea_Originator==empNo && r.Portal_Status=="Submitted");
                                //var requests = "";
                                foreach (var innovation in innovations)
                                {
                            %>
                            <tr>
                                <td><%=innovation.Document_No %></td>

                                <td><%=innovation.Description %></td>
                                <td><%=innovation.Innovation_Category %></td>
                                <td><%=Convert.ToDateTime(innovation.Document_Date).ToString("dd/MM/yyyy") %></td>
                                <td><%=innovation.Status %></td>
                                <td><%=innovation.Portal_Status %></td>
                                <td><a href="ResearchInnovationReport.aspx?applicationNo=<%=innovation.Document_No %>" class="btn btn-success"><i class="fa fa-file m-r-10"></i>View Report</a></td>



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
</asp:Content>
