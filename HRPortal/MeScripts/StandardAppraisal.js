'use-strict';
//save core initiatives
$(document).ready(function () {
    $("body").on("click", "#btnSaveObjectiveEvaluationResult", function () {
        //Loop through the Table rows and build a JSON array.
        var CoreInitiatives = new Array();
        $(".ObjectiveEvaluationResultTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entrynumber = row.find('td:eq(0)').html();
            primiarydetails.docNo = row.find('td:eq(1)').html();
            primiarydetails.appraiserQty = row.find("TD input").eq(0).val();
            primiarydetails.comments = row.find("TD input").eq(1).val();
            CoreInitiatives.push(primiarydetails);
        });
        console.log(JSON.stringify(CoreInitiatives))
        Swal.fire({
            title: "Confirm Activity Submission?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"
        });
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: '{primarydetails: ' + JSON.stringify(CoreInitiatives) + '}',
            url: "StandardAppraisalUnderEvaluationDetails.aspx/InsertStandardAppraisalActivities",
            dataType: "json",
            success: function (status) {
                var registerstatus = status.d;
                switch (registerstatus) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Appraisal Activities Submitted!",
                            text: registerstatus,
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Your Activity Details have been successfully submitted!");
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $("#feedback").html("Your Activity Details have been successfully submitted!");
                            $("#feedback").reset();
                        });
                        break;
                    default:
                        Swal.fire({
                            title: "Details Submission Error!!!",
                            text: registerstatus,
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(registerstatus);
                        });
                        break;
                }

            },
            error: function (err) {
                console.log(err.statusText);
                console.log(registerstatus);
            }
        });
        console.log(PerformanceLogs);
    });

    //PC
    $("body").on("click", "#btnSaveProficiencyEvaluationResult", function () {
        //Loop through the Table rows and build a JSON array.
        var CoreInitiatives = new Array();
        $(".ProficiencyEvaluationResultTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.docNo = row.find('td:eq(0)').html();
            primiarydetails.entrynumber = row.find('td:eq(1)').html();
            primiarydetails.appraiserQty = row.find("TD input").eq(0).val();
            primiarydetails.comments = row.find("TD input").eq(1).val();
            CoreInitiatives.push(primiarydetails);
        });
        console.log(JSON.stringify(CoreInitiatives))
        Swal.fire({
            title: "Confirm Activity Submission?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"
        });
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: '{primarydetails: ' + JSON.stringify(CoreInitiatives) + '}',
            url: "StandardAppraisalUnderEvaluationDetails.aspx/InsertStandardAppraisalPE",
            dataType: "json",
            success: function (status) {
                var registerstatus = status.d;
                switch (registerstatus) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Appraisal Activities Submitted!",
                            text: registerstatus,
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Your Activity Details have been successfully submitted!");
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $("#feedback").html("Your Activity Details have been successfully submitted!");
                            $("#feedback").reset();
                        });
                        break;
                    default:
                        Swal.fire({
                            title: "Details Submission Error!!!",
                            text: "Error Occured when submmitting your details.Kindly Try Again",
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(registerstatus);
                        });
                        break;
                }

            },
            error: function (err) {
                console.log(err.statusText);
                console.log(registerstatus);
            }
        });
        console.log(PerformanceLogs);
    });
});