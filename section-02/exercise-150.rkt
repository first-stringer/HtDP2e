;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-150) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3anats%29


;; 1a. DATA DEFINITIONS
;; A N is one of: 
;; – 0
;; – (add1 N)
;; Interpretation: Represents the counting numbers.


;; 2a. FUNCTION SIGNATURE: N -> Number
;; 2b. PURPOSE STATEMENT: Computes (+ n pi) without using +.
;; 2c. HEADER
(define (add-to-pi n) pi)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
;; 4. TEMPLATE
;; 5. CODE

