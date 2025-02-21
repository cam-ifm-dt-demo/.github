# Digital Twin Demo

**Organization:** Institute for Manufacturing, University of Cambridge

**Authors:**
  - Yin-Chi Chan

### 1. Getting started

These instructions were written for Linux; they should also work for WSL. See [these instructions](https://learn.microsoft.com/en-us/windows/wsl/install) for setting up WSL on Windows.

#### 1.1 Download all repositories

Create `clone-all.sh` as follows:

```bash
#!/usr/bin/env bash

# Set your GitHub organization name
org="cam-ifm-dt-demo"

# Get the list of repo names
echo "Fetching repo names from $org..."
repos=$(gh repo list "$org" --no-archived --json name -q '.[].name'| xargs echo)
echo "Found: $repos" | fold -s -w 80

echo

# Iterate over each repo
for repo in $repos; do
  # Check if a directory with the repo name already exists
  if [ ! -d "$repo" ]; then
    echo "Cloning $repo..."
    gh repo clone "$org/$repo"
  else
    echo "Skipping $repo; directory exists."
  fi
done
```

Execute the script using `chmod +x clone-all.sh && ./clone-all.sh`.

#### 1.2 Creating a Visual Studio Code workspace

Save the following script as `create-workspace.py`:

```py
import os
import sys

import json

# Define the directory to scan and the workspace file name.
directory = '.'

# List all subdirectories in the current directory.
folders = sorted([
    folder for folder in os.listdir(directory)
    if os.path.isdir(os.path.join(directory, folder))
])
folders = [{"path": folder} for folder in folders]

# Build the new workspace structure.
workspace = {
    "folders": folders,
    "settings": {}
}

print(json.dumps(workspace, indent='\t'), end='')
```

Execute `create-workspace.py > dt-demo.code-workspace` to create a workspace for Visual Studio code.  You can then open the workspace with `code dt-demo.code-workspace`, or copy your settings from an existing workspace.

#### 1.3 Set up `uv`

These repositories use `uv` for Python package management. Follow [these instructions](https://docs.astral.sh/uv/getting-started/installation/) to install `uv`, then run `uv sync` for each Python project.

### 2. Package naming and source code structure

We shall use `uv` for package management.  It can be installed here: <https://docs.astral.sh/uv/getting-started/installation/>

Package metadata is located in `pyproject.toml` and includes the name of each package. All package names should start with the name of this GitHub organisation. Example field values are included below:

```toml
[project]
name = "cam-ifm-dt-demo-my-package"
description = "Digital Twin demo: My Package"
requires-python = ">=3.12"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.hatch.build.targets.wheel]
packages = ["src/cam_ifm_dt_demo"]
```

All packages should be within the `cam_ifm_dt_demo` namespace, by placing their source code files under the `src/cam_ifm_dt_demo` directory under the project root.  For example, the TOML snippet above provides the `cam_ifm_dt_demo.my_package` package, with its source code lying within `src/cam_ifm_dt_demo/my_package`.

Additionally, the last line of the TOML snippet above allows 'uv' to identify `cam_ifm_dt_demo` as a namespace package.

> [!warning]
> Leave the top-level `src/cam_ifm_dt_demo` directory empty to ensure it is identified as a namespace package; it should only contain subdirectories (no files).

To import a module defined in another package, see the `README.md` file for `cam_ifm_dt_demo.common` ([link](https://github.com/cam-ifm-dt-demo/common)).

### 3. Python code style

The following script can be run to check code style.  Place the script anywhere in your `$PATH`:

```bash
#! /usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

uv add --dev isort pylint autopep8
uv run isort $GIT_ROOT/src/
uv run pylint $GIT_ROOT/src/
```

A `.pylintc` file can be added to each Python project to disable various warnings. An example is:

```toml
[MAIN]

ignore=.venv,test

[MESSAGES CONTROL]

disable=too-many-arguments,
        too-many-positional-arguments,
        too-many-locals,
        bare-except
```

### 4. Recommended VS Code extensions

- At the minimum, you should have the extensions for [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) and [Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter).

- In addition to using the bash script above for Python code style, you may wish to install the `autopep8`, `isort`, and `pylint` extensions.

The following extensions are reccomended:

- [GitHub Markdown Preview](http://marketplace.visualstudio.com/items?itemName=bierner.github-markdown-preview) (extension pack)
- [Markdown Preview for Github Alerts](https://marketplace.visualstudio.com/items?itemName=yahyabatulu.vscode-markdown-alert)
