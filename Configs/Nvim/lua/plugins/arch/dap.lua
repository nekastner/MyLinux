return {
	"mfussenegger/nvim-dap",

	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},

	keys = {
		{
			"<F5>",
			function() require("dap").continue() end,
			desc = "Start Debugging",
		},
		{
			"<C-F5>",
			function() require("dap").terminate() end,
			desc = "Stop Debugging",
		},
		{
			"<F9>",
			function() require("dap").toggle_breakpoint() end,
			desc = "Set/Unset Breakpoint",
		},
		{
			"<C-F9>",
			function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,
			desc = "Set conditional Breakpoint",
		},
		{
			"<F10>",
			function() require("dap").step_over() end,
			desc = "Step over",
		},
		{
			"<F11>",
			function() require("dap").step_into() end,
			desc = "Step into",
		},
		{
			"<F12>",
			function() require("dap").step_out() end,
			desc = "Step out",
		},
		{
			"<leader>dc",
			function() require("dap").run_to_cursor() end,
			desc = "Run until Cursor"
		},
		{
			"<leader>du",
			function() require("dapui").toggle() end,
			desc = "Toggle Debug-UI"
		},
		{
			"<leader>de",
			function() require("dapui").eval() end,
			mode = { "n", "v" },
			desc = "Evaluate Expression",
		},
		{
			"<leader>dw",
			function() require("dapui").elements.watches.add(vim.fn.expand("<cword>")) end,
			desc = "Add to Watch",
		},
		{
			"<leader>dr",
			function() require("dap").repl.toggle() end,
			desc = "Toggle REPL"
		},
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		vim.fn.sign_define(
			"DapBreakpoint",
			{
				text = "●",
				texthl = "DiagnosticError"
			}
		)
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{
				text = "◆",
				texthl = "DiagnosticWarn"
			}
		)
		vim.fn.sign_define(
			"DapStopped",
			{
				text = "▶",
				texthl = "DiagnosticOk",
				linehl = "Visual"
			}
		)

		dap.listeners.before.attach["dapui_config"] = function() dapui.open() end
		dap.listeners.before.launch["dapui_config"] = function() dapui.open() end

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}
		dap.adapters.coreclr = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
			args = { "--interpreter=vscode" },
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "Launch .NET",
				request = "launch",
				program = function()
					return vim.fn.input("DLL: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
			{
				type = "coreclr",
				name = "Attach to process",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
		}

		local function executable()
			return vim.fn.input(
				"Executable: ",
				vim.fn.getcwd() .. "/build/",
				"file"
			)
		end

		local function arguments()
			local input = vim.fn.input("Argumente: ")
			return vim.split(input, " ", { trimempty = true })
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
			{
				name = "Launch executable (with Arguments)",
				type = "gdb",
				request = "launch",
				program = executable,
				args = arguments,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMain = false,
			},
			{
				name = "Attach to process",
				type = "gdb",
				request = "attach",
				pid = require("dap.utils").pick_process,
			},
		}
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.rust = dap.configurations.c
	end,
}
