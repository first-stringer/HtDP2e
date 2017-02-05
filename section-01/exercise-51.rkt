;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aenums%29

;; 1. DATA DEFINITIONS:
;; A TrafficLight is one of the following Strings:
;; – "red"
;; – "green"
;; – "yellow"
;; Interpretation: The three strings represent the three possible states that a
;; traffic light may assume.

;; 2a. FUNCTION SIGNATURE: TrafficLight -> TrafficLight
;; 2b. PURPOSE STATEMENT: Returns the next state of the traffic light given its
;; current state (cs).
;; 2c. HEADER:
;; (define (traffic-light-next cs)
;;   cs)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: "red", Expect: "green"
;; Given: "green", Expect: "yellow"
;; Given: "yellow", Expect: "red"
;; 3b. TESTS:
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
;; 4. TEMPLATE:
;; (define (traffic-light-next cs)
;;   (... cs ...))
;; 5. CODE:
(define (traffic-light-next cs)
  (cond
    [(string=? "red" cs) "green"]
    [(string=? "green" cs) "yellow"]
    [(string=? "yellow" cs) "red"]))