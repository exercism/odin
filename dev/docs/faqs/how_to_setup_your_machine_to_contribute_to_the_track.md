# How to Setup Your Machine to Contribute to the Track

You need Odin installed, if you don't have it already, follow the [installation instructions][odin-installation].

If you have a previous installation of Odin, the language is still evolving and minor syntax difference may cause your program to compile locally but fail when run via the Exercism toolchain.
The installation instructions contains the version that the Odin track is currently using.
We encourage you to update to that version or at least be aware of the differences.

If your IDE or text editor supports it, you will benefit from the Odin Language Server and Formatter.
They can be found [here][odin-language-server-and-formatter].
The [README][ols-readme] contains information on setup for different text editors.

You need to fork the [Odin Exercism repository][odin-exercism-repository] and clone a copy on your local machine (we will call this local copy `$EXERCISM_ODIN` in the text below).

On Windows, since all the scripts are setup for bash (.sh), we recommend installing [Git for Windows][git-for-windows] and running the following commands from the git bash.
This will automatically call your Windows installation of Odin, as long as it is in your path.

In your local `$EXERCISM_ODIN` repo, run `bin/fetch-configlet.sh`. The configlet script is Exercism tools to create and check exercises.

In your local `$EXERCISM_ODIN` repo, run `bin/fetch-ols-odinfmt.sh`.
This will install the Odin formatter for the Odin track tool so this is a different installation than the one you are using for your text editor.

[odin-installation]: https://github.com/exercism/odin/blob/main/docs//INSTALLATION.md
[odin-language-server-and-formatter]: https://github.com/DanielGavin/ols
[ols-readme]: https://github.com/DanielGavin/ols/blob/master/README.md
[odin-exercism-repository]: https://github.com/exercism/odin
[git-for-windows]: https://gitforwindows.org/
