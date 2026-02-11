local M = {}

M.CONFIG_FILENAMES = {
	".stylelintrc",
	".stylelintrc.mjs",
	".stylelintrc.cjs",
	".stylelintrc.js",
	".stylelintrc.json",
	".stylelintrc.yaml",
	".stylelintrc.yml",
	"stylelint.config.js",
	"stylelint.config.mjs",
	"stylelint.config.cjs",
	"stylelint.config.ts",
	"stylelint.config.mts",
	"stylelint.config.cts",
}

M.WATCHED_CONFIG_FILENAMES = M.CONFIG_FILENAMES

return M
