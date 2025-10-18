# Generator Tests

This directory contains integration tests for the Fluxbit scaffold generator.

## Running Generator Tests

The generator tests require a Rails application context and are separated from the main test suite.

### Run Generator Tests:
```bash
# Run all generator tests
bundle exec rake test:generators

# Run specific generator test
bundle exec ruby -Itest test/integration/generators/scaffold_generator_test.rb
```

### Test Coverage

The generator tests cover all scaffold generator class options:

- **`scaffold_generator_test.rb`** - Main comprehensive tests
- **`scaffold_generator_paginator_test.rb`** - `--paginator` / `--no-paginator` option tests
- **`scaffold_generator_ui_test.rb`** - `--ui=modal|drawer|none` option tests
- **`scaffold_generator_turbo_test.rb`** - `--turbo` / `--no-turbo` option tests
- **`scaffold_generator_pundit_test.rb`** - `--pundit` / `--no-pundit` option tests

### Test Structure

Each test validates:
- File generation (controllers, views, policies, etc.)
- Template content based on options
- Option combinations and interactions
- Generated code patterns and syntax

### Running All Tests

```bash
# Run main component tests (default)
bundle exec rake test

# Run all tests including generators
bundle exec rake test test:generators
```

## Notes

Generator tests are kept separate because they require Rails::Generators::TestCase which needs proper Rails application context that differs from the standard ViewComponent tests.