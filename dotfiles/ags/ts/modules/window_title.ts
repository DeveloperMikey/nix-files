const hyprland = await Service.import("hyprland");
import { ActiveClient } from 'types/service/hyprland'

const filterTitle = (windowtitle: ActiveClient) => {
    const windowTitleMap = [
        ["kitty", "󰄛 Terminal"],
        ["firefox", "󰈹 Firefox"],
        ["webcord", " Discord"],
        ["discord", " Discord"],
        ["vesktop", " Discord"],
        ["steam", " Steam"],
        ["^$", "󰇄 Desktop"],
        ["(.+)", `󰣆 ${windowtitle.class.charAt(0).toUpperCase() + windowtitle.class.slice(1)}`],
    ];

    const foundMatch = windowTitleMap.find((wt) =>
        RegExp(wt[0]).test(windowtitle.class.toLowerCase()),
    );

    return foundMatch ? foundMatch[1] : windowtitle.class;
};

const ClientTitleBar = () => Widget.Label({
	class_name: 'bar-content',
	label: hyprland.active.bind("client").as((v) => filterTitle(v)),
})

export { ClientTitleBar }
