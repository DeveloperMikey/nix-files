const entry = '/home/mike/nix-files/dotfiles/ags/ts/main.ts'
const outdir = '/tmp/ags/js'

try {
	await Utils.execAsync([
		'bun', 'build', entry,
		'--outdir', outdir,
		'--external', 'resource://*',
		'--external', 'gi://*',
		'--external', 'file://*',
	])
	await import(`file://${outdir}/main.js`)
} catch (error) {
	console.error(error)
}
