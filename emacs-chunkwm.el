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
(require 'async)
(require 'windmove)

(defvar emacs-chunkwm-command "chunkc")

;; tiling focus
(defun emacs-chunkwm-tiling-focus (direction)
  (async-start-process emacs-chunkwm-command emacs-chunkwm-command 'ignore "tiling::window" "--focus" direction))

(defun emacs-chunkwm-tiling-left ()
  (interactive)
  (emacs-chunkwm-tiling-focus "west"))

(defun emacs-chunkwm-tiling-down ()
  (interactive)
  (emacs-chunkwm-tiling-focus "south"))

(defun emacs-chunkwm-tiling-up ()
  (interactive)
  (emacs-chunkwm-tiling-focus "north"))

(defun emacs-chunkwm-tiling-right ()
  (interactive)
  (emacs-chunkwm-tiling-focus "east"))

;; integrate with winmove
(defun emacs-chunkwm-winmove-left (&optional arg)
  (interactive)
  (if (null (windmove-find-other-window 'left))
      (emacs-chunkwm-tiling-left)
    (windmove-left)))

(defun emacs-chunkwm-winmove-down (&optional arg)
  (interactive)
  (if (null (windmove-find-other-window 'down))
      (emacs-chunkwm-tiling-down)
    (windmove-down)))

(defun emacs-chunkwm-winmove-up (&optional arg)
  (interactive)
  (if (null (windmove-find-other-window 'up))
      (emacs-chunkwm-tiling-up)
    (windmove-up)))

(defun emacs-chunkwm-winmove-right (&optional arg)
  (interactive)
  (if (null (windmove-find-other-window 'right))
      (emacs-chunkwm-tiling-right)
    (windmove-right)))

(defun emacs-chunkwm-get-current-desktop-windows()
  (let ((chunkc-result
         (async-get
          (async-start
           (lambda ()
             (process-lines
              emacs-chunkwm-command "tiling::query" "--desktop" "windows"))
           nil))))
    (mapcar
     (lambda (line)
       (mapcar
        (lambda (split)
          (print split)
          (string-remove-prefix ", " split))
        (s-slice-at "," line)))
     chunkc-result)))

(provide 'emacs-chunkwm)
;;; emacs-chunkwm.el ends here