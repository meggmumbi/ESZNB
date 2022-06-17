<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PostedImprestMemo.aspx.cs" Inherits="HRPortal.PostedImprestMemo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="span12">
    <div class="widget">
        
            <div class="widget-header"> <i class="icon-file"></i>
              <h3>Posted Imprest Memo</h3>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
                <div id="feedback" runat="server"></div>
           <%--  <div class="form-group">
                 <label>Employee No</label>
                 <asp:TextBox CssClass="form-control" ID="empNo" runat="server" AutoPostBack="True"/>
             <%--<asp:DropDownList CssClass="form-control select2" ID="payperiod" runat="server"/>--%>
             </div>--%>
               <%--<div class="com-md-3 col-lg-3">
                     <br/>
                 <asp:Button CssClass="btn btn-success" ID="generatePayslip" runat="server" Text="Generate" OnClick="generatePayslip_Click"/>
             </div> 
                <br />--%>

             <div class="form-group">
                 <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" ID="payslipFrame" style="margin-top: 10px;" ></iframe>
                    </div>
            
            </div>
            <!-- /widget-content --> 
          </div>
        </div>
    <div class="clearfix"></div>

</asp:Content>
