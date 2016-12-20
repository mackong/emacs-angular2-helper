;;; emacs-angular2-helper.el --- Helper functions make angular2 development more comfortable.

;; Copyright (C) 2016-2016 MacKong <mackonghp@gmail.com>

;; Author: MacKong <mackonghp@gmail.com>
;; Version: 1.0
;; Keywords: emacs, angular2

;;; Commentary:

;; Helper functions to create angular2 `component`, `service` and others easily.
;;

;; Usage:
;;
;; `eah-create-component` to create an angular2 component.
;; `eah-create-service` to create an angular2 service.
;;

;; TODO:
;;

;;; Code:

;;;; Functions

(defun format-name (name)
  "Format NAME in angular2 style.
E.g. `hello-world` to `HelloWorld`."
  (replace-regexp-in-string "-" "" (capitalize name)))

(defun create-component-script-content (name)
  "Create script content for component with a component NAME."
  (format "import { Component } from '@angular/core';

@Component({
    moduleId: module.id,
    selector: '%s',
    templateUrl: '%s.component.html',
    styleUrls: ['%s.component.css']
})
export class %sComponent {

}
" name name name (format-name name)))

(defun create-service-script-content (name)
  "Create script content for service with a service NAME."
  (format "import { Injectable } from '@angular/core'

@Injectable()
export class %sSerivce {

}
" (format-name name)))

(defun create-pipe-script-content (name)
  "Create script content for pipe with a pipe NAME."
  (format "import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
    name: '%s'
})
export class %sPipe implements PipeTransform {
    transform(value: any, args: any[]): any {
        
    }
}
" name (format-name name)))

;;;; Interactive functions
;;;###autoload
(defun eah-create-component (name)
  "Create an angular2 component with NAME."
  (interactive "sComponent Name: ")
  (append-to-file "" nil (concat name ".component.scss"))
  (append-to-file "" nil (concat name ".component.html"))
  (append-to-file (create-component-script-content name)
                  nil (concat name ".component.ts")))

;;;###autoload
(defun eah-create-service (name)
  "Create an angular2 service with NAME."
  (interactive "sSerivce Name: ")
  (append-to-file (create-service-script-content name)
                  nil (concat name ".service.ts")))

;;;###autoload
(defun eah-create-pipe (name)
  "Create an angular2 pipe with NAME."
  (interactive "sPipe Name: ")
  (append-to-file (create-pipe-script-content name)
                  nil (concat name ".pipe.ts")))

(provide 'emacs-angular2-helper)
;;; emacs-angular2-helper.el ends here

