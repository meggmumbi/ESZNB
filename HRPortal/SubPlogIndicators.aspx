<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubPlogIndicators.aspx.cs" Inherits="HRPortal.SubPlogIndicators" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <section class="content-header">
        <h1>Performance Log Sub Indicators
        </h1>
        <ol class="breadcrumb" style="background-color: antiquewhite">
            <li><a href="Dashboard.aspx"><i class="fa fa-dashboard"></i>Plog</a></li>
            <li><a href="imprest.aspx">Sub Plog lines</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
               Sub Indicators
            </div>
            <div class="panel-body">
            <div runat="server" id="FeedBack"></div> 
             <h4 style="color:blue"><%=Request.QueryString["description"] %></h4> <hr />    
                   <div class="table-responsive">     
               <table id="example5" class="table table-bordered table-striped PlogSubIndicatorTable">
                    <thead>
                        <tr>
                            <th style="display:none">LineNo</th>
                            <th style="display:none">PlogNo</th>
                            <th style="display:none">InitiativeNo</th>
                            <th style="display:none">PCID</th>
                            <th>Description</th>
                            <th>Achieved Date</th>
                            <th>Target Qty</th>
                            <th>Weight</th>
                            <th>Achieved Qty</th>
                            <th>Comments</th>
                            
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            var PlogNo = Request.QueryString["PlogNo"];
                            var InitiativeNo = Request.QueryString["InitiativeNo"];
                            var PCID = Request.QueryString["PCID"];

                            var nav = new Config().ReturnNav();
                            var AllData = nav.SubPlogLines.Where(x => x.PLog_No == PlogNo && x.Initiative_No == InitiativeNo && x.Personal_Scorecard_ID == PCID).ToList();
                            foreach (var item in AllData)
                            {
                            %>
                            <tr>
                                <td style="display:none"><% =item.EntryNo %></td>
                                <td style="display:none"><% =PlogNo %></td>
                                <td style="display:none"><% =InitiativeNo %></td>
                                <td style="display:none"><% =PCID %></td>
                                <td><% = item.Description%></td>
                                <td><% = Convert.ToDateTime(item.Achieved_Date).ToString("d/MM/yyyy")%></td>
                                <td><% = item.Target_Qty%></td>
                                <td><% = item.Weight%></td>
                                <td><input style="width: 5em;" type="number" step="any" autocomplete="off" value="<% =item.Achieved_Target%>"/></td>
                                <td><input style="width: 10em;" type="text" autocomplete="off" value="<% =item.Comments%>"/></td>    
                            <%
                                }
                            %>
                    </tbody>
                </table>
                       </div>
                <center>
                        <input type="button" id="btnSaveSubPlogLines" class="btn btn-success btnSaveSubPlogLines" value="Save Details" />                           
                    <div class="clearfix"></div>
                </center><br />

        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed_Click"/>
            <div class="clearfix"></div>
        </div>
      </div>
    </div>
    </section>
</asp:Content>