



function computeThousandDem(value) {

    var valueText = 0.00
    if (isNaN(value)) {
        value = 0;
    }

    $("#diathousandDem").val(parseInt(value));
    $("#thousandDem").val(parseInt(value));

    valueText = 1000 * parseInt(value)
    $("#diathousandText").val(valueText)
    $("#diathousandTextSpan").html(valueText.toFixed(2))

    computeTotals()

}

function computeFiveHundredDem(value) {

    var valueText = 0.00
    if (isNaN(value)) {
        value = 0;
    }

    $("#diafiveHundredDem").val(parseInt(value));
    $("#fiveHundredDem").val(parseInt(value));

    valueText = 500 * parseInt(value)
    $("#diafiveHundredText").val(valueText)
    $("#diafiveHundredTextSpan").html(valueText.toFixed(2))

    computeTotals()

}

function computeTwoHundredDem(value) {

    var valueText = 0.00
    if (isNaN(value)) {
        value = 0;
    }

    $("#diatwoHundredDem").val(parseInt(value));
    $("#twoHundredDem").val(parseInt(value));

    valueText = 200 * parseInt(value)
    $("#diatwoHundredText").val(valueText)
    $("#diatwoHundredTextSpan").html(valueText.toFixed(2))

    computeTotals()

}

function computeHundredDem(value) {

    var valueText = 0.00
    if (isNaN(value)) {
        value = 0;
    }

    $("#diahundredDem").val(parseInt(value));
    $("#hundredDem").val(parseInt(value));

    valueText = 100 * parseInt(value)
    $("#diahundredText").val(valueText)
    $("#diahundredTextSpan").html(valueText.toFixed(2))

    computeTotals()

}

function computeFiftyDem(value) {

    var valueText = 0.00
    if (isNaN(value)) {
        value = 0;
    }

    $("#diafiftyDem").val(parseInt(value));
    $("#fiftyDem").val(parseInt(value));

    valueText = 50 * parseInt(value)
    $("#diafiftyText").val(valueText)
    $("#diafiftyTextSpan").html(valueText.toFixed(2))

    computeTotals()

}


function computeTwentyDem(value) {

    var valueText = 0.00
    if (isNaN(value)) {
        value = 0;
    }

    $("#diatwentyDem").val(parseInt(value));
    $("#twentyDem").val(parseInt(value));

    valueText = 20 * parseInt(value)
    $("#diatwentyText").val(valueText)
    $("#diatwentyTextSpan").html(valueText.toFixed(2))

    computeTotals()

}

function computeTenPesoDem(value) {

    var valueText = 0.00
    if (isNaN(value)) {
        value = 0;
    }

    $("#diatenDem").val(parseInt(value));
    $("#tenDem").val(parseInt(value));

    valueText = 10 * parseInt(value)
    $("#diatenText").val(valueText)
    $("#diatenTextSpan").html(valueText.toFixed(2))

    computeTotals()

}

function computeFivePesoDem(value) {

    var valueText = 0.00
    if (isNaN(value)) {
        value = 0;
    }

    $("#diafiveDem").val(parseInt(value));
    $("#fiveDem").val(parseInt(value));

    valueText = 5 * parseInt(value)
    $("#diafiveText").val(valueText)
    $("#diafiveTextSpan").html(valueText.toFixed(2))

    computeTotals()

}

function computePesoDem(value) {

    var valueText = 0.00
    if (isNaN(value)) {
        value = 0;
    }

    $("#diapesoDem").val(parseInt(value));
    $("#pesoDem").val(parseInt(value));

    valueText = 1 * parseInt(value)
    $("#diapesoText").val(valueText)
    $("#diapesoTextSpan").html(valueText.toFixed(2))

    computeTotals()

}


function computeFiftyCentDem(value){

    var valueText = 0.00
    if (isNaN(value)) {
        value = 0;
    }

    $("#diafiftyCentDem").val(parseInt(value));
    $("#fiftyCentDem").val(parseInt(value));

    valueText = 0.5 * parseInt(value)
    $("#diafiftyCentText").val(valueText)
    $("#diafiftyCentTextSpan").html(valueText.toFixed(2))

    computeTotals()

}

function computeTwentyFiveCentDem(value){

    var valueText = 0.00
    if (isNaN(value)) {
        value = 0;
    }

    $("#diatwentyFiveCentDem").val(parseInt(value));
    $("#twentyFiveCentDem").val(parseInt(value));

    valueText = 0.25 * parseInt(value)
    $("#diatwentyFiveCentText").val(valueText)
    $("#diatwentyFiveCentTextSpan").html(valueText.toFixed(2))

    computeTotals()

}

function computeTotals() {

    var totalText = 0;
    totalText = parseFloat(totalText) + parseFloat($("#diathousandText").val())
    totalText = parseFloat(totalText) + parseFloat($("#diafiveHundredText").val())
    totalText = parseFloat(totalText) + parseFloat($("#diatwoHundredText").val())
    totalText = parseFloat(totalText) + parseFloat($("#diahundredText").val())
    totalText = parseFloat(totalText) + parseFloat($("#diafiftyText").val())
    totalText = parseFloat(totalText) + parseFloat($("#diatwentyText").val())
    totalText = parseFloat(totalText) + parseFloat($("#diatenText").val())
    totalText = parseFloat(totalText) + parseFloat($("#diafiveText").val())
    totalText = parseFloat(totalText) + parseFloat($("#diapesoText").val())
    totalText = parseFloat(totalText) + parseFloat($("#diafiftyCentText").val())
    totalText = parseFloat(totalText) + parseFloat($("#diatwentyFiveCentText").val())

    $("#totalTextSpan").html(parseFloat(totalText).toFixed(2))
    $("#cashOnHandText").html(parseFloat(totalText).toFixed(2))
    $("#totalCashDenom").val(totalText.toFixed(2))
    $("#cashOnHand").val(totalText.toFixed(2))

    var recordedCoh = $("#recordedCoh").val()
    var variance =   parseFloat(recordedCoh).toFixed(2) -  parseFloat(totalText.toFixed(2))


    
        $("#varianceText").html(parseFloat(variance).toFixed(2))
        $("#variance").val(parseFloat(variance).toFixed(2))

    
        if (parseFloat($("#variance").val()) > 0) {
            $("#varianceText").css("color", "red");
        } else if (parseFloat($("#variance").val()) < 0) {
            $("#varianceText").css("color", "#3C5326");
        } else if (parseFloat($("#variance").val()) == 0) {
            $("#varianceText").css("color", "#3C5326");
        }
    

}


$(document).ready(function () {

    computeThousandDem($("#thousandDem").val()) 
    computeFiveHundredDem($("#fiveHundredDem").val()) 
    computeTwoHundredDem($("#twoHundredDem").val()) 
    computeHundredDem($("#hundredDem").val()) 
    computeFiftyDem($("#fiftyDem").val()) 
    computeTwentyDem($("#twentyDem").val()) 
    computeTenPesoDem($("#tenPesoDem").val()) 
    computeFivePesoDem($("#fivePesoDem").val()) 
    computePesoDem($("#pesoDem").val()) 
    computeFiftyCentDem($("#fiftyCentDem").val())
    computeTwentyFiveCentDem($("#twentyFiveCentDem").val())

    if (parseFloat($("#variance").val()) > 0) {
        $("#varianceText").css("color", "red");
    } else if (parseFloat($("#variance").val()) < 0) {
        $("#varianceText").css("color", "#3C5326");
    } else if (parseFloat($("#variance").val()) == 0) {
        $("#varianceText").css("color", "#3C5326");
    }

});