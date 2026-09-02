import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
	id: root
	width: 640
	height: 480
	color: "#000000"

	state: "usernameInput"

	states:
	[
		State
		{
			name: "usernameInput"
			PropertyChanges
			{
				target: userHint
				text: "Username"
			}
			PropertyChanges
			{
				target: userInput
				placeholderText: "username...";
				echoMode: TextInput.Normal;
			}
		},
		State
		{
			name: "passwordInput"
			PropertyChanges
			{
				target: userHint
				text: "Password"
			}
			PropertyChanges
			{
				target: userInput
				placeholderText: "password...";
				echoMode: TextInput.Password;
			}
		},
		State
		{
			name: "tryLogin"
			PropertyChanges
			{
				target: userHint
				text: ""
			}
			PropertyChanges
			{
				target: userInput
				placeholderText: "";
				echoMode: TextInput.Normal;
			}
		}
	]

	Column
	{
		anchors.centerIn: parent

		spacing: 5

		UserHint
		{
			id: userHint
		}

		UserInput
		{
			id: userInput
			focus: true
		}

	}

	function evaluateUserInput()
	{
		if (root.state === "usernameInput")
		{
			userInput.username = userInput.text
			root.state = "passwordInput"
		}
		else if (root.state === "passwordInput")
		{
			userInput.password = userInput.text
			root.state = "tryLogin"
		}

		userInput.text = ""

		if (root.state === "tryLogin")
		{
			sddm.login(userInput.username, userInput.password, sessionModel.lastIndex)
		}
	}

	Connections
	{
		target: sddm
		function onLoginFailed()
		{
			root.state = "usernameInput"
			userInput.text = ""
			userInputBackground.border.color = "#ff0000"
		}
	}
}
