// Version 3

import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.1

ColumnLayout {
	id: configNotification
	property alias label: notificationEnabled.text
	property alias notificationEnabledKey: notificationEnabled.configKey
	property alias sfxEnabledKey: sfxEnabled.configKey
	property alias sfxPathKey: sfxPath.configKey
	property alias sfxPathDefaultValue: sfxPath.defaultValue

	property var sfxTest: Qt.createQmlObject("import QtMultimedia 5.4; Audio {}", configNotification)

	RowLayout {
		id: row1
		spacing: 0
		ConfigCheckBox {
			id: notificationEnabled
			style: CheckBoxStyle {
				// label: Item {}
			}
		}
		// Label {
		// 	id: nameLabel
		// }
	}

	RowLayout {
		spacing: 0
		Item {
			Layout.preferredWidth: sfxEnabled.width * 1.5
		}
		ConfigCheckBox {
			id: sfxEnabled
			style: CheckBoxStyle {
				label: Item {}
			}
		}
		Button {
			iconName: "media-playback-start-symbolic"
			enabled: !!sfxTest
			onClicked: {
				sfxTest.source = sfxPath.value
				sfxTest.play()
			}
		}
		ConfigString {
			id: sfxPath
			Layout.fillWidth: true
		}
		Button {
			iconName: "folder-symbolic"
			onClicked: sfxPathDialog.visible = true

			FileDialog {
				id: sfxPathDialog
				title: i18n("Choose a sound effect")
				folder: '/usr/share/sounds'
				nameFilters: [ "Sound files (*.wav *.mp3 *.oga *.ogg)", "All files (*)" ]
				onAccepted: {
					sfxPath.text = fileUrl
				}
			}
		}
	}
}
