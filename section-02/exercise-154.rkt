;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-154) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._rd._sec~3ard%29


;; 1a. DATA DEFINITIONS
;; An RD (short for Russian doll) is one of: 
;; – String 
;; – (make-layer String RD)
(define-struct layer [color doll])


;; 1b. CONSTANT DEFINITIONS
;; 1c. FUNCTION WISH LIST
;; NAME:
;; SIGNATURE:
;; PURPOSE STATEMENT:


;; 2a. FUNCTION SIGNATURE: RD -> Number
;; 2b. PURPOSE STATEMENT: How many dolls are part of an-rd.
;; 2c. HEADER
#; (define (depth an-rd) -1)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (depth "red") 1)
(check-expect (depth (make-layer "green" "red")) 2)
(check-expect (depth (make-layer "yellow" (make-layer "green" "red"))) 3)
;; 4. TEMPLATE
#; (define (depth an-rd)
     (cond
       [(string? an-rd) ...]
       [else (... (layer-color an-rd) ... (depth (layer-doll an-rd)) ...)]
       )
     )
;; 5. CODE
(define (depth an-rd)
  (cond
    [(string? an-rd) 1]
    [else (add1 (depth (layer-doll an-rd)))]
    )
  )

