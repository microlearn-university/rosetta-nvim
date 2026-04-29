# rosetta-nvim

Classical-algorithm exercises inside Neovim, across Python, Rust, Go, and TypeScript. Inspired by [ferris.nvim](https://github.com/microlearn-university/ferris-nvim): pick an algorithm, pick a language, edit a buffer, save, and the plugin compiles / runs tests and reports results inline.

The same algorithm can be worked through in every language — re-implementing binary search in Rust after nailing it in Python is the point, not a chore.

## Requirements

- Neovim 0.9+
- Toolchains for the languages you want to use:
  - **Python**: `python3`
  - **Rust**: `rustc` (a standard [rustup](https://rustup.rs/) install — no Cargo project needed)
  - **Go**: `go`
  - **TypeScript**: `node` 22.6+ (uses `--experimental-strip-types --test`)
- Optional: `ANTHROPIC_API_KEY` in the environment to use `:RosettaChat`

## Installation

### lazy.nvim

```lua
{
  dir = "~/me/rosetta-nvim",
  config = function()
    require('rosetta').setup()
  end,
}
```

## Commands

| Command            | Description                                        |
|--------------------|----------------------------------------------------|
| `:Rosetta`         | Pick an algorithm (then a language)                |
| `:RosettaNext`     | Next algorithm, same language                      |
| `:RosettaPrev`     | Previous algorithm, same language                  |
| `:RosettaHint`     | Reveal the next hint                               |
| `:RosettaCheck`    | Manually re-run the current exercise               |
| `:RosettaChat`     | Ask Claude for help on this algorithm + language   |
| `:RosettaLang`     | Switch language for the current algorithm         |
| `:RosettaReset`    | Reset the current (algo, lang) working copy        |
| `:RosettaResetAll` | Reset all progress and working copies              |
| `:RosettaProgress` | Per-algo completion grid across languages          |

Saving (`:w`) re-runs the check automatically.

## How it works

- Each algorithm in `exercises/<id>/stubs/<lang>/` ships a stub the student edits, plus tests (either appended to the stub or in a separate `*_test.*` file for languages like Go).
- On first open, the plugin seeds a working directory under `~/.local/share/nvim/rosetta-nvim/work/<algo>/<lang>/` — your edits live there, not in the plugin directory, and survive updates.
- A per-language runner in `lua/rosetta/runners/` compiles/runs the tests and translates compiler/test output into inline Neovim diagnostics + a one-line status echo.
- Progress is stored in `~/.local/share/nvim/rosetta-nvim/progress.json`, keyed on `(algo_id, language)` so each language is its own checkbox per algorithm.

## Algorithms (v0)

- 01 Binary Search
- 02 Two Sum
- 03 Maximum Subarray (Kadane's)
- 04 Roman to Integer

(More to come — DP, graph traversals, sorting, union-find, etc.)

## License

MIT
