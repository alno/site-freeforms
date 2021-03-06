ui = {
	initIndex : function() {
						        
        $('#new_user').validate({
        	rules: {
        		'user[password]': {
        			required: true,
        			minlength: 5
        		},
        		'user[password_confirmation]': {
        			required: true,
        			minlength: 5,
        			equalTo: "#user_password"
        		},
        		'user[email]': {
        			required: true,
        			email: true
        		}
        	},
        	messages: {
        		'user[password]': {
        			required: "Введите пароль",
        			minlength: "Пароль должен быть не короче 5 символов"
        		},
        		'user[password_confirmation]': {
        			required: "Подтвердите пароль",
        			minlength: "Пароль должен быть не короче 5 символовg",
        			equalTo: "Подтверждение пароля не совпадает с введенным паролем"
        		},
        		'user[email]': "Введите корректный E-Mail"
        	}
		});		
		
		$("#register_tabs").tabs("#register_panes > div");
	},
	
	initSetPassword : function() {
		$('#set_password_form').validate({			
        	rules: {
        		'user[password]': {
        			required: true,
        			minlength: 5
        		},
        		'user[password_confirmation]': {
        			required: true,
        			minlength: 5,
        			equalTo: "#user_password"
        		}
        	},			
        	messages: {				
        		'user[password]': {
        			required: "Введите пароль",
        			minlength: "Пароль должен быть не короче 5 символов"
        		},
        		'user[password_confirmation]': {
        			required: "Подтвердите пароль",
        			minlength: "Пароль должен быть не короче 5 символовg",
        			equalTo: "Подтверждение пароля не совпадает с введенным паролем"
        		}
        	}
		});
	},
	
	initShowForm : function( selectedTab ) {		
		function preview() {
			var p = $('#form-preview');
			p.html('<iframe src="' + p.attr('code') + '" style="width:100%;height:500px;border:none;" />');
		}
				
		if ( selectedTab == '#form-description' ) selectedTab = 0;
		else if ( selectedTab == '#form-fields' ) selectedTab = 1;
		else if ( selectedTab == '#form-style' ) selectedTab = 2;
		else if ( selectedTab == '#form-code' ) selectedTab = 3;
		else if ( selectedTab == '#form-preview' ) {
			selectedTab = 4;
			preview();
		} else {
			selectedTab = parseInt( selectedTab );
		}
				
		$("#form_tabs").tabs("#form_panes > div",{ 
			onBeforeClick: function(index) {
		        if ( index == 4 && $('#form-preview iframe').length == 0 )
		        	preview();
		        			        
		        return true;
		    }			
		 });
	},
	
	initEditForm : function( selectedTab ) {
		function preview() {
			$('#form-preview').html('<iframe src="/forms/preview?' + $('.form_editor').serialize() + '" style="width:100%;height:500px;border:none;" />');
		}
		
		if ( selectedTab == '#form-description' ) selectedTab = 0;
		if ( selectedTab == '#form-fields' ) selectedTab = 1;
		if ( selectedTab == '#form-style' ) selectedTab = 2;
		if ( selectedTab == '#form-preview' ) {
			selectedTab = 3;
			preview();
		}
		
		$("#form_tabs").tabs("#form_panes > div",{ 
			onBeforeClick: function(index) {
		        if ( index == 3 )
		        	preview();
		        
		        return true;
		    }
		});
	},
	
	initAccount : function( selectedTab ) {
		$("#account_tabs").tabs("#account_panes > div");
	},
	
	initAbout : function( selectedTab ) {
		$("#about_tabs").tabs("#about_panes > div");
	},
	
	initEnterForm : function() {		
		$('#new_user_session').validate({
        	rules: {
        		'user_session[password]': {
        			required: true,
        			minlength: 5
        		},
        		'user_session[email]': {
        			required: true,
        			email: true
        		}
        	},
        	messages: {
        		'user_session[password]': {
        			required: "Введите пароль",
        			minlength: "Пароль должен быть не короче 5 символов"
        		},
        		'user_session[email]': "Введите корректный E-Mail"
        	}
        });
	}
};

jQuery.fn.addBlurHint = function( opts ) {	
	opts = opts || {};
	
	var hintText  = opts.hintText  || 'Hint';
	var hintClass = opts.hintClass || 'hint';
	
	var e = jQuery(this);
	
	e.focus(function(){
		var t = jQuery(this);
		
		if ( t.val() == hintText )
			t.val( '' ).removeClass( hintClass );
	});
	
	e.blur(function(){
		var t = jQuery(this);
		
		if ( t.val() == '' )
			t.val( hintText ).addClass( hintClass );
	});
	
	e.val( hintText ).addClass( hintClass );
}

$(function(){
	$('#session_email').addBlurHint({ hintText: "EMail" });
	$('#session_password').addBlurHint();
});
