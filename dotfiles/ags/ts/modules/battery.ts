const battery = await Service.import("battery");

const BatteryBarLabel = () => {
	const isVis = Variable(battery.available);

	battery.connect("changed", ({ available }) => {
		isVis.value = available;
	});

	const formatTime = (seconds: number) => {
		const hours = Math.floor(seconds / 3600);
		const minutes = Math.floor((seconds % 3600) / 60);
		return { hours, minutes };
	};

	const generateTooltip = (timeSeconds: number, isCharging: boolean, isCharged: boolean) => {
		if (isCharged) {
			return "Fully Charged";
		}

		const { hours, minutes } = formatTime(timeSeconds);
		if (isCharging) {
			return `${hours} hours ${minutes} minutes until full`;
		} else {
			return `${hours} hours ${minutes} minutes left`;
		}
	};

	const component = Widget.Box({
		class_name: "battery-label bar-content",
		visible: battery.bind("available"),
		tooltip_text: battery.bind("time_remaining").as((t) => t.toString()),
		setup: (self) => {
			self.hook(battery, () => {
				if (battery.available) {
					self.tooltip_text = generateTooltip(
						battery.time_remaining,
						battery.charging,
						battery.charged,
					);
				}
			});
		},
		children: [
			Widget.Icon({ icon: battery.bind('icon_name') }),
			Widget.Label({
				label: battery.bind("percent").as((p) => ` ${p}%`),
			}),
		],
	})

	return component
}

export { BatteryBarLabel }
