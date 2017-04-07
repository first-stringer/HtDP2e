;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-149) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3anats%29


;; 1a. DATA DEFINITIONS
;; A N is one of: 
;; – 0
;; – (add1 N)
;; interpretation represents the counting numbers


;; 2a. FUNCTION SIGNATURE: Number String -> List-of-strings 
;; 2b. PURPOSE STATEMENT: Creates a list of n copies of s.
;; 2c. HEADER
#; (define (copier n s) '())
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello") (cons "hello" (cons "hello" '())))
;; 4. TEMPLATE
#; (define (copier n s)
     (cond
       [(zero? n) ...]
       [(positive? n) (... (copier (sub1 n) s) ...)]
       )
     )
;; 5. CODE
(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]
    )
  ) 


(copier 2 #true)
(copier 2 (rectangle 10 10 "solid" "red"))


;; Yes it functions properly because the function does not check if the second
;; argument is a String (i.e. the function is unchecked).


;; No we do not have to design another function, but the comments (i.e. function
;; signature) is not general enough if we intend to use the function this way.


;; 2a. FUNCTION SIGNATURE: Number String -> List-of-strings 
;; 2b. PURPOSE STATEMENT: Creates a list of n copies of s.
;; 2c. HEADER
#; (define (copier.v2 n s) '())
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (copier.v2 0 "hello") '())
(check-expect (copier.v2 2 "hello") (cons "hello" (cons "hello" '())))
;; 4. TEMPLATE
#; (define (copier.v2 n s)
     (cond
       [(zero? n) ...]
       [else (... (copier.v2 (sub1 n) s) ...)]
       )
     )
;; 5. CODE
(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))]
    )
  )


;; Copier throws an error because the argument it is passed on the first
;; recursive call is not 0 nor positive (0.1 - 1 = -0.9).  Copier.v2 never
;; terminates because n never becomes zero.

