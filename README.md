# CustomModalView

This is a sample iPhone project showing one way to display a custom modal view. 

## How to Use

Your view controller must inherit from `WPSModalViewController` to display as a custom modal view.

Use the `edgeInsets` property on `WPSModalViewController` to control the edge insets for the modal view. The default edge insets is `(8, 8, 8, 8)`.

To display the modal view, import the category file `UIViewController+WPSKit.h` and call the category method `-wps_presentModalViewController:completion:`. To dismiss the modal view, call the category method `-wps_dismissModalViewControllerWithCompletion:`.

# Known Issues

- Does not support rotation.

# Support, Bugs and Feature requests

There is absolutely **no support** offered for this project. You're on your own. If you want to submit a feature request, please do so via [the issue tracker on github](http://github.com/kirbyt/CustomModalView/issues). Please note, however, new features will only be added if and when I have the spare time and only if I find the feature interesting.

If you want to submit a bug report, please do so via the [issue tracker](http://github.com/kirbyt/CustomModalView/issues). Include a diagnosis of the problem and a suggested fix (in code) with the report. If you're using my custom modal view hack, then you're a developer - so I expect you to do your homework and provide a fix along with each bug report. You can also submit pull requests or patches.

Please don't submit bug reports without fixes!

# License

The MIT License

Copyright (c) 2013 White Peak Software Inc

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.