'use-strict';
$('#checkBoxAllGoods2').click(function () {
    var checked = this.checked;
})
var td2 = $(".additionalinitiativesTable1")
td2.on("change",
    "tbody tr .checkboxes",
    function () {
        var t = jQuery(this).is(":checked"), selected_arr = [];
        t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
            : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
        // Read all checked checkboxes
        $("input:checkbox[class=checkboxes]:checked").each(function () {
            selected_arr.push($(this).val());
        });

        if (selected_arr.length > 0) {
            $("#rfiresponsefeedback").css("display", "block");

        } else {
            $("#rfiresponsefeedback").css("display", "none");
            selected_arr = [];
        }

    });
//insert additional initiatives
//var selected_arr = [];
var PrimaryInitiatives = new Array();
$(".btn_insertadditionalinitiatives").on("click",
    function (e) {
        e.preventDefault();
        PrimaryInitiatives = [];
        $.each($(".additionalinitiativesTable1 tr.active"), function () {
            //procurement category
            var checkbox_value = $('#allselectedadditionalactivities').val();
            var Targets = {};
            Targets.targetNumber = ($(this).find('td').eq(1).text());
            PrimaryInitiatives.push(Targets);
        });
        var postData = {
            catgeories: PrimaryInitiatives
        };
        console.log(JSON.stringify(PrimaryInitiatives))
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

        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: '{targetNumber: ' + JSON.stringify(PrimaryInitiatives) + '}',
                    url: "NewIndividualScoreCard.aspx/SubmitSelectedAdditionalActivities",
                    dataType: "json",
                    processData: false
                }).done(function (status) {
                    var registerstatus = status.d;
                    console.log(JSON.stringify(registerstatus))
                    switch (registerstatus) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Activity Categories Submitted!",
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
                                location.reload();
                                return false;
                            });
                            PrimaryInitiatives = [];
                            $('#allsecondaryActivities').modal('hide');
                            $.modal.close();
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "feedback Error!!!",
                                text: registerstatus,
                                type: "error"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').addClass('alert alert-danger');
                                $("#feedback").html("Your Activity Details could not be submitted!" + registerstatus);
                            });
                            PrimaryInitiatives = [];
                            break;
                    }
                }
                );
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Activity Cancelled',
                    'You cancelled your Activity submission details!',
                    'error'
                );
            }
        });

    });

//save core initiatives
$(document).ready(function () {
    $("body").on("click", "#btnSaveAdditionalInitiativesData", function () {
        //Loop through the Table rows and build a JSON array.
        var CoreInitiatives = new Array();
        $(".additionalactivitiestableData TBODY TR").each(function () {
            var row = $(this);
            var primarydetailsData = {};
            primarydetailsData.entrynumber = row.find('td:eq(0)').html();
            primarydetailsData.startdate = row.find("TD input").eq(0).val();
            primarydetailsData.enddate = row.find("TD input").eq(1).val();
            primarydetailsData.agreedtarget = row.find("TD input").eq(2).val();
            primarydetailsData.assignedweight = row.find("TD input").eq(3).val();
            primarydetailsData.comments = row.find("TD input").eq(4).val();
            CoreInitiatives.push(primarydetailsData);
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
            data: '{primarydetailsData: ' + JSON.stringify(CoreInitiatives) + '}',
            url: "NewIndividualScoreCard.aspx/InsertAdditionalActivities",
            dataType: "json",
            success: function (status) {
                var registerstatus = status.d;
                switch (registerstatus) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Additional Activities Submitted!",
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
                            location.reload();
                            return false;
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