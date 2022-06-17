<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="HRPortal.Login" %>
<%@ Import Namespace="System.Globalization" %>


<!DOCTYPE html>
<html lang="en">
  
<head>
    <meta charset="utf-8">
    <title>Login - kasneb</title>
    
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes"> 
    
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />

<link href="css/font-awesome.css" rel="stylesheet">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
    
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/pages/signin.css" rel="stylesheet" type="text/css">
    <style>
        
        #loader {
            border: 12px solid #f3f3f3;
            border-radius: 50%;
            border-top: 12px solid #444444;
            width: 70px;
            height: 70px;
            animation: spin 1s linear infinite;
        }
          
        @keyframes spin {
            100% {
                transform: rotate(360deg);
            }
        }
          
        .center {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
        }
    </style>
     <script>
        document.onreadystatechange = function() {
            if (document.readyState !== "complete") {
                document.querySelector(
                  "body").style.visibility = "hidden";
                document.querySelector(
                  "#loader").style.visibility = "visible";
            } else {
                document.querySelector(
                  "#loader").style.display = "none";
                document.querySelector(
                  "body").style.visibility = "visible";
            }
        };
    </script>
   

</head>

<body>
    <div id="loader" class="center"></div>
	 <form id="form1" runat="server">
	<div class="navbar navbar-fixed-top" >
	
	<div class="navbar-inner">
		
		<div class="container">
			
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</a>
			
			<a class="brand" href="login.aspx">
				kasneb
			</a>		
			
			<div class="nav-collapse">
				<ul class="nav pull-right">
					
					<li class="">						
						<a href="signup.aspx" class="">
							Don't have an account?
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



<div class="account-container">
	
	<div class="content clearfix">
		
		
			<h1>Staff Login</h1>		
        <div  runat="server" id="feedback"></div>
			
			<div class="login-fields">
				
				
			
				<div class="field">
					<label for="username">Staff No/Id Number:</label>
					<asp:Textbox runat="server" type="text" id="username" name="username" value="" placeholder="Staff No/Id Number" cssClass="login username-field" required />
				</div> <!-- /field -->
				
				<div class="field">
					<label for="password">Password:</label>
					<asp:Textbox runat="server" type="password" id="password" name="password" value="" placeholder="Password" CssClass="login password-field" required/>
				</div> <!-- /password -->
				 
			</div> 
         <%-- <div class="field">
                    Prove you are not a robot <sup>*</sup>
                    <div class="g-recaptcha" data-sitekey="6Ld4LScUAAAAADuGShD198FZNCL8FSzwqw8arOSC" style="display: block; margin: auto;"></div>
                </div>--%>
			
			<div class="login-actions">

			    <asp:Button runat="server" class="button btn btn-success btn-large" Text="Log In" OnClick="Unnamed1_Click"/>
				
			</div> <!-- .actions -->
			
			
		</div> <!-- /content -->
	
</div> <!-- /account-container -->



<div class="login-extra">
	<a href="ForgotPass.aspx">Reset Password</a>
</div> <!-- /login-extra -->


<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.js"></script>

<script src="js/signin.js"></script>
 <script src="https://www.google.com/recaptcha/api.js"></script>
</form>
</body>

</html>
