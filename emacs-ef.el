;; emacs-ef.el --- -*- lexical-binding: t -*-
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

;; TODO: find more accurate argument names
(defmacro ef-prefixied (prefix-first prefix-second &rest forms)
  ""
  `(cl-macrolet ((,(intern (format "defun-%s"
                                   prefix-first))
                  (name &rest args)
                  `(defun ,(intern (concat (symbol-name ',prefix-second)
                                           "-"
                                           (symbol-name name)))
                       ,@args))
                 (,(intern (format "defun-%s-"
                                   prefix-first))
                  (name &rest args)
                  `(defun ,(intern (concat (symbol-name ',prefix-second)
                                           "--"
                                           (symbol-name name)))
                       ,@args))

                 (,(intern (format "defvar-%s"
                                   prefix-first))
                  (name &optional value doc)
                  `(defvar ,(intern (concat (symbol-name ',prefix-second)
                                            "-"
                                            (symbol-name name)))
                     ,value
                     ,doc))

                 (,(intern (format "defvar-%s-"
                                   prefix-first))
                  (name &optional value doc)
                  `(defvar ,(intern (concat (symbol-name ',prefix-second)
                                            "--"
                                            (symbol-name name)))
                     ,value
                     ,doc))

                 ($? (name)
                     `(symbol-value (intern (concat (symbol-name ',prefix-second)
                                                    "-"
                                                    (symbol-name ',name)))))
                 ($?- (name)
                      `(symbol-value (intern (concat (symbol-name ',prefix-second)
                                                     "--"
                                                     (symbol-name ',name))))))
     ,@forms))

(put 'ef-prefixied 'lisp-indent-function 'defun)

(provide 'emacs-ef)
;;; emacs-ef.el ends here
