# The Internet Herokuapp - Robot Framework Challenge

[![Robot Framework Testing](https://github.com/IcaroPrates/the-internet-herokuapp-robot-framework-test/actions/workflows/main.yml/badge.svg)](https://github.com/IcaroPrates/the-internet-herokuapp-robot-framework-test/actions/workflows/main.yml)

A fun, practical automation challenge built with Robot Framework. This project tests file upload, file download, and JSON validation flows on The Internet Herokuapp, with a few bonus twists.

## What this covers
- Upload tests (standard + drag-and-drop)
- Download tests (single, random, all files, zero-byte handling)
- JSON comparison tests (full, partial, structure, and value checks)
- Bonus: JWT-based hidden message challenge

## Project structure
- `TestCases/TestSuiteRegression/Web/` - BDD test suites
- `Resources/Keywords/` - Reusable keywords
- `Libraries/` - Custom Python helpers
- `Data/Files/` - Test data (CSV, JSON, downloads)
- `results/` - Robot output (log/report)

## Quick start
1. Install Python 3.12+.
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Run all tests:
   ```bash
   robot -d results TestCases/TestSuiteRegression
   ```

## Test suites
- Upload_BDD.robot - Upload flows + drag-and-drop + JWT bonus
- Download_BDD.robot - Download flows + random/all files + zero-byte check
- JSON_BDD.robot - JSON comparisons and validations

## Bonus challenge
There is a hidden message stored in a JWT inside a CSV file. The tests show a hint, but the decoding is yours to discover.

## Tips
- If Chrome/Chromedriver is needed, make sure they are installed and in PATH.
- To reduce log noise, run with a higher log level:
  ```bash
  robot --loglevel ERROR -d results TestCases/TestSuiteRegression
  ```

Have fun and break things (safely)!
