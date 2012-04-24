(defsystem :cl-twilio
  :name "CL-Twilio"
  :description "Common Lisp interface to the Twilio API, using OAuth2"
  :version "0.1"
  :author "Rudolf Olah"
  :license "MIT"
  :depends-on (:oauth2 :cl-web-utils)
  :serial t
  :components ((:file "twilio")))