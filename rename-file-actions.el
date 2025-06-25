;;; rename-file-actions.el --- Rename Emacs Lisp File -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Arthur Miller

;; Author: Arthur Miller <arthur.miller@live.com>
;; Keywords: 
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(defgroup rename-file-actions nil
  "Run actions when a visited file is renamed."
  :prefix "rename-file-"
  :group 'convenience)

;;;###autoload
(defcustom rename-file-mode-alist nil
  "A list of pairs in format \='(mode . update-function)

FUNCTION will be called when a file with major MODE is renamed."
  :type 'alist)

(defun rename-file--run (&rest args)
  "Action runner"
  (dolist (mode-spec rename-file-mode-alist)
    (when (eq major-mode (car mode-spec))
      (apply (cdr mode-spec) args))))

;;;###autoload
(define-minor-mode rename-file-actions
  "Run actions when a visited file is renamed"
  :global t :lighter " rename-file"
  (if rename-file-actions
      (advice-add 'set-visited-file-name :before #'rename-file--run)
    (advice-remove 'set-visited-file-name #'rename-file--run)))

(provide 'rename-file-actions)
;;; rename-file-actions.el ends here
