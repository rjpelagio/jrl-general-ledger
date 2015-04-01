
            function deleteRow(index){
              var rowIndex = $("#rowIndex").val();
              if (rowIndex > 1) {
                  var dataTable = document.getElementById("dataTable");
                  var row = document.getElementById("row_"+index);
                  dataTable.removeChild(row);
                  rowIndex--;
                  $("input[name='rowIndex']").val(rowIndex);
              } else {
                  alert("At least 1 Gl Account is required.")
              }
            }

            function addToTotal() {
                var amounts = document.getElementsByName("debits");
                var credits = document.getElementsByName("credits");
               
                var totalDebit = 0.00;
                var totalCredit = 0.00;
                
                for (i = 0; i < amounts.length; i++){
                  totalDebit = totalDebit + parseFloat(amounts[i].value);
                }
                for (i = 0; i < credits.length; i++){
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
                var debits = document.getElementsByName("debits");
                var credits = document.getElementsByName("credits");
                var totalDebit = 0.00;
                var totalCredit = 0.00;
                var zero = 0
                credits[index].value = zero.toFixed(2);
                
                
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
            
            function recomputeCredit(index) {
                var debits = document.getElementsByName("debits");
                var credits = document.getElementsByName("credits");
                var totalDebit = 0.00;
                var totalCredit = 0.00;
                var zero = 0
                debits[index].value = zero.toFixed(2);
               
                
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
                        $("#glAccountId_"+rowIndex).val(ui.item.id);
                        $("#glAccount_"+rowIndex).val(ui.item.value);

                        var TABKEY = 9;

                        if (event.keyCode == TABKEY) { 
                            event.preventDefault();
                            $("#glAccountId_"+rowIndex).val(ui.item.id);
                            $("#glAccount_"+rowIndex).val(ui.item.value);
                            $("#glAccount_"+rowIndex).focus();
                        }
                    }
                });
            }

            $(document).ready(function () {
                $("#partyName").autocomplete({
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
                    }
                });
            });

