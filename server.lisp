;;         DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;;                     Version 2, December 2004
;;
;;  Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
;;
;;  Everyone is permitted to copy and distribute verbatim or modified
;;  copies of this license document, and changing it is allowed as long
;;  as the name is changed.
;;
;;             DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;;    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;;
;;   0. You just DO WHAT THE FUCK YOU WANT TO.


;;  Copyright © 2019 Vito Van <awesomevito@live.com>
;;  This program is free software. It comes without any warranty, to
;;  the extent permitted by applicable law. You can redistribute it
;;  and/or modify it under the terms of the Do What The Fuck You Want
;;  To Public License, Version 2, as published by Sam Hocevar. See
;;  text above or http://www.wtfpl.net/ for more details.

;; ** -- WARNING --**
;; code below is written by a younger version of me,
;; and I don't have any interest to improve it unless something is broken,
;; so it is pretty messed up code. If you are going to use it, please just
;; use it as reference, for whoever's sake.

(setf sb-impl::*default-external-format* :UTF-8)
;;(declaim (optimize (debug 3)))
(ql:quickload '(drakma html-template cl-ppcre cl-fad xml-emitter hunchentoot))

(defpackage vitovan
  (:use :cl :drakma :html-template :cl-ppcre :cl-fad :xml-emitter))
(in-package :vitovan)

(defun concat (&rest rest)
  (apply #'concatenate 'string rest))

(defun ends-with-p (str1 str2)
  "Determine whether `str1` ends with `str2`"
  (let ((p (mismatch str2 str1 :from-end T)))
    (or (not p) (= 0 p))))

(defun file-to-string (path)
  (with-open-file (stream path)
    (let ((data (make-string (file-length stream))))
      (read-sequence data stream)
      data)))

(defun string-to-file (name content)
  (with-open-file (stream name
                          :direction :output
                          :if-exists :rename-and-delete
                          :if-does-not-exist :create )
    (format stream "~A" content))
  name)

(defun read-nth-line (file n &aux (line-number 0))
  "Read the nth line from a text file. The first line has the number 1"
  (assert (> n 0) (n))
  (with-open-file (stream file)
    (loop for line = (read-line stream nil nil)
       if (and (null line) (< line-number n))
       do (error "file ~a is too short, just ~a, not ~a lines long"
                 file line-number n)
       do (incf line-number)
       if (and line (= line-number n))
       do (return line))))

(defvar *md-path* "./md/")
(defvar *tmpl-path* "./tmpl/")
(defvar *ori-files-path* "./ori-files/")
(defvar *dist-path* "./docs/")
(defvar *shit-list* '("lispweb3" "lispweb3-cn" "new"))


(defun the-tmpl()
  (file-to-string (concat *tmpl-path* "the.tmpl")))

(defun get-title (md-file)
  (string-trim " " (regex-replace-all "#" (read-nth-line md-file 2) "")))

(defun get-order (md-file)
  (parse-integer (regex-replace-all "[^0-9]" (read-nth-line md-file 1) "") :junk-allowed t))

(defun the-list()
  (let* ((the-list))
    (dolist (md-file
              (sort
               (remove-if-not
                #'(lambda (p) (ends-with-p p "md"))
                (mapcar #'namestring (list-directory *md-path*)))
               #'(lambda(fa fb)
                   (< (get-order fa) (get-order fb)))))
      (format t "MD:~A~%" md-file)
      (push
       (cons (pathname-name md-file) (get-title md-file))
       the-list))
    the-list))

(defun dist-file-list()
  (let* ((dist-file-list))
    (dolist (md-file (list-directory *dist-path*))
      (push
       (pathname-name md-file)
       dist-file-list))
    dist-file-list))


(defun gh-markdown (md-file)
  (let ((result (drakma:http-request "https://api.github.com/markdown/raw"
                                     :method :post
                                     :content-type "text/x-markdown; charset=utf-8"
                                     :content md-file)))
    (regex-replace-all "id=\"user-content-" result "name=\"")))

(defun make-post(name)
  (regex-replace-all "#THE-TITLE#"
                     (regex-replace-all "#THE-CONTENT#" (the-tmpl)
                                        (gh-markdown (truename (concat *md-path* name ".md"))))
                     (get-title (truename (concat *md-path* name ".md")))))

(defun write-post(name)
  (format t "WRITING POST ~A ~%" name)
  (string-to-file (concat *dist-path* name ".html")
                  (make-post name))
  (format t "COPYING POST Attachments ~A ~%" name)
  (let ((att-dir (concat *dist-path* name "/"))
        (att-list (list-directory (concat *md-path* name))))
    (format t "ATT_DIR: ~A~%" att-dir)
    (when (> (length att-list) 0)
      (ensure-directories-exist (pathname att-dir)))
    (dolist (post-att att-list)
      (copy-file post-att
                 (concat
                  att-dir
                  (pathname-name post-att)
                  "."
                  (pathname-type post-att))
                 :overwrite t)))
  (format t "OK POST ~A ~%" name))

(defun copy-ori-file()
  (dolist (ori-file (list-directory *ori-files-path*))
    (copy-file ori-file (concat *dist-path* (pathname-name ori-file) "." (pathname-type ori-file))
               :overwrite t)))

(defun make-rss-item(name title)
  (rss-item title
            :link (concat "http://vito.sdf.org/" name ".html")
            :author "Vito Van"))


(defun make-rss()
  (with-output-to-string (s)
    (with-rss2 (s :encoding "UTF-8")
      (rss-channel-header "Vito Van" "http://vito.sdf.org/"
                          :description "The chips will fall where they may."
                          :image "http://vito.sdf.org/favicon.png"
                          :image-title "Vito's avatar")
      (dolist (x (the-list))
        (make-rss-item (car x) (cdr x))))))

(defun make-index()
  (regex-replace-all "#THE-TITLE#"
                     (regex-replace-all "#THE-CONTENT#" (the-tmpl)
                                        (let* ((the-list-html))
                                          (dolist (x (the-list))
                                            (format t "~A~%" x)
                                            (setf the-list-html
                                                  (concat the-list-html
                                                          (concat
                                                           "
                  <li"
                                                           (when
                                                               (member (car x) *shit-list* :test #'string=)
                                                             " class='shit' title='Caution: this link contains shit!'")
                                                           "><a href='"
                                                           (car x)
                                                           ".html'>"
                                                           (cdr x)
                                                           "</a></li>"))))
                                          (concat "<ul class='index'>" the-list-html "
                </ul>")))
                     "Vito Van"))

(defun write-index()
  (format t "WRITING INDEX ~%")
  (string-to-file (concat *dist-path* "list.html")
                  (make-index)))

(defun write-rss()
  (format t "WRITING RSS ~%")
  (string-to-file (concat *dist-path* "rss.xml")
                  (make-rss)))

(defun write-all-posts(&optional (force-rebuild nil))
  (dolist (x (the-list))
    (if (or force-rebuild (not (find (car x) (dist-file-list) :test #'equal)))
        (write-post (car x))))
  (write-index)
  (write-rss)
  (copy-ori-file))

(defparameter *ht-acceptor* (make-instance 'hunchentoot:easy-acceptor
                                           :port 8080
                                           :document-root *dist-path*))

(hunchentoot:start *ht-acceptor*)

;; (hunchentoot:stop *ht-acceptor*)
