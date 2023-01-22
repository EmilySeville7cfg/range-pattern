# range-pattern

Range pattern for pcase.

## Requirenments

- `emacs 27.1` higher

## Features

- [x] Function to check whether number is in a specific range
- [x] `in` and `not-in` operators for `pcase`

## Installation

### Copy-paste plugin script contents to `~/.emacs` while enabling lexical-binding

Example `~/.emacs` config:

```emacs
;;; -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; The extension file content with all comments removed can be placed here.

(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(package-selected-packages '(markdown-mode)))
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
)
```

## Functionality

To use open started or ended ranges replace `from` or `to` with `infinity` symbol.
By convention all parameters are ordered as follows:

- `number`, `from`, `to`, `exclude-from`, and `exclude-from` (for function)
- `from`, and `to` (for pattern in `pcase`)

Below square brackets are used to represent optional parameters and **not** arrays.

- Function: `range-pattern-check number from to [exclude-from exclude-to]`
  Description: Check whether a number in a specific range.

## Examples

Check whether 20 in a `[10..50]` range:

```lisp
(range-pattern-check 20 10 50)
```

Check whether 20 in a `[10..50]` range via pattern matching:

```lisp
(pcase 20
  ((in 10 50) "in range")
  (_ "anything else"))

```

Check whether 20 in a `[10..infinity]` range via pattern matching:

```lisp
(pcase 20
  ((in 10 'infinity) "in range")
  (_ "anything else"))

```
