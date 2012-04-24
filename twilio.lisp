;; Twilio API

(defpackage :cl-twilio
  (:use :common-lisp :oauth2 :cl-web-utils)
  (:documentation "An interface to the Twilio web API. Uses OAuth 2.0 for authentication."))

(in-package :cl-twilio)

(defparameter *account-sid* nil
  "The account SID.")

(defparameter *api-version* "2010-04-01"
  "The version of the API. Twilio uses the date the API was released.")

(define-json-request sms-message (From To Body)
  (format nil "/~a/Accounts/~a/SMS/Messages.json" *api-version* *account-sid*))
