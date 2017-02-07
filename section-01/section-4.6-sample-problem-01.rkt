;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname section-4.6-sample-problem-01) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3adesign-itemization%29

;; 1. DATA DEFINITIONS:
;; A Price falls into one of three intervals: 
;; — 0 through 1000
;; — 1000 through 10000
;; — 10000 and above.
;; interpretation the price of an item 

;; 2a. FUNCTION SIGNATURE: Price -> Number
;; 2b. PURPOSE STATEMENT: computes the amount of tax charged for p
;; 2c. HEADER:
;; (define (sales-tax p) 0)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 0, Expect: 0
;; Given: 537, Expect: 0
;; Given: 1000, Expect: 50
;; Given: 1282, Expect: 64
;; Given: 10000, Expect: 800
;; Given: 12017, Expect: 961
;; 3b. TESTS:
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 1282) (* 0.05 1282))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 12017) (* 0.08 12017))
;; 4. TEMPLATE:
;; (define (sales-tax p)
;;   (cond
;;     [(and (>= p 0) (< p 1000)) ...]
;;    [(and (>= p 1000) (< p 10000)) ...]
;;    [(and (>= p 1000) (< p 10000)) ...]
;;    )
;;  )
;; 5. CODE:
(define (sales-tax p)
  (cond
    [(and (>= p 0) (< p 1000)) 0]
    [(and (>= p 1000) (< p 10000)) (* p 0.05)]
    [(>= p 10000) (* p 0.08)]
    )
  )


