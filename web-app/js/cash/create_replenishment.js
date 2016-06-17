

    
    $(function() {
        $( "#accordion" ).accordion({
          collapsible: true
        });
    });


    $(document).ready(function () {

        $( "#dialog-denomination" ).dialog({
            modal: true,
            autoOpen : false,
            draggable: false,
            resizable: false,
            closeOnEscape: false,
            minWidth : 400,
            buttons: {
                OK: function() {
                    $( this ).dialog( "close" );
                }
            }
        });
        //$('#dialog').dialog(); 
        $('#denominationButton').click(function () {
            $("#dialog-denomination").dialog('open');
            return false;
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

    