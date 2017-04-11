;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-153) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3anats%29


;; 1a. DATA DEFINITIONS
;; A N is one of: 
;; – 0
;; – (add1 N)
;; Interpretation: Represents the counting numbers.


;; 1b. CONSTANT DEFINITIONS
(define TEST_IMAGE (square 10 "solid" "red"))


;; 2a. FUNCTION SIGNATURE: Number Image -> Image
;; 2b. PURPOSE STATEMENT: Consumes a natural number n and an image img. It
;; produces a column—a vertical arrangement—of n copies of img.
;; 2c. HEADER
#; (define (col n i) empty-image)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (col 0 TEST_IMAGE) empty-image)
(check-expect (col 1 TEST_IMAGE) TEST_IMAGE)
(check-expect (col 2 TEST_IMAGE) (above TEST_IMAGE TEST_IMAGE))
;; 4. TEMPLATE
#; (define (col n i)
     (cond
       [(zero? n) ...]
       [else (col ... n ... i ... )]
       )
     )
;; 5. CODE
(define (col n i)
  (cond
    [(zero? n) empty-image] 
    [else (above i (col (sub1 n) i))]
    )
  )


;; 2a. FUNCTION SIGNATURE: Number Image -> Image
;; 2b. PURPOSE STATEMENT: Consumes a natural number n and an image img. It
;; produces a row—a horizontal arrangement—of n copies of img.
;; 2c. HEADER
#; (define (row n i) empty-image)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (row 0 TEST_IMAGE) empty-image)
(check-expect (row 1 TEST_IMAGE) TEST_IMAGE)
(check-expect (row 2 TEST_IMAGE) (beside TEST_IMAGE TEST_IMAGE))
;; 4. TEMPLATE
#; (define (row n i)
     (cond
       [(zero? n) ...]
       [else (row ... n ... i ... )]
       )
     )
;; 5. CODE
(define (row n i)
  (cond
    [(zero? n) empty-image] 
    [else (beside i (row (sub1 n) i))]
    )
  )

