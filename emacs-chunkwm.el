;;; emacs-chunkwm.el --- emacs bindings for macos chunkwm  -*- lexical-binding: t; -*-

;; Copyright © 2018, Rashawn Zhang, all rights reserved.

;; Author: Rashawn Zhang <namy.19@gmail.com>
;; Created: 31 December 2018
;; Keywords: macos chunkwm

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

(require 's)

(defun emacs-chunkwm-get-current-desktop-windows()
  (let ((chunkc-result (async-get
                        (async-start
                         (lambda ()
                           (process-lines
                            "chunkc" "tiling::query" "--desktop" "windows"))
                         nil))))
    (mapcar (lambda (line) (s-slice-at "," line)) chunkc-result)))

(provide 'emacs-chunkwm)
;;; emacs-chunkwm.el ends here