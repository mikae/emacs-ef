;; emacs-ef.el --- 
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

(defmacro ef-setq?! (variable value)
  "Unless VARIABLE is non-nil, then set VALUE to VARIABLE.
Shortcut for:
(unless variable
  (setq variable value))"
  `(unless (and (boundp ',variable)
                ,variable)
     (setq ,variable ,value)))

(defmacro ef-fset?! (symbol func)
  "Like `ef-setq?!', just for function cells.
Shortcut for:
(unless (symbol-function symbol)
  (fset symbol func))"
  `(unless (symbol-function ',symbol)
     (cond
       ((or (functionp ',func)
            (macrop ',func))
         (fset ',symbol (symbol-function ',func)))
       ((or (functionp ,func)
            (macrop    ,func))
         (fset ',symbol ,func)))))

(defun ef-infect-language ()
  "Infect language with ef functions."
  (ef-fset?! setq?! ef-setq?!)
  (ef-fset?! fset?! ef-fset?!))

(provide 'emacs-ef)
;;; emacs-ef.el ends here
