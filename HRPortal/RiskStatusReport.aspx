<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RiskStatusReport.aspx.cs" Inherits="HRPortal.RiskStatusReport" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

   
       <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 2 || step < 1)
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
    <div class="panel panel-primary">
        <div class="panel-heading">
            Risk Status Report
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#"></a>Home</li>
                        <li class="breadcrumb-item active">Risk Status Report</li>
                    </ol>
                </div>
            </div>
            <div id="ictFeedback" runat="server"></div>
            <div runat="server" id="generalFeedback"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Risk Register Type</strong>
                        <asp:DropDownList ID="riskType" runat="server" CssClass="form-control select2" OnSelectedIndexChanged="riskType_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem>Select</asp:ListItem>
                            <asp:ListItem Value="1">Corporate</asp:ListItem>
                            <asp:ListItem Value="2">Functional (Directorate)</asp:ListItem>
                            <asp:ListItem Value="3">Functional (Department)</asp:ListItem>
                            <asp:ListItem Value="4">Project</asp:ListItem>
                        </asp:DropDownList>
                    </div>


                    <div class="form-group">
                        <strong>Risk Management Plan ID:<span class="text-danger">*</span></strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="riskMngtPlan" />
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="addRiskTReport" OnClick="addRiskTReport_Click" />
                <span class="clearfix"></span>
            </div>
        </div>
    </div>
     <%
        }
        else if (step == 2)
        {
    %>

    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Risk Management Lines</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Risks 
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
             <div runat="server" id="linesFeedback"></div>
            <div class="row" style="justify-content: center">
                <input type="hidden" value="<% =Request.QueryString["requisitionNo"] %>" id="txtAppNo" />
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped tblselectedServices" id="example8">
                            <thead>
                                <tr>



                                    <th></th>
                                    <th>Risk Title</th>
                                    <th>Risk Likelihood rating</th>
                                    <th>Risk Impact Rating</th>
                                    <th>Risk Impact Rating</th>
                                    <th>Risk Impact Type</th>
                                    <th>Risk Status</th>
                                    <th></th>
                                    <th></th>
                                    <th></th>

                                </tr>
                            </thead>
                            <tbody>

                                <% 
                                    var nav = new Config().ReturnNav();
                                    string docNo = Request.QueryString["requisitionNo"].Trim();
                                    var Activities = nav.RiskStatusReportLines.Where(r => r.Document_No == docNo).ToList();
                                    int count = 0;
                                    foreach (var activity in Activities)
                                    {
                                        count++;
                                %>
                                <tr>


                                    <td><%=count %></td>
                                    <td><%=activity.Risk_Title %></td>
                                    <td><%=activity.Risk_Likelihood_Code %></td>
                                    <td><%=activity.Risk_Impact_Code %></td>
                                    <td><%=activity.Risk_Impact_Type %></td>
                                    <td><%=activity.Risk_Status %></td>
                                    <td><a href="RiskOwnership.aspx?DocumentNo=<%=activity.Document_No%>&&DocumentType=<%=activity.Document_Type %>&&RiskId=<%=activity.Risk_ID %>" class="btn btn-success"><i class="fa fa-eye"></i>View Ownership</a></td>
                                     <td><label class="btn btn-default" onclick="CloseRisk('<% =activity.Risk_Title %>','<%=activity.Risk_ID %>');"><i class="fa fa-trash"></i>Close</label></td>
                                     <td><label class="btn btn-success" onclick="RiskResponse('<%=activity.Risk_Title %>','<%=activity.Document_Type %>','<%=activity.Risk_ID %>');" ><i class="fa fa-eye"></i>Risk Response</label></td>



                                    <%}
                                    %>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


        </div>
    </div>

    
    <div class="panel-heading">
        Responses
    </div>
    <div class="panel-body">
        <div class="table-responsive">
            <table id="example4" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th></th>

                        <th>Risk Description</th>
                        <th>Risk Mitigation Strategy</th>
                        <th> Risk Response Action Taken</th>
                        <th>Responsible Officer Name</th>

                    </tr>
                </thead>
                <tbody>
                    <%


                        string requisitionNo = Request.QueryString["requisitionNo"];
                        int counter = 0;
                        var data = nav.RMPLineResponseActions.Where(r => r.Document_No == requisitionNo && r.Activity_Description != "").ToList();
                        if (data.Count > 0)
                        {

                            foreach (var item in data)
                            {
                                counter++;

                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><% =item.Risk_Title%></td>
                        <td><% =item.Activity_Description%></td>
                        <td><% =item.Risk_Response_Action_Taken %></td>
                        <td><% =item.Responsible_Officer_Name %></td>
                       
                        <%
                            }
                        }
                        %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="panel-footer">        
      
        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="back" OnClick="back_Click" />       
        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit" OnClick="post_Click" id="post"/>
        <div class="clearfix"></div>
    </div>
    
    <%
        }
    %>
     <script>
         function CloseRisk(itemName, lineNo) {
            document.getElementById("itemName").innerText = itemName;
            document.getElementById("ContentPlaceHolder1_lineNo").value = lineNo;
           
            $("#removeLineModal").modal();
        }
    </script>
     <script>
         function RiskResponse(riskTitle,docType, lineNo) {
             document.getElementById("ContentPlaceHolder1_riskT").value = riskTitle;
             document.getElementById("ContentPlaceHolder1_originalNo").value = docType;
             document.getElementById("ContentPlaceHolder1_originalWorkType").value = lineNo;
           
            $("#editTeamMemberModal").modal();
        }
    </script>
    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Close Risk</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to Close Risk item <strong id="itemName"></strong>?</p>
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                   
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Close Risk" OnClick="deleteLine_Click" />
                </div>
            </div>

        </div>
    </div>
         <div id="editTeamMemberModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Risk Response</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="originalNo" type="hidden"/>
          <asp:TextBox runat="server" ID="originalWorkType"   type="hidden"/>
          <div class="form-group">
              <strong>Risk Title:</strong>
              <asp:TextBox runat="server" CssClass="form-control" ID="riskT" ReadOnly/>
          </div>
      <div class="form-group">
            <strong>Risk Mitigation Strategy:</strong>
            <asp:TextBox runat="server" CssClass="form-control" placeholder="MitigationStrategy" ID="mitigationStrat"/>
        </div>
       <div class="form-group">
            <strong>Risk Response Action Taken:</strong>
            <asp:TextBox runat="server" CssClass="form-control" placeholder="Action Taken" ID="riskAction"/>
        </div>
          <div class="form-group">
            <strong>Responsible Officer:</strong>
            <asp:DropDownList runat="server" CssClass="form-control select" ID="Officer"/>
        </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Risk Responce" OnClick="editTeamMember_Click"/>
      </div>
    </div>

  </div>
</div>



</asp:Content>
