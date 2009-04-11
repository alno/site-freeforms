
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
	}
};
