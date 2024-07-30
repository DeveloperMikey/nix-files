import {CalendarBarButton} from './clock'
import {NotificationBarButton} from './notifications'
import {ClientTitleBar} from './window_title'
import {BatteryBarLabel} from './battery'
import {NetworkBarButton} from './network'
import {VolumeBarButton} from './audio'
import {BarWorkspaces} from './workspaces'

const Left = () => Widget.Box({
	class_name: "barbox",
	children: [
		BarWorkspaces() 
	]
})

const Center = () => Widget.Box({
	class_name: "barbox",
	children: [
		ClientTitleBar()
	]
})

const Right = () => Widget.Box({
	class_name: "barbox",
	hpack: "end",
	children: [
		BatteryBarLabel(),
		NetworkBarButton(),
		VolumeBarButton(),
		CalendarBarButton(),
		NotificationBarButton()
	]
})

const bar = (monitor = 0) => Widget.Window({
	name: `bar_${monitor}`,
	class_name: 'bar',
	monitor,
	anchor: ['bottom', 'right', 'left'],
	exclusivity: 'exclusive',
	child: Widget.CenterBox({
		start_widget: Left(),
    center_widget: Center(),
    end_widget: Right(),	
	})
})

export default bar;
