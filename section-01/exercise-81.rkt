;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-81) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3adesignstructs%29

;; 1. DATA DEFINITIONS:
;; A Time-point is a (make-time-point Number Number Number) where
;; hours is an integer from 0 to 23,
;; minutes is an integer from 0 to 59, and
;; seconds is an integer from 0 to 59.
;; This DD copied from exercise number 77.
(define-struct time-point [hours minutes seconds])

;; 2a. FUNCTION SIGNATURE: Time-point -> Number
;; 2b. PURPOSE STATEMENT: Consumes instances of time-point (tp) structures and
;; produces the number of seconds that have passed since midnight (hours * 60 * 60 + minutes * 60 + seconds).
;; 2c. HEADER:
;; (define (time->seconds tp)
;;   0)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 0 0 0, Expect: 0
;; Given: 12 30 2, Expect: 45002
;; Given: 23 59 59, Expect: 86399
;; 3b. TESTS:
(check-expect (time->seconds (make-time-point 0 0 0)) 0)
(check-expect (time->seconds (make-time-point 12 30 2)) 45002)
(check-expect (time->seconds (make-time-point 23 59 59)) 86399)
;; 4. TEMPLATE:
;; (define (time->seconds tp)
;;   (... (time-point-hours tp) ... (time-point-minutes tp) ... (time-point-seconds tp) ...))
;; 5. CODE:
(define (time->seconds tp)
  (+ (* 3600 (time-point-hours tp)) (* 60 (time-point-minutes tp)) (time-point-seconds tp)))

