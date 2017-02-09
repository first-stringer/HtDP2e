;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-63) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aprogramming-posn%29

;; 2a. FUNCTION SIGNATURE: Posn -> Number
;; 2b. PURPOSE STATEMENT: Computes the distance of ap to the origin (0,0).
;; 2c. HEADER:
;; (define (distance-to-0 ap) 0)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: (3.4), Expect: 5
;; Given: (8.6), Expect: 10
;; Given: (5.12), Expect: 13
;; 3b. TESTS:
(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 8 6)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)
;; 4. TEMPLATE:
;; (define (distance-to-0 ap)
;;  (... ap ...))
;; 5. CODE:
(define (distance-to-0 ap)
  (sqrt (+ (sqr (posn-x ap)) (sqr (posn-y ap)))))

(distance-to-0 (make-posn 3 4))
(distance-to-0 (make-posn 6 (* 2 4)))
(+ (distance-to-0 (make-posn 12 5)) 10)