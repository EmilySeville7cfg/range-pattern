;;; tests.el --- Unit tests  -*- lexical-binding: t; -*-

;; Copyright (c) 2022 Emily Grace Seville <EmilySeville7cfg@gmail.com>
;; Version: 0.2
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
;;  This package is the part of Better Emacs project.

;; URL: https://github.com/emilyseville7cfg-better-emacs/range-pattern

;;; Code:

(load-file "./range-pattern.el")

(ert-deftest range-pattern-check--expect-error-when-number-is-not-integer()
  "Expect error when NUMBER is not an integer."
  (should-error (range-pattern-check "wrong")))

(ert-deftest range-pattern-check--expect-error-when-from-is-not-integer-or-infinity()
  "Expect error when FROM is not an integer or infinity."
  (should-error (range-pattern-check 5 "wrong")))

(ert-deftest range-pattern-check--expect-error-when-to-is-not-integer-or-infinity()
  "Expect error when TO is not an integer or infinity."
  (should-error (range-pattern-check 5 1 "wrong")))

(ert-deftest range-pattern-check--expect-error-when-exclude-from-is-not-boolean()
  "Expect error when EXCLUDE-FROM is not a boolean."
  (should-error (range-pattern-check 5 1 2 "wrong")))

(ert-deftest range-pattern-check--expect-error-when-exclude-to-is-not-boolean()
  "Expect error when EXCLUDE-TO is not a boolean."
  (should-error (range-pattern-check 5 1 2 nil "wrong")))

(ert-deftest range-pattern-check--expect-correct-checks-when-parameters-are-correct()
  "Expect correct checks when all parameters are correct."
  (should (equal (range-pattern-check 1 1 10) t))
  (should (equal (range-pattern-check 5 1 10) t))
  (should (equal (range-pattern-check 10 1 10) t))
  (should (equal (range-pattern-check 1 1 10 t) nil))
  (should (equal (range-pattern-check 10 1 10 nil t) nil)))

(ert-deftest range-pattern-check--expect-error-when-from-is-greater-than-to()
  "Expect error when FROM > TO."
  (should-error (range-pattern-check 5 10 1)))

(ert-deftest pcase--expect-correct-checks-when-parameters-are-correct()
  "Expect correct checks when all parameters are correct."
  (should (equal (pcase 5
		   ((in 1 20) t)
		   (_ nil)) t))
  (should (equal (pcase 0
		   ((not-in 1 20) t)
		   (_ nil)) t)))

;;; tests.el ends here
