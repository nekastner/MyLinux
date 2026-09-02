import QtQuick 2.15
import QtQuick.Controls 2.15

Label
{
	id: userHint

	width: 500
	color: "#ffffff"
	
	text: ""

	anchors.horizontalCenter: parent.horizontalCenter

	horizontalAlignment: Text.AlignHCenter
	verticalAlignment: Text.AlignVCenter

	background: Rectangle
	{
		id: userHintBackground

		color: "#333333"
		radius: 4
	}
}
