'<tr id="row_'+index+'">' + 
	<g:if test="${session.employee.department == 'Finance'}">
        '<td style="width:20%">' +
        	'<g:textField id="glAccounts_'+index+'" name="glAccounts" size="30" onkeypress="getAccounts('+index+')"/>'+
        	'<input type="hidden" name="glAccountIds" id="glAccountIds_'+index+'"/>'+
        '</td>' +
        '<td style="width:20%"><g:textField id="description_'+index+'" name="descriptions" size="35"/></td>' +
        '<td style="width:15%"><g:textField id="payee_'+index+'" name="payees" onkeypress="getPayees('+index+')"/>' +
            '<input type="hidden" id="payeeId_'+index+'" name="payeeIds"/></td>' + 
        '<td style="width:10%"><span id="tinText_'+index+'"></span></td>' +
        '<td style="width:15%"><g:textField id="refDoc_'+index+'" name="refDocs" size="20"/></td>' +
        '<td style="text-align:right;width:5%">' +
        	'<g:textField id="amount_'+index+'" name="amounts"
        		onchange="this.value=validateInteger(this. value);recomputeAmount('+index+')" 
        			style="text-align:right" size="10" value="0.00"/></td>' +
        '<td><input type="button" id="delete_'+index+'" value="Delete" onClick="deleteRow('+index+');"/></td>'+
    </g:if>
    <g:else>
		'<td><g:textField id="description_'+index+'" name="descriptions" size="55"/></td>' +
		'<td><g:textField id="payee_'+index+'" name="payees" onkeypress="getPayees('+index+')"/>' +
			'<input type="hidden" id="payeeId_'+index+'" name="payeeIds"/></td>' +
	 	'<td><span id="tinText_'+index+'"></span></td>' +
		'<td><g:textField id="refDoc_'+index+'" name="refDocs" size="35"/></td>' +
		'<td style="text-align:right;width:5%">' +
			'<g:textField id="amount_'+index+'" name="amounts" onchange="this.value=validateInteger(this.value);recomputeAmount('+index+')" style="text-align:right" value="0.00" size="10"/></td>' +
		'<td>' +
		    '<input type="button" id="delete_'+index+'" value="Delete" onClick="deleteRow('+index+');"/>' +
		'</td>' +
	</g:else>
'</tr>'