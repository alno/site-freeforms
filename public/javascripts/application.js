
var ui = {
	initIndex : function( selectedTab ) {
						
		if ( selectedTab == '#login' ) selectedTab = 0;
		if ( selectedTab == '#register' ) selectedTab = 1;
		if ( selectedTab == '#restore_password' ) selectedTab = 2;
		
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
		
		$('#tabs').tabs({ selected: selectedTab });
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
        		},
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
		if ( selectedTab == '#form-fields' ) selectedTab = 1;
		if ( selectedTab == '#form-style' ) selectedTab = 2;
		if ( selectedTab == '#form-code' ) selectedTab = 3;
		if ( selectedTab == '#form-preview' ) {
			selectedTab = 4;
			preview();
		}
		
		$('#form-tabs').tabs({ 
			selected : selectedTab,
			select:  function(event, ui) {
		        if ( ui.index == 4 && $('#form-preview iframe').length == 0 )
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
		
		$('#form-tabs').tabs({ 
			selected : selectedTab,
			select:  function(event, ui) {
		        if ( ui.index == 3 )
		        	preview();
		        
		        return true;
		    }
		});
	},
	
	initAccount : function( selectedTab ) {
		if ( selectedTab == '#account-main' ) selectedTab = 0;
		
		$('#account-tabs').tabs({ 
			selected : selectedTab
		});
	},
	
	initAbout : function( selectedTab ) {
		if ( selectedTab == '#about-intro' ) selectedTab = 0;
		if ( selectedTab == '#about-why' ) selectedTab = 1;
		
		$('#about-tabs').tabs({ 
			selected : selectedTab
		});
	}
};
