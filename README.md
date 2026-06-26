# Overview

A collection of scripts I use frequently, including both **Bash scripts** for Linux and **Batch scripts** for Windows.

---

## Setting Up

### Windows

1. Add the path of the `scripts/batch/` folder to your **`PATH`** environment variable.
2. After that, you can run any batch script from any terminal or command prompt.

### Linux

1. Add the path of the `scripts/bash/` folder to your **`PATH`** environment variable.
2. Ensure all Bash scripts are executable. You can do this by running:

```bash
chmod +x /path/to/scripts/bash/*
```

3. To enable tab completion for `merge`, add this to your `~/.bashrc`:

```bash
source /path/to/scripts/bash/merge
```

---

## Bash Scripts

### `work`

Creates a GitHub issue, branches off the current branch linked to that issue, and checks out the new branch.

```
work "Issue title"
work -t "Issue title" [-b "Body"] [--base "base-branch"]
```

### `merge`

Creates a PR from one branch into another, auto-selects the merge strategy (squash for a single commit, merge commit for multiple), merges, and checks out the target branch.
Pushes unpushed local commits before creating the PR if needed. Supports tab completion for branch names.

```
merge <branch-to-merge-from> <branch-to-merge-to>
```

### `killport`

Kills processes using a specific port.

```
killport <port> [-f|--force] [-u|--udp]
```

### `winboot`

Reboots from Ubuntu into Windows via GRUB. Prompts for confirmation before rebooting.

```
winboot
```

---

## Batch Scripts

### `killport`

Terminates processes listening on one or more specified ports.

```
killport <port1> [port2] [port3] ...
```

### `pinq`

Pings `www.google.com` a specified number of times to test connectivity (defaults to 5).

```
pinq [-n <number_of_pings>]
```

### `linboot`

Reboots from Windows into Ubuntu. Prompts for confirmation before rebooting.

```
linboot
```

### `reduce`

Reduces video file size by scaling to 720p and compressing with H.264. Saves the output alongside the original with a `_reduced` suffix.

```
reduce <video_path>
```
