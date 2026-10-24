import "components"

import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

SessionManagementScreen {
    property bool showUsernamePrompt: !showUserList
    property int usernameFontSize
    property string usernameFontColor
    property string lastUserName
    property bool passwordFieldOutlined: config.PasswordFieldOutlined == "true"
    property bool hidePasswordRevealIcon: config.HidePasswordRevealIcon == "false"
    property int visibleBoundary: mapFromItem(loginButton, 0, 0).y
    onHeightChanged: visibleBoundary = mapFromItem(loginButton, 0, 0).y + (loginButton ? loginButton.height : 0) + units.smallSpacing

    signal loginRequest(string username, string password)

    onShowUsernamePromptChanged: {
        if (!showUsernamePrompt) { lastUserName = "" }
    }

    function startLogin() {
        var username = showUsernamePrompt ? userNameInput.text : userList.selectedUser
        var password = passwordBox.text
        loginButton.forceActiveFocus();
        loginRequest(username, password);
    }

    // Specjalny kontener do wymuszenia idealnego wyśrodkowania na ekranie
    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 34
        visible: showUsernamePrompt

        PlasmaComponents.TextField {
            id: userNameInput
            width: 300
            height: 34
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            font.family: "Cantarell"
            font.pointSize: fontSize + 1
            font.weight: Font.Bold
            text: lastUserName
            focus: showUsernamePrompt && !lastUserName
            placeholderText: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Username")

            style: TextFieldStyle {
                textColor: "white"
                placeholderTextColor: "#dddddd"
                padding { left: 15; right: 15 }
                background: Rectangle {
                    radius: 17
                    color: "#33ffffff"
                    border.color: "#80ffffff"
                    border.width: 1
                }
            }
        }
    }

    // Specjalny kontener dla hasła
    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 34

        PlasmaComponents.TextField {
            id: passwordBox
            width: 300
            height: 34
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            font.family: "Cantarell"
            font.pointSize: fontSize + 2
            font.weight: Font.Bold
            placeholderText: "Enter Password"
            focus: !showUsernamePrompt || lastUserName
            echoMode: TextInput.Password
            revealPasswordButtonShown: hidePasswordRevealIcon
            onAccepted: startLogin()

            style: TextFieldStyle {
                textColor: "white"
                placeholderTextColor: "#dddddd"
                passwordCharacter: "●"
                padding { left: 15; right: 15 }
                background: Rectangle {
                    radius: 17
                    color: "#33ffffff" 
                    border.color: "#80ffffff"
                    border.width: 1
                }
            }

            Keys.onEscapePressed: { mainStack.currentItem.forceActiveFocus(); }
            Keys.onPressed: {
                if (event.key == Qt.Key_Left && !text) { userList.decrementCurrentIndex(); event.accepted = true }
                if (event.key == Qt.Key_Right && !text) { userList.incrementCurrentIndex(); event.accepted = true }
            }
            Keys.onReleased: {
                if (loginButton.opacity == 0 && length > 0) { showLoginButton.start() }
                if (loginButton.opacity > 0 && length == 0) { hideLoginButton.start() }
            }

            Connections {
                target: sddm
                function onLoginFailed() {
                    passwordBox.selectAll()
                    passwordBox.forceActiveFocus()
                }
            }
        }

        Image {
            id: loginButton
            source: "assets/login.svgz"
            smooth: true
            sourceSize: Qt.size(24, 24)
            anchors {
                left: passwordBox.right
                verticalCenter: passwordBox.verticalCenter
                leftMargin: 10
            }
            visible: opacity > 0
            opacity: 0
            MouseArea { anchors.fill: parent; onClicked: startLogin(); }
            PropertyAnimation { id: showLoginButton; target: loginButton; properties: "opacity"; to: 0.8; duration: 100 }
            PropertyAnimation { id: hideLoginButton; target: loginButton; properties: "opacity"; to: 0; duration: 80 }
        }
    }
}
