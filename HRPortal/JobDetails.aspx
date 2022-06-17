<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JobDetails.aspx.cs" Inherits="HRPortal.JobDetails" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% var nav = new Config().ReturnNav();
        var jobId = Request.QueryString["id"]; %>

    <div class="row" style="margin: 10px;">
        <% var jobDetails = nav.VacantPositions.Where(r => r.Job_ID == jobId);
            foreach (var jobDetail in jobDetails)
            {

        %>

        <%Session["desc"] = jobDetail.Job_Description;%>
        <div class="span12">
            <h3><i><a href="JobDetails.aspx?id=<%=jobId %>"><%=jobId %></a> :<%=jobDetail.Job_Description %> &nbsp;<%=jobDetail.Job_Grade %></i></h3>
        </div>
        <%-- <div class="span12"><h3><i> <a href="JobDetails.aspx?id=<%=jobId %>"><%=jobId %></a> :<%=jobDetail.Job_Description %> </i></h3></div>  --%>

        <% 
            }
        %>

        <%--Id: <a href="JobDetails.aspx?id=<%=jobId %>"><%=jobId %></a></i></h3></div> --%>
    </div>
    <div class="row" style="margin: 10px;">
        <div class="span6">
            <div class="widget">
                <div class="widget-header">
                    <i class="icon-file"></i>
                    <h3>a)Job Responsibilities/Specifications</h3>


                </div>
                <div class="widget-content" style="overflow: auto;">
                    <table class="table table-striped table-bordered">
                        <thead>
                            <tr>

                                <th>The Duties and responsibilities of the officer will entail:-</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var responsibilities = nav.JobResponsibilities.Where(r => r.Job_ID == jobId);
                                foreach (var responsibility in responsibilities)
                                {
                            %>
                            <tr>

                                <td><% =responsibility.Responsibility %></td>

                            </tr>
                            <% 
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="span6">
            <div class="widget">
                <div class="widget-header">
                    <i class="icon-file"></i>
                    <h3>b)Job Specifications/Person Specifications</h3>

                </div>
                <div class="widget-content" style="overflow: auto;">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <%--<th>Qualification Type</th>--%>
                                    <th>For appointment to this grade,a candidate must have:-</th>
                                    <%--<th>Priority</th>--%>
                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    var requirements = nav.JobRequirements.Where(r => r.Job_Id == jobId && r.Qualification_Type == "Requirement");
                                    foreach (var requirement in requirements)
                                    {
                                %>
                                <tr>
                                    <%--<td><% =requirement.Qualification_Type %></td>--%>
                                    <td><% =requirement.Job_Requirements %></td>
                                    <%--<td><% =requirement.Priority %></td>--%>
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

        <div class="span6">
            <div class="widget">
                <div class="widget-header">
                    <i class="icon-file"></i>
                    <h3>c)Key Skills and Competence</h3>
                </div>
                <div class="widget-content" style="overflow: auto;">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>

                                    <th>Skills Required for this position:-</th>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var skills = nav.JobRequirements.Where(r => r.Job_Id == jobId && r.Qualification_Type == "Skill");
                                    // var requirements = nav.JobRequirements.Where(r => r.Job_Id == jobId && r.Qualification_Type=="Skill");
                                    foreach (var skill in skills)
                                    {
                                %>
                                <tr>

                                    <td><% =skill.Job_Requirements %></td>

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



        <div class="span6">


            <a href="ApplicationForm.aspx?id=<%=jobId %>" class="button btn btn-success btn-large">Apply</a>

        </div>

    </div>
</asp:Content>
