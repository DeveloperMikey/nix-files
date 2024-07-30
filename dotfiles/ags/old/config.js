import Bar from "./modules/bar.js"
import { IndicatorSideBar } from "./modules/volumeChangeIndicator.js"

App.config({
	style: "./style.css",
  windows: [
  	Bar(),
		IndicatorSideBar(),
  ],
});
