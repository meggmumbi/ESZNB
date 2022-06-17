<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="BoardPerformanceContract.aspx.cs" Inherits="HRPortal.BoardPerformanceContract" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel panel-heading">
            Board Performance Contract 
        </div>    
            <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#home" data-toggle="tab"   <h3 class="panel-title" style="color:black">General Details</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#initiatives" data-toggle="tab"><h3 class="panel-title" style="color:black">Initiatives and Perfomance Indicators</h3></a>
                        </li>
                  </ul>
            </ul>
            <div class="tab-content">
                <div id="home" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">Board Performance Contract General Details</h3> 
                        </div>
                        <div class="table-responsive">               
                              <table id="example1" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                       
                                        <th>Name</th>
                                        <th>Strategy Plan No.</th>
                                        <th>Year Reporting</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        var nav = new Config().ReturnNav();
                                        var boardpcs = nav.PerfomanceContractHeader.Where(x=>x.Document_Type=="Board/Executive PC" &&x.End_Date>= DateTime.Now.Date && x.Approval_Status == "Released");
                                        foreach (var boardpc in boardpcs)
                                        {
                                            Session["docNo"] = boardpc.No;
                                    %>
                                    <tr>
                                        
                                        <td><% =boardpc.Description%></td>
                                        <td><% =boardpc.Strategy_Plan_ID%> </td>
                                        <td><% =boardpc.Annual_Reporting_Code%></td>
                                        <td><% = Convert.ToDateTime(boardpc.Start_Date).ToString("dd/MM/yyyy")%></td>
                                        <td><% = Convert.ToDateTime(boardpc.End_Date).ToString("dd/MM/yyyy")%></td>
                                        <td><a href="BoarPcReport.aspx?IndividualPCNo=<%=boardpc.No %>"><label class="btn btn-success">View Report</label></a></td>
                                        </tr>
                                        <%
                                            }
                                      %>
                                </tbody>
                            </table>
                            </div>
                        </div>
                  </div>
                  <div id="initiatives" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                Initiatives And Perfomance Indicators (<i style="color:yellow">Kindly click on Objective/Initiative to view sub-initiatives</i>)
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">               
                                <table class="table table-bordered table-striped datatable" id="example3">
                                    <thead>
                                        <tr>  
                                            <th>Initiative Type</th>           
                                            <th>Objective/Initiative</th>                                            
                                            <th>Unit of Measure</th>
                                            <th>Primary Directorate</th>
                                             <th>Previous FY Target</th>
                                             <th>Current FY Target</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>                                          
                                        </tr>
                                    </thead>
                                    <tbody>
                                         <%
                                        var nav1 = new Config().ReturnNav();
                                        var tinitiatives = nav.PCObjective.Where(x=> x.Workplan_No == Convert.ToString(Session["docNo"]));
                                        foreach (var initiative in tinitiatives)
                                        {
                                    %>
                                       <tr>
                                        <td><% =initiative.Initiative_Type%></td>
                                         <td><a href="BoardPCSubIndicators.aspx?InitiativeNo=<%=initiative.Initiative_No %>&&docNo=<%=initiative.Workplan_No %>"</a><% =initiative.Objective_Initiative%> </td>  
                                        <td><% =initiative.Unit_of_Measure%></td>
                                        <td><% =initiative.primarydirectoratename%></td>
                                           <td><% =initiative.Previous_Annual_Target_Qty%></td>
                                           <td><% =initiative.Imported_Annual_Target_Qty%></td>
                                        <td><% = Convert.ToDateTime(initiative.Start_Date).ToString("dd/MM/yyyy")%></td>
                                        <td><% = Convert.ToDateTime(initiative.Due_Date).ToString("dd/MM/yyyy")%></td>
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
          </div>
</asp:Content>