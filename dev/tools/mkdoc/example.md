# About Basics

This file demonstrates how the documentation for the concept About, Introduction and the exercise Introduction files are combined into a single file and the three files are then generated using `bin/gen-concept-doc.sh`.
It serves both as example and documentation for the tool.
The intent of this approach is to help keep the three documents consistent and make it easy for writers to compare the content of the files.


This file should hold the documentation for a concept, we are also assuming that the Odin track will use a single exercise per concept.

## Concept documents

A concept requires three documentation files.

- The concept `introduction.md` provides an introduction to the concept and is shown to the student before it solves the concept exercise.
- The `about.md` provides a more complete introduction and replaces the `introduction.md` once the student has solved the exercise.
- The exercise `introduction.md` provides an introduction to the exercise associated with the concept (and is either the same as the concept introduction or a cut-down version focused on leading the student through the exercise).

## Tags

The `gen-concept-doc.sh` tool uses a couple of tags (pseudo markdown link reference) to select the sections going in each document.

The top of the overall document goes in all 3 documents until it encounters a 'restrict' tag.
The 'restrict' tag will specify a subset of the documents and all following text will be restricted to this subset until another 'restrict' tag or an 'all' tag is encountered.
The 'all' tag will redirect the following text to all three documents until a 'restrict' tag is encountered.

The syntax for the 'restrict' tag is as follow:

```
[/restrict/]: #(<options1>,...)

options:
  about : the concept 'about.md' document
  cintro: the concept 'introduction.md' document
  xintro: the exercise 'introduction.md' document
```

The syntax for the 'all' tag is as follow: (The `#()` section is required to mimic the markdown syntax for a reference link, even though the tag itself has no option)


```
[/all/]: #()
```

## Document Location

`gen-concept-doc.sh` expects this document to be located at `concepts/<concept_slug>/_introduction.md`.

## Tag Usage Example

The rest of the document demonstrates the use of the tags and shows which text will end up in each document.

The text from the top of the document to the first 'restrict' tag, will be copied in the three documents (up to this point in our example).

[/restrict/]: #(about)
This text will only show in the about document.

[/restrict/]: #(cintro)
This text will only show in the concept introduction document.

[/all/]: #()
This text will show in all three documents.

[/restrict/]: #(xintro)
This text will only show in the exercise introduction document.

[/restrict/]: #(about,cintro)
This text will only show in the about document and the concept introduction document.

[/restrict/]: #(about,xintro)
This text will only show in the about document and the exercise introduction document.

[/restrict/]: #(cintro,xintro)
This text will only show in the concept introduction document and the exercise introduction document.

[/all/]: #()
This text will show in all three documents.
