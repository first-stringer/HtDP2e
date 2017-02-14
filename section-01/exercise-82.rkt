;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-82) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3adesignstructs%29

;; 1. DATA DEFINITIONS:
;; A 3-letter word is a (make-3-letter-word (1String or #false) (1String or #false) (1String or #false)) where
;; first-letter is a 1String "a" through "z" or #false,
;; second-letter is a 1String "a" through "z" or #false, and
;; third-letter is a 1String "a" through "z" or #false.
;; This DD copied from exercise 78.
(define-struct 3-letter-word [first-letter second-letter third-letter])

;; 2a. FUNCTION SIGNATURE: 1String -> Boolean
;; 2b. PURPOSE STATEMENT: Compares to characters and returns the character if
;; they are equal, otherwise returns #false.
;; 2c. HEADER:
;; (define (check-chars c1 c2)
;;   #false)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: "a" "a", Expect: "a"
;; Given: "b" "c", Expect: #false
;; 3b. TESTS:
(check-expect (check-chars "a" "a") "a")
(check-expect (check-chars "b" "c") #false)
;; 4. TEMPLATE
;; (define (check-chars c1 c2)
;;   (... c1 ... c2 ...))
;; 5. CODE:
(define (check-chars c1 c2)
  (if (equal? c1 c2) c1 #false))