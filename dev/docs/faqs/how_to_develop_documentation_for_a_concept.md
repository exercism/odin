# How To Develop Documentation for a Concept?

A Concept requires two documents:

- The `introduction.md` document provides an introduction to the concept and is shown to the student before it solves the concept exercise.
- The `about.md` provides a more complete introduction and replaces the `introduction.md` once the student has solved the exercise.

The about documentation is, typically, a more detailed version of the introduction document and will contain links to online docs, articles and other relevant information.

In addition, each Odin concept has a single associated concept exercise designed to illustrate the concept.
This exercise also requires an introduction document to introduce the concept in the context of the exercise.
Typically, it is  either the same as the concept introduction or a cut-down version focusing on solving the exercise.

To avoid these three documents becoming inconsistent over time, the concept developer should produce a single document with tags indicating which sections goes in which of the three documents (a section could be common to all the documents, specific to one, or anywhere in between).

The document should be located at `concepts/<concept-slug>/_introduction.md`.
The tags to associate sections to documents are described in this [example file][example-concept-doc-file] and the tool used to generate all the documents from this single one is `bin/gen-concept-docs.sh`.

[example-concept-doc-file]: https://github.com/exercism/odin/blob/main/dev/tools/mkdoc/example.md
