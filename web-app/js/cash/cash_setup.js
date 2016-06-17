$(document).ready(function () {

	$("#cashVoucherAcctTitle").autocomplete({
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

                    $("#cashVoucherAcctTitleId").val(ui.item.id);
                    $("#cashVoucherAcctTitle").val(ui.item.value);

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#cashVoucherAcctTitleId").val(ui.item.id);
                        $("#cashVoucherAcctTitle").val(ui.item.value);
                        $("#cashVoucherAcctTitle").focus();
                    }

                } else {

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#cashVoucherAcctTitleId").val("");
                        $("#cashVoucherAcctTitle").val("");
                        $("#cashVoucherAcctTitle").focus();
                    }

                }
            }
    });

	$("#liquidationAcctTitle").autocomplete({
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

                    $("#liquidationAcctTitleId").val(ui.item.id);
                    $("#liquidationAcctTitle").val(ui.item.value);

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#liquidationAcctTitleId").val(ui.item.id);
                        $("#liquidationAcctTitle").val(ui.item.value);
                        $("#liquidationAcctTitle").focus();
                    }

                } else {

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#liquidationAcctTitleId").val("");
                        $("#liquidationAcctTitle").val("");
                        $("#liquidationAcctTitle").focus();
                    }

                }
            }
    });
	
	$("#reimbursementAcctTitle").autocomplete({
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

                    $("#reimbursementAcctTitleId").val(ui.item.id);
                    $("#reimbursementAcctTitle").val(ui.item.value);

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#reimbursementAcctTitleId").val(ui.item.id);
                        $("#reimbursementAcctTitle").val(ui.item.value);
                        $("#reimbursementAcctTitle").focus();
                    }

                } else {

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#reimbursementAcctTitleId").val("");
                        $("#reimbursementAcctTitle").val("");
                        $("#reimbursementAcctTitle").focus();
                    }

                }
            }
    });

	$("#reimbursementCreditAccount").autocomplete({
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

                    $("#reimbursementCreditAccountId").val(ui.item.id);
                    $("#reimbursementCreditAccount").val(ui.item.value);

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#reimbursementCreditAccountId").val(ui.item.id);
                        $("#reimbursementCreditAccount").val(ui.item.value);
                        $("#reimbursementCreditAccount").focus();
                    }

                } else {

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#reimbursementCreditAccountId").val("");
                        $("#reimbursementCreditAccount").val("");
                        $("#reimbursementCreditAccount").focus();
                    }

                }
            }
    });

	$("#reimbursementDebitAccount").autocomplete({
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

                    $("#reimbursementDebitAccountId").val(ui.item.id);
                    $("#reimbursementDebitAccount").val(ui.item.value);

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#reimbursementDebitAccountId").val(ui.item.id);
                        $("#reimbursementDebitAccount").val(ui.item.value);
                        $("#reimbursementDebitAccount").focus();
                    }

                } else {

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#reimbursementDebitAccountId").val("");
                        $("#reimbursementDebitAccount").val("");
                        $("#reimbursementDebitAccount").focus();
                    }

                }
            }
    });

	$("#replenishmentAcctTitle").autocomplete({
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

                    $("#replenishmentAcctTitleId").val(ui.item.id);
                    $("#replenishmentAcctTitle").val(ui.item.value);

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#replenishmentAcctTitleId").val(ui.item.id);
                        $("#replenishmentAcctTitle").val(ui.item.value);
                        $("#replenishmentAcctTitle").focus();
                    }

                } else {

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#replenishmentAcctTitleId").val("");
                        $("#replenishmentAcctTitle").val("");
                        $("#replenishmentAcctTitle").focus();
                    }

                }
            }
    });

	$("#replenishmentNegVariance").autocomplete({
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

                    $("#replenishmentNegVarianceId").val(ui.item.id);
                    $("#replenishmentNegVariance").val(ui.item.value);

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#replenishmentNegVarianceId").val(ui.item.id);
                        $("#replenishmentNegVariance").val(ui.item.value);
                        $("#replenishmentNegVariance").focus();
                    }

                } else {

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#replenishmentNegVarianceId").val("");
                        $("#replenishmentNegVariance").val("");
                        $("#replenishmentNegVariance").focus();
                    }

                }
            }
    });

	$("#replenishmentPosVariance").autocomplete({
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

                    $("#replenishmentPosVarianceId").val(ui.item.id);
                    $("#replenishmentPosVariance").val(ui.item.value);

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#replenishmentPosVarianceId").val(ui.item.id);
                        $("#replenishmentPosVariance").val(ui.item.value);
                        $("#replenishmentPosVariance").focus();
                    }

                } else {

                    var TABKEY = 9;

                    if (event.keyCode == TABKEY) { 
                        event.preventDefault();
                        $("#replenishmentPosVarianceId").val("");
                        $("#replenishmentPosVariance").val("");
                        $("#replenishmentPosVariance").focus();
                    }

                }
            }
    });

})