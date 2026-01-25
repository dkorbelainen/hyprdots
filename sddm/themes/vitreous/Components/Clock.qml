// Author: sane1090x (https://github.com/sane1090x)
// Copyright (C) 2025– sane1090x
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
    id: clock

    width: parent.width / 2
    spacing: 0

    Label {
        id: headerTextLabel

        anchors.horizontalCenter: parent.horizontalCenter

        font.pointSize: root.font.pointSize * 3
        color: config.HeaderTextColor
        renderType: Text.QtRendering
        text: config.HeaderText
    }

    Label {
        id: timeLabel

        anchors.horizontalCenter: parent.horizontalCenter

        font.pointSize: root.font.pointSize * 9
        font.bold: true
        font.family: "PP Neue Machina"
        color: config.TimeTextColor
        renderType: Text.QtRendering

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(config.Locale), config.HourFormat == "long" ? Locale.LongFormat : config.HourFormat !== "" ? config.HourFormat : Locale.ShortFormat);
        }
    }

    // Weather holder (hidden)
    Text {
        id: weatherLabel
        visible: false
        text: ""
    }

    function fetchWeather() {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "file:///run/sddm-weather.txt?t=" + Date.now());
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                weatherLabel.text = (xhr.responseText || "").trim();
                dateLabel.updateTime();
            }
        };
        xhr.send();
    }

    Label {
        id: dateLabel
        anchors.horizontalCenter: parent.horizontalCenter
        color: config.DateTextColor
        font.pointSize: root.font.pointSize * 1.5
        font.family: "LondonBetween"
        font.weight: 1000
        renderType: Text.QtRendering

        function updateTime() {
            var dateString = new Date().toLocaleDateString(Qt.locale(config.Locale), config.DateFormat == "short" ? Locale.ShortFormat : (config.DateFormat !== "" ? config.DateFormat : Locale.LongFormat));
            var w = weatherLabel.text;
            text = (w && w.length) ? (dateString + "  •  " + w) : dateString;
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            dateLabel.updateTime();
            timeLabel.updateTime();
        }
    }

    // fetch weather every 10 min AND once immediately
    Timer {
        interval: 10 * 60 * 1000
        repeat: true
        running: true
        triggeredOnStart: true   // fire right away
        onTriggered: fetchWeather()
    }

    Component.onCompleted: {
        fetchWeather();
        dateLabel.updateTime();
        timeLabel.updateTime();
    }
}
