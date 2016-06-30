
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
                    alert("At least 1 entry is required.")
                }
            }

            function recompute() {
                var amounts = document.getElementsByName("amounts");
                var totalAmount = 0.00;
                var totalCredit = 0.00;

                for (i = 0; i < amounts.length; i++) {
                    if (isNaN(parseFloat(amounts[i].value))) {
                        amounts[i].value = parseFloat(0);
                    }
                    totalAmount = totalAmount + parseFloat(amounts[i].value);
                }
                
                $("input[name='total']").val(parseFloat(totalAmount.toFixed(2)));
                //span = document.getElementById("totalDisplay");
                //span.innerHTML = parseFloat(totalAmount.toFixed(2));
                $("#totalDisplay").html(parseFloat(totalAmount.toFixed(2)));
                
            }
            
            function recomputeAmount(index) {
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

            function getAccounts(rowIndex) {
                
                $("#glAccounts_"+rowIndex).autocomplete({
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

                            $("#glAccountIds_"+rowIndex).val(ui.item.id);
                            $("#glAccounts_"+rowIndex).val(ui.item.value);

                            var TABKEY = 9;

                            if (event.keyCode == TABKEY) { 
                                event.preventDefault();
                                $("#glAccountIds_"+rowIndex).val(ui.item.id);
                                $("#glAccounts_"+rowIndex).val(ui.item.value);
                                $("#glAccounts_"+rowIndex).focus();
                            }

                        } else {

                            $("#glAccountIds_"+rowIndex).val("");
                            $("#glAccounts_"+rowIndex).val("");

                            var TABKEY = 9;

                            if (event.keyCode == TABKEY) { 
                                event.preventDefault();
                                $("#glAccountIds_"+rowIndex).val("");
                                $("#glAccounts_"+rowIndex).val("");
                                $("#glAccounts_"+rowIndex).focus();
                            }

                        }
                    }
                });
            }

            function getPayees(rowIndex){
                $("#payee_"+rowIndex).autocomplete({
                    source: function(request, response){
                            $.ajax({
                                url: "/jrl/lookup/payeeWithTin",
                                data: request,
                                success: function(data) {
                                    response(data);
                                }
                            });
                    },
                    minLength: 2,
                    selectFirst: true,
                    autoFocus: true,
                    select : function(event,ui) {

                        if (ui != null) {

                            $("#payeeId_"+rowIndex).val(ui.item.id);
                            $("#payee_"+rowIndex).val(ui.item.value);
                            $("#tinText_"+rowIndex).html(ui.item.tin);

                            var TABKEY = 9;

                            if (event.keyCode == TABKEY) { 
                                event.preventDefault();
                                $("#payeeId_"+rowIndex).val(ui.item.id);
                                $("#payee_"+rowIndex).val(ui.item.value);
                                $("#payee_"+rowIndex).focus();
                                $("#tinText_"+rowIndex).html(ui.item.tin);
                            }

                        } else {

                            $("#payeeId_"+rowIndex).val("");
                            $("#payee_"+rowIndex).val("");
                            $("#tinText_"+rowIndex).html("");

                            var TABKEY = 9;

                            if (event.keyCode == TABKEY) { 
                                event.preventDefault();
                                $("#payeeId_"+rowIndex).val("");
                                $("#payee_"+rowIndex).val("");
                                $("#payee_"+rowIndex).focus();
                                $("#tinText_"+rowIndex).html(ui.item.tin);
                            }

                        }
                    }
                });
            }

            $(document).ready(function () {

                $("#save, #submit").click(function(event) {

                    var payeeInvalid = 0;
                    var glInvalid = 0;
                    var descInvalid = 0;
                    var refInvalid = 0;
                    var payeeIds = document.getElementsByName("payeeIds");
                    var glAccountIds = document.getElementsByName("glAccountIds");
                    var descriptions = document.getElementsByName("descriptions");
                    var refDocs = document.getElementsByName("refDocs");
                    var msg = '';


                    for (i = 0; i < payeeIds.length; i++) {
                        if (isNaN(parseInt(payeeIds[i].value))) {
                            payeeInvalid = 1;
                            $("#payee_"+i).css("border", "1px solid red");
                        }
                    }

                    var department = $("#department").val();
                    if (department == 'Finance') {
                        for (i = 0; i < glAccountIds.length; i++) {
                            if (isNaN(parseInt(glAccountIds[i].value))) {
                                glInvalid = 1;
                                $("#glAccounts_"+i).css("border", "1px solid red");
                            }
                        }
                    } else {
                        glInvalid = 0;
                    }

                    for (i = 0; i < descriptions.length; i++) {
                        if (descriptions[i].value == '') {
                            descInvalid = 1;
                            $("#description_"+i).css("border", "1px solid red");
                        }
                    }

                    for (i = 0; i < refDocs.length; i++) {
                        if (refDocs[i].value == '') {
                            refInvalid = 1;
                            $("#refDoc_"+i).css("border", "1px solid red");
                        }
                    }

                    if (glInvalid == 1 || payeeInvalid == 1 || refInvalid == 1 || descInvalid == 1) {
                        $("#dialog-message").append("<p>Please fill up the red highlighted fields on the list.</p>")
                        $("#dialog-message").dialog( "open" );
                        return false;
                    }

                });

                $( "#dialog-message" ).dialog({
                    modal: true,
                    autoOpen : false,
                    draggable: false,
                    resizable: false,
                    closeOnEscape: false,
                    buttons: {
                        OK: function() {
                            $("#dialog-message").html("");
                            $( this ).dialog( "close" );
                        }
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
                        $("#requestedBy").val(ui.item.id); // update the hidden field.
                        $("#tinText").val(ui.item.tin);
                        $("#tin").html(ui.item.tin);
                    }
                });

                
                $("#payeeText2").autocomplete({
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
                        $("#payee").val(ui.item.id); // update the hidden field.
                        $("#tinText2").val(ui.item.tin);
                        $("#tin2").html(ui.item.tin);
                    }
                });

                $("#glAccount").autocomplete({
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

                            $("#glAccountId").val(ui.item.id);
                            $("#glAccount").val(ui.item.value);

                            var TABKEY = 9;

                            if (event.keyCode == TABKEY) { 
                                event.preventDefault();
                                $("#glAccountId").val(ui.item.id);
                                $("#glAccount").val(ui.item.value);
                                $("#glAccount").focus();
                            }

                        } else {

                            $("#glAccountId_"+rowIndex).val("");
                            $("#glAccount_"+rowIndex).val("");

                            var TABKEY = 9;

                            if (event.keyCode == TABKEY) { 
                                event.preventDefault();
                                $("#glAccountId").val("");
                                $("#glAccount").val("");
                                $("#glAccount").focus();
                            }

                        }
                    }
                });
            });

            

