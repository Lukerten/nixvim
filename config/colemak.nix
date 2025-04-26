{
  # Colemak keyboard layout mappings
  extraConfigLua = ''
    -- Colemak keyboard layout remappings
    local function apply_colemak_mappings()
      local mappings = {
        {"", "d", "g", { noremap = true, buffer = true }},
        {"", "e", "k", { noremap = true, buffer = true }},
        {"", "f", "e", { noremap = true, buffer = true }},
        {"", "g", "t", { noremap = true, buffer = true }},
        {"", "i", "l", { noremap = true, buffer = true }},
        {"", "j", "y", { noremap = true, buffer = true }},
        {"", "k", "n", { noremap = true, buffer = true }},
        {"", "l", "u", { noremap = true, buffer = true }},
        {"", "n", "j", { noremap = true, buffer = true }},
        {"", "o", "p", { noremap = true, buffer = true }},
        {"", "p", "r", { noremap = true, buffer = true }},
        {"", "r", "s", { noremap = true, buffer = true }},
        {"", "s", "d", { noremap = true, buffer = true }},
        {"", "t", "f", { noremap = true, buffer = true }},
        {"", "u", "i", { noremap = true, buffer = true }},
        {"", "y", "o", { noremap = true, buffer = true }},
        {"", "D", "G", { noremap = true, buffer = true }},
        {"", "E", "K", { noremap = true, buffer = true }},
        {"", "F", "E", { noremap = true, buffer = true }},
        {"", "G", "T", { noremap = true, buffer = true }},
        {"", "I", "L", { noremap = true, buffer = true }},
        {"", "J", "Y", { noremap = true, buffer = true }},
        {"", "K", "N", { noremap = true, buffer = true }},
        {"", "L", "U", { noremap = true, buffer = true }},
        {"", "N", "J", { noremap = true, buffer = true }},
        {"", "O", "P", { noremap = true, buffer = true }},
        {"", "P", "R", { noremap = true, buffer = true }},
        {"", "R", "S", { noremap = true, buffer = true }},
        {"", "S", "D", { noremap = true, buffer = true }},
        {"", "T", "F", { noremap = true, buffer = true }},
        {"", "U", "I", { noremap = true, buffer = true }},
        {"", "Y", "O", { noremap = true, buffer = true }},
      }
      for _, mapping in ipairs(mappings) do
        vim.keymap.set(mapping[1], mapping[2], mapping[3], mapping[4])
      end
    end
  '';

  # Autocoomand to apply this script on all Buffers
  AutoCmd = [
    {
      event = "BufEnter";
      pattern = "*";
      command = "lua apply_colemak_mappings()";
    }
  ];
}
