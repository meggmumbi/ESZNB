<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RiskManagementFramework.aspx.cs" Inherits="HRPortal.RiskManagementFramework" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <div class="panel panel-primary">
        <div class="panel panel-heading">
            <h3 class="panel-title">Risk Mnagement Framework</h3>
        </div> 
        <br />
        <div>
          <asp:Button runat="server" ID="Button1" CssClass="btn btn-success" style ="margin-left:90%" Text="Print Report" OnClick="printriskreport_Click"/>
        </div>
        <br />
            <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#step-1" data-toggle="tab"   <h3 class="panel-title" style="color:black">General Details</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#step-2" data-toggle="tab"><h3 class="panel-title" style="color:black">Risk Framework Overview</h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#step-3" data-toggle="tab"><h3 class="panel-title" style="color:black">Purpose/Objective </h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#step-4" data-toggle="tab"><h3 class="panel-title" style="color:black">Guiding Principles </h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#step-5" data-toggle="tab"><h3 class="panel-title" style="color:black">Risk Taxonomy </h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#step-6" data-toggle="tab"><h3 class="panel-title" style="color:black">Risk Response Strategies </h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#step-7" data-toggle="tab"><h3 class="panel-title" style="color:black">Risk Identification Methods </h3></a>
                        </li>
                    </ul>
               </ul>
            <div class="tab-content">
                <div id="step-1" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">Risk Mnagement Framework General Details</h3>
                        </div>
                           <div class="panel-body">
                             <div class="row">
                                <div class="col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <strong>Description:</strong>                     
                                        <asp:TextBox runat="server" ID="description" CssClass="form-control" ReadOnly="true"/>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <strong>Primary Purpose:</strong>                     
                                        <asp:TextBox runat="server" ID="primarypurpose" CssClass="form-control" ReadOnly="true"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <strong>External Document Number:</strong>                     
                                        <asp:TextBox runat="server" ID="documentnumber" CssClass="form-control" ReadOnly="true"/>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <strong>Overall Responsibility:</strong>                     
                                        <asp:TextBox runat="server" ID="responsinbility" CssClass="form-control" ReadOnly="true"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <strong>Organization Name:</strong>                     
                                        <asp:TextBox runat="server" ID="Organizationname" CssClass="form-control" ReadOnly="true"/>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <div class="form-group">
                                        <strong>Last Revision Date:</strong>                     
                                        <asp:TextBox runat="server" ID="revisiondate" CssClass="form-control" ReadOnly="true"/>
                                    </div>
                                </div>
                            </div>
                        </div> 
                    </div>
                  </div>
                    <div id="step-2" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Risk Framework Overview</h3>
                            </div>
                            <div class="panel-body">
                                <table id="example1" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th>Overview Description</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav = new Config().ReturnNav();
                                        var queryRisk = nav.Overview.Where(x => x.RMF_Section == "RMF Overview");
                                        foreach (var risk in queryRisk)
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
                    <div id="step-3" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Purpose/Objective</h3>
                            </div>
                            <div class="panel-body">                  
                                <table id="example2" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <%--<th>Name</th>--%>
                                        <th>Description</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav5 = new Config().ReturnNav();
                                        var queryRisk5 = nav.Overview.Where(x => x.RMF_Section == "Benefits/Importance");
                                        foreach (var risk in queryRisk5)
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
                    <div id="step-4" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Guiding Principles</h3>
                            </div>
                            <div class="panel-body">
                                <table id="example3" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                       <%-- <th>Risk Management Framework Section</th>--%>
                                        <th>Description</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav1 = new Config().ReturnNav();
                                        var queryRisk1 = nav.Overview.Where(x => x.RMF_Section == "RMF Guiding Principle");
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
                    
                    <div id="step-5" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Risk Taxonomy</h3>
                            </div>
                            <div class="panel-body">
                                <table id="example4" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th>Description</th>
                                        <th>Additional Comments</th>
                                        <th>Number Of Strategies</th>
                                        <th>Number Of Operational Risks</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav4 = new Config().ReturnNav();
                                        var queryRisk4 = nav.RiskCategory;
                                        foreach (var risk in queryRisk4)
                                        {
                                            %>
                                        <tr>
                                            <td><%=risk.Description %></td>
                                            <td><%=risk.Addditiona_Comments %></td>
                                            <td><%=risk.No_of_Strategic_Risks %></td> 
                                            <td><%=risk.No_of_Operational_Risks %></td> 
                                        </tr>
                                                <%
                                                    }
                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                      <div id="step-6" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Risk Response Strategies</h3>
                            </div>
                            <div class="panel-body">
                                <table id="example5" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th>Risk Impact Type</th>
                                        <th>Description</th>
                                        <th>Additional Comments</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        var nav2 = new Config().ReturnNav();
                                        var queryRisk2 = nav.RiskResponceStrategy;
                                        foreach (var risk in queryRisk2)
                                        {
                                            %>
                                        <tr>
                                            <td><%=risk.Risk_Impact_Type %></td>
                                            <td><%=risk.Description %></td>
                                            <td><%=risk.Additional_Comments %></td>                   
                                        </tr>
                                                <%
                                                    }
                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="step-7" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Risk Response Strategies</h3>
                            </div>
                            <div class="panel-body">
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

</asp:Content>
