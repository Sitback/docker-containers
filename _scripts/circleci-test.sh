#!/usr/bin/env bash

set -o nounset

# Exit entire script on interrupt.
trap 'exit 130' INT

TEST_FILES="$(circleci tests glob "spec/**/*_spec.rb" | circleci tests split --split-by=timings)"
TEST_OUTPUT_PATH="/tmp/test-results"
EXIT_CODE=0

printf '%s\n' "$TEST_FILES" | while IFS= read -r line
do
  if [[ -z "${line}" ]]; then
    continue
  fi

  spec_path="${line#*/}"
  spec_base="$(dirname spec_path)"
  spec_filename="${line##*/}"

  output_path="${TEST_OUTPUT_PATH}/${spec_base}"
  mkdir -p "${output_path}"

  echo "Running test ${line}..."
  bundle exec rspec --format progress \
  --format RspecJunitFormatter \
  --out "${output_path}/${spec_filename}.xml" \
  --format progress \
  "${line}"


  ret=$?
  if [[ $ret -ne 0 ]]; then
    EXIT_CODE=$ret
  fi
done

exit $EXIT_CODE
