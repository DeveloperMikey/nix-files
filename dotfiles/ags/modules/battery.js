const battery = await Service.import('battery')

const module = {}

module.BatteryIcon = () => Widget.Icon({
	icon: battery.bind('icon_name')
})

module.BatteryLabel = () => Widget.Label({
	visible: battery.bind('available'),
	class_name: battery.bind('charging').as(ch => ch ? 'charging' : 'battery'),
	label: battery.bind('percent').transform(p => `${p}%`)
})

module.BatteryBox = () => Widget.Box({
	class_name: 'barbox',
	children: [
		module.BatteryIcon(),
		module.BatteryLabel()
	]
})

export default module
