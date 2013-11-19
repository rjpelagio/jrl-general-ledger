'<tr id="row_'+index+'">\n\
    <td><g:newSelect id="glAccount_'+index+'" name="glAccounts" from="${glAccountList}" optionKey="id" value="${glAccount?.id}"/></td>\n\
    <td><g:textField id="credit_'+index+'" name="debits" onchange="this.value=validateInteger(this.value);recomputeDebit('+index+')" style="text-align:right" value="0.00"/></td>\n\
    <td><g:textField id="debit_'+index+'" name="credits" onchange="this.value=validateInteger(this.value);recomputeCredit('+index+')" style="text-align:right" value="0.00"/></td>\n\
    <td><input type="button" id="delete_'+index+'" value="Delete" onClick="deleteRow('+index+');"/></td>\n\
</tr>'
