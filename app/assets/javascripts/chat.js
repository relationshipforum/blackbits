var moment = window.moment || {},
    ReconnectingWebSocket = ReconnectingWebSocket || {};

(function () {
    "use strict";

    var url = "ws",
        scrolledToBottom = true,
        socket;

    if (window.location.protocol.match("https")) {
        url += "s";
    }

    url += "://" + window.location.host + "/chats/socket";

    function onMessage(e) {
        var data = JSON.parse(e.data),
            panel = $("#chat .panel-body"),
            time = moment(data.timestamp),
            template;

        template = " " +
            "<div class='message' style='padding-top:0px'>" +
                "(" + time.format("h:mm a") + ") " +
                "<a href='/users/" + data.slug + "'>" +
                    data.username +
                "</a>" +
                ": " + data.message +
            "</div>";

        panel.append(template);
        panel.scrollTop(panel[0].scrollHeight);
    }

    function reloadChat() {
        var conversationId = $("#chat").data("conversation-id") || "global";

        $.ajax({
            type: "GET",
            url: "/chats/load",
            data: { conversation_id: conversationId },

            success: function (data) {
                var panel;

                $("#chat").replaceWith(data);

                panel = $("#chat .panel-body");

                if (scrolledToBottom === true) {
                    if (panel && panel[0] && panel[0].scrollHeight) {
                        panel.scrollTop(panel[0].scrollHeight);
                    }
                }
            }
        });
    }

    function onClose(e) {
        reloadChat();
    }

    function sendMessage() {
        var input = $("#chat-input").val();

        if (input) {
            socket.send(input);
            $("#chat-input").val("");
        }

        return false;
    }

    $(document).on("submit", "#chat form", sendMessage);
    $(document).on("keypress", "#chat-input", function (e) {
        if (e.keyCode === 13) {
            sendMessage();
            e.preventDefault();
        }
    });

    $(document).on("ready", function () {
        var panel = $("#chat .panel-body"),
            conversationId = $("#chat").data("conversation-id") || "global";

        if (panel && panel[0] && panel[0].scrollHeight) {
            panel.scrollTop(panel[0].scrollHeight);

            url += "?conversation_id=" + conversationId;

            socket = new ReconnectingWebSocket(url);
            socket.onmessage = onMessage;
            socket.onclose = onClose;

            panel.on("scroll", function () {
                scrolledToBottom = $(this).scrollTop() +
                    $(this).innerHeight() >= this.scrollHeight;
            });
        }
    });
}());
