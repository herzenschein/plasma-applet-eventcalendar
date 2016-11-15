import QtQuick 2.0
import QtQuick.Layouts 1.1

import org.kde.plasma.core 2.0 as PlasmaCore

Item {
	id: timeModel
	property string timezone: "Local"
	property var currentTime: dataSource.data[timezone]["DateTime"]
	property alias dataSource: dataSource

	signal secondChanged()
	signal minuteChanged()
	signal dateChanged()

	PlasmaCore.DataSource {
		id: dataSource
		engine: "time"
		connectedSources: [timezone]
		interval: 1000
		intervalAlignment: PlasmaCore.Types.NoAlignment
		onNewData: {
			timeModel.tick()
		}
	}

	property int lastMinute: -1
	property int lastDate: -1
	function tick() {
		secondChanged()
		var currentMinute = currentTime.getMinutes()
		if (currentMinute != lastMinute) {
			minuteChanged()
			var currentDate = currentTime.getDate()
			if (currentDate != lastDate) {
				dateChanged()
				lastDate = currentDate
			}
			lastMinute = currentMinute
		}
	}


	property bool testing: false
	Component.onCompleted: {
		if (testing) {
			currentTime = new Date(2016, 1, 1, 23, 59, 55)
		}
	}

	Timer {
		running: testing
		repeat: true
		interval: 1000
		onTriggered: {
			currentTime.setSeconds(currentTime.getSeconds() + 1)
			timeModel.currentTimeChanged()
			timeModel.tick()
		}
	}
}