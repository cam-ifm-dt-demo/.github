# Digital Twin Demo

**Organization:** Institute for Manufacturing, University of Cambridge

**Authors:**
  - Yin-Chi Chan

**Quick links:**
  - [Documentation]()

### 3. Python code style

The following script can be run to check code style.  Place the script anywhere in your `$PATH`:

```bash
#! /usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

uv add --dev isort pylint autopep8
uv run isort $GIT_ROOT/src/ -l 100 --project cam_ifm_dt_demo
uv run pylint $GIT_ROOT/src/
```

A `.pylintc` file can be added to each Python project to disable various warnings. An example is:

```
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

- GitHub
  - [GitHub Repositories](https://marketplace.visualstudio.com/items?itemName=GitHub.remotehub)
  - [GitHub Markdown Preview](http://marketplace.visualstudio.com/items?itemName=bierner.github-markdown-preview) (extension pack)
  - [Markdown Preview for Github Alerts](https://marketplace.visualstudio.com/items?itemName=yahyabatulu.vscode-markdown-alert)
  - [Open in GitHub](https://marketplace.visualstudio.com/items?itemName=fabiospampinato.vscode-open-in-github)
  - [Git Graph](http://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)
