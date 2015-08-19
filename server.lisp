(setf sb-impl::*default-external-format* :UTF-8)
;;(declaim (optimize (debug 3)))
(ql:quickload '(drakma html-template cl-ppcre cl-fad))

(defpackage vitovan
  (:use :cl :drakma :html-template :cl-ppcre :cl-fad))
(in-package :vitovan)

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
    (format stream content))
  name)

(defun the-tmpl()
  (file-to-string #p"./tmpl/the.tmpl"))

(defun get-title (md-file)
  (with-open-file (stream md-file)
    (string-trim " " (regex-replace-all "#" (read-line stream nil) ""))))

(defun the-list()
  (let* ((the-list))
    (dolist (md-file
              (sort (list-directory "./md")
                    #'(lambda(fa fb)
                        (< (file-write-date fa) (file-write-date fb)))))
      (push
       (cons (pathname-name md-file) (get-title md-file))
       the-list))
    the-list))

(defun the-html-list()
  (let* ((the-html-list))
    (dolist (md-file (list-directory "./html"))
      (push
       (pathname-name md-file)
       the-html-list))
    the-html-list))


(defun gh-markdown (md-file)
  (let ((result (drakma:http-request "https://api.github.com/markdown/raw"
                                     :method :post
                                     :content-type "text/x-markdown; charset=utf-8"
                                     :content md-file)))
    result))

(defun make-post(name)
  (regex-replace-all "#THE-TITLE#"
                     (regex-replace-all "#THE-CONTENT#" (the-tmpl)
                                        (gh-markdown (truename (concatenate 'string "./md/" name ".md"))))
                     (get-title (truename (concatenate 'string "./md/" name ".md")))))

(defun write-post(name)
  (format t "WRITING POST ~A ~A" name #\newline)
  (string-to-file (concatenate 'string "./html/" name ".html")
                  (make-post name)))

(defun make-index()
  (regex-replace-all "#THE-TITLE#"
                     (regex-replace-all "#THE-CONTENT#" (the-tmpl)
                                        (let* ((the-list-html))
                                          (dolist (x (the-list))
                                            (setf the-list-html
                                                  (concatenate 'string the-list-html
                                                               (concatenate 'string "<a href='" (car x) ".html'>" (cdr x) "</a>"))))
                                          (concatenate 'string "<div class='index'>" the-list-html "</div>")))
                     "Vito Van"))

(defun write-index()
  (string-to-file "./html/index.html"
                  (make-index)))

(defun write-all-posts(&optional (force-rebuild nil))
  (dolist (x (the-list))
    (if (or force-rebuild (not (find (car x) (the-html-list) :test #'equal)))
        (write-post (car x))))
  (if force-rebuild
      (write-index)))
