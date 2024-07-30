const audio = await Service.import('audio')

const VolumeBarButton = () => {
	const icons = {
		99: "󰕾",
		66: "󰕾",
		34: "󰖀",
		1: "󰕿",
		0: "󰝟",
	};

	const getIcon = () => {
		const icon = Utils.merge(
			[audio.speaker.bind("is_muted"), audio.speaker.bind("volume")],
			(isMuted, vol) => {
				return isMuted
					? 0
					: [101, 66, 34, 1, 0].find((threshold) => threshold <= vol * 100);
			},
		);

		return icon.as((i) => i !== undefined ? icons[i] : 101);
	};

	return Widget.Box({
		class_name: 'bar-content',
		children: [
			Widget.Label({
				label: Utils.merge([getIcon(), audio.speaker.bind('volume')], (icon, volume) => {
					return `${icon} ${Math.round(volume * 100)}%`
				})
			})
		]
	})
}

export { VolumeBarButton }
