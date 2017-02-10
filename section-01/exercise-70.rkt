;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-70) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aeval-structs%29

(define-struct centry [name home office cell])
(define-struct phone [area number])


(define contact (make-centry "Jim" (make-phone 555 "555-5555") (make-phone 444 "444-4444") (make-phone 666 "666-6666")))
(string=? "Jim" (centry-name contact))
(= 555 (phone-area (centry-home contact)))
(string=? "555-5555" (phone-number (centry-home contact)))
(= 444 (phone-area (centry-office contact)))
(string=? "444-4444" (phone-number (centry-office contact)))
(= 666 (phone-area (centry-cell contact)))
(string=? "666-6666" (phone-number (centry-cell contact)))

(= 101 (phone-area
 (centry-office
  (make-centry
    "Shriram Fisler"
    (make-phone 207 "363-2421")
    (make-phone 101 "776-1099")
    (make-phone 208 "112-9981")))))

