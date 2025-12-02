# About Basics

This is supposed to be an introduction to the Odin Basics concept.
A concept requires three documentation files.

- The concept `introduction.md` provides an introduction to the concept and is shown to the student before it solves the concept exercise.
- The `about.md` provides a more complete introduction and replaces the `introduction.md` once the student has solved the exercise.
- The exercise `introduction.md` provides an introduction to the exercise associated with the concept (and is either the same as the concept introduction or a cut-down version).

Some of the text, like this one will be common to all three documents.

[/restrict/]: #(about)
Some text will only show in the about document.

[/restrict/]: #(cintro)
Some text will only show in the concept introduction document.

[/restrict/]: #(xintro)
Some text will only show in the exercise introduction document.

[/restrict/]: #(about,cintro)
Some text will only show in the about document and the concept introduction document.

[/restrict/]: #(about,xintro)
Some text will only show in the about document and the exercise introduction document.

[/restrict/]: #(cintro,xintro)
Some text will only show in the concept introduction document and the exercise introduction document.

[/all/]: #()
The intent is to write a single document and use `mkdoc` to split it intro the three documents above.
This will help keep the documents consistent with each other and makes it easier to see which information is specific to one of the three.
