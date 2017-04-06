;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-146) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alists~3ane%29


;; 1a. DATA DEFINITIONS
;; A NEList-of-temperatures is one of: 
;; – (cons CTemperature '())
;; – (cons CTemperature NEList-of-temperatures)
;; interpretation non-empty lists of Celsius temperatures 


;; 2a. FUNCTION SIGNATURE: NEList-of-temperatures -> Number
;; 2b. PURPOSE STATEMENT: Consumes a list and returns the number of items in the
;; list.
;; 2c. HEADER
#; (define (how-many ne-l) 0)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (how-many (cons 1 '())) 1)
(check-expect (how-many (cons 2 (cons 1 '()))) 2)
;; 4. TEMPLATE
#; (define (how-many ne-l)
     (cond
       [(empty? (rest ne-l) ...)]
       [else (... (first ne-l) ... (rest ne-l) ...)]
       )
     )
;; 5. CODE
(define (how-many ne-l)
  (cond
    [(empty? (rest ne-l)) 1]
    [else (add1 (how-many (rest ne-l)))]
    )
  )

;; 2a. FUNCTION SIGNATURE: NEList-of-temperatures -> Number
;; 2b. PURPOSE STATEMENT: Computes the sum of the given temperatures.
;; 2c. HEADER
#; (define (sum ne-l) 0)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)
;; 4. TEMPLATE
#; (define (sum ne-l)
     (cond
       [(empty? (rest ne-l)) ...]
       [else ...]))
;; 5. CODE
(define (sum ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (+ (first ne-l) (sum (rest ne-l)))]
    )
  )


;; 2a. FUNCTION SIGNATURE: NEList-of-temperatures -> Number
;; 2b. PURPOSE STATEMENT: Computes the average temperature.
;; 2c. HEADER
#; (define (average ne-l) 0)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)
;; 4. TEMPLATE
#; (define (average ne-l)
     (... (first ne-l) ... (rest ne-l) ...))
;; 5. CODE
(define (average ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))

