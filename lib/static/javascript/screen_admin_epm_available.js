Event.observe(window, 'load', function() {
	new PeriodicalExecuter(js_admin_epm_available_update, 2);
});
function js_admin_epm_available_update(pe)
{
	var screenid = 'Admin::EPM::Available';

<<<<<<< HEAD
	var input_q = $(screenid + '_q');
	var input_v = $(screenid + '_v');

	if( !input_q || !input_v)
		return;

	if( !input_q._pvalue )
		input_q._pvalue = '';

	if( !input_v._pvalue )
		input_v._pvalue = '';

	var input_v_value = input_v.options[input_v.selectedIndex].value; 

	if( input_q.value == input_q._pvalue &&
	    input_v_value == input_v._pvalue )
		return;

	if( input_q._inprogress )
		return;

	if( input_v._inprogress )
		return;
	
	input_q._inprogress = 1;
	input_v._inprogress = 1;
=======
	var input = $(screenid + '_q');
	if( !input )
		return;

	if( !input._pvalue )
		input._pvalue = '';

	if( input.value == input._pvalue )
		return;

	if( input._inprogress )
		return;
	
	input._inprogress = 1;

>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	var container = $(screenid + '_results');
	var loading = $('loading').cloneNode( 1 );

	container.insertBefore( loading, container.firstChild );
	loading.style.position = 'absolute';
	loading.clonePosition( container );
	loading.show();

<<<<<<< HEAD
	var qvalue = input_q.value;
	var vvalue = input_v_value;
=======
	var qvalue = input.value;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	var params = {};
	params['screen'] = screenid;
	params['ajax'] = 1;
	params[screenid + '_q'] = qvalue;
<<<<<<< HEAD
	params[screenid + '_v'] = vvalue;
=======
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	new Ajax.Updater(container, eprints_http_cgiroot+'/users/home', {
		method: 'get',
		parameters: params,
		onComplete: function () {
<<<<<<< HEAD
			input_q._pvalue = qvalue;
			input_v._pvalue = vvalue;
			input_q._inprogress = 0;
			input_v._inprogress = 0;
=======
			input._pvalue = qvalue;
			input._inprogress = 0;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
		}
	});
}
