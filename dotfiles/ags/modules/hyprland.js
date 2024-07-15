const module = {}
const hyprland = await Service.import('hyprland')

module.switchWorkspace = ws => hyprland.messageAsync(`dispatch workspace ${ws}`)

const WorkspaceButton = (i) => Widget.EventBox({
	class_name: "ws-button",
	on_primary_click_release: () => module.switchWorkspace(i)
		.catch(logError),
	child: Widget.Label({
		label: `${i}`,
		class_name: "ws-button-label"
	})
})
.hook(hyprland.active.workspace, (button) => {
	button.toggleClassName("active", hyprland.active.workspace.id === i)
})

module.Workspaces = () => Widget.EventBox({
	child: Widget.Box({
		class_name: "ws-container",
		children: Array.from({length: 10}, (_, i) => i + 1).map(i => WorkspaceButton(i)),
	})
	.hook(hyprland, (box) => {
		box.children.forEach((button, i) => {
			const ws = hyprland.getWorkspace(i + 1)
			const ws_before = hyprland.getWorkspace(i)
			const ws_after = hyprland.getWorkspace(i + 2)

			button.toggleClassName("occupied", ws?.windows > 0)
	button.toggleClassName("occupied-left", !ws_before || ws_after?.windows <= 0)
	button.toggleClassName("occupied-right", !ws_after || ws_after?.windows <= 0)
		})
	}, "notify::workspaces")
})

export default module
