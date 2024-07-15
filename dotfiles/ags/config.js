import Bar from "./modules/bar.js"
import { IndicatorSideBar } from "./modules/volumeChangeIndicator.js"

App.config({
	name: "ags-bar",
	style: "./style.css",
  windows: [
  	Bar(),
  ],
});
