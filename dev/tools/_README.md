# Developer Tools Folder

This folder includes additional tooling used in the generation and linting of the exercises or the documentation as well as any other tool specific to the Odin track.
They are located here to keep the `bin` directory tidy and because Odin programs require a separate folder structure.
There will typically be a bash script in the `bin` folder to call them with the correct set of parameters.

- **codegen** is an initial take on generating solution stub and test files from a problem specification. It should be considered obsolete.
- **mkdoc** is a tool that takes a single introduction file containing all the documentation material for a concept and split it into the concept `about.md`, `introduction.md` and the exercise `introduction.md` files (Avoiding inconsistency between the sections common to the three documents).  