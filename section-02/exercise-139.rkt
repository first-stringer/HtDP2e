;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-139) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3afinger-lists%29

;; A List-of-numbers is one of: 
;; – '()
;; – (cons Number List-of-numbers)


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

