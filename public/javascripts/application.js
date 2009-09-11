
var ui = {
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
		
		function updateLinks(index) {
			var edit_link = $('#form_edit_link');
		    var clone_link = $('#form_clone_link');
		        
		    var hrefPart = '#form-' + ['description','fields','style','code','preview'][index];
		        
		    edit_link[0].href = edit_link[0].href.replace(/\#.*/,hrefPart);
		    clone_link[0].href = clone_link[0].href.replace(/\#.*/,hrefPart);
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
		
		updateLinks( selectedTab );
		
		$("#form_tabs").tabs("#form_panes > div",{ 
			onBeforeClick: function(index) {
		        if ( index == 4 && $('#form-preview iframe').length == 0 )
		        	preview();
		        	
		        updateLinks( index );
		        
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
	},
	
	renderFieldEditor : function( title, type, def, enabled, required ) {
		
		function renderTextField( name, value ) {
			var s = '';
			
			s += '<input class="t" type="text" name="form[fields][][';
			s += name;
			s += ']" value="';
			s += value;
			s += '" />';
			
			return s;
		}
		
		function renderCheckBox( name, value ) {
			var s = '';
			
			s += '<input ';
			s += (value != false) ? 'checked="checked" ' : '';
			s += 'type="checkbox" name="form[fields][][';
			s += name;
			s += ']" value="1"/>';
			
			return s;
		}
		
		function renderSelect(name,v,opts) {
			var s = '';
			
			s += '<select name="form[fields][][';
			s += name;
			s += ']">';
			
			for ( var k in opts ) {
				s += '<option value="';
				s += k;
				s += (v == k) ? '" selected="selected">' : '">';
				s += opts[k];
				s += '</option>';
			}
			
			s += '</select>';
			
			return s;
		}		
		
		var s = '';
		
		s += '<table class="field_editor"><tr><td>';
		s += '<label>Заголовок:</label></td><td>';
		s += renderTextField('title',title);
		s += '</td><td>';
		s += '<label>Тип:</label>';
		s += renderSelect('type',type,{ text: 'Текст', email: 'E-Mail', string: 'Строка' });
		s += '</td><td>';
		s += '<label>По умолчанию:</label></td><td>';
		s += renderTextField('default',def);
		s += '</td></tr><tr><td>';
		s += renderCheckBox('enabled',enabled);
		s += '<label>Разрешено</label>';
		s += '</td><td>';
		s += renderCheckBox('required',required);
		s += '<label>Обязательно</label>';
		s += '</td><td></td></tr></table>';
		
		return s;
	},
	
	appendFieldEditor : function() {
		$('#form_fields_area')[0].innerHTML += this.renderFieldEditor('','text','',true);
	}
};
