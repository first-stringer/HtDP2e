;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-75) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aprogstructs%29

;; 1. DATA DEFINITIONS:
(define-struct vel [deltax deltay])
;; A Vel is a structure: 
;;   (make-vel Number Number)
;; interpretation (make-vel dx dy) means a velocity of 
;; dx pixels [per tick] along the horizontal and
;; dy pixels [per tick] along the vertical direction
(define-struct ufo [loc vel])
;; A UFO is a structure: 
;;   (make-ufo Posn Vel)
;; interpretation (make-ufo p v) is at location p moving at velocity v.

(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))
 
(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))
 
(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))

;; 2a. FUNCTION SIGNATURE: UFO -> UFO
;; 2b. PURPOSE STATEMENT: Determines where u moves in one clock tick, leaves the
;; velocity as is.
;; 2c. HEADER:
;; (define (ufo-move-1 u) u)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 22.80 8.-3, Expect: 30.77 8.-3
;; Given: 22.80 -5.-3, Expect: 17.77 8.-3
;; 3b. TESTS:
(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2) (make-ufo (make-posn 17 77) v2))
;; 4. TEMPLATE:
;; (define (ufo-move-1 u)
;;   (... (posn-x (ufo-loc u)) ...
;;    ... (posn-y (ufo-loc u)) ...
;;    ... (vel-deltax (ufo-vel u)) ...
;;    ... (vel-deltay (ufo-vel u)) ...))
;; 5. CODE:
(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))

;; 2a. FUNCTION SIGNATURE: Posn Vel -> Posn 
;; 2b. PURPOSE STATEMENT: Adds v to p.
;; 2c. HEADER:
;; (define (posn+ p v) p)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 22.80 8.-3, Expect: 30.77
;; Given: 22.80 -5.-3, Expect: 17.77
;; 3b. TESTS:
(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))
;; 4. TEMPLATE:
;; (define (posn+ p v)
;;   (...(posn-x p)...(posn-y p)...(vel-deltax v)...(vel-deltay v)...)
;; 5. CODE:
(define (posn+ p v)
  (make-posn
   (+ (posn-x p) (vel-deltax v))
   (+ (posn-y p) (vel-deltay v))))
