(function () {
    "use strict";

    $(document).on("ready", function () {
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

        $(document).on("click", ".quote-post", function () {
            var panel = $(this).closest(".panel").first(),
                postId = panel.data("post-id"),
                postBody = $(".post-body[data-post-id=" + postId + "]").html().trim(),
                text = $(postBody).text().replace(/\n/g, "\n> ").replace(/[^\S\n]+/g, " ");

            $("#post_body").val("> " + text + "\n\n");
            $(window).scrollTop($(document).height());
            $("#message-details-reply textarea").focus();
        });

        $(document).on("click", ".thank-post", function () {
            var panel = $(this).closest(".panel").first(),
                postId = panel.data("post-id");

            $.ajax({
                url: "/posts/" + postId + "/thanks",
                method: "POST",

                success: function (data) {
                    panel.replaceWith(data);
                }
            });
        });

        $(document).on("ajax:success", "form#message-details-reply", function (e, response) {
            $(".posts-wrapper").append(response);
            $(window).scrollTop($(document).height());
            $("#message-details-reply textarea").val("");
        });

        $(document).on("click", ".delete-post", function () {
            var panel = $(this).closest(".panel"),
                postId = panel.data("post-id");

            $.ajax({
                url: "/posts/" + postId,
                method: "DELETE",

                success: function () {
                    panel.remove();
                }
            });
        });
    });
}());
