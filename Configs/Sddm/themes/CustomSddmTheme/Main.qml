import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
	id: root
	width: 640
	height: 480
	color: "#000000"

	Column
	{
		anchors.centerIn: parent

		TextField
		{
			id: userInput

			width: 500
			placeholderTextColor: "#000000"

			focus: true

			horizontalAlignment: TextInput.AlignHCenter
			verticalAlignment: TextInput.AlignVCenter

			property string username: ""
			property string password: ""

			state: "usernameInput"

			states:
			[
				State
				{
					name: "usernameInput"
					PropertyChanges
					{
						target: userInput;
						placeholderText: "username...";
						text: "";
						echoMode: TextInput.Normal;
					}
				},
				State
				{
					name: "passwordInput"
					PropertyChanges
					{
						target: userInput;
						placeholderText: "password...";
						text: "";
						echoMode: TextInput.Password;
					}
				},
				State
				{
					name: "tryLogin"
					PropertyChanges
					{
						target: userInput;
						placeholderText: "";
						text: "";
						echoMode: TextInput.Normal;
					}
				}
			]

			onAccepted: evaluateUserInput()
		}
	}

	function evaluateUserInput()
	{
		if (userInput.state === "usernameInput")
		{
			userInput.username = userInput.text
			userInput.state = "passwordInput"
		}
		else if (userInput.state === "passwordInput")
		{
			userInput.password = userInput.text
			userInput.state = "tryLogin"
		}

		userInput.text = ""

		if (userInput.state === "tryLogin")
		{
			sddm.login(root.username, root.password, sessionModel.lastIndex)
		}
	}

	Connections
	{
		target: sddm
		function onLoginFailed()
		{
			userInnut.state = "usernameInput"
		}
	}
}
