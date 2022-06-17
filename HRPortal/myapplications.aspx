<%@ Page Title="My Applications" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="myapplications.aspx.cs" Inherits="HRPortal.myapplications" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% var nav = new Config().ReturnNav(); %>
    <%
        int Count = 0;
        int totalCount = 0;
        //bool Closed_Application = false;

        //var pst = nav.VacantPositions.Where(x=>x.Closed_Application == false);
        //foreach (var position in pst)
        //{
        //    Closed_Application = Convert.ToBoolean( position.Closed_Application);
        //}

         %>
    <div class="span12">
        <div runat="server" id="doc"></div>
          <div class="widget widget-table action-table">
            <div class="widget-header"> <i class="icon-th-list"></i>
              <h3>My Job Applications</h3>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
                   <div class="table-responsive">  
              <table class="table table-striped table-bordered">
                <thead>
                  <tr>
                    <th>APPLICATION NUMBER</th>
                    <th> DATE APPLIED</th>
                    <th> JOB APPLIED FOR</th>
                      <th> Number of Applicant</th>
                     
                  </tr>
                </thead>
                <tbody>
                <%
                    var positions = nav.MyJobApplications.Where(r=>r.ID_Number==(String) Session["idNo"]);
                    foreach (var position in positions)
                    {
                        %>
                     <tr>
                         <td>
                            
                                 <% if(position.Closed_Application == false)
                                    
                           {  %>
                  <a href="ApplicationFormEdit.aspx?appNo=<%=position.Application_No %>"><%=position.Application_No %></a>
                                   <%
                                     }
                                      %>
                                     <%
                                     else
                                     {
                                     %>
                                        <%=position.Application_No %>
                                     <%
                                       }
                                       %>
                                 
                         </td>
                   <%-- <td><a href="ApplicationFormEdit.aspx?appNo=<%=position.Application_No %>"><%=position.Application_No %></a> </td>--%>
                     
                    <td><%=Convert.ToDateTime(position.Date_Applied).ToString("dd/MM/yyyy") %></td>
                    <td><%=position.Job_Applied_For %></td>
                     
                        
               <%
                   var post = nav.MyJobApplications.Where(r => r.Job_Applied_For == position.Job_Applied_For);
                   foreach(var item in post)
                   {  %>

                         <%Count++; 
                         
                                 %>

                 <% } %>
                      
                 <td><%=Count %> </td>
                         

                     </tr>
                    <%
                    }
                     %>
                 
                 
                
                </tbody>
              </table>
                       </div>
            </div>
            <!-- /widget-content --> 
          </div>
          <!-- /widget --> 
       
    </div>
     <div class="clearfix"></div>
</asp:Content>
