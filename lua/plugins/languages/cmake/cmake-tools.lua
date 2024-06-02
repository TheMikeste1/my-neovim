local function open_overseer(task)
	require("overseer").open({ enter = false, direction = "bottom" })
end

return {
	"Civitasv/cmake-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/overseer.nvim",
	},
	opts = {
		cmake_regenerate_on_save = false,
		cmake_build_directory = "build",
		cmake_kits_path = "~/.local/share/CMakeTools/cmake-tools-kits.json",
		cmake_executor = {
			name = "overseer",
			default_opts = {
				overseer = {
					new_task_opts = {
						components = {
							{
								"unique",
								restart_interrupts = false,
							},
							"default",
						},
					},
					on_new_task = open_overseer,
				},
			},
		},
		cmake_runner = {
			name = "overseer",
			default_opts = {
				overseer = {
					new_task_opts = {
						components = {
							{
								"unique",
								restart_interrupts = false,
							},
							"default",
						},
					},
					on_new_task = open_overseer,
				},
			},
		},
		cmake_notifications = {
			runner = { enabled = false },
			executor = { enabled = false },
		},
	},
	cmd = {
		"CMakeGenerate",
		"CMakeBuild",
		"CMakeRun",
		"CMakeDebug",
		"CMakeRunTest",
		"CMakeLaunchArgs",
		"CMakeSelectBuildType",
		"CMakeSelectBuildTarget",
		"CMakeSelectLaunchTarget",
		"CMakeSelectKit",
		"CMakeSelectConfigurePreset",
		"CMakeSelectBuildPreset",
		"CMakeSelectCwd",
		"CMakeSelectBuildDir",
		"CMakeOpenExecutor",
		"CMakeOpenRunner",
		"CMakeCloseExecutor",
		"CMakeCloseRunner",
		"CMakeInstall",
		"CMakeClean",
		"CMakeStopExecutor",
		"CMakeStopRunner",
		"CMakeQuickBuild",
		"CMakeQuickRun",
		"CMakeQuickDebug",
		"CMakeShowTargetFiles",
		"CMakeSettings",
		"CMakeTargetSettings",
	},
}
