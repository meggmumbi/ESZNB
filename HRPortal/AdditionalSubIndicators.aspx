<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdditionalSubIndicators.aspx.cs" Inherits="HRPortal.AdditionalSubIndicators" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:content id="Content1" contentplaceholderid="head" runat="server">
</asp:content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="server">
        <div class="panel panel-primary">
        <div class="panel-heading">Sub Initiatives
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
              <div class="row" >
            <div class="col-md-6 col-lg-6">
            <div class="form-group">
                <strong>Sub-Initiative:</strong>
                <asp:TextBox runat="server" ID="subinitiative" CssClass="form-control" placeholder="Enter Sub-Initiative"/>
            </div>
            <div class="form-group">
                <strong>Sub-Indicator:</strong>
                <asp:TextBox runat="server" ID="subindicator" CssClass="form-control" placeholder="Enter Sub-Indicator"/>
            </div>
            </div>
            <div class="col-md-6 col-lg-6">
             <div class="form-group">
                <strong>Unit of Measure:</strong>
                <asp:DropDownList runat="server" ID="uom" CssClass="form-control select2" AppendDataBoundItems="true">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
                <div class="form-group">
                    <strong>Completion Date:</strong>
                       <asp:TextBox runat="server" ID="startdate" CssClass="form-control" placeholder="" TextMode="Date" /> 
               </div>         
           </div>
           <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Target:</strong>
                 <asp:TextBox runat="server" ID="target" CssClass="form-control" placeholder="Enter Target"/>
                </div>          
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Assigned Weight:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="nassignedweight" TextMode="Number" />
                </div>          
            </div>
            <div class="col-md-12 col-lg-12">
                <center>
                    <asp:Button runat="server" ID="apply" CssClass="btn btn-success" Text="Submit Sub Indicator" OnClick="apply_Click"/>
                <div class="clearfix"></div>
                </center>
            </div>
         </div>
        </div>
        <div class="panel-footer">
            <span class="clearfix"></span>
        </div>
            <div class="table-responsive">               
            <table id="example3" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Sub-Initiative</th>
                    <th>Sub-Indicator</th>
                    <th>Unit of Measure</th>
                    <th>Target</th>
                    <%--<th>Assigned Weight</th>--%>
                    <th>Completion Date</th>
                    <th>Remove</th>
                </tr>
                </thead>
                <tbody>
                <%
                    var nav = new Config().ReturnNav();
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    String ScoreCardId = Convert.ToString(Session["IndividualPCNo"]);
                    string ActivityNo = Convert.ToString(Request.QueryString["ActivityNo"]);
                    var subactivities = nav.SubPCObjective.Where(r => r.Initiative_No == ActivityNo && r.Workplan_No == ScoreCardId);
                    foreach (var subactivity in subactivities)
                    {
                     %>
                    <tr>
                        <td><%=subactivity.Objective_Initiative %></td>
                        <td><%=subactivity.Outcome_Perfomance_Indicator %></td>
                        <td><%=subactivity.Unit_of_Measure %></td>
                        <td><% =subactivity.Imported_Annual_Target_Qty%></td>
                        <%--<td><% =subactivity.Assigned_Weight%></td>--%>
                        <td><% =Convert.ToDateTime(subactivity.Due_Date ).ToString("dd/MM/yyyy")%></td>
                        <td><label class="btn btn-success" onclick="editsubindicator('<%=subactivity.Entry_Number%>','<%=subactivity.Objective_Initiative%>','<%=subactivity.Outcome_Perfomance_Indicator%>','<%=subactivity.Unit_of_Measure%>','<%=subactivity.Due_Date%>','<%=subactivity.Imported_Annual_Target_Qty%>','<%=subactivity.Initiative_No%>','<%=subactivity.Imported_Annual_Target_Qty%>');"><i class="fa fa-edit"></i>Edit</label></td>
                        <td><label class="btn btn-danger" onclick="DeleteSubInitiative('<%=subactivity.Entry_Number %>');"><i class="fa fa-trash-o"></i> Remove</label></td>
                      
                    </tr>
                            <%
                                }
                     %>
                </tbody>             
            </table>
                </div>
        </div>
        <br />
        <asp:Button runat="server" ID="PreviousPage" CssClass="btn btn-warning pull-left" Text="Previous Page" OnClick="PreviousPage_Click"/>
         
  <div id="removeSubActivity" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Individual Score Card Sub Activity</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="subactivityEntryNo" type="hidden"/>
         Are you sure you want to send Remove Sub Activity ? 
        </div>

      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-success" Text="Remove Sub-Activity" OnClick="deleteSubActity_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      </div>
    </div>

  </div>
</div>

<div id="editSubIndicatorsModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Edit Sub Indicator</h4>
            </div>
            <div class="modal-body">
                <asp:TextBox runat="server" ID="originalLine" type="hidden" />
                <asp:TextBox runat="server" ID="initiativeno" type="hidden" />
                <div class="form-group">
                    <strong>Sub-Initiative:</strong>
                    <asp:TextBox runat="server" CssClass="form-control"  ID="editsubinitiative" />
                </div>

                <div class="form-group">
                    <strong>Sub-Indicator:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="editsubindicator" />
                </div>
                <div class="form-group">
                    <strong>Unit of Measure:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="edituom" style="width:570px" />
                </div>
                <div class="form-group">
                    <strong>Completion Date:</strong>
                    <asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" ID="editcompletiondate"/>
                </div>
                <div class="form-group">
                    <strong>Target:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="edittarget" TextMode="Number" />
                </div>
                <div class="form-group">
                    <strong>Assigned Weight:</strong>
                    <asp:TextBox runat="server" CssClass="form-control" ID="nassignedweight1" TextMode="Number" />
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Sub Indicator" ID="editsubindicatorbutton" OnClick="editsubindicatorbutton_Click" />
            </div>
        </div>

    </div>
</div>
<script>
    function DeleteSubInitiative(entryNumber) {
        document.getElementById("ContentPlaceHolder1_subactivityEntryNo").value = entryNumber;
        $("#removeSubActivity").modal();
    }
</script> 

<script>
    function editsubindicator(lineNo, subnitiative, subindicator, uom, cdate, target, tno, assWeight) {
        document.getElementById("ContentPlaceHolder1_originalLine").value = lineNo;
        document.getElementById("ContentPlaceHolder1_initiativeno").value = tno;
        document.getElementById("ContentPlaceHolder1_editsubinitiative").value = subnitiative;
        document.getElementById("ContentPlaceHolder1_editsubindicator").value = subindicator;
        document.getElementById("ContentPlaceHolder1_edituom").value = uom;
        document.getElementById("ContentPlaceHolder1_nassignedweight1").value = assWeight;
        //document.getElementById("ContentPlaceHolder1_editcompletiondate").value = cdate;
        document.getElementById("ContentPlaceHolder1_edittarget").value = target;
        var nowstartdate = cdate.split(' ')[0];
        $('#ContentPlaceHolder1_editcompletiondate').datepicker({ dateFormat: 'mm/dd/yyyy' }, "update").val(nowstartdate);
        $("#editSubIndicatorsModal").modal();
    }
</script>
</asp:content>
