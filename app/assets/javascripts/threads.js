(function () {
    "use strict";

    $(document).on("ready page:load", function () {
        $(".markdown").markdown({
            iconlibrary: "fa"
        });

        $("#new-thread-form").validate({
            rules: {
                "thread[forum_id]": {
                    required: true
                },
                "thread[title]": {
                    required: true
                },
                "thread[body]": {
                    required: true
                }
            }
        });
    });
}());
