# nvim-stylelint

`nvim-stylelint` is a plugin designed to integrate Stylelint functionality within Neovim. This plugin leverages the [`vscode-stylelint`](https://github.com/stylelint/vscode-stylelint) language server and nvim native language client API to provide linting and code analysis capabilities directly in Neovim.

## Why

I was inspired to make the same Neovim plugin for Stylelint as it has already been done in [esmuellert/nvim-eslint](https://github.com/esmuellert/nvim-eslint) for ESLint. The [stylelint-lsp](https://github.com/bmatcuk/stylelint-lsp) doesn't seem to be maintained anymore. Other solutions, like [none-ls](https://github.com/nvimtools/none-ls.nvim) or [efm](https://github.com/mattn/efm-langserver) apparently do not support code actions.

## Features

-   **Native Nvim LSP and vscode-stylelint server**: Achieve optimal performance with minimal differences from the Stylelint VSCode plugin, as both use the same server and LSP protocol.
-   **All-in-one Stylelint experience**: No additional tools are required. The plugin includes the language server.
-   **Up-to-date with the latest vscode-stylelint server**: The plugin uses the latest release of vscode-stylelint, ensuring support for new features.
-   **Easy to extend**: The Lua script is concise, with just over 100 lines of code. It uses optimized default configurations but is also straightforward to customize according to your needs.

## Installation

### Prerequisite

`node` and `stylelint` needs to be installed

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'leiswatch/nvim-stylelint',
  opts = {},
}
```

In many cases, your repository might function with the default configurations. However, similar to the `vscode-stylelint` plugin, you may need to adjust some settings to ensure compatibility. The following section explains how to customize these default settings.

## Configuration

### Default Configuration

```lua
{
    -- Toggle debug mode for Stylelint language server, see debugging part
    debug = false,

    -- Command to launch language server. You might hardly want to change this setting
    cmd = M.create_cmd(),

    -- root_dir is used by Neovim LSP client API to determine if to attach or launch new LSP
    -- The default configuration uses the git root folder as the root_dir
    -- For monorepo it can have many projects, so launching too many LSP for one workspace is not efficient
    -- You can override it with passing function(bufnr)
    -- It should receive active buffer number and return root_dir
    root_dir = M.resolve_git_dir(args.buf),

    -- A table used to determine what filetypes trigger the start of LSP
    filetypes = { "css", "scss", "sass", "less", "postcss" },

    -- The client capabilities for LSP Protocol. See Nvim LSP docs for details
    -- It uses the default Nvim LSP client capabilities. Adding the capability to dynamically change configs
    capabilities = M.make_client_capabilities(),

    handlers = {
        -- The handlers handles language server responses. See Nvim LSP docs for details
        -- The default handlers only has a rewrite of default "workspace/configuration" handler of Nvim LSP
        -- Basically, when you load a new buffer, Stylelint LSP requests the settings with this request
        -- You might add more custom handlers with reference to LSP protocol spec and vscode-stylelint code
    },

    -- The settings send to Stylelint LSP. See below part for details.
    settings = {
      stylelint = {
			  validate = { "css", "scss", "less", "sass", "postcss" },
			  snippet = { "css", "scss", "less", "sass", "postcss" },
      },
    }
}
```

### Settings Options

For more stylelint options, please take a look at https://github.com/stylelint/vscode-stylelint.

## Debugging

If the linter doesn't work for your project, there are several ways to troubleshoot.

First, enable debug level logs for Nvim LSP with `vim.lsp.set_log_level('debug')`. This will show detailed requests and responses sent to and received from the Stylelint language server, helping you identify issues related to configuration, handlers, or the language server startup.

If the issue seems to originate from the Stylelint language server itself, you can attach to the Node.js process for debugging:

1. Run the `build-stylelint-language-server.sh` script in the root folder of the repo with the debug option: `./build-stylelint-language-server.sh --debug`. This will clone the `vscode-stylelint` project and compile the language server with source maps enabled, allowing you to set breakpoints in TypeScript files.
2. Open VSCode from the root folder of the repository. Then, set `debug = true` in the plugin configuration and open a buffer you want to lint. The language server will start when you click `start debugging` in the VSCode debug tab. The `launch.json` file contains the correct debugger configuration, so it should work immediately.
    - This should also work with other debuggers as long as you can attach to the language server process and enable source maps. Feel free to share steps for other debuggers via a PR.
3. Set breakpoints and debug.

## FAQ
- `Formatting doesn't work`

This is true, as it is work in progress in [vscode-stylelint](https://github.com/stylelint/vscode-stylelint). Please check https://github.com/stylelint/vscode-stylelint/pull/814 and https://github.com/stylelint/vscode-stylelint/issues/815. For now you can use `require('nvim-stylelint').format()` or `:StylelintFix` in Neovim.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.

## License

`nvim-stylelint` is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Third Party Licenses

Most of the code is copied from esmuellert/nvim-eslint plugin. Their license is: [LICENSE](https://github.com/esmuellert/nvim-eslint/blob/main/LICENSE)

We used the original Stylelint language server developed by Stylelint. Their license is: [LICENSE](https://github.com/stylelint/vscode-stylelint/blob/main/LICENSE)

As mentioned above we rewrite a Neovim LSP handler. Their license is: [LICENSE](https://github.com/neovim/neovim/blob/master/LICENSE.txt)
