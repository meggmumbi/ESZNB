<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPass.aspx.cs" Inherits="HRPortal.ForgotPass" %>


<!DOCTYPE html>
<html lang="en">
  
<head>
    <meta charset="utf-8">
    <title>Forgot Pass - kasneb</title>

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
		
		
			<h1>Reset Password/First time use</h1>		
        <div runat="server" id="feedback"></div>
			
			<div class="login-fields">
				
				
				
				<div class="field">
					<label for="username">Staff Number/ID Number</label>
					<asp:Textbox runat="server" type="text" id="username" name="username" value="" placeholder="Staff Number/ID Number" cssClass="login username-field" required />
				</div> <!-- /field -->
				<%--<div class="field">
                    Prove you are not a robot <sup>*</sup>
                    <div class="g-recaptcha" data-sitekey="6Ld4LScUAAAAADuGShD198FZNCL8FSzwqw8arOSC" style="display: block; margin: auto;"></div>
                </div>--%>
				
			</div> <!-- /login-fields -->
			
			<div class="login-actions">

			    <asp:Button runat="server" class="button btn btn-success btn-large" Text="Reset Password" OnClick="Unnamed1_Click"/>
				
			</div> <!-- .actions -->
			
			
		</div> <!-- /content -->
	
</div> <!-- /account-container -->



<div class="login-extra">
	<a href="Login.aspx">Login</a>
</div> <!-- /login-extra -->


<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.js"></script>

<script src="js/signin.js"></script>
<script src="https://www.google.com/recaptcha/api.js"></script>
</form>
</body>

</html>
