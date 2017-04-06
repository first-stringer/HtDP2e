;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-147) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alists~3ane%29


;; 1a. DATA DEFINITIONS
;; A NEList-of-Booleans is one of: 
;; – (cons Boolean '())
;; – (cons Boolean NEList-of-Booleans)
;; interpretation non-empty lists of Booleans


;; 2a. FUNCTION SIGNATURE: NEList-of-Booleans -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a list of Boolean values containing at least
;; one item and determines whether all of them are #true.
;; 2c. HEADER
#; (define (all-true ne-l) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #true (cons #true '()))) #true)
(check-expect (all-true (cons #false'())) #false)
(check-expect (all-true (cons #true (cons #false'()))) #false)
;; 4. TEMPLATE
#; (define (all-true ne-l)
     (cond
       [(empty? (rest ne-l)) ...]
       [else (... (first ne-l) ... (rest ne-l) ...)]
       )
     )
;; 5. CODE
(define (all-true ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (and (first ne-l) (all-true (rest ne-l)))]
    )
  )


;; 2a. FUNCTION SIGNATURE: NEList-of-Booleans -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a list of Boolean values containing at least
;; one item and determines whether at least one item on the list is #true.
;; 2c. HEADER
#; (define (one-true ne-l) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #true (cons #true '()))) #true)
(check-expect (one-true (cons #false '())) #false)
(check-expect (one-true (cons #true (cons #false'()))) #true)
(check-expect (one-true (cons #false (cons #false'()))) #false)
;; 4. TEMPLATE
#; (define (one-true ne-l)
     (cond
       [(empty? (first ne-l)) ...]
       [else (... (first ne-l) ... (rest ne-l) ...)]
       )
     )
;; 5. CODE
(define (one-true ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (or (first ne-l) (one-true (rest ne-l)))]
    )
  )

