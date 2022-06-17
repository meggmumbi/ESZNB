<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OSHmanagementPlanList.aspx.cs" Inherits="HRPortal.OSHmanagementPlanList" %>
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
                    <h5 class="title"><i>Welcome to Operation Sfety Health Management Plan</i></h5>
                </div>
            </div>
        </div>
        <p>The Operation Safety Health Management Plan.</p>
        <h5><u>Management Plans</u></h5>
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
                                <th>Plan Id</th>
                                <th>Plan Type</th>
                                <th>Document Date</th>
                                <th>Description</th>
                                <th>Department</th>
                                <th>View</th>


                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var empNo = Session["employeeNo"].ToString();
                                var nav = new Config().ReturnNav();
                                var today = DateTime.Today;
                                var innovations = nav.HSPmanagement.Where(r =>r.Status == "Released" && r.Planning_End_Date >= today);
                                //var requests = "";
                                foreach (var innovation in innovations)
                                {
                            %>
                            <tr>
                                <td><%=innovation.Plan_ID %></td>

                                <td><%=innovation.Plan_Type %></td>
                               
                                <td><%=Convert.ToString(innovation.Document_Date) %></td>
                                 <td><%=innovation.Description %></td>
                                <td><%=innovation.Department_ID %></td>
                                <td><a href="OSHManagementPlan.aspx?planId=<%=innovation.Plan_ID %>" class="btn btn-success"><i class="fa fa-share m-r-10"></i>View</a></td>



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
