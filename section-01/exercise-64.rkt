;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-64) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aprogramming-posn%29

;; 2a. FUNCTION SIGNATURE: Posn -> Number
;; 2b. PURPOSE STATEMENT: Computes the Manhattan distance of ap to the origin (0,0).
;; 2c. HEADER:
;; (define (manhattan-distance-to-0 ap) 0)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: (3.4), Expect: 7
;; Given: (9.1), Expect: 10
;; 3b. TESTS:
(check-expect (manhattan-distance-to-0 (make-posn 3 4)) 7)
(check-expect (manhattan-distance-to-0 (make-posn 9 1)) 10)
;; 4. TEMPLATE:
;; (define (manhattan-distance-to-0 ap)
;;   (... ap ...))
;; 5. CODE:
(define (manhattan-distance-to-0 ap)
  (+ (posn-x ap) (posn-y ap)))