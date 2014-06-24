var moment = window.moment || {};

(function () {
    "use strict";

    var url = "ws",
        socket;

    if (window.location.protocol.match("https")) {
        url += "s";
    }

    url += "://" + window.location.host + "/chats/socket";

    function onMessage(e) {
        var data = JSON.parse(e.data),
            panel = $("#chat .panel-body"),
            time = moment(data.timestamp.replace(" ", "T").substring(0, 19)),
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

    function onClose() {
        window.location.reload(true);
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
        var panel = $("#chat .panel-body");

        if (panel && panel[0] && panel[0].scrollHeight) {
            panel.scrollTop(panel[0].scrollHeight);

            socket = new WebSocket(url);
            socket.onmessage = onMessage;
            socket.onclose = onClose;
        }
    });
}());
