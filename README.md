# Public Holidays
[![macOS 26](https://github.com/timtwotoes/PublicHolidays/actions/workflows/macos26.yml/badge.svg?branch=main)](https://github.com/timtwotoes/PublicHolidays/actions/workflows/macos26.yml) [![Ubuntu 24.04](https://github.com/timtwotoes/PublicHolidays/actions/workflows/ubuntu24.yml/badge.svg)](https://github.com/timtwotoes/PublicHolidays/actions/workflows/ubuntu24.yml)

See the names and dates for public holidays for any country.

This is a trivial package meant to explore DocC, GitHub pages and actions.

## Building DocC documentation

The ``build-docc.sh`` script builds the documentation for static hosting on
GitHub Pages.

### Preview documentation locally

You can use the same command as in ``build-docc.sh`` with a single modification.

```bash
swift package --allow-writing-to-directory "./docs" \
   generate-documentation --target PublicHolidays \
   --disable-indexing \
   --transform-for-static-hosting \
   --hosting-base-path "" \
   --output-path "./docs"
```

Using the empty string in ``--hosting-base-path`` makes it suitable for local
viewing.

Easy way to hosting it locally, is to use python3. In the root folder of the
project run

```bash
python3 -m http.server -d docs
```

This will serve the page at localhost:8000/documentation/publicholidays.

## References
- [caldays](https://caldays.com/api)  
- [Publish DocC to GitHub Pages via Actions](https://www.kodeco.com/40047657-docc-tutorial-for-swift-automating-publishing-with-github-actions)
- [Swift DocC Plugin documentation](https://swiftlang.github.io/swift-docc-plugin/documentation/swiftdoccplugin/)
