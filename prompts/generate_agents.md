---
name: Generate AGENTS.md
interaction: chat
description: Analyze the project for future agent use.
---

## system

You are an AI agent that is a master in project discovery and analysis. You are operating as the first agent on this project, and are tasked with analyzing the project in the current directory and generating a comprehensive AGENTS.md file to be used as instructional context for future agent interactions.

## user

As part of this process, @{files}. You may also use @{cmd_runner} as needed. Ensure you do not edit any project files except AGENTS.md.

### Analysis Process

Repeat this process for the top-level project and all of its recursive git submodules.

1. Initial Exploration
    1. Start by listing all files and directories to understand the project from a high level. Respect `.gitignore`, if possible, but don't respect it if you need more context.
        - Try to list all files at any depth, regardless of previous suggestions. Do this even if files have been listed previously. Be aware that this might consume many tokens, making respecting `.gitignore` more important.
    2. Read any readmes, such as `README.md`, that you can find. These should provide a human-level context and may guide the rest of your analysis.
    3. Read any AGENTS.md files in submodules to understand their purpose.
    4. Note that a brief git history may be beneficial, if applicable.

2. Determine the type of project
    - **Code Project** Search for common project configuration files. This might include CMakeLists.txt, Cargo.toml, requirements.txt, pyproject.toml, or a `src` directory. If these exist, this is likely a software project.
    - **Non-Code Project** Check for notes, documentation, or other signs that this is not a code project. Note that if the directory is mostly Markdown files and configs, it might be an mdbook, Obsidian.md vault, or similar. These types of directories count as "non-code," though they might be considered "code-enhanced" projects.

3. File exploration
    - Select key files that represent the project's structure, main entry points, configuration, and dependencies. Continue exploring until a comprehensive understanding of the project's architecture and tooling is achieved. These might be configuration files, source files, documentation, or other similar files.
        - Try to keep the maximum files examined as part of this step to around 10, not including the number of files read in previous steps.
        - Examine as many files as possuble, up to the maximum. This will provide more context.
    - Read these files one at a time. Based on what you learn, choose the next file to read. Use this time to improve your understanding.

### AGENTS.md Generation

Ensure you never include secrets, API keys, passwords, or any personally identifiable information in the final AGENTS.md file.
Projects should at a minimum have the following, in any order, depending on the type of project.

#### Code Projects

1. **Project overview** This overview should be concise and deliberate. Provide information about the project's purpose, architecture, and technologies used. For projects where version is important (e.g., C++), note the version and compilers used as well as where to find this information in case it is ever changed. This can typically be found in the top-level CMakeLists.txt for C++, or other relevant config files for other languages.
2. **Important commands** Identify and document commands for building, running, and testing. If the project uses more than one language, ensure commands are documented for each as needed. If commands cannot be found, use your best guess with a TODO and query the user AFTER the rest of AGENTS.md is done. Then go back and amend AGENTS.md. You may need to
    - Inspect the scripts section of package.json.
    - Look for a Makefile, Taskfile, or other script runners.
    - Check for CI/CD configuration files like .github/workflows/main.yml, .gitlab-ci.yml, or Jenkinsfile. These tend to be excellent sources for build, test, and lint commands.
3. **Conventions** Identify conventions for the project, such as style, testing practices, contribution guidelines, or other relevant information you have learned.
4. **Patterns** Identify common patterns used in source files.
5. **Architecture** Determine how the project works. Is this a multi-application project? How do components interact with each other?
6. (Optional) **Submodules** Describe the use and purpose of each submodule included by the project.
7. (Optional) **Constraints** Some projects have unique constraints. For example, C++ flight code may be extra sensitive to bit flips. Identify and document constrains and work arounds. Ask the user for clarification as-needed using the previously described pattern.
8. (Optional) **Additional Notes** Include any additional information that would be beneficial to an agent, but would be time consuming or inconvenient to discover every time.

#### Non-Code Projects

1. **Project overview** This overview should be concise and deliberate. Provide information about the purpose of the project. Describe its contents and important information relevant to the project.
2. **Key files** Identify and list important documents. Provide a (brief) summary of each.
3. **Conventions** Identify conventions for the project, such as style, common patterns, or other relevant information you have learned.
4. **Tool usage** For code-enhanced projects, provide a brief description of the tools used and how to use them.

### Final Output

Write the complete content to the AGENTS.md file using @{create_file}. The output must be Markdown and ready for AI agent consumption. Since this file is for agents outside of this buffer, you may disregard previous styling requirements for the contents of this file. Use formats and structures easily consumable for AI/LLM agents such as yourself, preferring to cater to the agents' informational and format needs rather than the humans'. 
