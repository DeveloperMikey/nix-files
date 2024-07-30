const network = await Service.import("network");

const NetworkBarButton = () => {
	return Widget.Box({
		vpack: "center",
		class_name: "network-button bar-content",
		children: [
			Widget.Icon({
				icon: network.wifi.bind('icon_name'),
			}),
			Widget.Label({
				label: network.wifi.bind('ssid')
					.as(ssid => ssid || 'Unknown'),
			}),
		]
	})
}

export { NetworkBarButton }
