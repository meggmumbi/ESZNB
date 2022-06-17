<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResultSlip.aspx.cs" Inherits="HRPortal.ResultSlip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    
    <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">

            <div class="panel-heading">
                <i class="icon-file"></i>
                Result Slip
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Results Slip </a></li>
                            <li class="breadcrumb-item active">Dashboard </li>
                        </ol>
                    </div>
                </div>
                   <asp:Button runat="server" CssClass="btn btn-success pull-right"  Text="Send Result Slip to Student" ID="sendResultSlip" OnClick="sendResultSlip_Click"></asp:Button>
                <div id="feedback" runat="server"></div>
                <br />
                <div class="form-group">
                    <iframe runat="server" class="col-sm-12 col-xs-12 col-md-12 col-lg-12" height="500px" id="p9form" style="margin-top: 10px;"></iframe>
                </div>
            </div>



        </div>
                <div class="panel-footer">
            <a href="ViewExamintionAccountDetails.aspx?regNo=<%=Request.QueryString["No"]%>" class="btn btn-success"><i class="fa fa-arrow-left"></i>Back to Details Page</a>
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="clearfix"></div>
    <script>


        $(document).ready(function () {


        });
    </script>


</asp:Content>
