;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-151) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3anats%29

;; 1a. DATA DEFINITIONS
;; A N is one of: 
;; – 0
;; – (add1 N)
;; Interpretation: Represents the counting numbers.


;; 2a. FUNCTION SIGNATURE: N -> Number
;; 2b. PURPOSE STATEMENT: Computes (* n x) without using *.
;; 2c. HEADER
#; (define (multiply n x) 0)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (multiply 0 0) 0)
(check-expect (multiply 0 3) 0)
(check-expect (multiply 3 0) 0)
(check-expect (multiply 3 3) 9)
;; 4. TEMPLATE
#; (define (multiply n x)
     (cond
       [(zero? n) ...]
       [else (... n ... (multiply ...) ...)]
       )
     )
;; 5. CODE
(define (multiply n x)
  (cond
    [(zero? n) 0]
    [else (+ x (multiply (sub1 n) x))]
    )
  )

