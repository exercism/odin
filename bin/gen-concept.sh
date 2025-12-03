#!/usr/bin/env bash

# This script creates a scaffolding for a new concept so all the required files are in place.
# it **doesn't create scaffolding for the concept exercise, use gen-exercise.sh for this.

# Exit script if any subcommands fail
set -eo pipefail

die() {
    echo "$*" >&2
    exit 1
}

to_snake_case() {
    sed -E '
        s/[ -]/_/g
        s/([[:lower:][:digit:]])([[:upper:]])/\1_\2/g
        s/[^[:alnum:]_]//g
    ' | tr '[:upper:]' '[:lower:]'
}

[[ $# -eq 1 ]] || die "Usage gen-concept <concept name>"

read -rp 'What is your github userid? ' author
read -rp 'What is the concept blurb? ' blurb

concept_name=$1
concept_slug=$(to_snake_case <<< "$concept_name")
concept_path="concepts/${concept_slug}"

if [[ -d "$concept_path" ]]; then
  die "Concept ${concept_name} directory already exist!"
fi

mkdir -p "$concept_path"
mkdir -p "$concept_path/.meta"

# Generate stub files for the concept

cat >>"${concept_path}/about.md"<<EOL
# About

<!--
This file provides information about the concept for a student who has completed the corresponding
concept exercise to learn from and refer back to.

It should provide students with comprehensive information on what they need to know to be fluent in the concept.
At a minimum, this file should contain all information that is introduced in the Concept's introduction.md document.

If the Concept introduces new syntax, syntax samples should be included. The student should not have to follow a lot
of links to gain the knowledge that the file tries to convey. Instead the about.md should contain enough information
to be understandable within its context.

The about.md file is not limited to the scope of the corresponding Concept Exercise. The content can require knowledge
of other concepts that will be introduced later on. If other Concepts are mentioned, their respective introductions
should be linked to (see internal linking for details).

Here some examples of what could be covered.

- Popular usages for a Concept
- Common pitfalls in a Concept's use (e.g. failing to consider thread-safety)
- Limitations on use that may catch out the unsuspecting developer
- Alternative approaches addressed in other Concepts (e.g. the recursion Concept might reference that the Higher Order
  Functions Concept offers an alternative approach to similar problems)
- Compromises made for ease of learning or to accommodate the Exercism environment, e.g. multiple classes in single file
- Similar features with which the Concept may be confused
- Performance characteristics and memory usage, when a common consideration within that language
- Don't refer to an exercise in the text, as this file is displayed outside the context of an exercise.

- It is not the aim of the about.md file to provide a complete set of information on the Concept. As an example, imagine a
  language that has some older features for which experienced programmers (and maybe even the official docs/specs) recommend
  they should not be used anymore. Providing details on such features would be out of scope for the about.md file because
  they are not relevant to gain fluency. However, maintainers may choose to add a short block to acknowledge the old standards
  if a student might commonly come across those standards in the wild. However, this block should be marked as such.

The about.md file MUST be clearly structured, especially when it contains a lot of information. In the future there will also
be support for marking parts as "advanced topics" to point them out to interested students without overloading others.
-->
EOL


cat >>"${concept_path}/introduction.md"<<EOL
# Introduction

<!--
This file provides a brief introduction to a student who has not yet completed the corresponding concept exercise.

It is shown if a student has not yet completed the corresponding concept exercise. It should provide a brief introduction
to the concept.

- Only information that is needed to understand the fundamentals of the concept should be provided. Extra information should
  be left for the about.md document.
- Links should be used sparingly, if at all. While a link explaining a complex topic like recursion might be useful, for most
  concepts the links will provide more information than needed so explaining things concisely inline should be the aim.
- Proper technical terms should be used so that the student can easily search for more information.
- Code examples should only be used to introduce new syntax (students should not need to search the web for examples of syntax).
  In other cases provide descriptions or links instead of code.
- Don't refer to an exercise in the text, as this file is displayed outside the context of an exercise.
-->
EOL

cat >>"${concept_path}/links.json"<<EOL

// This file provides helpful links that provide more reading or information about a concept.
//
// These might be official docs, a great tutorial, etc. These links do not replace the more contextual links within a
// concept's about.md file, but provide a quick set of overarching reference points for a student.
// Each link must contain the following fields:
// - url: the URL it links to.
// - description: a description of the link, which is shown as the link text.
// Links can also optionally have an icon_url field, which can be used to customize the icon shown when the link is displayed.
// If not specified, the icon defaults to the favicon.
//
// JSON does not support comments. PLEASE DELETE ALL THE C-STYLE COMMENTS FROM THE FINAL VERSION.
[
  {
    "url": "https://odin-lang.org/docs/overview/",
    "description": "Odin Overview"
  },
]
EOL

cat >>"${concept_path}/.meta/config.json"<<EOL
{
  "blurb": "$blurb",
  "authors": ["$author"],
  "contributors": [
  ]
}
EOL

# Add the concept to config.json 
uuid=$(bin/configlet uuid)
tmp=$(mktemp)
jq \
  --arg uuid "$uuid" \
  --arg name "$concept_name" \
  --arg slug "$concept_slug" \
   '.concepts += [
      {
        "uuid": $uuid,
        "slug": $slug,
        "name": $name
      }
   ]' config.json > "$tmp" && mv "$tmp" config.json

echo "Be sure to implement the following files:"
echo -e "\t${concept_path}/introduction.md"
echo -e "\t${concept_path}/about.md"
echo -e "\t${concept_path}/links.json"
echo ""
