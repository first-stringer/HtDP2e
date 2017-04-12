;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-155) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._rd._sec~3ard%29


;; 1a. DATA DEFINITIONS
;; An RD (short for Russian doll) is one of: 
;; – String 
;; – (make-layer String RD)
(define-struct layer [color doll])


;; 2a. FUNCTION SIGNATURE: RD -> String
;; 2b. PURPOSE STATEMENT: Consumes an RD and produces the (color of the)
;; innermost doll. 
;; 2c. HEADER
#; (define (inner an-rd) "")
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (inner "red") "red")
(check-expect (inner (make-layer "green" "red")) "red")
(check-expect (inner (make-layer "yellow" (make-layer "green" "red"))) "red")
;; 4. TEMPLATE
#; (define (inner an-rd)
     (cond
       [(string? an-rd) ...]
       [else (... (layer-color an-rd) ... (inner (layer-doll an-rd)) ...)]
       )
     )
;; 5. CODE
(define (inner an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (inner (layer-doll an-rd))]
    )
  )

