# re-css-mode

A Emacs major mode for editing CSS code.

---

This mode implements css-mode and adds some improved font locking on top.


## INSTALL

### Manual install:

Place file at ~/.emacs.d/lisp/
Put the following in ~/.emacs.d/init.el:

``` elisp
(add-to-list 'load-path "~/.emacs.d/lisp/")
(autoload 're-css-mode "re-css-mode" "CSS major mode." t)
```

### Package manager:
To install with straight.el, put the following in ~/.emacs.d/init.el:

``` elisp
(straight-use-package
 `(re-css-mode :type git :host nil :repo "https://git2.trbk.it/cbra/re-css-mode.git")
```
