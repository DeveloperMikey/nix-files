const audio = await Service.import('audio')

const module = {}

module.AudioIcon = () => Widget.Icon({
	class_name: "misc_bar_item"
}).hook(audio.speaker, self => {
	self.visible = !!audio.speaker.stream
	let isMuted = undefined;
	if (audio.speaker.stream){
		isMuted = audio.speaker.stream.isMuted
	}
	const vol = audio.speaker.volume * 100;
	let icon = [
    [101, 'overamplified'],
    [67, 'high'],
    [34, 'medium'],
    [15, 'low'],
    [0, 'muted'],
  ].find(([threshold]) => threshold <= vol)?.[1];

	if(isMuted){
		icon = 'muted'
	}

  self.icon = `audio-volume-${icon}-symbolic`;
})

module.MicrophoneIcon = () => Widget.Icon({
	class_name: "misc_bar_item"
}).hook(audio.microphone, self => {
	self.visible = !!audio.microphone.stream
	self.icon = `audio-input-microphone-symbolic`
	if (audio.microphone.stream && audio.microphone.stream.isMuted){
		self.icon = `audio-input-microphone-low-symbolic`
		Utils.execAsync(['sudo', 'set-mic-led', "1"])
		.then()
		.catch(err => print(err))
	}else{
		Utils.execAsync(['sudo', 'set-mic-led', "0"])
		.then()
		.catch(err => print(err))
	}
})

module.MiscBox = () => Widget.Box({
	class_name: "barbox",
	children: [
		module.AudioIcon(),
		module.MicrophoneIcon()
	]
})

export default module
