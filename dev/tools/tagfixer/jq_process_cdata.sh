#!/usr/bin/env bash

slurp_cdata() {
    canonical_data=$(
          jq '
            def concat($a; $b): if $a == "" then $b else $a + "__" + $b end ;

            def test_cases($description):
                if has("cases") then
                    # this object has nested test cases
                    .description as $d | .cases[] | test_cases(concat($description; $d))
                else
                    # emit this test case with an updated description
                    .description |= concat($description; .)
                end
                ;

            .cases |= (
                reduce (.[] | test_cases("")) as $case ({};
                    $case.reimplements as $r
                    | if $r then del(.[$r]) else . end
                    | .[$case.uuid] = $case
                )
                | [.[]]     # convert an object to a list of values
            )
        ' "$1"
      )

    echo "$canonical_data"
}

slurp_cdata "$1"
