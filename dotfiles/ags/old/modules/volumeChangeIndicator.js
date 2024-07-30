const audio = await Service.import('audio')
let canPop = false
let visible = Variable(false)

let disappearTimeout;

const Indicator = () => {

	const levelBar = Widget.LevelBar({
		'bar-mode': 'continuous',
		vertical: true,
		widthRequest: 80,
	})
	console.log(levelBar['class-names'])

	const indicator = Widget.Box({
		spacing: 2,	
		homogeneous: false,
		vertical: true,
		class_name: "indicator-bar",
		hexpand: false,
		vexpand: false,
		children: [
			levelBar
		],
	})

	setTimeout(() => { canPop = true }, 2500) // ignore startup calls

	indicator.hook(audio, (self) => {
		if (!canPop) { return }
		visible.setValue(true)

		if (disappearTimeout) {
			disappearTimeout.destroy()
		}

		disappearTimeout = setTimeout(() => { visible.setValue(false) }, 3500)
		levelBar.value = audio.speaker.volume
	}, "speaker-changed")

	indicator.hook(audio, (self) => {
		if (!canPop) { return }

		visible.setValue(true)
		if (disappearTimeout) {
			disappearTimeout.destroy()
		}

		disappearTimeout = setTimeout(() => { visible.setValue(false) }, 3500)
	}, "microphone-changed")

	return indicator
}

const IndicatorSideBar = (monitor = 0) => Widget.Window({
	name: `indicatorBar_${monitor}`,
	class_name: 'indicator-bar-window',
	monitor: monitor,
	anchor: ['right'],
	exclusivity: 'ignore',
	child: Indicator(),
	keymode: 'none',
	visible: visible.bind() 
})

export { Indicator, IndicatorSideBar }
