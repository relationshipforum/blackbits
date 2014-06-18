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

        $("#message-details-reply").expandingInput({
			target: "textarea",
			hidden_content: "> div",
			placeholder: 'Click here to <a htef="#" class="text-muted"><strong>Reply</strong></a>',
			onAfterExpand: function () {
				$("#message-details-reply textarea").attr("placeholder", "").markdown({
					iconlibrary: "fa"
				});
			}
		});

        $(document).on("click", "#thank-post", function () {
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
    });
}());
