##!/bin/sh

swift package --allow-writing-to-directory "./docs" \
   generate-documentation --target PublicHolidays \
   --disable-indexing \
   --transform-for-static-hosting \
   --hosting-base-path "PublicHolidays" \
   --output-path "./docs"

find docs -type f | wc -l

echo '<script>window.location.href += "/documentation/publicholidays"</script>' > docs/index.html
