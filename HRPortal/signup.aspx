<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="HRPortal.signup" %>

<!DOCTYPE html>
<html lang="en">
  
 <head>
    <meta charset="utf-8">
    <title>Signup - KASNEB</title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes"> 
    
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />

<link href="css/font-awesome.css" rel="stylesheet">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
    
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/pages/signin.css" rel="stylesheet" type="text/css">

</head>

<body>
	<form id="form1" runat="server">
	<div class="navbar navbar-fixed-top">
	
	<div class="navbar-inner">
		
		<div class="container">
			
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</a>
			
			<a class="brand" href="login.aspx">
				KASNEB			
			</a>		
			
			<div class="nav-collapse">
				<ul class="nav pull-right">
					<li class="">						
						<a href="login.aspx" class="">
							Already have an account? Login now
						</a>
						
					</li>
					<li class="">						
						<a href="login.aspx" class="">
							<i class="icon-chevron-left"></i>
							Back to Homepage
						</a>
						
					</li>
				</ul>
				
			</div><!--/.nav-collapse -->	
	
		</div> <!-- /container -->
		
	</div> <!-- /navbar-inner -->
	
</div> <!-- /navbar -->



<div class="account-container register">
	
	<div class="content clearfix">
		
		
		
			<h1>Create your Account</h1>
            <div  runat="server" id="feedback"></div>			
			
			<div class="login-fields">
				
				
				
				<div class="field">
					First Name:
					<asp:Textbox runat="server" required type="text" id="firstname" name="firstname"  placeholder="First Name" class="login" />
				</div> <!-- /field -->
				<div class="field">
					Middle Name:
					<asp:Textbox runat="server"  type="text" id="middle" name="middle"  placeholder="Middle Name" class="login" />
				</div> <!-- /field -->
				
				<div class="field">
					Last Name:	
					<asp:Textbox runat="server" required type="text" id="lastname" name="lastname"  placeholder="Last Name" class="login" />
				</div> <!-- /field -->
				
				
				<div class="field">
					Email Address:
					<asp:Textbox runat="server" required type="email" id="email" name="email" placeholder="Email" class="login"/>
				</div> <!-- /field -->
				<div class="field">
					Phone Number:
					<asp:Textbox runat="server" required type="text" id="phone" name="phone"  placeholder="Phone Number" class="login"/>
				</div> <!-- /field -->
                <div class="field">
					ID Number/Passport Number:
					<asp:Textbox runat="server" required type="text" id="idNumber" name="idNumber"  placeholder="ID Number/Passport Number" class="login"/>
				</div> <!-- /field -->
                <div class="field">
                    Citizenship:
					<asp:DropDownList runat="server"  id="citizenship" name="citizenship"   class="form-control select2" style="width: 100%;"/>
				</div> <!-- /field -->
                <div class="field">
					Gender:
					<asp:DropDownList runat="server"  type="number" id="gender" name="gender"  class="form-control select2" style="width: 100%; "/>
				</div> <!-- /field -->
				
                

				
			</div> <!-- /login-fields -->
			
			<div class="login-actions">
				
				
					<asp:Checkbox runat="server" class="field login-checkbox" Text="Agree with the Terms & Conditions" ID="agree"/>
					
			
									
			    <asp:Button runat="server" class="button btn btn-primary btn-large" Text="Register" ID="register" OnClick="register_Click"/>
				
			</div> <!-- .actions -->
			
	
		
	</div> <!-- /content -->
	
</div> <!-- /account-container -->


<!-- Text Under Box -->
<div class="login-extra">
	Already have an account? <a href="login.aspx">Login to your account</a>
</div> <!-- /login-extra -->


<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.js"></script>

<script src="js/signin.js"></script>
    	</form>
</body>

 </html>
