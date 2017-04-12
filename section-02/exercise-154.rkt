;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-154) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._rd._sec~3ard%29


;; 1a. DATA DEFINITIONS
;; An RD (short for Russian doll) is one of: 
;; – String 
;; – (make-layer String RD)
(define-struct layer [color doll])


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


;; 2a. FUNCTION SIGNATURE: RD -> String
;; 2b. PURPOSE STATEMENT: Consumes a Russian doll and produces a string of all
;; colors, separate by a comma and a space.
;; 2c. HEADER
#; (define (colors an-rd) "")
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (colors "red") "red")
(check-expect (colors (make-layer "green" "red")) "green, red")
(check-expect (colors (make-layer "yellow" (make-layer "green" "red")))
              "yellow, green, red")
;; 4. TEMPLATE
#; (define (colors an-rd)
     (cond
       [(string? an-rd) ...]
       [else (... (layer-color an-rd) ... (colors (layer-doll an-rd)) ...)]
       )
     )
;; 5. CODE
(define (colors an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (string-append (layer-color an-rd) ", " (colors (layer-doll an-rd)))]
    )
  )

