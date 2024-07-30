import Bar from './modules/bar';

const scss = `/home/mike/nix-files/dotfiles/ags/css/style.scss`
const css = `/tmp/ags/style.css`

Utils.exec(`sassc ${scss} ${css}`)

App.config({
	style: css,
	windows: [Bar()],
})

Utils.monitorFile(
    `/home/mike/nix-files/dotfiles/ags/css/`,

    function() {
        Utils.exec(`sassc ${scss} ${css}`)
        App.resetCss()
        App.applyCss(css)
    },
)
