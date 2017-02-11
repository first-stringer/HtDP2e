;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-73) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aprogstructs%29

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
 
;; 1. DATA DEFINITIONS:
;; A Posn represents the state of the world.

;; 2a. FUNCTION SIGNATURE: Posn -> Image
;; 2b. PURPOSE STATEMENT: Adds a red spot to MTS at p.
;; 2c. HEADER:
;; (define (scene+dot p) MTS)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 10 20, Expect: (place-image DOT 10 20 MTS)
;; Given: 88 73, Expect: (place-image DOT 88 73 MTS)
;; 3b. TESTS:
(check-expect (scene+dot (make-posn 10 20)) (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73)) (place-image DOT 88 73 MTS))
;; 4. TEMPLATE:
;; (define (scene+dot p)
;;   (... (posn-x p) ... (posn-y p) ... MTS ...))
;; 5. CODE:
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

;; 2a. FUNCTION SIGNATURE: Posn -> Posn
;; 2b. PURPOSE STATEMENT: Increases the x-coordinate of p by 3.
;; 2c. HEADER:
;; (define (x+ p) p)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 10 0, Expect: 13 0
;; 3b. TESTS:
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
;; 4. TEMPLATE:
;; (define (x+ p)
;;  (... (posn-x p) ... (posn-y p) ...))
;; 5. CODE:
(define (x+ p)
  (make-posn (+ 3 (posn-x p)) (posn-y p)))

;; 2a. FUNCTION SIGNATURE: Posn -> Posn
;; 2b. PURPOSE STATEMENT: Produces a Posn like p with n in the x field.
;; 2c. HEADER:
;; (define (posn-up-x p n) p)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 1.1 2, Expect: 2.1
;; 3b. TESTS:
(check-expect (posn-up-x (make-posn 1 1) 2) (make-posn 2 1))
;; 4. TEMPLATE:
;; (define (posn-up-x p n)
;;   (... (posn-x p) ... (posn-y p) ... n))
;; 5. CODE:
(define (posn-up-x p n)
  (make-posn n (posn-y p)))

;; 2a. FUNCTION SIGNATURE: Posn -> Posn 
;; 2b. PURPOSE STATEMENT: Accepts the initial position of the red dot and starts
;; the game.
;; 2c. HEADER:
;; (define (main p0) p0)
;; 3a. FUNCTIONAL EXAMPLES: NA
;; 3b. TESTS: NA
;; 4. TEMPLATE:
;; (define (main p0)
;;   (... p0 ...))
;; 5. CODE:
;; (define (main p0) (big-bang p0 [on-tick x+] [on-mouse reset-dot] [to-draw scene+dot]))