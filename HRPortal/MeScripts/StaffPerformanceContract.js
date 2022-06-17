'use-strict';
$('#checkBoxAllGoods').click(function () {
    var checked = this.checked;
})
var td2 = $(".primaryActivityInitiativeTableDetails")
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
//var selected_arr = [];
var PrimaryInitiative = new Array();
$(".btn_applyallselectedActvities").on("click",
    function (e) {
        e.preventDefault();
        PrimaryInitiative = [];
        $.each($(".primaryActivityInitiativeTableDetails tr.active"), function () {
            //procurement category
            var checkbox_value = $('#selectedactivityrecords1').val();
            var Targets = {};
            Targets.targetNumber = ($(this).find('td').eq(1).text());
            PrimaryInitiative.push(Targets);
        });
        var postData = {
            catgeories: PrimaryInitiative
        };
        console.log(JSON.stringify(PrimaryInitiative))
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
                    data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                    url: "NewIndividualScoreCard.aspx/SubmitSelectedCoreInitiatives",
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
                            PrimaryInitiative = [];
                            $('#primaryActivities').modal('hide');
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
                            PrimaryInitiative = [];
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

//save selected plogs
$('#checkboxes1').click(function () {
    var checked = this.checked;
})
var td2 = $(".PerformanceTargetsTable2")
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
//var selected_arr = [];
var PrimaryInitiative1 = new Array();
$(".btn_apply_SavePlogs").on("click",
    function (e) {
        e.preventDefault();
        PrimaryInitiative1 = [];
        $.each($(".PerformanceTargetsTable2 tr.active"), function () {
            //procurement category
            var checkbox_value = $('#selectedplogactivity').val();
            var Targets1 = {};
            Targets1.targetNumber1 = ($(this).find('td').eq(1).text());
            PrimaryInitiative1.push(Targets1);
        });
        var postData = {
            catgeories: PrimaryInitiative1
        };
        console.log(JSON.stringify(PrimaryInitiative1))
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
                    data: '{targetNumber1: ' + JSON.stringify(PrimaryInitiative1) + '}',
                    url: "NewPerformanceLogEntry.aspx/SubmitSelectedPlogCategories",
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
                            PrimaryInitiative1 = [];
                            $('#plogsActivities').modal('hide');
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
                            PrimaryInitiative1 = [];
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
    $("body").on("click", "#btnSave", function () {
        //Loop through the Table rows and build a JSON array.
        var CoreInitiatives = new Array();
        $(".primaryInitiativeTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entrynumber = row.find('td:eq(0)').html();
            primiarydetails.startdate = row.find("TD input").eq(0).val();
            primiarydetails.enddate = row.find("TD input").eq(1).val();
            primiarydetails.agreedtarget = row.find("TD input").eq(2).val();
            primiarydetails.assignedweight = row.find("TD input").eq(3).val();
            primiarydetails.comments = row.find("TD input").eq(4).val();
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
            url: "NewIndividualScoreCard.aspx/InsertCoreInitiatives",
            dataType: "json",
            success: function (status) {
                var registerstatus = status.d;
                switch (registerstatus) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Core Activities Submitted!",
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

   
    ////////////////////////////////////////
    //plog targets
    $("body").on("click", "#btnSaveTargets", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".PerformanceTargetsTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entrynumber = row.find('td:eq(0)').html();
            primiarydetails.docNo = row.find('td:eq(1)').html();
            primiarydetails.description = row.find('td:eq(2)').html();
            primiarydetails.actualTarget = row.find('td:eq(5)').html();
            primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
            primiarydetails.comments = row.find("TD input").eq(1).val();                    
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "NewPerformanceLogEntry.aspx/InsertTergets",
            data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Targets Added!",
                            text: "Achieved Targets saved successfully!",
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Achieved Targets saved successfully!");
                        });
                        break;

                    case "componentnull":
                        Swal.fire
                        ({
                            title: "Component not filled!",
                            text: "Component field empty!",
                            type: "danger"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').attr("class", "alert alert-danger");
                            $("#feedback").html("Component field empty!");
                        });
                        break;
                    default:
                        Swal.fire
                        ({
                            title: "Error!!!",
                            text: status.d,
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(status.d);
                        });

                        break;
                }
            },
            error: function (err) {
                console.log(err.statusText);
                console.log(status.d);
            }

        });

        console.log(PerformanceLogs);

    });

    ////////////////////////////////////////
    //sub plog lines
    $("body").on("click", "#btnSaveSubPlogLines", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".PlogSubIndicatorTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entryNo = row.find('td:eq(0)').html();
            primiarydetails.plogNo = row.find('td:eq(1)').html();
            primiarydetails.initiativeNo = row.find('td:eq(2)').html();
            primiarydetails.pcId = row.find('td:eq(3)').html();
            primiarydetails.achievedTarget = row.find("TD input").eq(0).val();
            primiarydetails.comments = row.find("TD input").eq(1).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "SubPlogIndicators.aspx/InsertSubPlogLines",
            data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Data Added!",
                            text: status.d,
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Achieved Targets saved successfully!");
                        });
                        break;

                    case "componentnull":
                        Swal.fire
                        ({
                            title: "Component not filled!",
                            text: status.d,
                            type: "danger"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').attr("class", "alert alert-danger");
                            $("#feedback").html("Component field empty!");
                        });
                        break;
                    default:
                        Swal.fire
                        ({
                            title: "Error!!!",
                            text: "Error Occured",
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(status.d);
                        });

                        break;
                }
            },
            error: function (err) {
                console.log(err.statusText);
                console.log(status.d);
            }

        });

        console.log(PerformanceLogs);

    });

    //standard appraisal sub objectives and outcomes
    $("body").on("click", "#btnStandardAppraisalSubObjectives", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".StandardAppraisalSubObjectivesTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entryNo = row.find('td:eq(0)').html();
            primiarydetails.plogNo = row.find('td:eq(1)').html();
            primiarydetails.initiativeNo = row.find('td:eq(2)').html();
            primiarydetails.achievedTarget = row.find("TD input").eq(0).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "StandardAppraisalSubIndicatorsDetails.aspx/InsertStandardAppraisalSubObjectives",
            data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Data Added!",
                            text: status.d,
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Achieved Targets saved successfully!");
                        });
                        break;

                    case "componentnull":
                        Swal.fire
                        ({
                            title: "Component not filled!",
                            text: status.d,
                            type: "danger"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').attr("class", "alert alert-danger");
                            $("#feedback").html("Component field empty!");
                        });
                        break;
                    default:
                        Swal.fire
                        ({
                            title: "Error!!!",
                            text: "Error Occured",
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(status.d);
                        });

                        break;
                }
            },
            error: function (err) {
                console.log(err.statusText);
                console.log(status.d);
            }

        });

        console.log(PerformanceLogs);

    });

    //insert JD targets
    $("body").on("click", ".btn_saveJDTargets", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".JDTargetsTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entrynumber = row.find('td:eq(0)').html();
            primiarydetails.workplanno = row.find('td:eq(1)').html();
            primiarydetails.annualtarget = row.find("TD input").eq(0).val();
            primiarydetails.assignedweight = row.find("TD input").eq(1).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "NewIndividualScoreCard.aspx/InsertJDTergets",
            data: '{primiarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Targets Added!",
                            text: "Job Description activities saved successfully!",
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Job Description activities saved successfully!");
                        });
                        break;

                    case "componentnull":
                        Swal.fire
                        ({
                            title: "Component not filled!",
                            text: "Component field empty!",
                            type: "danger"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').attr("class", "alert alert-danger");
                            $("#feedback").html("Component field empty!");
                        });
                        break;
                    default:
                        Swal.fire
                        ({
                            title: "Error!!!",
                            text: "Error Occured",
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(status.d);
                        });

                        break;
                }
            },
            error: function (err) {
                console.log(err.statusText);
                console.log(status.d);
            }

        });

        console.log(PerformanceLogs);

    });

    //PLOG DETAILS
    // insert plog targets(new version)
    $("body").on("click", "#btnSavePlogAllTargets", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".PerformanceTargetsTableData TBODY TR").each(function () {
            alert = "found!";
            var row = $(this);

            var Entrynumber = row.find('td:eq(0)').html();
            var DocNo = row.find('td:eq(1)').html();
            var Description = row.find('td:eq(2)').html();
            var Agreedtarget = row.find("TD input").eq(0).val();
            var Comments = row.find("TD input").eq(1).val();
            var Attachment = row.find("TD input").eq(2).get(0).files[0];

            fd = new FormData();
            fd.append('nAttachment', Attachment);
            fd.append('nEntrynumber', Entrynumber);
            fd.append('nDocNo', DocNo);
            fd.append('nDescription', Description);
            fd.append('nAgreedtarget', Agreedtarget);
            fd.append('nComments', Comments);

        });
        console.log(JSON.stringify(fd))
        //Swal Message
        Swal.fire({
            title: "Confirm Past Experience Details Submission?",
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
                    url: "PerformanceLog.aspx/InsertPlogTargets/",
                    type: "POST",
                    traditional: true,
                    data: fd,
                    contentType: false,
                    cache: false,
                    processData: false

                    //cache: false,

                    //traditional: true

                    //url: "PerformanceLog.aspx/InsertPlogTargets/",
                    //type: "POST",
                    //traditional: true,
                    //data: fd,
                    //data: { Attachment: Attachment, Entrynumber: Entrynumber, DocNo: DocNo, Description: Description, Agreedtarget: Agreedtarget, Comments: Comments },
                    //dataType: "json",
                    //contentType: "application/json; charset=utf-8",
                    //cache: false,
                    //processData: false
                }).done(function (status) {
                    var registerstatus = status.split('*');
                    status = registerstatus[0];
                    switch (status) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Past Experience Details Submitted!",
                                text: status,
                                type: "success"
                            }).then(() => {
                                $("#pastexperiencefeedback").css("display", "block");
                                $("#pastexperiencefeedback").css("color", "green");
                                $('#pastexperiencefeedback').attr("class", "alert alert-success");
                                $("#pastexperiencefeedback").html("Your Past Experience Details have been successfully submitted.Kindly Proceed to fill in the rest details!");
                                $("#pastexperiencefeedback").css("display", "block");
                                $("#pastexperiencefeedback").css("color", "green");
                                $("#pastexperiencefeedback").html("Your Past Experience Details have been successfully submitted.Kindly Proceed to fill in the rest details!");
                            });
                            VendorPastExperienceDetails.init();
                            $('#add_pastexperience').modal('hide');
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "Past Experience Details Submission Error!!!",
                                text: "Your Past Experience Details could not be submitted.Kindly Proceed to fill in the rest details!" + " " + registerstatus[1],
                                type: "error"
                            }).then(() => {
                                $("#pastexperiencefeedback").css("display", "block");
                                $("#pastexperiencefeedback").css("color", "red");
                                $('#pastexperiencefeedback').addClass('alert alert-danger');
                                $("#pastexperiencefeedback").html("Your Past Experience Details could not be submitted.Kindly Proceed to fill in the rest details!" + " " + registerstatus[1]);
                            });
                            break;
                    }
                }
                );
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Past Experience Details Registration Cancelled',
                    'You cancelled your supplier Past Experience registration submission details!',
                    'error'
                );
            }
        });

    });
    //insert selected core initiatives to plogs lines
    $('#checkBoxAllGoods').click(function () {
        var checked = this.checked;
    })
    var td2 = $(".primaryActivityInitiativeTableDetails1")
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
    //var selected_arr = [];
    var PrimaryInitiative = new Array();
    $(".btn_applyallselectedActvities1").on("click",
        function (e) {
            e.preventDefault();
            PrimaryInitiative = [];
            $.each($(".primaryActivityInitiativeTableDetails1 tr.active"), function () {
                //procurement category
                var checkbox_value = $('#selectedactivityrecords1').val();
                var Targets = {};
                Targets.targetNumber = ($(this).find('td').eq(2).text());
                Targets.plogNo = ($(this).find('td').eq(1).text());
                PrimaryInitiative.push(Targets);
            });
            var postData = {
                catgeories: PrimaryInitiative
            };
            console.log(JSON.stringify(PrimaryInitiative))
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
                        data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                        url: "PerformanceLog.aspx/SubmitSelectedCoreInitiatives",
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
                                PrimaryInitiative = [];
                                $('#primaryActivities').modal('hide');
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
                                PrimaryInitiative = [];
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

    //insert selected additional initiatives to plogs lines
    $('#checkBoxAllGoods').click(function () {
        var checked = this.checked;
    })
    var td2 = $(".AdditionalToPlogTableDetails")
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
    //var selected_arr = [];
    var PrimaryInitiative = new Array();
    $(".btn_AdditionalToPlogTableDetails").on("click",
        function (e) {
            e.preventDefault();
            PrimaryInitiative = [];
            $.each($(".AdditionalToPlogTableDetails tr.active"), function () {
                //procurement category
                var checkbox_value = $('#selectedactivityrecords2').val();
                var Targets = {};
                Targets.targetNumber = ($(this).find('td').eq(2).text());
                Targets.plogNo = ($(this).find('td').eq(1).text());
                PrimaryInitiative.push(Targets);
            });
            var postData = {
                catgeories: PrimaryInitiative
            };
            console.log(JSON.stringify(PrimaryInitiative))
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
                        data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                        url: "PerformanceLog.aspx/SubmitSelectedAddInitiatives",
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
                                PrimaryInitiative = [];
                                $('#primaryActivities').modal('hide');
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
                                PrimaryInitiative = [];
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

    //insert selected JD to plogs lines
    $('#checkBoxAllGoods').click(function () {
        var checked = this.checked;
    })
    var td2 = $(".JDInitiativeTableDetails")
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
    //var selected_arr = [];
    var PrimaryInitiative = new Array();
    $(".btn_JDInitiativeTableDetails").on("click",
        function (e) {
            e.preventDefault();
            PrimaryInitiative = [];
            $.each($(".JDInitiativeTableDetails tr.active"), function () {
                //procurement category
                var checkbox_value = $('#selectedactivityrecords3').val();
                var Targets = {};
                Targets.targetNumber = ($(this).find('td').eq(2).text());
                Targets.plogNo = ($(this).find('td').eq(1).text());
                PrimaryInitiative.push(Targets);
            });
            var postData = {
                catgeories: PrimaryInitiative
            };
            console.log(JSON.stringify(PrimaryInitiative))
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
                        data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                        url: "PerformanceLog.aspx/SubmitSelectedJDInitiatives",
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
                                PrimaryInitiative = [];
                                $('#primaryActivities').modal('hide');
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
                                PrimaryInitiative = [];
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

    //insert sub-plog lines
    $("body").on("click", "#btnSaveSubPlogLines", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".PlogSubIndicatorTable TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.entryNo = row.find('td:eq(0)').html();
            primiarydetails.plogNo = row.find('td:eq(1)').html();
            primiarydetails.initiativeNo = row.find('td:eq(2)').html();
            primiarydetails.pcId = row.find('td:eq(3)').html();
            primiarydetails.achievedTarget = row.find("TD input").eq(0).val();
            primiarydetails.comments = row.find("TD input").eq(1).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "SubPlogIndicators.aspx/InsertSubPlogLines",
            data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Data Added!",
                            text: status.d,
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Achieved Targets saved successfully!");
                        });
                        break;

                    case "componentnull":
                        Swal.fire
                        ({
                            title: "Component not filled!",
                            text: status.d,
                            type: "danger"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').attr("class", "alert alert-danger");
                            $("#feedback").html("Component field empty!");
                        });
                        break;
                    default:
                        Swal.fire
                        ({
                            title: "Error!!!",
                            text: "Error Occured",
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(status.d);
                        });

                        break;
                }
            },
            error: function (err) {
                console.log(err.statusText);
                console.log(status.d);
            }

        });

        console.log(PerformanceLogs);

    });

    //Insert Standard Appraisal Objectives
    $("body").on("click", "#btn_objectivesandoutcomes", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".objectivesandoutcomes TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.Olineno = row.find('td:eq(0)').html();
            primiarydetails.Otargetquantity = $("#txtagreedtarget").val();
            //primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "NewStandardAppraisal.aspx/InsertObjectives",
            data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Targets Added!",
                            text: "Achieved Targets saved successfully!",
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Achieved Targets saved successfully!");
                            location.reload();
                            return false;
                        });
                        break;

                    case "componentnull":
                        Swal.fire
                        ({
                            title: "Component not filled!",
                            text: "Component field empty!",
                            type: "danger"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').attr("class", "alert alert-danger");
                            $("#feedback").html("Component field empty!");
                        });
                        break;
                    default:
                        Swal.fire
                        ({
                            title: "Error!!!",
                            text: "Error Occured",
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(status.d);
                        });

                        break;
                }
            },
            error: function (err) {
                console.log(err.statusText);
                console.log(status.d);
            }

        });

        console.log(PerformanceLogs);
    });

    //Insert Standard Appraisal Proficiency
    $("body").on("click", "#btn_proficiencyandevaluation", function () {
        //Loop through the Table rows and build a JSON array.
        var PerformanceLogs = new Array();
        $(".proficiencyandevaluation TBODY TR").each(function () {
            var row = $(this);
            var primiarydetails = {};
            primiarydetails.lineno = row.find('td:eq(0)').html();
            primiarydetails.targetquantity = $("#txttarget").val();
            //primiarydetails.agreedtarget = row.find("TD input").eq(0).val();
            PerformanceLogs.push(primiarydetails);
        });
        console.log(JSON.stringify(PerformanceLogs))

        $.ajax({
            type: "POST",
            url: "NewStandardAppraisal.aspx/InsertProfiency",
            data: '{primarydetails: ' + JSON.stringify(PerformanceLogs) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                    case "success":
                        Swal.fire
                        ({
                            title: "Targets Added!",
                            text: "Achieved Targets saved successfully!",
                            type: "success"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "green");
                            $('#feedback').attr("class", "alert alert-success");
                            $("#feedback").html("Achieved Targets saved successfully!");
                            location.reload();
                            return false;
                        });
                        break;

                    case "componentnull":
                        Swal.fire
                        ({
                            title: "Component not filled!",
                            text: "Component field empty!",
                            type: "danger"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').attr("class", "alert alert-danger");
                            $("#feedback").html("Component field empty!");
                        });
                        break;
                    default:
                        Swal.fire
                        ({
                            title: "Error!!!",
                            text: "Error Occured",
                            type: "error"
                        }).then(() => {
                            $("#feedback").css("display", "block");
                            $("#feedback").css("color", "red");
                            $('#feedback').addClass('alert alert-danger');
                            $("#feedback").html(status.d);
                        });

                        break;
                }
            },
            error: function (err) {
                console.log(err.statusText);
                console.log(status.d);
            }

        });

        console.log(PerformanceLogs);
    });

});


