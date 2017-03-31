;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-138) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3afinger-lists%29


;; 1a. DATA DEFINITIONS
;;                        A List-of-amounts is one of: 
;; – '()                        ^
;;                              |
;; – (cons PositiveNumber List-of-amounts)
#; '() ; data definition example
#; (cons 3 '()) ; data definition example
#; (cons 5 (cons 3 '())) ; data definition example


;; 2a. FUNCTION SIGNATURE: List-of-amounts -> Number
;; 2b. PURPOSE STATEMENT: Consumes a List-of-amounts and computes the sum of the
;; amounts.
;; 2c. HEADER
#; (define (sum loa) 0)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (sum '()) 0)
(check-expect (sum (cons 0 '())) 0)
(check-expect (sum (cons 1 '())) 1)
(check-expect (sum (cons 2 (cons 1 '()))) 3)
;; 4. TEMPLATE
(define (sum loa)
  (cond
    [(empty? loa) ...]
    [else (... (first loa) ... (rest loa) ...)]
    )
  )
;; 5. CODE



