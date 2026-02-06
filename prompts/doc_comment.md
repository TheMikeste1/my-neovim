---
name: Doc comment
interaction: inline
description: Provide documentation comments for some code.
opts:
    alias: comment
    modes:
        - v
---

## user

Provide a documentation comment for the following in buffer #{context.bufnr}.

- If the object already has a comment, update it.
- Use doc comments appropriate for the language.
- Use single ticks for inline code and triple ticks for code blocks.
- Match the comment style of surrounding objects.
- Document WHAT it does and HOW to use it, not HOW it does it.
- Include parameters.
    - Exclude parameter types when it is annotated in the function (e.g. `arg: str` in Python), unless the doc comment style specifically requires it.
- Include returns and yields ONLY WHEN IT RETURNS/YIELDS SOMETHING.
    - If it returns or yields void/None/nil, DO NOT add a comment about it.
- Include usage examples. In Python, these should be doctest-style examples. Others should use their doctest-equivalent. If they do not have one, use Markdown codeblocks.
    - Examples should be somewhat whimsical and fun. This applies ONLY to the examples, which should still be realistic regardless of their whimsical use cases.
- Provide warnings, e.g. "Ensure `m_mutex` is locked" ONLY when applicable.
- Avoid being too wordy except for particularly delicate functions.
- Include comments for enum variants without comments when documenting an enum.
- Include comments for class members without comments when documenting a class.

```${context.filetype}
${context.code}
```

Buffer contents:

```${context.filetype}
${utils.buffer_contents}
```
