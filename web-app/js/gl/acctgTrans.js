
            function deleteRow(index){
                var rowIndex = $("#rowIndex").val();
                if (rowIndex > 1) {
                    var dataTable = document.getElementById("dataTable");
                    var row = document.getElementById("row_"+index);
                    dataTable.removeChild(row);
                    rowIndex--;
                    $("input[name='rowIndex']").val(rowIndex);

                    recompute();

                } else {
                    alert("At least 1 Gl Account is required.")
                }
            }

            function recompute() {
                var debits = document.getElementsByName("debits");
                var credits = document.getElementsByName("credits");
                var totalDebit = 0.00;
                var totalCredit = 0.00;

                for (i = 0; i < debits.length; i++) {
                    totalDebit = totalDebit + parseFloat(debits[i].value);
                }
                
                for (i = 0; i < credits.length; i++) {
                    totalCredit = totalCredit + parseFloat(credits[i].value);
                }
                
                $("input[name='debit']").val(totalDebit);
                $("input[name='credit']").val(totalCredit);
                span = document.getElementById("debitDisplay");
                span.innerHTML = totalDebit;
                span = document.getElementById("creditDisplay");
                span.innerHTML = totalCredit;

            }
            
            function recomputeDebit(index) {
                var zero = 0;
                $("#credit_"+index).val(zero.toFixed(2));
                recompute();
            }
            
            function recomputeCredit(index) {
                var zero = 0;
                $("#debit_"+index).val(zero.toFixed(2));
                recompute();
            }

            function showTin(partyId){
              if(partyId){
                $.ajax({
                  url: "../glAccountingTransaction/showTin/"+partyId,
                  dataType:"json",
                  success: function(json) {
                      $("#tin").text(json.tin)
                  }
                });
              }
              else{
                  $("#tin").text('N/A')
              }
            }

            function setSelectedIndex(rowIndex){
                $("#glAccount_"+rowIndex).autocomplete({
                    source: function(request, response){
                            $.ajax({
                                url: "/jrl/lookup/glAccount",
                                data: request,
                                success: function(data) {
                                    response(data);
                                }
                            });
                    },
                    minLength: 3,
                    selectFirst: true,
                    autoFocus: true,
                    select : function(event,ui) {

                        if (ui != null) {

                            $("#glAccountId_"+rowIndex).val(ui.item.id);
                            $("#glAccount_"+rowIndex).val(ui.item.value);

                            var TABKEY = 9;

                            if (event.keyCode == TABKEY) { 
                                event.preventDefault();
                                $("#glAccountId_"+rowIndex).val(ui.item.id);
                                $("#glAccount_"+rowIndex).val(ui.item.value);
                                $("#glAccount_"+rowIndex).focus();
                            }

                        } else {

                            $("#glAccountId_"+rowIndex).val("");
                            $("#glAccount_"+rowIndex).val("");

                            var TABKEY = 9;

                            if (event.keyCode == TABKEY) { 
                                event.preventDefault();
                                $("#glAccountId_"+rowIndex).val("");
                                $("#glAccount_"+rowIndex).val("");
                                $("#glAccount_"+rowIndex).focus();
                            }

                        }
                    }
                });
            }

            $(document).ready(function () {

                $("#save, #submit").click(function(event) {

                    var msg = '';
                    var valid = 0

                    if ($("input[name='debit']").val() == 0) {
                        valid = 1;
                        msg = "Debit total must not be equal to 0.\n\n"
                    }

                    if ($("input[name='credit']").val() == 0) {
                        valid = 1;
                        msg = msg + "Credit total must not be equal to 0.\n\n"
                    }

                    if ($("input[name='credit']").val() != $("input[name='debit']").val()) {
                        valid = 1;
                        msg = msg + "Debit and Credit values must equal\n\n"
                    }

                    if (valid == 1) {
                        alert (msg);
                        return false;
                    }
                });

                $("#payeeText").autocomplete({
                    source: function(request, response){
                        $.ajax({
                            url: "/jrl/lookup/payeeWithTin", // remote datasource
                            data: request,
                            success: function(data){
                                response(data); // set the response
                            },
                        });
                    },
                    minLength: 2, // triggered only after minimum 2 characters have been entered.
                    select: function(event, ui) { // event handler when user selects a company from the list.
                        $("#partyId").val(ui.item.id); // update the hidden field.
                        $("#tin").html(ui.item.tin);
                        $("#tinText").val(ui.item.tin);
                    }
                });
            });

            

