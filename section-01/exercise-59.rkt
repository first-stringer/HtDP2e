;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-59) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3adesign-itemization%29

(define SCENE_WIDTH 150)
(define SCENE_HEIGHT 50)
(define EMPTY_SCENE (empty-scene SCENE_WIDTH SCENE_HEIGHT))

(define EMPTY_TL (place-image (rectangle (- SCENE_WIDTH 5) (- SCENE_HEIGHT 5) "outline" "black") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2) EMPTY_SCENE))

;; 1. DATA DEFINITIONS:
;; A TrafficLight is one of the following Strings:
;; – "red"
;; – "green"
;; – "yellow"
;; Interpretation: The three strings represent the three possible states that a
;; traffic light may assume.


;; 2a. FUNCTION SIGNATURE: TrafficLight -> TrafficLight
;; 2b. PURPOSE STATEMENT: Yields the next state given the current state (cs).
;; 2c. HEADER:
;; (define (tl-next cs) cs)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: "red", Expect: "green"
;; Given: "green", Expect: "yellow"
;; Given: "yellow", Expect: "red"
;; 3b. TESTS:
(check-expect (tl-next "red") "green")
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")
;; 4. TEMPLATE:
;; (define (tl-next cs)
;;  (cond
;;    [(string=? cs "red") ...]
;;    [(string=? cs "green") ...]
;;    [(string=? cs "yellow") ...]
;;    )
;;  )
;; 5. CODE:
(define (tl-next cs)
  (cond
    [(string=? cs "red") "green"]
    [(string=? cs "green") "yellow"]
    [(string=? cs "yellow") "red"]
    )
  )

;; 2a. FUNCTION SIGNATURE: TrafficLight -> Image
;; 2b. PURPOSE STATEMENT: Renders the current state (cs) as an image.
;; 2c. HEADER:
;; (define (tl-render current-state)
;;  (empty-scene 90 30))
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: "red", Expect: tl with red light on
;; Given: "yellow", Expect: tl with yellow light on
;; Given: "green, Expect: tl with green light on
;; 3b. TESTS:
(check-expect (tl-render "red")
              (place-image (circle (/ SCENE_HEIGHT 4) "solid" "red") (/ SCENE_WIDTH 4) (/ SCENE_HEIGHT 2)
                           (place-image (circle (/ SCENE_HEIGHT 4) "outline" "yellow") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2)
                                        (place-image (circle (/ SCENE_HEIGHT 4) "outline" "green") (- SCENE_WIDTH (/ SCENE_WIDTH 4)) (/ SCENE_HEIGHT 2)
                                                     EMPTY_TL))))
(check-expect (tl-render "yellow")
              (place-image (circle (/ SCENE_HEIGHT 4) "outline" "red") (/ SCENE_WIDTH 4) (/ SCENE_HEIGHT 2)
                           (place-image (circle (/ SCENE_HEIGHT 4) "solid" "yellow") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2)
                                        (place-image (circle (/ SCENE_HEIGHT 4) "outline" "green") (- SCENE_WIDTH (/ SCENE_WIDTH 4)) (/ SCENE_HEIGHT 2)
                                                     EMPTY_TL))))
(check-expect (tl-render "green")
              (place-image (circle (/ SCENE_HEIGHT 4) "outline" "red") (/ SCENE_WIDTH 4) (/ SCENE_HEIGHT 2)
                           (place-image (circle (/ SCENE_HEIGHT 4) "outline" "yellow") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2)
                                        (place-image (circle (/ SCENE_HEIGHT 4) "solid" "green") (- SCENE_WIDTH (/ SCENE_WIDTH 4)) (/ SCENE_HEIGHT 2)
                                                     EMPTY_TL))))
;; 4. TEMPLATE:
;; (define (tl-render cs)
;;   (cond
;;    [(string=? cs "red") ... ]
;;    [(string=? cs "yellow") ... ]
;;    [(string=? cs "green") ... ]
;;    )
;;  )
;; 5. CODE:
(define (tl-render cs)
  (cond
    [(string=? cs "red") (place-image (circle (/ SCENE_HEIGHT 4) "solid" "red") (/ SCENE_WIDTH 4) (/ SCENE_HEIGHT 2)
                                      (place-image (circle (/ SCENE_HEIGHT 4) "outline" "yellow") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2)
                                                   (place-image (circle (/ SCENE_HEIGHT 4) "outline" "green") (- SCENE_WIDTH (/ SCENE_WIDTH 4)) (/ SCENE_HEIGHT 2)
                                                                EMPTY_TL)))]
    [(string=? cs "yellow") (place-image (circle (/ SCENE_HEIGHT 4) "outline" "red") (/ SCENE_WIDTH 4) (/ SCENE_HEIGHT 2)
                           (place-image (circle (/ SCENE_HEIGHT 4) "solid" "yellow") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2)
                                        (place-image (circle (/ SCENE_HEIGHT 4) "outline" "green") (- SCENE_WIDTH (/ SCENE_WIDTH 4)) (/ SCENE_HEIGHT 2)
                                                     EMPTY_TL)))]
    [(string=? cs "green") (place-image (circle (/ SCENE_HEIGHT 4) "outline" "red") (/ SCENE_WIDTH 4) (/ SCENE_HEIGHT 2)
                           (place-image (circle (/ SCENE_HEIGHT 4) "outline" "yellow") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2)
                                        (place-image (circle (/ SCENE_HEIGHT 4) "solid" "green") (- SCENE_WIDTH (/ SCENE_WIDTH 4)) (/ SCENE_HEIGHT 2)
                                                     EMPTY_TL)))]
    )
  )