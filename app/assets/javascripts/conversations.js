var bootbox = bootbox || {};

(function () {
    "use strict";

    $(document).on("click", "#new-conversation", function () {
        bootbox.prompt({
            title: "Enter all recipients, separated by commas (,)",
            className: "bootbox-md",

            callback: function (result) {
                if (result) {
                    $.ajax({
                        url: "/conversations",
                        type: "POST",
                        data: { recipients: result },

                        success: function () {
                            window.location.reload(true);
                        }
                    });
                }
            }
        });
    });
}());
