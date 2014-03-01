'<tr id="row_'+index+'">\n\
    <td>\n\
    	<g:textField name="glAccounts" id="glAccount_'+index+'"  style="width:500px;background-color:#FFFF71" onclick="setSelectedIndex('+index+')"/>\n\
    	<input type="hidden" id="glAccountId_'+index+'" name="glAccountIds"/>\n\
    </td>\n\
    <td style="text-align:right"><g:textField id="credit_'+index+'" name="debits" onchange="this.value=validateInteger(this.value);recomputeDebit('+index+')"  value="0.00" style="text-align:right"/></td>\n\
    <td style="text-align:right"><g:textField id="debit_'+index+'" name="credits" onchange="this.value=validateInteger(this.value);recomputeCredit('+index+')" value="0.00" style="text-align:right"/></td>\n\
    <td><input type="button" id="delete_'+index+'" value="Delete" onClick="deleteRow('+index+');"/></td>\n\
</tr>'
