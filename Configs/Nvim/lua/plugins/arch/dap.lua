return {
	"mfussenegger/nvim-dap",

	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},

	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debugging starten",
		},
		{
			"<F9>",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Breakpoint setzen",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "Step over",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "Step into",
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
			desc = "Step out",
		},
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end

		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}

		local function executable()
			return vim.fn.input(
				"Executable: ",
				vim.fn.getcwd() .. "/build/",
				"file"
			)
		end

		dap.configurations.c = {
			{
				name = "Launch executable",
				type = "gdb",
				request = "launch",
				program = executable,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMain = false,
			},
		}

		dap.configurations.cpp = dap.configurations.c
	end,
}
