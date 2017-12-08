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
(ef-infect-language)

(defmacro test-setq?! (name)
  `(describe (symbol-name ',name)
     (before-each
       (makunbound '--test-var))

     (it "Sets variable if it is nil"
       (let ((--test-var nil))
         (,name --test-var "nyan :3")
         (expect --test-var
                 :to-equal "nyan :3")))

     (it "Don't reassigns variable"
       (let ((--test-var nil))
         (,name --test-var "nyan :3")
         (,name --test-var "nyan-nyan")
         (expect --test-var
                 :to-equal "nyan :3")))

     (it "Do nothing when variable is set"
       (let ((--test-var "nyan :3"))
         (,name --test-var "nyan-nyan")
         (expect --test-var
                 :to-equal "nyan :3")))

     (it "Do nothing when variable is not defined"
       (,name --test-var "nyan-nyan")
       (expect --test-var
               :to-throw))))

(defmacro test-fset?! (name)
  `(describe (symbol-name ',name)
     (before-each
       (fmakunbound '--test-func-1)
       (fmakunbound '--test-func-2))

     (describe "Sets function's cell if it's nil with"
       (it "lambda"
         (let ((--lambda (lambda () 1)))
           (,name --test-func-1 --lambda)
           (expect (symbol-function '--test-func-1)
                   :to-be --lambda)))

       (it "function in function cell bound with symbol"
         (let ((--lambda (lambda () 1)))
           (,name --test-func-1 --lambda)
           (,name --test-func-2 --test-func-1)
           (expect (symbol-function '--test-func-2)
                   :to-be --lambda)))

       (it "macro in function cell bound with symbol"
         (let ((--macro '(macro lambda () 1)))
           (,name --test-func-1 --macro)
           (,name --test-func-2 --test-func-1)
           (expect (symbol-function '--test-func-2)
                   :to-be --macro)))
       )

     (it "Don't reassigns symbol's function"
       (let ((--lambda-1 (lambda () 1))
             (--lambda-2 (lambda () 2)))
         (,name --test-func-1 --lambda-1)
         (,name --test-func-1 --lambda-2)
         (expect (symbol-function '--test-func-1)
                 :to-be --lambda-1)))

     (it "Do nothing when symbol's function is set"
       (let ((--lambda-1 (lambda () 1))
             (--lambda-2 (lambda () 2)))
         (fset '--test-func-1 --lambda-1)
         (,name --test-func-1 --lambda-2)
         (expect (symbol-function '--test-func-1)
                 :to-be --lambda-1)))))

(test-setq?! ef-setq?!)
(test-fset?! ef-fset?!)
(test-setq?! setq?!)
(test-fset?! fset?!)


;; Local Variables:
;; eval: (put 'describe    'lisp-indent-function 'defun)
;; eval: (put 'it          'lisp-indent-function 'defun)
;; eval: (put 'before-each 'lisp-indent-function 'defun)
;; eval: (put 'after-each  'lisp-indent-function 'defun)
;; eval: (put 'before-all  'lisp-indent-function 'defun)
;; eval: (put 'after-all   'lisp-indent-function 'defun)
;; End:
