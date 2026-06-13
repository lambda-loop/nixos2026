{ pkgs, inputs, ... }: 
let 
  my_custom_keymaps = import ./keymaps.nix;
in {

  imports = [ inputs.nvf.nixosModules.default ];

  # --- Fontes ---
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # --- Pacotes do Sistema ---
  environment.systemPackages = with pkgs; [
    vimPlugins.haskell-tools-nvim
    xclip wl-clipboard
    fzf
    yazi
    lazygit
    ripgrep

    # Multimídia e Zueira
    mpv      
    yt-dlp   
    libcaca  
    cmatrix  
    aalib 
  ];

  programs.nvf = { 
    enable = true;

    settings = {
      vim = {
        luaConfigRC.utils = ''
        function _G.format_and_save()
          local view = vim.fn.winsaveview()  -- saves the position
          vim.cmd("keepjumps normal! gg=G") 
          vim.cmd("wa") 
          vim.fn.winrestview(view) 
        end

        function _G.just_indent()
          local view = vim.fn.winsaveview()
          vim.cmd("keepjumps normal! gg=G")
          vim.fn.winrestview(view)
        end
        '';


        luaConfigRC.force-line-colors = ''
          vim.api.nvim_set_hl(0, "LineNr", { fg = "#f9e2af", bold = true }) 

          vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f5c2e7", bold = true })

          vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" }) 
        '';

        # --- OBRIGATÓRIO PARA NVF ---
        package = pkgs.neovim-unwrapped;


        viAlias = false;
        vimAlias = true;

        # --- TEMA (CATPPUCCIN) ---
        # theme = "gruvbox_dark";
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        # --- VISUAL ---
        visuals = {
          rainbow-delimiters.enable = true;
          highlight-undo.enable = true; 
          nvim-web-devicons.enable = true;     

          indent-blankline = {
            enable = true;
            setupOpts = {
              scope = { enabled = true; };
              indent = { char = "│"; };
            };
          };
        };

        # --- UI & UTILITÁRIOS ---
        ui.noice.enable = true;

        utility = {
          surround.enable = true;
          motion.leap.enable = true;
        };

        notes.todo-comments.enable = true;
        # autopairs.nvim-autopairs.enable = true;
        comments.comment-nvim.enable = true;
        binds.whichKey.enable = true;

        # --- GIT ---
        git.gitsigns.enable = true;

        # --- DASHBOARD (SHREK) ---
        dashboard.dashboard-nvim.enable = true;
        # dashboard.dashboard-nvim = {
        #   enable = true;
        #   setupOpts = {
        #     theme = "doom";
        #     # theme = "catppuccin"; 
        #     # config = {
        #     #   header = [ " NEOVIM " ]; 
        #     # };
        #   };
        # setupOpts = {
        #   config = {
        #     header = [
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⠟⠋⠻⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⠞⠛⠛⣿⠀⠀⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠃⠀⠀⠀⣿⣤⣤⣤⣤⣤⣤⣤⠾⠋⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⢠⡞⠛⠛⠁⠀⠀⠀⠀⠀⠀⣼⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⠟⠻⣦⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⢠⡍⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣄⡀⣴⠏⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠈⣷⠀⠀⠀⠀⠀⠀⠀⠀⢘⠃⠀⠀⠀⠀⠀⢀⡟⠁⣠⣤⣤⠙⣄⠀⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⣠⡴⠖⠛⠶⣦⡀⠀⠀⠀⠀⠀⢹⡆⠀⠀⠀⠀⠀⢿⡄⠸⣿⣿⡟⠀⣿⠀⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⢰⡏⢠⣾⣿⣶⠀⢻⡄⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠈⠻⢶⣤⣤⣤⠾⠃⠀⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠘⣧⡈⠛⠛⠛⣀⡾⠁⠀⠀⣤⠀⠀⠀⣠⡆⠀⠀⠀⠀⣠⡾⠃⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠙⠛⠛⣿⠻⣤⣀⡀⠀⠘⠃⠀⠀⠋⠀⠀⣀⣤⠾⠋⢀⡼⠃⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠘⠷⣤⠈⠙⠛⠛⠶⠶⠶⠞⠛⠛⠉⠀⣠⠴⡋⠀⠀⠀⠀⢸⡏⠳⣦⣀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⣶⠦⣤⣤⣤⣤⣤⠴⠶⠛⠉⢸⡇⠀⠀⠀⠀⢸⡇⠀⠀⠙⠃⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⠀⠀⠀⠀⠀⣸⠀⠀⠀⣼⠃"
        #       "⠀⠀⠀⣠⡾⠻⣄⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⣸⠇⠀⠀⣼⠏⠀"
        #       "⠀⢀⡾⠋⠀⠀⠙⢷⣄⡀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⢀⣼⠏⠀⢀⣼⡟⠀⠀"
        #       "⠀⠈⠻⣦⡀⠀⠀⠀⠉⠉⠛⠛⠻⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢀⣠⠾⠁⠀⣠⣾⠁⠀⠀⠀"
        #       "⠀⠀⠀⠈⠛⢶⣄⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠁⣀⣤⠾⣫⣿⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠉⠛⠛⠛⠛⠛⠋⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⠶⠟⠋⠁⢰⡇⣿⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⢠⡏⢸⡇⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⢸⡇⢸⡇⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣇⠀⠀⠀⠀⢸⡇⢸⡇⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⠀⠀⠀⠀⣼⠀⢸⠃⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⣿⠀⢸⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⠀⠀⠀⠀⣿⠀⣿⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⢰⡇⠀⣿⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⢸⡇⠀⣿⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⢸⠇⠀⣿⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⠀⠀⣾⠀⠀⣿⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⢠⡟⠀⠀⡿⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢀⡿⠁⠀⠀⡇⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣾⠁⠀⠀⢸⡇⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⢀⡾⠃⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⣠⡟⠁⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡇⣰⠏⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠋⠀⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⠀⠀⢀⣠⡴⠶⠛⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀"
        #       "⠀⠀⠀⠀⠀⣠⡴⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠶⢦⣄⠀⠀⠀⠀"
        #       "⠀⠀⠀⢀⣼⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣷⡀⠀⠀"
        #       "⠀⠀⣠⡟⠁⠀⠀⠀⠀⠀⠀⢀⣠⡴⠞⠛⠋⠉⠉⠛⠛⠶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀"
        #       "⠀⣼⠏⠀⠀⠀⠀⠀⠀⣠⡶⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡀⠀⠀⠀⠀⠀⠀⠀⢀⣼⠃⠀⠀"
        #       "⢼⣇⡀⠀⠀⠀⠀⣠⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠧⣤⣤⣤⣤⠤⠶⠶⠞⠁⠀⠀⠀"
        #       "⠀⠉⠙⠛⠷⠶⠾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        #     ];
        #   };
        # };
        # };

        # --- LINGUAGENS E TREESITTER ---
        languages = {
          enableDAP = true;
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableTreesitter = true;

          assembly.enable = true;
          clang.enable = true;
          rust.enable = true;
          #gleam.enable = true;
          elixir.enable = true;
          haskell = {
            enable = true;
            extensions.haskell-tools.enable = true;
            lsp.enable = false;
          };
          html.enable = true;
          nix.enable = true;
          # NO LISPS??
        };

        treesitter = {
          enable = true;
          highlight.enable = true;
          indent.enable = true;
        };

        # --- LSP & DIAGNOSTICS ---
        lsp = {
          enable = true;
          trouble.enable = true;
        };

        diagnostics = {
          enable = true;
          config = {
            signs = true;
            update_in_insert = true;
            virtual_text = true;
          };
        };

        # --- AUTOCOMPLETE ---
        autocomplete.nvim-cmp = {
          enable = true;
          mappings = {
            confirm = "<Tab>"; 
            next = "<C-j>";      
            previous = "<C-k>";
            close = "<C-x>";    
          };
        };

        # --- STATUSLINE (LUALINE) ---
        statusline.lualine = {
          enable = true;
          theme = "catppuccin"; # TODO: create a pre-config-list
        };

        # --- OPÇÕES ---
        options = {
          cursorline = true;
          encoding = "UTF-8";
          ruler = true;
          clipboard = "unnamedplus";
          tabstop = 2;
          expandtab = true;
          shiftwidth = 2;
          guifont = "JetBrainsMono Nerd Font:h13";
        };

        globals.mapleader = " ";
        globals.maplocalleader = " ";
        keymaps = my_custom_keymaps;

        # --- TELESCOPE ---
        telescope = {
          enable = true;
          setupOpts = {
            defaults = {
              layout_config = { horizontal = { prompt_position = "top"; }; };
              sorting_strategy = "ascending";
              mappings = {
                i = {
                  "<C-j>" = "move_selection_next";
                  "<C-k>" = "move_selection_previous";
                  "<Esc>" = "close";
                };
                n = { "q" = "close"; };
              };
            };
          };
        };

        # --- FILE TREE (NEO-TREE) ---
        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            window = { width = 25; };
            enable_cursor_hijack = true;
            add_blank_line_at_top = true;
            auto_clean_after_session_restore = true;
            git_status_async = true;
          };
        };

        # --- PLUGINS EXTRAS ---
        extraPlugins = {

          # beautiful but slow for scrolling and some other things..
          # mini-animate = {
          #   package = pkgs.vimPlugins.mini-nvim;
          #   setup = "require('mini.animate').setup()";
          # };

          zen-mode = {
            package = pkgs.vimPlugins.zen-mode-nvim;
            setup = "require('zen-mode').setup({})";
          };

          presence-nvim = {
            package = pkgs.vimPlugins.presence-nvim;
            setup = ''
              require("presence").setup({
                  auto_update         = true,
                  neovim_image_text   = "The One True Editor",
                  main_image          = "neovim",
                  enable_line_number  = true,
              })
            '';
          };

          # showkeys = {
          #   package = pkgs.vimPlugins.screenkey-nvim; 
          #   setup = "require('screenkey').setup()";
          # };

          codewindow = {
            package = pkgs.vimPlugins.codewindow-nvim;
            setup = ''
              local codewindow = require('codewindow')
              codewindow.setup({
                auto_enable = false, 
                use_git = true,      
                minimap_width = 10,  
                use_lsp = true,      
              })
              -- Não precisamos aplicar keybinds padrão aqui, faremos no keymaps.nix
            '';
          };

          # cellular-automaton = {
          #   package = pkgs.vimPlugins.cellular-automaton;
          #   setup = ''
          #   local config = { fps = 50, name = 'slide' }
          #   require('cellular-automaton').register_animation('make_it_rain')
          #   '';
          # };

          # Pets
          # pets-nvim = {
          #   package = pkgs.vimPlugins.pets-nvim;
          #   after = [ "nui-nvim" ]; 
          #   setup = ''
          #     require('pets').setup({
          #       row = 1, 
          #       popup = { width = "30%", winblend = 10, },
          #     })
          #   '';
          # };

          nui-nvim = { package = pkgs.vimPlugins.nui-nvim; };

          yazi = {
            package = pkgs.vimPlugins.yazi-nvim; 
            setup = ''
              require("yazi").setup({
                open_for_directories = true,
                floating_window_scaling_factor = 0.8, 
                yazi_floating_window_winblend = 10,
              })
            '';
          };

          oil-nvim = {
            package = pkgs.vimPlugins.oil-nvim;
            setup = "require('oil').setup()";
          };

          lazygit-nvim = {
            package = pkgs.vimPlugins.lazygit-nvim;
            setup = ""; 
          };

          # toggleterm = {
          #   package = pkgs.vimPlugins.toggleterm-nvim;
          #   setup = ''
          #     require("toggleterm").setup({
          #       size = 10,
          #       open_mapping = [[<c-\>]],
          #       hide_numbers = true,
          #       shade_filetypes = {},
          #       shade_terminals = true,
          #       start_in_insert = true,
          #       persist_size = true,
          #       direction = 'float',
          #       float_opts = { border = 'curved', winblend = 0 }
          #     })
          #
          #     local Terminal = require('toggleterm.terminal').Terminal
          #     function _G.abrir_term_no_dir_atual()
          #       local file_dir = vim.fn.expand("%:p:h")
          #       if file_dir == "" then file_dir = vim.fn.getcwd() end
          #       local term = Terminal:new({ 
          #         cmd = vim.o.shell, 
          #         dir = file_dir,    
          #         direction = "float",
          #         on_open = function(term)
          #           vim.cmd("startinsert!")
          #           vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<C-\\><C-n><cmd>close<CR>", {noremap = true, silent = true})
          #         end,
          #       })
          #       term:toggle()
          #     end
          #   '';
          # };

          toggleterm = {
            package = pkgs.vimPlugins.toggleterm-nvim;
            setup = ''
              require("toggleterm").setup({
                size = 10,
                open_mapping = [[<c-\>]],
                hide_numbers = true,
                shade_terminals = true,
                start_in_insert = true,
                persist_size = true,
                direction = 'float',
                float_opts = { border = 'curved', winblend = 0 }
              })

              local Terminal = require('toggleterm.terminal').Terminal

              -- 1. RICK ROLL
              local rick = Terminal:new({
                cmd = "mpv --vo=caca 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' --quiet",
                hidden = true,     -- Não mostra na lista de buffers
                direction = "float",
                close_on_exit = true, -- Fecha a janela ao terminar
                float_opts = {
                  border = "double",
                  width = 1000,    -- Tenta ocupar a largura toda
                  height = 1000,
                },
                on_open = function(term)
                  vim.cmd("startinsert!") -- Já entra focado
                end,
              })

              function _G.play_rick()
                rick:toggle()
              end

              -- 2. LOCAL GIF
              -- Nota: Usamos vim.fn.expand para pegar o HOME corretamente
              local gif_cmd = "mpv --vo=caca " .. vim.fn.expand("~") .. "/Videos/meme.gif --loop --quiet"
              local meme = Terminal:new({
                cmd = gif_cmd,
                hidden = true,
                direction = "float",
                close_on_exit = true,
                float_opts = { border = "double", width = 1000, height = 1000 },
                on_open = function(term) vim.cmd("startinsert!") end,
              })

              function _G.play_meme()
                meme:toggle()
              end

              -- 3. FIRE
              local fire = Terminal:new({
                cmd = "aafire",
                hidden = true,
                direction = "float",
                close_on_exit = true,
                float_opts = { border = "curved", width = 1000, height = 1000 },
                on_open = function(term) vim.cmd("startinsert!") end,
              })

              function _G.play_fire()
                fire:toggle()
              end

              -- Função do terminal normal (mantida)
              function _G.abrir_term_no_dir_atual()
                local file_dir = vim.fn.expand("%:p:h")
                if file_dir == "" then file_dir = vim.fn.getcwd() end
                local term = Terminal:new({ 
                  cmd = vim.o.shell, 
                  dir = file_dir,     
                  direction = "float",
                  hidden = true, -- Terminal flutuante tbm não precisa ficar na tabline
                  on_open = function(term)
                    vim.cmd("startinsert!")
                    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<C-\\><C-n><cmd>close<CR>", {noremap = true, silent = true})
                  end,
                })
                term:toggle()
              end
            '';
          };

          haskell-tools-nvim = {
            package = pkgs.vimPlugins.haskell-tools-nvim;
            setup = "";
          };
        }; # end-extraPlugins
      }; # end-vim
    }; # end-settings
  }; # end-programs.nvf
}

