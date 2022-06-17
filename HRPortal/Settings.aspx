<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="HRPortal.Settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="col-md-8 col-lg-8">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Change your Account Password
            </div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="form-group">
                    <strong>Current Password:</strong>
                    <asp:Textbox runat="server" CssClass="form-control" placeholder="Current Password" TextMode="Password" ID="currentPassword"/>
                </div>
           
                 <div class="form-group">
                    <strong>New Password:</strong>
                    <asp:Textbox runat="server" CssClass="form-control" placeholder="New Password" TextMode="Password" ID="newPassword"/>
                </div>
           
                 <div class="form-group">
                    <strong>Confirm Password:</strong>
                    <asp:Textbox runat="server" CssClass="form-control" placeholder="Confirm Password" TextMode="Password" ID="confirmPassword"/>
                </div>
           
                 </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Password" OnClick="Unnamed1_Click"/>
                <div class="clearfix"></div>
            </div>
        </div>
                </div>
        </div>
    </div>
</asp:Content>
