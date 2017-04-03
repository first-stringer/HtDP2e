;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-139) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3afinger-lists%29


;; 1a. DATA DEFINITIONS
;; #1:                  A List-of-amounts is one of: 
;; – '()                        ^
;;                              |
;; – (cons PositiveNumber List-of-amounts)
#; '() ; data definition example
#; (cons 3 '()) ; data definition example
#; (cons 5 (cons 3 '())) ; data definition example
;; #2: A List-of-numbers is one of: 
;; – '()
;; – (cons Number List-of-numbers)
#; (cons 5 '()) ; data definition example
#; (cons -1 '()) ; data definition example
#; (cons 5 (cons -1 '())) ; data definition example


;; 1b. CONSTANT DEFINITIONS
(define ERROR_MESSAGE "Cannot have negative amount!")


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
#; (define (sum loa)
     (cond
       [(empty? loa) ...]
       [else (... (first loa) ... (sum (rest loa)) ...)]
       )
     )
;; 5. CODE
(define (sum loa)
  (cond
    [(empty? loa) 0]
    [else (+ (first loa) (sum (rest loa)))]
    )
  )


;; 2a. FUNCTION SIGNATURE: List-of-numbers -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a List-of-numbers and determines whether all
;; numbers are positive numbers.
;; 2c. HEADER
#; (define (pos? lon) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (pos? '()) #true)
(check-expect (pos? (cons 5 '())) #true)
(check-expect (pos? (cons -1 '())) #false)
(check-expect (pos? (cons -1 (cons 5 '()))) #false)
(check-expect (pos? (cons 5 (cons -1 '()))) #false)
(check-expect (pos? (cons 5 (cons 1 '()))) #true)
(check-expect (pos? (cons -5 (cons -1 '()))) #false)
;; 4. TEMPLATE
#; (define (pos? lon)
     (cond
       [(empty? lon) #true]
       [else (... (first lon) ... (rest lon) ...)]
       ) 
     )
;; 5. CODE
(define (pos? lon)
  (cond
    [(empty? lon) #true]
    [else (and (positive? (first lon)) (pos? (rest lon)))]
    ) 
  )


;; 2a. FUNCTION SIGNATURE: List-of-numbers -> Number
;; 2b. PURPOSE STATEMENT: Consumes a List-of-numbers. It produces their sum if
;; the input also belongs to List-of-amounts; otherwise it signals an error.
;; 2c. HEADER
#; (define (checked-sum lon) 0)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (checked-sum '()) 0)
(check-expect (checked-sum (cons 5 '())) 5)
(check-expect (checked-sum (cons 6 (cons 5 '()))) 11)
(check-error (checked-sum (cons -5 '())) ERROR_MESSAGE)
;; 4. TEMPLATE
#; (define (checked-sum lon)
     (cond
       [(pos? lon) (... lon ...)]
       [else (... lon ...)]
       )
     )
;; 5. CODE
(define (checked-sum lon)
  (cond
    [(pos? lon) (sum lon)]
    [else (error ERROR_MESSAGE)]
    )
  )

