;;; on-rename-elisp-library.el --- Update an Elisp library after file rename  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Arthur Miller

;; Author: Arthur Miller <arthur.miller@live.com>
;; Keywords: 

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

(defun on-rename-elisp-library (&rest args)
  "Change all instances of old library name for the new name."
  (save-excursion
    (let* ((old-file-name (file-name-nondirectory (buffer-file-name)))
           (old-library-name (file-name-sans-extension old-file-name))
           (new-file-name (file-name-nondirectory (car args)))
           (new-library-name (file-name-sans-extension new-file-name)))
      (goto-char 1)
      (while (search-forward old-file-name nil t)
        (replace-match new-file-name))
      (and (search-backward "(provide " nil t)
           (search-forward old-library-name nil t)
           (replace-match new-library-name)))))

(provide 'on-rename-elisp-library)
;;; on-rename-elisp-library.el ends here
