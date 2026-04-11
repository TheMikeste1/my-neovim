---
name: Doc comment
interaction: inline
placement: new
description: Provide documentation comments for some code.
opts:
    alias: comment
    modes:
        - v
---

## user

Provide a documentation comment for the "To Comment" code.

- If the object already has a comment, update it.
- Do not edit the object by changing code or removing other comments; ONLY provide (or update) the doc comment.
- Use doc comments appropriate for the language.
- Use single ticks for inline code and triple ticks for code blocks.
- Match the comment style of surrounding objects.
- Document WHAT it does and HOW to use it, not HOW it does it.
- Avoid calling anything a "helper" function/class/etc.
- Include parameters.
    - Exclude parameter types when it is annotated in the function (e.g. `arg: str` in Python), unless the doc comment style specifically requires it.
    - Exclude parameters like `self` or `this` for methods.
- Include returns and yields ONLY WHEN IT RETURNS/YIELDS SOMETHING.
    - If it returns or yields void/None/nil, DO NOT add a comment about it.
- Include usage examples. In Python, these should be doctest-style examples. Others should use their doctest-equivalent. If they do not have one, use Markdown codeblocks.
- Provide warnings, e.g. "Ensure `m_mutex` is locked" ONLY when applicable.
- Avoid being too wordy except for particularly delicate functions.
- Include comments for enum variants without comments when documenting an enum.
- Include comments for class members without comments when documenting a class.
- Use single backticks for inline code (e.g. use \`self\`, not \`\`self\`\`).
- Do not use French spaces (prefer "\<sentence\>. \<new_sentence\>" instead of "\<sentence\>.  \<new_sentence\>")

### Buffer Contents

Take note of the usage of the code in the file.
```${context.filetype}
${utils.buffer_contents}
```

### To Comment

${context.user_prompt}

Here is the code to document. Ensure you include it, unchanged, in your response.
