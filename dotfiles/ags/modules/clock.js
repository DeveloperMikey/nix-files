const module = {}

module.day = Variable('', {
	poll: [10000, 'date +"%a"']
})

module.date = Variable('', {
	poll: [10000, 'date +"%m/%d"']
})

module.time = Variable('', {
	poll: [1000, 'date +"%H:%M"']
})

module.DayName = () => Widget.Label({
	class_name: 'dayname_label',
	label: module.day.bind(),
})

module.Clock = () => Widget.Label({
	class_name: 'clock_label',
  label: module.time.bind(),
});

module.Date = () => Widget.Label({
	class_name: 'date_label',
	label: module.date.bind()
})

module.DateBox = () => Widget.Box({
	class_name: 'barbox',
	children: [
		module.DayName(),
		module.Date(),
		module.Clock(),
	]
})

export default module
