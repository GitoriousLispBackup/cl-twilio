;; Example of a Company Directory using the Twilio API

(defvar *directory*
  '(("0" "415-555-1111")
    ("1234" "415-555-2222")
    ("4321" "415-555-3333")))

(defvar *people*
  '(("john" "smith" "1234")
    ("eric" "anderson" "5555")
    ("will" "example" "9124")))

(defun string-to-digits (string)
  )
  
(defun get-phone-number-by-extension (extension)
  (second (assoc extension *directory*)))

(defun receptionist-phone-number ()
  (get-phone-number-by-extension "0"))

(defun search (digits)
  (find digits *directory* :key (lambda (person) (string-to-digits (second person)))))

(defun dial-extension (digits)
  (let ((phone-number (get-phone-number-by-extension digits)))
    (if phone-number
      (with-twilio (stream)
        (say "Thank you, dialing now")
        (dial phone-number)))))

(defun greeting-message (digits &key first-visit-p)
  (with-twilio (stream)
    (if first-visit-p
      (say "Thank you for calling Example Incorporated.")
     (say "I'm sorry, we could not find the extension " digits))
    (prompt "If you know your party's extension, please enter the extension now, followed by the pound sign. To search the directory, press star. Otherwise, stay on the line for the receptionist.")
    (say "Connecting you to the operator, please stay on the line.")
    (dial (receptionist-phone-number))))

(defun directory-search (digits)
  (let ((result (search digits)))
    (if result
      (with-twilio (stream)
        (say (first result) " " (second result) "'s extension is " (third result) " Connecting you now")
        (dial (get-phone-number-by-extension digits)))
      (with-twilio (stream)
        (say "No match found for " digits)
        (prompt "Enter the first several digits of the last name of the party you wish to reach, followed by the pound sign")
        (say "I did not receive a response from you")))))
