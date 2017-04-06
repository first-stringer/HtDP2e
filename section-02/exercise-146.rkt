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

