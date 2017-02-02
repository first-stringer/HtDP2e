;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-38) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3afinger-design%29

;; 1. DATA DEFINITIONS: NA
;; 2a. FUNCTION SIGNATURE: String -> String
;; 2b. PURPOSE STATEMENT: Produces a string like the given one with the last character removed.
;; 2c. HEADER:
;; (define (string-remove-last str)
;;   "")
;; 3. FUNCTIONAL EXAMPLES:
;; Given: "abc", Expect "ab".
;; Given: "123", Expect "12".
;; 4. TEMPLATE:
;; (define (string-remove-last str)
;;   (... str ...))
;; 5. CODE:
(define (string-remove-last str)
  (substring str 0 (sub1 (string-length str))))
