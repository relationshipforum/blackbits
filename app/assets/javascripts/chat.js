(function () {
    "use strict";

    var url = "ws",
        socket;

    if (window.location.protocol.match("https")) {
        url += "s";
    }

    url += "://" + window.location.host + "/chats/socket";

    socket = new WebSocket(url);
    socket.onmessage = function (e) {
        console.log(e.data);
        var data = JSON.parse(e.data),
            panel = $("#chat .panel-body"),
            template;

        template = " " +
            "<div class='message' style='padding-top:0px'>" +
                "<a href='/users/" + data.slug + "'>" +
                    data.username +
                "</a>" +
                ": " + data.message +
            "</div>";

        panel.append(template);
        panel.scrollTop(panel[0].scrollHeight);
    };

    function sendMessage() {
        var input = $("#chat-input").val();
        socket.send(input);

        $("#chat-input").val("");

        return false;
    }

    $(document).on("submit", "#chat form", sendMessage);
    $(document).on("keypress", "#chat-input", function (e) {
        if (e.keyCode === 13) {
            sendMessage();
            e.preventDefault();
        }
    });
}());