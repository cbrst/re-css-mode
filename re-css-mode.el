;;; re-css-mode.el --- Pimp my CSS

;; Copyright 2019 by Christian Brassat

;; Author: Christian Brassat (http://brassat.eu/)
;; Version: 0.1.0
;; Created: 2019/05/06
;; Package-Requires: ((emacs "24.3"))
;; Keywords: languages, convenience, css, color
;; License: GPL v3
;; Homepage: https://git2.trbk.it/cbra/re-css-mode

;; This file is not part of GNU Emacs.

;;; Commentary:

;;  Extending font-lock for CSS mode.

;; INSTALL

;; Manual install:
;; Place file at ~/.emacs.d/lisp/
;; Put the following in ~/.emacs.d/init.el:
;; (add-to-list 'load-path "~/.emacs.d/lisp/")
;; (autoload 're-css-mode "re-css-mode" "CSS major mode." t)

;; Package manager:
;; To install with straight.el, put the following in ~/.emacs.d/init.el:
;; (straight-use-package
;;  `(re-css-mode :type git :host nil :repo "https://git2.trbk.it/cbra/re-css-mode.git")

;;; Code:

(defface re-css-id-selector
  '((t :foreground "firebrick" :weight bold))
  "Face for CSS ID selector."
  :group 're-css-mode)

(defface re-css-class-selector
  '((t :weight bold))
  "face for CSS class selector."
  :group 're-css-mode)

(defface re-css-pseudo-selector
  '((t :weight bold))
  "face for CSS pseudo selector."
  :group 're-css-mode)

(defface re-css-html-tag
  '((t :foreground "red" :weight bold))
  "Face for HTML tags."
  :group 're-css-mode)

(defface re-css-property
  '((t :foreground "green"))
  "Face for CSS properties."
  :group 're-css-mode)

(defface re-css-value
  '((t :foreground "blue"))
  "Face for CSS values."
  :group 're-css-mode)

(defface re-css-var-name
  '((t :foreground "teal"))
  "Face for CSS variables."
  :group 're-css-mode)

;; https://developer.mozilla.org/en-US/docs/Web/HTML/Element
(defvar +re-css-html-tag-names
  '("html"

	;; Document metadata
	"base"
	"head"
	"link"
	"meta"
	"style"
	"title"

	;; Sectioning root
	"body"

	;; Content sectioning
	"address"
	"article"
	"aside"
	"footer"
	"header"
	"h1" "h2" "h3" "h4" "h5" "h6"
	"hgroup"
	"main"
	"nav"
	"section"

	;; Text content
	"blockquote"
	"dd"
	"dir"
	"div"
	"dl"
	"dt"
	"figcaption"
	"figure"
	"hr"
	"li"
	"main"
	"ol"
	"p"
	"pre"
	"ul"

	;; Inline text semantics
	"a"
	"abbr"
	"b"
	"bdi"
	"bdo"
	"br"
	"cite"
	"code"
	"data"
	"dfn"
	"em"
	"i"
	"kbd"
	"mark"
	"q"
	"rb"
	"rp"
	"rt"
	"rtc"
	"ruby"
	"s"
	"samp"
	"small"
	"span"
	"strong"
	"sub"
	"sup"
	"time"
	"tt"
	"u"
	"var"
	"wbr"

	;; Image and multimedia
	"area"
	"audio"
	"img"
	"map"
	"track"
	"video"

	;; Embedded content
	"applet"
	"embed"
	"iframe"
	"noembed"
	"object"
	"param"
	"picture"
	"source"

	;; Scripting
	"canvas"
	"noscript"
	"script"

	;; Demarcating edits
	"del"
	"ins"

	;; Table content
	"caption"
	"col"
	"colgroup"
	"table"
	"tbody"
	"td"
	"tfoot"
	"th"
	"thead"
	"tr"

	;; Forms
	"button"
	"datalist"
	"fieldset"
	"form"
	"input"
	"label"
	"legend"
	"meter"
	"optgroup"
	"option"
	"output"
	"progress"
	"select"
	"textarea"

	;; Interactive elements
	"details"
	"dialog"
	"menu"
	"menuitem"
	"summary"
	)
  "List of HTML tags.")

(defvar +re-css-property-names
  '("align-content"
	"align-items"
	"align-self"
	"animation"
	"animation-delay"
	"animation-direction"
	"animation-duration"
	"animation-fill-mode"
	"animation-iteration-count"
	"animation-name"
	"animation-play-state"
	"animation-timing-function"
	"attr"

	"backface-visibility"
	"background"
	"background-attachment"
	"background-clip"
	"background-color"
	"background-image"
	"background-origin"
	"background-position"
	"background-position-x"
	"background-position-y"
	"background-repeat"
	"background-size"
	"border"
	"border-block"
	"border-block-color"
	"border-block-end"
	"border-block-end-color"
	"border-block-end-style"
	"border-block-end-width"
	"border-block-start"
	"border-block-start-color"
	"border-block-start-style"
	"border-block-start-width"
	"border-block-style"
	"border-block-width"
	"border-bottom"
	"border-bottom-color"
	"border-bottom-left-radius"
	"border-bottom-right-radius"
	"border-bottom-style"
	"border-bottom-width"
	"border-collapse"
	"border-color"
	"border-end-end-radius"
	"border-end-start-radius"
	"border-image"
	"border-image-outset"
	"border-image-repeat"
	"border-image-slice"
	"border-image-source"
	"border-image-width"
	"border-inline"
	"border-inline-color"
	"border-inline-end"
	"border-inline-end-color"
	"border-inline-end-style"
	"border-inline-end-width"
	"border-inline-start"
	"border-inline-start-color"
	"border-inline-start-style"
	"border-inline-start-width"
	"border-inline-style"
	"border-inline-width"
	"border-left"
	"border-left-color"
	"border-left-style"
	"border-left-width"
	"border-radius"
	"border-right"
	"border-right-color"
	"border-right-style"
	"border-right-width"
	"border-spacing"
	"border-start-end-radius"
	"border-start-start-radius"
	"border-style"
	"border-top"
	"border-top-color"
	"border-top-left-radius"
	"border-top-right-radius"
	"border-top-style"
	"border-top-width"
	"border-width"
	"bottom"
	"bottom"
	"box-decoration-break"
	"box-shadow"
	"box-sizing"
	"break-after"
	"break-before"
	"break-inside"

	"caption-side"
	"caret-color"
	"clear"
	"clip"
	"clip-path"
	"color"
	"color-adjust"
	"column-count"
	"column-fill"
	"column-gap"
	"column-rule"
	"column-rule-color"
	"column-rule-style"
	"column-rule-width"
	"column-span"
	"column-width"
	"columns"
	"content"
	"counter-increment"
	"counter-reset"
	"cursor"

	"direction"
	"display"

	"empty-cells"

	"filter"
	"flex"
	"flex-basis"
	"flex-direction"
	"flex-flow"
	"flex-grow"
	"flex-shrink"
	"flex-wrap"
	"font-family"
	"font-feature-settings"
	"font-kerning"
	"font-language-override"
	"font-optical-sizing"
	"font-size"
	"font-size-adjust"
	"font-stretch"
	"font-style"
	"font-synthesis"
	"font-variant"
	"font-variant-alternates"
	"font-variant-caps"
	"font-variant-east-asian"
	"font-variant-ligatures"
	"font-variant-numeric"
	"font-variant-position"
	"font-weight"

	"gap"
	"grid"
	"grid-area"
	"grid-auto-columns"
	"grid-auto-flow"
	"grid-auto-rows"
	"grid-column"
	"grid-column-end"
	"grid-column-start"
	"grid-row"
	"grid-row-end"
	"grid-row-start"
	"grid-template"
	"grid-template-areas"
	"grid-template-columns"
	"grid-template-rows"

	"hanging-punctuation"
	"height"
	"hyphens"

	"image-rendering"
	"isolation"

	"justify-content"
	"justify-items"
	"justify-self"

	"left"
	"letter-spacing"
	"line-break"
	"line-height"
	"list-style"
	"list-style-image"
	"list-style-type"
	"list-style-position"

	"margin"
	"margin-block"
	"margin-block-end"
	"margin-block-start"
	"margin-bottom"
	"margin-inline"
	"margin-inline-end"
	"margin-inline-start"
	"margin-left"
	"margin-right"
	"margin-top"
	"mask"
	"mask-clip"
	"mask-composite"
	"mask-image"
	"mask-mode"
	"mask-origin"
	"mask-position"
	"mask-repeat"
	"mask-size"
	"mask-type"
	"max-height"
	"max-width"
	"min-block-size"
	"min-height"
	"min-inline-size"
	"min-width"
	"mix-blend-mode"

	"object-fit"
	"object-position"
	"opacity"
	"order"
	"orphans"
	"outline"
	"outline-color"
	"outline-offset"
	"outline-style"
	"outline-width"
	"overflow"
	"overflow-wrap"
	"overflow-x"
	"overflow-y"

	"padding"
	"padding-block"
	"padding-block-end"
	"padding-block-start"
	"padding-bottom"
	"padding-inline"
	"padding-inline-end"
	"padding-inline-start"
	"padding-left"
	"padding-right"
	"padding-top"
	"page-break-after"
	"page-break-before"
	"page-break-inside"
	"perspective"
	"perspective-origin"
	"place-content"
	"place-items"
	"place-self"
	"pointer-events"
	"position"
	"pre-wrap"

	"quotes"

	"resize"
	"revert"
	"right"
	"row-gap"

	"scale"
	"scroll-behavior"
	"scroll-margin"
	"scroll-margin-block"
	"scroll-margin-block-end"
	"scroll-margin-block-start"
	"scroll-margin-bottom"
	"scroll-margin-inline"
	"scroll-margin-inline-end"
	"scroll-margin-inline-start"
	"scroll-margin-left"
	"scroll-margin-right"
	"scroll-margin-top"
	"scroll-padding"
	"scroll-padding-block"
	"scroll-padding-block-end"
	"scroll-padding-block-start"
	"scroll-padding-bottom"
	"scroll-padding-inline"
	"scroll-padding-inline-end"
	"scroll-padding-inline-start"
	"scroll-padding-left"
	"scroll-padding-right"
	"scroll-padding-top"
	"scroll-snap-align"
	"scroll-snap-stop"
	"scroll-snap-type"
	"scrollbar-color"
	"scrollbar-width"
	"shape-image-threshold"
	"shape-margin"
	"shape-outside"

	"tab-size"
	"table-layout"
	"text-align"
	"text-align-last"
	"text-combine-horizontal"
	"text-combine-upright"
	"text-decoration"
	"text-decoration-color"
	"text-decoration-line"
	"text-decoration-style"
	"text-emphasis"
	"text-emphasis-color"
	"text-emphasis-position"
	"text-emphasis-style"
	"text-indent"
	"text-justify"
	"text-orientation"
	"text-overflow"
	"text-rendering"
	"text-shadow"
	"text-transform"
	"text-underline-position"
	"top"
	"transform"
	"transform-origin"
	"transform-style"
	"transform-box"
	"transition"
	"transition-delay"
	"transition-duration"
	"transition-property"
	"transition-timing-function"
	"translate"

	"unicode-bidi"

	"vertical-align"
	"visibility"
	
	"white-space"
	"widows"
	"width"
	"will-change"
	"word-break"
	"word-spacing"
	"word-wrap"
	"writing-mode"

	"z-index")
  "List of CSS property names.")

(defvar +re-css-pseudo-selector-names
  '(":active"
	":after"
	":any"
	":before"
	":checked"
	":default"
	":dir"
	":disabled"
	":empty"
	":enabled"
	":first"
	":first-child"
	":first-letter"
	":first-line"
	":first-of-type"
	":focus"
	":fullscreen"
	":hover"
	":in-range"
	":indeterminate"
	":invalid"
	":lang"
	":last-child"
	":last-of-type"
	":left"
	":link"
	":not"
	":nth-child"
	":nth-last-child"
	":nth-last-of-type"
	":nth-of-type"
	":only-child"
	":only-of-type"
	":optional"
	":out-of-range"
	":read-only"
	":read-write"
	":required"
	":right"
	":root"
	":scope"
	":target"
	":valid"
	":visited")
  "List of CSS pseudo selector names.")

(defvar +re-css-values
  '("absolute"
	"alpha"
	"at"
	"auto"
	"avoid"
	"blink"
	"block"
	"bold"
	"border-box"
	"both"
	"bottom"
	"break-word"
	"calc"
	"capitalize"
	"center"
	"circle"
	"collapse"
	"content-box"
	"dashed"
	"dotted"
	"double"
	"ellipse"
	"embed"
	"fixed"
	"flex"
	"flex-start"
	"flex-wrap"
	"grid"
	"groove"
	"help"
	"hidden"
	"hsl"
	"hsla"
	"important" ; todo, this actually needs to be !important
	"inherit"
	"initial"
	"inline"
	"inline-block"
	"inset"
	"italic"
	"justify"
	"large"
	"left"
	"line-through"
	"linear-gradient"
	"lowercase"
	"ltr"
	"middle"
	"monospace"
	"no-repeat"
	"none"
	"normal"
	"nowrap"
	"oblique"
	"outset"
	"overline"
	"pointer"
	"radial-gradient"
	"relative"
	"repeat"
	"repeat-x"
	"repeat-y"
	"rgb"
	"rgba"
	"ridge"
	"right"
	"rotate"
	"rotate3d"
	"rotateX"
	"rotateY"
	"rotateZ"
	"rtl"
	"sans-serif"
	"scale"
	"scale3d"
	"scaleX"
	"scaleY"
	"scaleZ"
	"serif"
	"skew"
	"skewX"
	"skewY"
	"small"
	"smaller"
	"solid"
	"square"
	"static"
	"steps"
	"table"
	"table-caption"
	"table-cell"
	"table-column"
	"table-column-group"
	"table-footer-group"
	"table-header-group"
	"table-row"
	"table-row-group"
	"thick"
	"thin"
	"top"
	"translate"
	"translate3d"
	"translateX"
	"translateY"
	"translateZ"
	"transparent"
	"underline"
	"uppercase"
	"url"
	"visible"
	"wrap"
	"x-large"
	"xx-large"
	)
  "CSS Values.")

(defvar +re-css-units
  '("px" "pt" "pc" "cm" "mm" "in" "em" "rem" "ex" "%" "deg" "rad" "ch" "vw" "vh" "vmin" "vmax" )
  "CSS units.")

(defvar +re-css-font-lock-keywords nil "Making font lock stuff.")
(setq +re-css-font-lock-keywords
	  (let ((cssPseudoSelectorNames (regexp-opt +re-css-pseudo-selector-names))
			(cssPropertyNames       (regexp-opt +re-css-property-names 'symbols))
			(cssValueNames          (regexp-opt +re-css-values 'symbols))
			(cssUnitNames           (regexp-opt +re-css-units))
			(cssHtmlTags            (regexp-opt +re-css-html-tag-names 'symbols)))

		`(("#[-_a-zA-Z]+[-_a-zA-Z0-9]*"                  . 're-css-id-selector)
		  ("\\.[a-zA-Z]+[-_a-zA-Z0-9]*"                  . 're-css-class-selector)
		  ("\\(var\\)(\\(.*\\))"                         (1 're-css-value) (2 're-css-var-name))
		  ("\\(^\\|[[:space:](]\\)\\(--[-a-zA-Z0-9]+\\)" (2 're-css-var-name))
		  (,cssHtmlTags                                  . 're-css-html-tag)
		  (,cssPseudoSelectorNames                       . 're-css-pseudo-selector)
		  (,cssPropertyNames                             . 're-css-property)
		  (,cssValueNames                                . 're-css-value)

		  ;; Match units
		  (,(concat "\\([0-9]+\\)" "\\(" cssUnitNames "\\)") (1 font-lock-constant-face) (2 font-lock-type-face))

		  )))

;;;###autoload
(define-derived-mode re-css-mode css-mode "ϱCSS"
  "Major mode for editing CSS."
  (setq font-lock-defaults '((+re-css-font-lock-keywords)))

  :group 're-css-mode)

(provide 're-css-mode)

;;; re-css-mode.el ends here
