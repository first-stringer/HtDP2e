;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3azoo1%29

;; 1. DATA DEFINITIONS: HappinessLevel (hl) is a Number representing the amount
;; of happiness experienced with a maximum happiness of 100 and a minimum
;; happiness of 0.

(define RATE 0.1)



;; 2a. FUNCTION SIGNATURE: HappinessLevel -> HappinessLevel
;; 2b. PURPOSE STATEMENT: Decreases hl by RATE amount on every clock tick.
;; 2c. HEADER:
;;(define (tock hl)
;;  0)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 0, Expect: 0
;; Given: 100, Expect: 99.9
;; 3b. TESTS:
(check-expect (tock 0) 0)
(check-expect (tock 100) 99.9)
;; 4. TEMPLATE:
;;(define (tock hl)
;;  (... hl ... RATE ...))
;; 5. CODE:
(define (tock hl)
  (if (> hl 0)
      (- hl RATE)
      0
      )
  )