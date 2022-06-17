<%@ Page Title="Payslip" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="payslip.aspx.cs" Inherits="HRPortal.payslip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* CSS for responsive iframe */
/* ========================= */

/* outer wrapper: set max-width & max-height; max-height greater than padding-bottom % will be ineffective and height will = padding-bottom % of max-width */
#Iframe-Master-CC-and-Rs {
  max-width: 512px;
  max-height: 100%; 
  overflow: hidden;
}

/* inner wrapper: make responsive */
.responsive-wrapper {
  position: relative;
  height: 0;    /* gets height from padding-bottom */
  
  /* put following styles (necessary for overflow and scrolling handling on mobile devices) inline in .responsive-wrapper around iframe because not stable in CSS:
    -webkit-overflow-scrolling: touch; overflow: auto; */
  
}
 
.responsive-wrapper iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  
  margin: 0;
  padding: 0;
  border: none;
}

/* padding-bottom = h/w as % -- sets aspect ratio */
/* YouTube video aspect ratio */
.responsive-wrapper-wxh-572x612 {
  padding-bottom: 107%;
}

/* general styles */
/* ============== */
.set-border {
  border: 5px inset #4f4f4f;
}
.set-box-shadow { 
  -webkit-box-shadow: 4px 4px 14px #4f4f4f;
  -moz-box-shadow: 4px 4px 14px #4f4f4f;
  box-shadow: 4px 4px 14px #4f4f4f;
}
.set-padding {
  padding: 40px;
}
.set-margin {
  margin: 30px;
}
.center-block-horiz {
  margin-left: auto !important;
  margin-right: auto !important;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="span12">
        <div class="widget">

            <div class="widget-header">
                <i class="icon-file"></i>
                <h3>Generate Payslip</h3>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
                <div id="feedback" runat="server"></div>
                <div class="form-group">
                    <label>Pay Period</label>
                    <asp:DropDownList CssClass="form-control select2" ID="payperiod" runat="server" AutoPostBack="True" OnSelectedIndexChanged="payperiod_SelectedIndexChanged" />
                    <%--<asp:DropDownList CssClass="form-control select2" ID="payperiod" runat="server"/>--%>
                </div>
                <%--<div class="com-md-3 col-lg-3">
                     <br/>
                 <asp:Button CssClass="btn btn-success" ID="generatePayslip" runat="server" Text="Generate" OnClick="generatePayslip_Click"/>
             </div> 
                <br />--%>
                <div class="responsive-wrapper responsive-wrapper-wxh-572x612" style="-webkit-overflow-scrolling: touch; overflow: auto;">
                    <div id="Iframe-Master-CC-and-Rs" class="set-margin set-padding set-border set-box-shadow center-block-horiz">

                        <iframe runat="server" height="500px" id="payslipFrame" style="margin-top: 10px;"></iframe>


                    </div>
                </div>
                <!-- /widget-content -->
            </div>
    </div>
        </div>
    <div class="clearfix"></div>
</asp:Content>
