; inherits: cmake
(block_def
  (block_command
    (block) @function.builtin
    (argument_list
      (argument
        (unquoted_argument) @constant))?
    (#any-of? @constant "SCOPE_FOR" "POLICIES" "VARIABLES" "PROPAGATE"))
  (endblock_command
    (endblock) @function.builtin))
