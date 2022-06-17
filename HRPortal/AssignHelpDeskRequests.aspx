<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssignHelpDeskRequests.aspx.cs" Inherits="HRPortal.AssignHelpDeskRequests" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Assign ICT Help Desk Request  
            <span class="pull-right"></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="ictFeedback" runat="server"></div>
              <div class="row" >
        <div class="col-md-6 col-lg-6">
            
            <div class="form-group">
                <strong>Assignee:</strong>
                <asp:DropDownList CssClass="form-control select2" runat="server" ID="Assignee"/>
            </div>
            
            </div>
            
      </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Assign
                " ID="addAssignee" OnClick="addAssignee_Click"/>
            <span class="clearfix"></span>
        </div>
    </div>

</asp:Content>
