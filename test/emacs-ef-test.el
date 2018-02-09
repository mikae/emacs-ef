;; emacs-ef-test.el --- 
;;
;; Author: Minae Yui <minae.yui.sain@gmail.com>
;; Version: 0.1
;; URL: 
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;; .
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'buttercup)
(require 'cl-lib)

(require 'emacs-ef)

(describe "ef-prefixied"
  (it "defun-*-/defun-*-- works"
    (ef-prefixied a b
      (defun-a test (arg1 arg2)
        (+ arg1 arg2))

      (defun-a- test (arg1 arg2)
        (* arg1 arg2)))

    (expect (b-test 1 2)
            :to-be 3)
    (expect (b--test 1 2)
            :to-be 2))

  (it "defvar-*-/defvar-*-- works"
    (ef-prefixied a b
      (defvar-a test 1)
      (defvar-a- test 1))

    (expect b-test
            :to-be 1)
    (expect b--test
            :to-be 1))

  (it "$?/$?- works"
    (ef-prefixied a b
      (defvar-a test 1)
      (defvar-a- test 1)

      (expect ($? test)
              :to-be 1)
      (expect ($?- test)
              :to-be 1)))

  (it "$!/$!- works"
    (ef-prefixied a b
      (defvar-a test 1)
      (defvar-a- test 1)
      ($! test 2)
      ($!- test 2)

      (expect ($? test)
              :to-be 2)
      (expect ($?- test)
              :to-be 2)))

  (it "$@/$@- works"
    (ef-prefixied a b
      (defun-a test (arg1 arg2)
        (+ arg1 arg2))

      (defun-a- test (arg1 arg2)
        (* arg1 arg2))

      (expect ($@ test 1 2)
              :to-be 3)
      (expect ($@- test 1 2)
              :to-be 2))

    )
  )

;; Local Variables:
;; eval: (put 'describe    'lisp-indent-function 'defun)
;; eval: (put 'it          'lisp-indent-function 'defun)
;; eval: (put 'before-each 'lisp-indent-function 'defun)
;; eval: (put 'after-each  'lisp-indent-function 'defun)
;; eval: (put 'before-all  'lisp-indent-function 'defun)
;; eval: (put 'after-all   'lisp-indent-function 'defun)
;; End:
