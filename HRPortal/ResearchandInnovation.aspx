<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResearchandInnovation.aspx.cs" Inherits="HRPortal.ResearchandInnovation" %>
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
        <p>The innovation Portal enables the users to view all Active Invitation For innovation ideas,  and allow for online submission of the same.</p>
        <h5><u>Open Innovation Notices</u></h5>
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
                                <th>Notice No</th>
                                <th>Description</th>
                                <th>Innvovation Category</th>
                                <th>Idea Submission Start Date</th>
                                <th>Idea Submission End Date</th>
                                <th>Apply</th>


                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var empNo = Session["employeeNo"].ToString();
                                var nav = new Config().ReturnNav();
                                var today = DateTime.Today;
                                var innovations = nav.InnovationSolicitation.Where(r => r.Document_Type == "Innovation Invitation" && r.Status == "Released" && r.Idea_Submission_End_Date >= today);
                                //var requests = "";
                                foreach (var innovation in innovations)
                                {
                            %>
                            <tr>
                                <td><%=innovation.Document_No %></td>

                                <td><%=innovation.Description %></td>
                                <td><%=innovation.Innovation_Category %></td>
                                <td><%=Convert.ToDateTime(innovation.Idea_Submission_Start_Date).ToString("dd/MM/yyyy") %></td>
                                <td><%=Convert.ToDateTime(innovation.Idea_Submission_End_Date).ToString("dd/MM/yyyy") %></td>
                                <td><a href="viewResearchandInnovation.aspx?innovationNumber=<%=innovation.Document_No %>" class="btn btn-success"><i class="fa fa-share m-r-10"></i>Apply</a></td>



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
