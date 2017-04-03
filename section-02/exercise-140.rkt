;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-140) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3afinger-lists%29

;; 1a. DATA DEFINITIONS
;; A List-of-booleans is one of: 
;; – '()
;; – (cons Boolean List-of-booleans)


;; 2a. FUNCTION SIGNATURE: List-of-booleans -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a list of Boolean values and determines
;; whether all of them are #true.
;; 2c. HEADER
#; (define (all-true lob) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (all-true '()) #true)
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #true (cons #true '()))) #true)
(check-expect (all-true (cons #false'())) #false)
(check-expect (all-true (cons #true (cons #false'()))) #false)
;; 4. TEMPLATE
#; (define (all-true lob)
     (cond
       [(empty? lob) ...]
       [else (... (first lob) ... (rest lob) ...)]
       )
     )
;; 5. CODE
(define (all-true lob)
  (cond
    [(empty? lob) #true]
    [else (and (first lob) (all-true (rest lob)))]
    )
  )

