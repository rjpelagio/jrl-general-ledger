'<tr id="row_'+index+'">\n\
    <td><g:newSelect id="glAccount_'+index+'" name="glAccounts" from="${glAccountList}" optionKey="id" value="${glAccount?.id}" style="width:500px"/></td>\n\
    <td style="text-align:right"><g:textField id="credit_'+index+'" name="debits" onchange="this.value=validateInteger(this.value);recomputeDebit('+index+')"  value="0.00" style="text-align:right"/></td>\n\
    <td style="text-align:right"><g:textField id="debit_'+index+'" name="credits" onchange="this.value=validateInteger(this.value);recomputeCredit('+index+')" value="0.00" style="text-align:right"/></td>\n\
    <td><input type="button" id="delete_'+index+'" value="Delete" onClick="deleteRow('+index+');"/></td>\n\
</tr>'
