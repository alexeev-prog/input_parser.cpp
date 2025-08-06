# input_parser.cpp
A lightweight, robust library for parsing command-line arguments with strict validation and automatic help generation.

## Features
- Support for both short (`-h`) and long (`--help`) options
- Options with required/optional arguments
- Positional arguments handling
- Strict input validation with detailed error reporting
- Automatic help message generation
- Zero external dependencies (except STL and Abseil for string utilities)
- Thread-safe implementation

## Requirements
- C++17 compatible compiler
- CMake 3.12+ (optional for integration)
- Abseil library (for string utilities)

## Integration
1. Copy `input_parser.hpp` and `input_parser.cpp` to your project's include directory
2. Include in your code:
```cpp
#include "input_parser.hpp"
```

### Building as Static Library
```bash
git clone https://github.com/alexeev-prog/input_parser.cpp
cd input_parser
make
sudo make install  # Installs to /usr/local by default
```

## Usage
### Basic Example
```cpp
#include "input_parser.hpp"

int main(int argc, char** argv) {
    InputParser parser("myapp", "Sample application with argument parsing");

    // Register options
    parser.add_option({
        .short_name = "-v",
        .long_name = "--verbose",
        .description = "Enable verbose output",
        .requires_argument = false
    });

    parser.add_option({
        .short_name = "-f",
        .long_name = "--file",
        .description = "Input file path",
        .requires_argument = true,
        .arg_placeholder = "PATH"
    });

    // Parse arguments
    if (!parser.parse(argc, argv)) {
        for (const auto& error : parser.get_errors()) {
            std::cerr << "ERROR: " << error << "\n";
        }
        std::cerr << parser.generate_help();
        return 1;
    }

    // Check options
    if (parser.has_option("--verbose")) {
        std::cout << "Verbose mode enabled\n";
    }

    if (auto file_path = parser.get_argument("-f")) {
        std::cout << "Processing file: " << *file_path << "\n";
    }

    return 0;
}
```

### Supported Syntax Formats
1. Short options:
   ```bash
   ./app -v -f data.txt
   ```
2. Long options:
   ```bash
   ./app --verbose --file=data.txt
   ```
3. Mixed formats:
   ```bash
   ./app -v --file data.txt
   ```
4. Positional arguments:
   ```bash
   ./app input.dat -v
   ```

## API Reference
### `InputParser` Class
| Method | Description |
|--------|-------------|
| `add_option(const Option&)` | Register new command-line option |
| `parse(int, char**)` | Parse command-line arguments |
| `has_option(string)` | Check if option was provided |
| `get_argument(string)` | Get argument for option |
| `get_positional_args()` | Get non-option arguments |
| `get_errors()` | Get parsing errors |
| `generate_help()` | Generate help message |

### `Option` Structure
| Field | Description |
|-------|-------------|
| `short_name` | Short option name (e.g., "-v") |
| `long_name` | Long option name (e.g., "--verbose") |
| `description` | Help text description |
| `requires_argument` | Whether option requires argument |
| `arg_placeholder` | Argument placeholder for help |

## Error Handling
The parser collects all errors during parsing. Common errors include:
- Unknown options
- Missing required arguments
- Unexpected arguments for options
- Duplicate option declarations

## License
MIT License. See LICENSE file for details.
