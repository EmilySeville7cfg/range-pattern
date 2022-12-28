;;; range-pattern.el --- Range pattern for pcase  -*- lexical-binding: t; -*-

;; Copyright (c) 2022 Emily Grace Seville <EmilySeville7cfg@gmail.com>
;; Version: 0.1
;; Package-Requires: ((emacs "27.1"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;  For details view README file.

;; URL: https://github.com/Emilyseville7cfg/generators

;;; Code:

(defun range-pattern-check(number from to &optional exclude-from exclude-to)
  "Check whether a number in a specific range.
FROM: the lowest range boundary
TO: the highest range boundary
EXCLUDE-FROM: whether to exclude the lowest range boundary
EXCLUDE-TO: whether to exclude the highest range boundary"
  (unless (or (integerp from) (equal from 'infinity))
    (error "The lowest range boundary '%s' is not an integer or 'infinity'" from))
  (unless (or (integerp to) (equal to 'infinity))
    (error "The highest range boundary '%s' is not an integer or 'infinity'" to))
  (unless (booleanp exclude-from)
    (error "The lowest range boundary exclusion flag '%s' is not a boolean" exclude-from))
  (unless (booleanp exclude-to)
    (error "The highest range boundary exclusion flag '%s' is not a boolean" exclude-to))

  (let ((from-checker (cond
		       (exclude-from '(lambda (value from) (< from value)))
		       (t '(lambda (value from) (<= from value)))))
	(to-checker (cond
		       (exclude-to '(lambda (value to) (> to value)))
		       (t '(lambda (value to) (>= to value))))))
    (and (cond
	  ((equal from 'infinity) t)
	  (t (funcall from-checker number from)))
	 (cond
	  ((equal to 'infinity) t)
	  (t (funcall to-checker number to))))))

(defmacro range-pattern--internal-wrapper(from to number)
  (list 'range-pattern-check number from to))

(defmacro range-pattern--negated-internal-wrapper(from to number)
  (list 'not (list 'range-pattern-check number from to)))

(pcase-defmacro in(from to)
  "Check whether EXPVAL is in a specific range [from..to].
FROM: the lowest range boundary
TO: the highest range boundary"
  `(pred (range-pattern--internal-wrapper ,from ,to)))

(pcase-defmacro not-in(from to)
  "Check whether EXPVAL is not in a specific range [from..to].
FROM: the lowest range boundary
TO: the highest range boundary"
  `(pred (range-pattern--negated-internal-wrapper ,from ,to)))

(provide 'range-pattern)

;;; range-pattern.el ends here
