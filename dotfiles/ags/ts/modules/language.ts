const hyprland = await Service.import('hyprland')

const LanguageLabel = () => {
	return Widget.Label({
		class_name: "bar-content",
	}).hook(hyprland, async (self, _n, layout) => {
		if (!layout) {
			self.label = "...";
			let obj = await Utils.execAsync('hyprctl devices -j')
			let keyboards = JSON.parse(obj)['keyboards'];
			let kb = keyboards.find(val => val.name === 'at-translated-set-2-keyboard');

			layout = kb['active_keymap'];
		}
			self.label = layout;
	}, 'keyboard-layout')
}

export { LanguageLabel }
