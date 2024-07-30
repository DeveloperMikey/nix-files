import clock from "./clock.js"
import battery from "./battery.js"
import misc from "./bar_misc.js"

const Left = () => Widget.Box({
	class_name: "left_box_bar",
	children: [
		 
	]
})

const Center = () => Widget.Box({
	class_name: "center_box_bar",
	children: [
	]
})

const Right = () => Widget.Box({
	class_name: "right_box_bar",
	hpack: "end",
	children: [
		battery.BatteryBox(),
		misc.MiscBox(),
		clock.DateBox()
	]
})


const Bar = (monitor = 0) => Widget.Window({
    name: `bar_${monitor}`,
    class_name: 'bar',
    monitor,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(),
    }),
});

export default Bar
