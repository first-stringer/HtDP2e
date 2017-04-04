;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-143) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alists~3ane%29


;; 1a. DATA DEFINITIONS
;; #1: A List-of-temperatures is one of: 
;; – '()
;; – (cons CTemperature List-of-temperatures)
;; #2: A CTemperature is a Number greater than -273.


;; 1b. CONSTANT DEFINITIONS


;; 1c. FUNCTION WISH LIST
;; #1 HEADER
#; (define (sum alot) 0)
;; SIGNATURE: List-of-temperatures -> Number 
;; PURPOSE STATEMENT: Adds up the temperatures on the given list.
;; #2 HEADER
#; (define (how-many alot) 0)
;; SIGNATURE: List-of-temperatures -> Number 
;; PURPOSE STATEMENT: Counts the temperatures on the given list.


;; 2a. FUNCTION SIGNATURE: List-of-temperatures -> Number
;; 2b. PURPOSE STATEMENT: Computes the average temperature.
;; 2c. HEADER
#; (define (average alot) 0)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)
;; 4. TEMPLATE
#; (define (average alot)
     (cond
       [(empty? alot) ...]
       [(cons? alot)
        (... (first alot) ...
             ... (average (rest alot)) ...)]))
;; 5. CODE
(define (average alot)
  (/ (sum alot) (how-many alot)))
