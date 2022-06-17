<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubPlogIndicatorsApproved.aspx.cs" Inherits="HRPortal.SubPlogIndicatorsApproved" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="panel panel-primary">
            <div class="panel-heading">
                Performance Update Sub Indicators 
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                   <div class="table-responsive">  
                 <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Description</th>
                            <th>Achieved Date</th>
                            <th>Target Qty</th>
                            <th>Achieved Qty</th>
                            <th>Comments</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                        var PlogNo = Request.QueryString["PlogNo"]; 
                        var InitiativeNo = Request.QueryString["InitiativeNo"];  
                        var PCID = Request.QueryString["PCID"]; 

                            string AllData = Config.ObjNav.FnGetSubPlogLines2(PlogNo, InitiativeNo, PCID);
                            String[] info = AllData.Split(new string[] { ":" }, StringSplitOptions.RemoveEmptyEntries);
                            if (info != null)
                            {
                                foreach (var allInfo in info)
                                {
                                    String[] arr = allInfo.Split('*');
                                    %>
                                    <tr>
                                        <td><% = arr[1]%></td>
                                        <td><% = arr[2]%></td>
                                        <td><% = arr[3]%></td>
                                        <td><% =arr[4]%></td>
                                        <td><% =arr[5]%></td>
                                    </tr>
                                    <% 
                                }
                            }
                        %>
                    </tbody>
                </table>
                       </div>
            </div>          
        </div> 
</asp:Content>

