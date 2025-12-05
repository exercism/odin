# Developer Tools Folder

This folder includes additional tooling used in the generation and linting of the exercises and the documentation, and other tools specific to the Odin track.
Tools are located here to keep the `bin` directory tidy and because Odin requires each package to have its own folder.

Tools are called from a bash script located in the `bin` folder; the script is responsible for setting the proper environment and parameters before calling the tool.

The tools so far:
- **codegen** is an initial take on generating solution stub and test files from a problem specification. It should be considered obsolete.
- **mkdoc** is a tool that takes a single introduction file containing all the documentation material for a concept and split it into the concept `about.md`, `introduction.md` and the exercise `introduction.md` files (Avoiding inconsistency between the sections common to the three documents).  