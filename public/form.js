/**
 * @author alno
 */

function attachScript(src){
	var element = document.createElement("script");
	element.type = "text/javascript";
	element.src = src;
	document.getElementsByTagName("head")[0].appendChild(element);
}

function attachStyle(src) {
	var element = document.createElement("link");
	element.href = src;
	element.rel = 'stylesheet';
	element.type = 'text/css';
	
	document.getElementsByTagName("head")[0].appendChild(element);
}

var messageFormConfig = {
	userId : 1,
	host: 'localhost:3000'
}

var messageForm = {
	onSuccess: function( token ) {
		var content = 'Сообщение отправлено. <a href="http://' + messageFormConfig.host + '/status/' + token + '">Статус</a>';
		
		document.getElementById('message_form_div').innerHTML = content;
	},

	onError: function(errors) {
		for ( var i = 0; i < errors.length; ++ i ) {
			var error = errors[i];
			document.getElementById('message_form_'+error[0]).className = 'error';
		}

		document.getElementById('message_form_block').style['display'] = 'none';
	},

	postMessage: function(form) {
		document.getElementById('message_form_block_text').innerHTML = "Sending...";
		document.getElementById('message_form_block').style['display'] = 'block';

		attachScript("http://" + messageFormConfig.host + "/post/" + messageFormConfig.userId + "?name=" + encodeURIComponent(form['name'].value) + "&email=" + encodeURIComponent(form['email'].value) + "&title=" + encodeURIComponent(form['title'].title) + "&content=" + encodeURIComponent(form['content'].value));
	},
	
	insertForm: function() {
		attachStyle('http://' + messageFormConfig.host + '/form.css');
		
		document.write('<div id="message_form_div"><form action="http://' + messageFormConfig.host + '/post/1" method="POST" target="message_form_frame">');
		document.write('<p id="message_form_sender_name"><label for="name">Name</label><input type="text" name="name" /></p>');
		document.write('<p id="message_form_sender_email"><label for="name">EMail</label><input type="text" name="email" /></p>');
		document.write('<p id="message_form_title"><label for="name">Title</label><input type="text" name="title" /></p>');
		document.write('<p id="message_form_content"><label for="name">Text</label><textarea name="content" ></textarea></p>');
		document.write('<input type="submit" onclick="messageForm.postMessage(this.form); return false;"/>');
		document.write('</form><div id="message_form_block"><div id="message_form_block_center"><img src="http://' + messageFormConfig.host + '/images/loader-bar.gif" /><p id="message_form_block_text"></p></div></div></div>');
	}
};

messageForm.insertForm();

