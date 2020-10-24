import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    width: 640 + 9*5 + 2*10 // Width calculations
    height: 640 + 9*5 + 2*10
    visible: true
    title: qsTr("Pairs")
    color: "gold"

    Grid {
        id: grid
        property int lastIndex: -1 // For correct resetting after second wrong try
        property int currentIndex: -1
        anchors.fill: parent
        anchors.margins: 10
        rows: 10
        rowSpacing: 5
        columns: 10
        columnSpacing: 5

        Repeater { // There is no insertions/deletions in model, so Repeater is ok.
            id: repeater
            model: 100

            Flipable {
                id: flipable
                width: 64
                height: 64

                property bool flipped: false
                property url coverPath: "/res/generic.png"
                property url imagePath: index < 50 ? "/res/" + (index + 1) + ".png" : "/res/" + (index - 49) + ".png"

                front: Image { source: flipable.coverPath; anchors.centerIn: parent }
                back: Image { source: flipable.imagePath; anchors.centerIn: parent }

                transform: Rotation {
                    id: rotation
                    origin.x: flipable.width/2
                    origin.y: flipable.height/2
                    axis.x: 0; axis.y: 1; axis.z: 0
                    angle: 0
                }

                states: State {
                    name: "back"
                    PropertyChanges { target: rotation; angle: 180 }
                    when: flipable.flipped
                }

                transitions: Transition {
                    NumberAnimation { target: rotation; property: "angle"; duration: 1000 }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: { flip(index) }
                }
            }
        }

        Timer { // Makes delay after second wrong try
            id: timer
            interval: 1000; running: false; repeat: false
            onTriggered: {
                console.log("Timer triggered.")
                repeater.itemAt(grid.lastIndex).flipped = false
                repeater.itemAt(grid.currentIndex).flipped = false
                grid.lastIndex = -1
            }
        }

    }

    function flip(index) { // Logic of the game
        if (!repeater.itemAt(index).flipped) {
            console.log("Flip.")
            repeater.itemAt(index).flipped = true
            if (grid.lastIndex === -1) {
                grid.lastIndex = index
                console.log("Wait for second flip, last index = " + grid.lastIndex)
            } else {
                console.log("Second flip.")
                if (repeater.itemAt(index).imagePath === repeater.itemAt(grid.lastIndex).imagePath) { // Match is the same pictures
                    console.log("Match!")
                    grid.lastIndex = -1
                } else {
                    console.log("Not match, reset.")
                    grid.currentIndex = index
                    timer.start()
                }
            }
        } else {
            console.log("Already flipped.")
        }
    }
}
