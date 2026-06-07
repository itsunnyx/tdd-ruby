# Coverage Gutters Setup

Show inline test coverage in Cursor/VS Code using [Coverage Gutters](https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters).

Coverage Gutters reads **LCOV** files. SimpleCov's HTML report alone is not enough — you also need an `lcov.info` file.

## 1. Install the extension

In Cursor, install **Coverage Gutters** (`ryanluker.vscode-coverage-gutters`).

## 2. Add the LCOV formatter gem

Add to `Gemfile`:

```ruby
gem "simplecov-lcov", "~> 0.9"
```

Install:

```bash
bundle install
```

## 3. Load SimpleCov once (not in every spec)

SimpleCov must start **before** any file in `lib/` is loaded. Do not put `require "simplecov"` in individual spec files.

Create `spec/spec_helper.rb`:

```ruby
require "simplecov"
```

Create `.rspec` in the project root:

```
--require spec_helper
```

RSpec loads `spec_helper` automatically before any spec runs. Your spec files only need to require the lib files they test:

```ruby
require_relative "../lib/cart"
```

## 4. Configure SimpleCov

Replace the contents of `.simplecov` with:

```ruby
require "simplecov-lcov"

SimpleCov::Formatter::LcovFormatter.config do |c|
  c.report_with_single_file = true
  c.output_directory = "coverage"
  c.lcov_file_name = "lcov.info"
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::LcovFormatter,
  SimpleCov::Formatter::HTMLFormatter
])

SimpleCov.start do
  add_filter "/spec/"
  track_files "lib/**/*.rb"
end
```

Run tests to generate the report:

```bash
bundle exec rspec
```

This creates `coverage/lcov.info` alongside the HTML report.

## 5. Configure workspace settings

Add to `.vscode/settings.json` at the repo root (`ror/.vscode/settings.json`):

```json
{
  "coverage-gutters.coverageFileNames": [
    "lcov.info",
    "cov.info",
    "coverage.info"
  ],
  "coverage-gutters.coverageBaseDir": "01",
  "coverage-gutters.lcovname": "coverage/lcov.info"
}
```

If you open the `01` folder directly as the workspace root instead, use:

```json
{
  "coverage-gutters.lcovname": "coverage/lcov.info"
}
```

## 6. Use Coverage Gutters

1. Run tests: `bundle exec rspec`
2. Click **Watch** in the status bar, or run **Coverage Gutters: Watch** from the command palette
3. Open a file under `lib/` — green gutters mean covered lines, red means uncovered

### Commands

| Command | Description |
|---------|-------------|
| **Watch** | Auto-refresh when `lcov.info` changes |
| **Display** | Show coverage for the current file once |
| **Remove Watch** | Stop watching for changes |

## Troubleshooting

- **Low coverage (e.g. 10%) despite passing tests** — A spec file loaded `lib/` code before SimpleCov started. Use `spec/spec_helper.rb` and `.rspec` as shown above; do not `require "simplecov"` in individual specs.
- **No gutters showing** — Open the **Coverage Gutters** output panel and check for file path errors.
- **Stale coverage** — Re-run `bundle exec rspec` after changing code or specs.
- **Wrong paths in lcov** — Keep `report_with_single_file = true` and output to `coverage/lcov.info` as shown above.

## Typical workflow

```bash
cd 01
bundle exec rspec
```

Enable **Watch** in Cursor, edit code, re-run specs, and gutters update automatically.
