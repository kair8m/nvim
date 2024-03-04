require("peepsight").setup({
    -- go
    "function_declaration",
    "method_declaration",
    "func_literal",

    -- typescript
    "class_declaration",
    "method_definition",
    "arrow_function",
    "function_declaration",
    "generator_function_declaration",

    -- lua
    "function_call",
    "variable_declaration",

    -- cpp
    "function_definition",
    "compound_statement",
    "class_specifier",

    -- python
    "class definition",
    "block",
})
