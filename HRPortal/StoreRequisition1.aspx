<%@ Page Title="Store Requisition" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StoreRequisition1.aspx.cs" Inherits="HRPortal.StoreRequisition1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- location code, description,  -->
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step>2||step<1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        if (step==1)
        {
           %>
    <!--location code, description, -->
    <div class="panel panel-primary">
        <div class="panel-heading">
            General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Location:</strong>
                        <asp:DropDownList runat="server" ID="location" CssClass="form-control select2"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Description:</strong>
                        <asp:TextBox runat="server" ID="description" CssClass="form-control" placeholder="Description"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
             <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next"/>
            <div class="clearfix"></div>
        </div>
    </div>
            <% 
        }else if (step==2)
        {
               %>
     <div class="panel panel-primary">
        <div class="panel-heading">
            Store Requisition Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i> Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Budget:</strong>
                    <asp:DropDownList runat="server" ID="budget" CssClass="form-control select2"/>
                </div>
            </div>
             <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Procurement Plan Item:</strong>
                    <asp:DropDownList runat="server" ID="procurementPlanItem" CssClass="form-control select2"/>
                </div>
            </div>

            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Item Category:</strong>
                    <asp:DropDownList runat="server" ID="itemCategory" CssClass="form-control select2"/>
                </div>
            </div>
             <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Item:</strong>
                    <asp:DropDownList runat="server" ID="item" CssClass="form-control"/>
                </div>
            </div>
             <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Quantity Requested:</strong>
                    <asp:TextBox runat="server" ID="quantityRequested" CssClass="form-control" placeholder="Quantity Requested"/>
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <br/>
                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Item"/>
                    </div>
                    </div>
               <div class="table-responsive">  
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Budget</th>
                    <th>Procurement Plan Item</th>
                    <th>Item Category</th>
                    <th>Item </th>
                    <th>Quantity Requested </th>
                    <th>Edit </th>
                    <th>Remove </th>
                </tr>
                </thead>
            </table>
                   </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request"/>
            <div class="clearfix"></div>
        </div>
    </div>
        <% 
        }
         %>
</asp:Content>
