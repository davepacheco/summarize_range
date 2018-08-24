# `summarize_range`

`summarize_range` takes a newline-separated, sorted list of positive integers on
stdin and produces a human-readable summary of the integer ranges.

Examples:

    `seq 1 10 | summarize_range`
        => "1 - 10"

    `(seq 5 10; echo 12; seq 17 20) | summarize_range`
        => "5 - 10, 12, 17 - 20"
