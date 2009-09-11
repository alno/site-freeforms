var formEditor = new function() {
		
	var currentField = null;
	var currentIndex = 0;
	
	var editorsPane;
		
	function editorFor( field ) {
		if ( field == null || field.length == 0 )
			return null;
				
		var mField = field[0].id.match(/mf_(\d*)_(\d+)/);
			
		if ( mField != null )		
			return $( '#fe_' + mField[1] + '_' + mField[2] );
			
		var mForm = field[0].id.match(/mfd_(\d*)/);
			
		if ( mForm != null )
			return $( '#fe_' + mForm[1] );
			
		return editorFor( field.parent() );
	}
	
	function fieldFor( editor ) {
		if ( editor == null || editor.length == 0 )
			return null;
				
		var mField = editor[0].id.match(/fe_(\d*)_(\d+)/);
						
		if ( mField != null )
			return $( '#mf_' + mField[1] + '_' + mField[2] );
			
		return fieldFor( editor.parent() );
	}
				
	function hideFieldEditor( field ) {
		field.removeClass( 'current' );
			
		editorFor( field ).css('display','none');
	}
		
	function showFieldEditor( field ) {
		field.addClass( 'current' );
							
		editorFor( field ).css({
			display: 'block',
			'margin-top': Math.max(field.offset().top - editorsPane.offset().top - $('.editor_links').height() - 30,0) + 'px'
		});
	}
	
	function extendField() {
		var field = $(this);
		var removeIcon = $('<img src="/images/icons/delete.png" class="act_icon" />');
		
		removeIcon.click(function(){
			var editor = editorFor( field );
		
			field.remove();
			editor.remove();
		});
		removeIcon.prependTo( field );
	}
	
	function onFieldClick() {
		if ( currentField != null )
			hideFieldEditor( currentField );			
			
		var field = $(this);
				
		currentField = field;
			
		showFieldEditor( field );
	}	
	
	function onInputKeyUp() {
		$(this).change();
	}
	
	function sortEditorsByFields(fields) {
		var prevEditor = null;
		
		for ( var i = 0, l = fields.length; i < l; ++ i ) {
			var mField = fields[i].match(/mf_(\d*)_(\d+)/);
			
			if ( mField == null )
				continue;
						
			var editor = $( '#fe_' + mField[1] + '_' + mField[2] );
			
			if ( prevEditor ) {
				editor.insertAfter( prevEditor );
			}
			
			prevEditor = editor;
		}
	}
	
	this.editorFor = editorFor;
	this.fieldFor = fieldFor;
	
	this.init = function() {		
		editorsPane = $('#form_editors');
		
		$('#form_editors .form_editor').css('display', 'none').each(function(){
			var m = this.id.match(/fe_(\d*)_(\d+)/);
			
			if ( m != null && m[2] > currentIndex )
				currentIndex = m[2];
		});
		
		$('.mfd p').each( extendField );
		
		$('.mfd p, .mfd h3').click( onFieldClick );			
		$('input,textarea').keyup( onInputKeyUp );
		
		$('.mfd').sortable({
			items: '> p',
			update: function(event,ui) {
				sortEditorsByFields( $('.mfd').sortable('toArray') );
			}
		}).disableSelection();
		
		$('.editor_links ul').hide();
		$('.editor_links li').mouseover(function(){
			var t = $(this);
			$('> ul',this).css({
				position: 'absolute',
				top: (t.position().top + t.height()) + 'px',
				left: t.position().left + 'px'
			}).show();
		}).mouseout(function(){
			$('> ul',this).hide();
		});
	}
	
	this.addField = function( formId, proto ) {
		var editor = $('#fe_' + formId + '_' + proto).clone();
		var field = $('#mf_' + formId + '_' + proto).clone();
		var index = ++ currentIndex;
		
		editor.attr( 'id', 'fe_' + formId + '_' + index );
		editor.find('.index_field').val( index );
		
		field.attr( 'id', 'mf_' + formId + '_' + index );		
		field.find('*').each(function() {
			var e = $(this);
			var atts = ['id','name','for'];
			
			for ( var i = atts.length - 1; i >= 0; -- i ) {
				var a = atts[i];
				var v = e.attr( a );
				if ( v ) e.attr( a, v.replace(proto,index) );
			}
		});
		field.each( extendField );
		
		editor.find('input,textarea').keyup( onInputKeyUp ); 
		field.find('input,textarea').keyup( onInputKeyUp );
		field.click( onFieldClick );
		
		editor.appendTo( editorsPane );
		field.insertBefore( '#mfd_' + formId + ' .submit' );
		field.click();
		
		$('.mfd').sortable('refresh');
	}
	
	this.removeField = function( elem ) {
		var field = fieldFor( elem );
		var editor = editorFor( field );
		
		field.remove();
		editor.remove();
	}
	
	return this;
}();