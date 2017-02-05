;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aenums%29

;; 1. DATA DEFINITIONS:
;; A TrafficLight is one of the following Strings:
;; – "red"
;; – "green"
;; – "yellow"
;; Interpretation: The three strings represent the three possible states that a
;; traffic light may assume.

(define SCENE_WIDTH 50)
(define SCENE_HEIGHT 50)
(define SCENE (empty-scene SCENE_WIDTH SCENE_HEIGHT))
(define TL_RADIUS (- (/ SCENE_WIDTH 2) 1))

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

;; 2a. FUNCTION SIGNATURE: TrafficLight -> Image
;; 2b. PURPOSE STATEMENT: Accepts a TrafficLight (tl) state and returns an
;; image of the corresponding light.
;; 2c. HEADER:
;; (define (display-tl tl)
;;   SCENE) 
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: "red", Expect: solid red circle
;; Given: "green", Expect: solid green circle
;; Given: "yellow", Expect: solid yellow circle
;; 3b. TESTS:
(check-expect (display-tl "red") (place-image (circle TL_RADIUS "solid" "red") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2) SCENE))
(check-expect (display-tl "green") (place-image (circle TL_RADIUS "solid" "green") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2) SCENE))
(check-expect (display-tl "yellow") (place-image (circle TL_RADIUS "solid" "yellow") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2) SCENE))
;; 4. TEMPLATE:
;; (define (display-tl tl)
;;  (... tl ... SCENE ...))
;; 5. CODE:
(define (display-tl tl)
  (place-image (circle TL_RADIUS "solid" tl) (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2) SCENE))

;; 2a. FUNCTION SIGNATURE: TrafficLight Number -> TrafficLight
;; 2b. PURPOSE STATEMENT: Initiates the traffic light with the given state for
;; the given number of clocks ticks where each clock tick is one second.
;; 2c. HEADER:
;; (define (tl-simulator initial-state seconds)
;;  initial-state)
;; 3a. FUNCTIONAL EXAMPLES: NA
;; 3b. TESTS: NA
;; 4. TEMPLATE:
;; (define (tl-simulator initial-state seconds)
;;   (... initial-state ... seconds ...))
;; 5. CODE:
(define (tl-simulator initial-state seconds)
  (big-bang initial-state
            [on-tick traffic-light-next 1 seconds]
            [to-draw display-tl]))

(tl-simulator "red" 9)
