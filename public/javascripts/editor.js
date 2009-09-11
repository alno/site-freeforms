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
			'margin-top': (field.offset().top - editorsPane.offset().top - 30) + 'px'
		});
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
	
	this.editorFor = editorFor;
	this.fieldFor = fieldFor;
	
	this.init = function() {		
		editorsPane = $('#form_editors');
		
		$('#form_editors .form_editor').css('display', 'none').each(function(){
			var m = this.id.match(/fe_(\d*)_(\d+)/);
			
			if ( m != null && m[2] > currentIndex )
				currentIndex = m[2];
		});
		
		$('.mfd p, .mfd h3').click( onFieldClick );			
		$('input,textarea').keyup( onInputKeyUp );		
	}
	
	this.newField = function(formId,proto) {
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
		
		editor.find('input,textarea').keyup( onInputKeyUp ); 
		field.find('input,textarea').keyup( onInputKeyUp );
		field.click( onFieldClick );
		
		editor.appendTo( editorsPane );
		field.insertBefore( '#mfd_' + formId + ' .submit' );
		field.click();
	}
	
	this.newStringField = function() {
		
	}
	
	return this;
}();