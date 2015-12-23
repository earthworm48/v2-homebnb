$( document ).on('ready page:load',function(){
	

		FB.login(function(response)
		{
			debugger
		  if (response.session)
		  {
		    // user successfully logged in
		  }
		  else
		  {
		    // user cancelled login
		  }
		}, {perms:'publish_stream'});

		(function(d, s, id) {
		  var js, fjs = d.getElementsByTagName(s)[0];
		  if (d.getElementById(id)) return;
		  js = d.createElement(s); js.id = id;
		  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5&appId=809569919151897";
		  fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
});
