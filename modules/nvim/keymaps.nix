[
  # --- Terminal ---
  {
    key = "<leader>tt";
    mode = "n";
    silent = true;
    action = ":lua _G.abrir_term_no_dir_atual()<CR>";
    desc = "Floating terminal";
  }

  {
    key = "<leader>w";
    mode = "n";
    silent = true;
    # Chama a função global que criamos no default.nix
    action = ":lua _G.format_and_save()<CR>";
    desc = "Format & Save (Stable)";
  }
  {
    key = "<leader>i";
    mode = "n";
    silent = true;
    action = ":lua _G.just_indent()<CR>";
    desc = "Indent file (Stable)";
  }


  # --- Formatting (FIXED: keepjumps) ---
  # {
  #   key = "<leader>w";
  #   mode = "n";
  #   silent = true;
  #   action = ":let v=winsaveview() | lockmarks keepjumps normal! gg=G | call winrestview(v) | wa<CR>";
  #   desc = "Save indent";
  # }
  # {
  #   key = "<leader>i";
  #   mode = "n";
  #   silent = true;
  #   action = ":let v=winsaveview() | lockmarks keepjumps normal! gg=G | call winrestview(v)<CR>";
  #   desc = "Indent file";
  # }
  #
  # # --- Selection (BLINDADO) ---
  # { 
  #   key = "<C-x>h"; 
  #   mode = "n"; 
  #   silent = true; 
  #   action = ":lockmarks keepjumps normal! ggVG<CR>"; 
  # }

  # --- Minimap (CodeWindow - Bindings Padrão) ---
  {
    key = "<leader>mm";
    mode = "n";
    silent = true;
    action = "<cmd>lua require('codewindow').toggle_minimap()<CR>";
    desc = "Toggle Minimap";
  }
  {
    key = "<leader>mo";
    mode = "n";
    silent = true;
    action = "<cmd>lua require('codewindow').open_minimap()<CR>";
    desc = "Open Minimap";
  }
  {
    key = "<leader>mc";
    mode = "n";
    silent = true;
    action = "<cmd>lua require('codewindow').close_minimap()<CR>";
    desc = "Close Minimap";
  }
  {
    key = "<leader>mf";
    mode = "n";
    silent = true;
    action = "<cmd>lua require('codewindow').focus()<CR>";
    desc = "Focus Minimap";
  }


  # --- Telescope ---
  { key = "<leader>ff"; mode = "n"; silent = true; action = ":Telescope find_files<CR>"; }
  { key = "<leader>fg"; mode = "n"; silent = true; action = ":Telescope live_grep<CR>"; }
  { key = "<leader>fb"; mode = "n"; silent = true; action = ":Telescope buffers<CR>"; }

  # --- LSP ---
  { key = "<leader>ca"; mode = "n"; silent = true; action = ":lua vim.lsp.buf.code_action()<CR>"; }
  { key = "<leader>d";  mode = "n"; silent = true; action = ":lua vim.diagnostic.open_float()<CR>"; }

  # --- NeoTree ---
  { key = "<C-n>";      mode = "n"; silent = true; action = ":Neotree filesystem reveal left<CR>"; }
  { key = "<leader>n";  mode = "n"; silent = true; action = ":Neotree filesystem close left<CR>"; }

  # --- Emacs Navigation ---
  { key = "<M-b>"; mode = "i"; silent = true; action = "<C-Left>"; }
  { key = "<M-f>"; mode = "i"; silent = true; action = "<C-Right>"; }
  { key = "<C-a>"; mode = "i"; silent = true; action = "<Home>"; }
  { key = "<C-e>"; mode = "i"; silent = true; action = "<End>"; }
  { key = "<C-f>"; mode = "i"; silent = true; action = "<Right>"; }
  { key = "<C-b>"; mode = "i"; silent = true; action = "<Left>"; }

  # --- Emacs Editing ---
  { key = "<M-BS>"; mode = "i"; silent = true; action = "<C-w>"; }
  { key = "<M-d>";  mode = "i"; silent = true; action = "<C-o>dw"; }
  { key = "<C-k>";  mode = "i"; silent = true; action = "<C-o>D"; }
  { key = "<C-d>";  mode = "i"; silent = true; action = "<Del>"; }

  # --- Undo ---
  { key = "<C-z>"; mode = "i"; silent = true; action = "<C-o>u"; }
  { key = "<C-/>"; mode = "i"; silent = true; action = "<C-o>u"; }

  # --- Global Navigation ---
  { key = "<M-<>"; mode = "n"; silent = true; action = "gg"; }
  { key = "<M-<>"; mode = "i"; silent = true; action = "<C-o>gg"; }
  { key = "<M->>"; mode = "n"; silent = true; action = "G"; }
  { key = "<M->>"; mode = "i"; silent = true; action = "<C-o>G"; }

  # --- Selection (FIXED: keepjumps) ---
  { key = "<C-x>h"; mode = "n"; silent = true; action = ":keepjumps normal! ggVG<CR>"; }
  { key = "<C-x>h"; mode = "i"; silent = true; action = "<Esc>:keepjumps normal! ggVG<CR>"; }

  # --- Trouble (Errors) ---
  { key = "<leader>xx"; mode = "n"; silent = true; action = "<cmd>Trouble diagnostics toggle<CR>"; desc = "Toggle Trouble"; }
  { key = "<leader>xw"; mode = "n"; silent = true; action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>"; desc = "Buffer errors"; }
  { key = "<leader>cs"; mode = "n"; silent = true; action = "<cmd>Trouble symbols toggle focus=false<CR>"; desc = "Symbols outline"; }
  { key = "<leader>cl"; mode = "n"; silent = true; action = "<cmd>Trouble lsp toggle focus=false win.position=right<CR>"; desc = "LSP refs"; }

  # --- Todo Comments ---
  { key = "<leader>ft"; mode = "n"; silent = true; action = "<cmd>TodoTelescope<CR>"; desc = "Find TODOs"; }
  { key = "]t";         mode = "n"; silent = true; action = "<cmd>lua require('todo-comments').jump_next()<CR>"; desc = "Next TODO"; }
  { key = "[t";         mode = "n"; silent = true; action = "<cmd>lua require('todo-comments').jump_prev()<CR>"; desc = "Prev TODO"; }

  # --- Noice (Notifications) ---
  { key = "<leader>nl"; mode = "n"; silent = true; action = "<cmd>NoiceLast<CR>"; desc = "Last message"; }
  { key = "<leader>nh"; mode = "n"; silent = true; action = "<cmd>NoiceHistory<CR>"; desc = "History log"; }
  { key = "<leader>nd"; mode = "n"; silent = true; action = "<cmd>NoiceDismiss<CR>"; desc = "Clear messages"; }

  # --- LazyGit ---
  { 
    key = "<leader>gg"; 
    mode = "n"; 
    silent = true; 
    action = ":LazyGit<CR>"; 
    desc = "Open LazyGit"; 
  }

  # --- YAZI ---
  { 
    key = "<leader>y"; 
    mode = "n"; 
    silent = true; 
    action = "<cmd>Yazi<CR>"; 
    desc = "Open Yazi"; 
  }

  { 
    key = "<leader>cw"; 
    mode = "n"; 
    silent = true; 
    action = "<cmd>Yazi cwd<CR>"; 
    desc = "Yazi in Current Workdir"; 
  }

  { key = "<leader>bm"; mode = "n"; action = ":TermExec cmd='btm' direction=float<CR>"; desc = "System Monitor"; }

  { key = "-"; mode = "n"; action = "<cmd>Oil<CR>"; }

  # --- FUN / MEME COMMANDS (FIXED: Syntax & TermExec) ---

  { 
    key = "<leader>rr"; 
    mode = "n"; 
    silent = true; 
    action = ":lua _G.play_rick()<CR>"; 
    desc = "Risky Click (Rick Roll)"; 
  }

  { 
    key = "<leader>vv"; 
    mode = "n"; 
    silent = true; 
    action = ":lua _G.play_meme()<CR>"; 
    desc = "Play Local GIF"; 
  }

  { 
    key = "<leader>fire"; 
    mode = "n"; 
    silent = true; 
    action = ":lua _G.play_fire()<CR>"; 
    desc = "Burn baby burn"; 
  }

]
