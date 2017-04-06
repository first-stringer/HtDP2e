;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-145) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alists~3ane%29


;; A NEList-of-temperatures is one of: 
;; – (cons CTemperature '())
;; – (cons CTemperature NEList-of-temperatures)
;; interpretation non-empty lists of Celsius temperatures 


;; 2a. FUNCTION SIGNATURE: NEList-of-temperatures -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a NEList-of-temperatures. It produces #true if
;; the temperatures are sorted in descending order, otherwise it produces #false.
;; 2c. HEADER
#; (define (sorted>? alot) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (sorted>? (cons 0 '())) #true)
(check-expect (sorted>? (cons 1 (cons 0 '()))) #true)
(check-expect (sorted>? (cons 0 (cons 1 '()))) #false)
;; 4. TEMPLATE
#; (define (sorted>? alot)
     (cond
       [(empty? (rest alot)) ...]
       [else (... (first alot) ... (rest alot) ...)]
       )
     )
;; 5. CODE
(define (sorted>? alot)
  (cond
    [(empty? (rest alot)) #true]
    [else (and (> (first alot) (first (rest alot))) (sorted>? (rest alot)))]
    )
  )

