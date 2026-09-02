import QtQuick 2.15
import QtQuick.Controls 2.15

TextField
{
	id: userInput

	property string username: ""
	property string password: ""

	width: 500
	color: "#ffffff"
	placeholderTextColor: "#ffffff"

	anchors.horizontalCenter: parent.horizontalCenter

	horizontalAlignment: TextInput.AlignHCenter
	verticalAlignment: TextInput.AlignVCenter

	background: Rectangle
	{
		id: userInputBackground

		color: "#333333"
		border.color: userInput.activeFocus ? "#ffffff" : "#aaaaaa"
		radius: 4
	}

	onAccepted: evaluateUserInput()
}
