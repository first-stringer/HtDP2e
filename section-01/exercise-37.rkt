;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-37) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3afinger-design%29

;; 1. DATA DEFINITIONS: NA
;; 2a. FUNCTION SIGNATURE: String -> String
;; 2b. PURPOSE STATMENT: Produces a string like the given one with the first character removed.
;; 2c. HEADER:
;; (define (string-rest str)
;;   "" )
;; 3. FUNCTIONAL EXAMPLES:
;; Given: "abc", Expect "bc".
;; Given: "123", Expect "23".
;; 4. TEMPLATE:
;; (define (string-rest str)
;;   (... str ...))
;; 5. CODE:
(define (string-rest str)
  (substring str 1))