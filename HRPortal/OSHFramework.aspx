<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OSHFramework.aspx.cs" Inherits="HRPortal.OSHFramework" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Occupational Health Safety</h3>
        </div> 
        <br />
        <div>
          <asp:Button runat="server" ID="Button1" CssClass="btn btn-success" style ="margin-left:90%" Text="OHS Charter" OnClick="Button1_Click"/>
        </div>
        <br />
            <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#step-1" data-toggle="tab"   <h3 class="panel-title" style="color:black">Hazard Type</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#step-2" data-toggle="tab"><h3 class="panel-title" style="color:black">Hazard Identification Method</h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#step-3" data-toggle="tab"><h3 class="panel-title" style="color:black">Evacuation Events </h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#step-4" data-toggle="tab"><h3 class="panel-title" style="color:black">Workplace Prohibited Items</h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#step-5" data-toggle="tab"><h3 class="panel-title" style="color:black">Safety Work Permits </h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#step-6" data-toggle="tab"><h3 class="panel-title" style="color:black">Safety WorkGroups </h3></a>
                        </li>
                      <%--  <li style="background-color:#D3D3D3">
                            <a href="#step-7" data-toggle="tab"><h3 class="panel-title" style="color:black">Risk Identification Methods </h3></a>
                        </li>--%>
                    </ul>
               </ul>
            <div class="tab-content">
                <div id="step-1" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">Hazard Type</h3>
                        </div>
                           <div class="panel-body">
                                  <div class="table-responsive">  
                            <table id="example1" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <%--<th>Name</th>--%>
                                        <th>Overview Description</th>
                                        <th>Hzard Category</th>
                                        
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav = new Config().ReturnNav();
                                        var queryRisk = nav.HazardType;
                                        foreach (var risk in queryRisk)
                                        {
                                            %>
                                        <tr>
                                            <%--<td><%=risk.RMF_Section %></td>--%>
                                            <td><%=risk.Description %></td>  
                                            <td><%=risk.Hazard_Category%></td>  
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
                    <div id="step-2" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Hazard Identification Method</h3>
                            </div>
                            <div class="panel-body">
                                   <div class="table-responsive">  
                                <table id="example1" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <%--<th>Name</th>--%>
                                        <th>Overview Description</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav1 = new Config().ReturnNav();
                                        var queHazardIdentificationMethodryRisk = nav1.HazardIdentificationMethod;
                                        foreach (var risk in queHazardIdentificationMethodryRisk)
                                        {
                                            %>
                                        <tr>
                                            <%--<td><%=risk.RMF_Section %></td>--%>
                                            <td><%=risk.Description %></td>  
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
                    <div id="step-3" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Evacuation Events </h3>
                            </div>
                            <div class="panel-body"> 
                                   <div class="table-responsive">                   
                                <table id="example2" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                       
                                        <th>Description</th>
                                         <th>Hzard Type</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav5 = new Config().ReturnNav();
                                        var queryRisk5 = nav.EvacuationEventnt;
                                        foreach (var risk in queryRisk5)
                                        {
                                            %>
                                        <tr>
                                            <%--<td><%=risk.RMF_Section %></td>--%>
                                            <td><%=risk.Description %></td>  
                                              <td><%=risk.Hazard_Type %></td>
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
                    <div id="step-4" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Workplace Prohibited Items</h3>
                            </div>
                            <div class="panel-body">
                                   <div class="table-responsive">  
                                <table id="example3" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                       <%-- <th>Risk Management Framework Section</th>--%>
                                        <th>Description</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav9 = new Config().ReturnNav();
                                        var queryRisk1 = nav.WorkplaceProhibitedItem;
                                        foreach (var risk in queryRisk1)
                                        {
                                            %>
                                        <tr>
                                           <%-- <td><%=risk.RMF_Section %></td>--%>
                                            <td><%=risk.Description %></td>
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
                    
                    <div id="step-5" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Safety Work Permits</h3>
                            </div>
                            <div class="panel-body">
                                   <div class="table-responsive">  
                                <table id="example4" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th>Description</th>
                                       
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav4 = new Config().ReturnNav();
                                        var queryRisk4 = nav.SafeWorkPermitType;
                                        foreach (var risk in queryRisk4)
                                        {
                                            %>
                                        <tr>
                                            <td><%=risk.Description %></td>
                                           
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
                      <div id="step-6" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Safety WorkGroups</h3>
                            </div>
                            <div class="panel-body">
                                   <div class="table-responsive">  
                                <table id="example5" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                       
                                        <th>Description</th>
                                       
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav2 = new Config().ReturnNav();
                                        var queryRisk2 = nav.SafetyWorkGroup;
                                        foreach (var risk in queryRisk2)
                                        {
                                            %>
                                        <tr>
                                          
                                            <td><%=risk.Description %></td>
                                                          
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
                    <div id="step-7" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Risk Response Strategies</h3>
                            </div>
                            <div class="panel-body">
                                   <div class="table-responsive">  
                                <table id="example6" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th>Description</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav3 = new Config().ReturnNav();
                                        var queryRisk3 = nav.RiskIdentificationMethods;
                                        foreach (var risk in queryRisk3)
                                        {
                                            %>
                                        <tr>
                                            <td><%=risk.Description %></td>                
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


