This is an example repo demonstrating a (almost certainly) newbie mistake I am making, that prevents cross compiling and linking when using a third party library.

`docker build -t deleteme .`

and then to actually run it against the included project, which should fail:

`docker run deleteme`

Notice that both the linux build and the windows build fail.
