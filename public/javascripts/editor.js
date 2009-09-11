function initEditor() {
	
	var currentField = null;
	
	var editorsPane = $('#form_editors');
	
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
	
	$('.form_editor').css({
		display: 'none'
	});
	
	$('.mfd p, .mfd h3').click(function(){
		var field = $(this);
		
		showFieldEditor( field );
		
		if ( currentField != null )
			hideFieldEditor( currentField );
			
		currentField = field;
	});
		
	$('input').keyup(function(){
		$(this).change();
	});
	
};