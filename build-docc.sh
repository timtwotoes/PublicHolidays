##!/bin/sh

swift package --allow-writing-to-directory "./docs" \
   generate-documentation --target PublicHolidays \
   --disable-indexing \
   --transform-for-static-hosting \
   --hosting-base-path "PublicHolidays" \
   --output-path "./docs"

echo '<script>window.location.href += "/documentation/publicholidays"</script>' > docs/index.html
