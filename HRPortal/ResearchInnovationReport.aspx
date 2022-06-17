<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResearchInnovationReport.aspx.cs" Inherits="HRPortal.ResearchInnovationReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="row" style="width: 100%; margin: auto;">
    <div class="panel panel-primary">
        
            <div class="panel-heading"> <i class="icon-file"></i>
           Innovation Response Report
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div class="row">
                <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">report </a></li>
                            <li class="breadcrumb-item active">Innovation Portal  </li>
                        </ol>
                    </div>
            </div>
                <div id="feedback" runat="server"></div>
           <%--<div class="com-md-4 col-lg-4">
                 <label>Request Date:</label>
                 <asp:Textbox CssClass="form-control" ID="startDate1"  runat="server" type="date"/>
             </div>--%>
              <%--   <div class="com-md-4 col-lg-4">
                 <label>End Date:</label>
                 <asp:Textbox CssClass="form-control" ID="endDate1"  runat="server" type="date"/>
             </div>
                 <div class="com-md-3 col-lg-3">
                     <br/>
                 <asp:Button CssClass="btn btn-success" ID="generate" runat="server" Text="Generate" OnClick="generate_Click"/>
             </div>--%>
                <br/>
                <div class="form-group">
                 <iframe runat="server" class="col-md-12" height="500px" ID="p9form" style="margin-top: 10px;" ></iframe>
                    </div>
                </div>
               
            
         
          </div>
        </div>
    <div class="clearfix"></div>
     <script>
            
       
            $(document).ready(function () {
               

            });
        </script>
</asp:Content>
