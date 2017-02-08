;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-60) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3adesign-itemization%29

(define SCENE_WIDTH 150)
(define SCENE_HEIGHT 50)
(define EMPTY_SCENE (empty-scene SCENE_WIDTH SCENE_HEIGHT))

(define EMPTY_TL (place-image (circle (/ SCENE_HEIGHT 4) "outline" "red") (/ SCENE_WIDTH 4) (/ SCENE_HEIGHT 2)
                              (place-image (circle (/ SCENE_HEIGHT 4) "outline" "yellow") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2)
                                           (place-image (circle (/ SCENE_HEIGHT 4) "outline" "green") (- SCENE_WIDTH (/ SCENE_WIDTH 4)) (/ SCENE_HEIGHT 2)
                                                        (place-image (rectangle (- SCENE_WIDTH 5) (- SCENE_HEIGHT 5) "outline" "black") (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2) EMPTY_SCENE)))))

;; 1. DATA DEFINITIONS:
;; A N-TrafficLight is one of:
;; – 0 interpretation the traffic light shows red
;; – 1 interpretation the traffic light shows green
;; – 2 interpretation the traffic light shows yellow

;; 2a. FUNCTION SIGNATURE: N-TrafficLight -> N-TrafficLight
;; 2b. PURPOSE STATEMENT: Yields the next state given the current state (cs).
;; 2c. HEADER:
;; (define (tl-next-numeric cs) cs)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 0, Expect: 1
;; Given: 1, Expect: 2
;; Given: 2, Expect: 0
;; 3b. TESTS:
(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)
;; 4. TEMPLATE:
;; (define (tl-next-numeric cs)
;;   (... cs ...))
;; 5. CODE:
(define (tl-next-numeric cs) (modulo (+ cs 1) 3))


;; 2a. FUNCTION SIGNATURE: N-TrafficLight -> Image
;; 2b. PURPOSE STATEMENT: Creates the image of a one-color bulb.
;; 2c. HEADER:
;; (define (create-bulb color)
;;   EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 0, Expect: an activated red light bulb
;; Given: 1, Expect: an activated yellow light bulb
;; Given: 2, Expect: an activated green light bulb
;; 3b. TESTS:
(check-expect (create-bulb 0) (circle (/ SCENE_HEIGHT 4) "solid" "red"))
(check-expect (create-bulb 1) (circle (/ SCENE_HEIGHT 4) "solid" "green"))
(check-expect (create-bulb 2) (circle (/ SCENE_HEIGHT 4) "solid" "yellow"))
;; 4. TEMPLATE:
;; (define (create-bulb color)
;;  (cond
;;    [(= color 0) ...]
;;    [(= color 1) ...]
;;    [(= color 2) ...]
;;    )
;;  )
;; 5. CODE:
(define (create-bulb color)
  (cond
    [(= color 0) (circle (/ SCENE_HEIGHT 4) "solid" "red")]
    [(= color 1) (circle (/ SCENE_HEIGHT 4) "solid" "green")]
    [(= color 2) (circle (/ SCENE_HEIGHT 4) "solid" "yellow")]
    )
  )
  
;; 2a. FUNCTION SIGNATURE: N-TrafficLight -> Image
;; 2b. PURPOSE STATEMENT: Renders the current state (cs) as an image.
;; 2c. HEADER:
;; (define (tl-render current-state)
;;  (empty-scene 90 30))
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 0, Expect: tl with red light on
;; Given: 1, Expect: tl with green light on
;; Given: 2, Expect: tl with yellow light on
;; 3b. TESTS:
(check-expect (tl-render 0) (place-image (create-bulb 0) (/ SCENE_WIDTH 4) (/ SCENE_HEIGHT 2) EMPTY_TL))
(check-expect (tl-render 1) (place-image (create-bulb 1) (- SCENE_WIDTH (/ SCENE_WIDTH 4)) (/ SCENE_HEIGHT 2) EMPTY_TL))
(check-expect (tl-render 2) (place-image (create-bulb 2) (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2) EMPTY_TL))
;; 4. TEMPLATE:
;; (define (tl-render cs)
;;   (cond
;;    [(= cs 0) ... ]
;;    [(= cs 1) ... ]
;;    [(= cs 2) ... ]
;;    )
;;  )
;; 5. CODE:
(define (tl-render cs)
  (cond
    [(= cs 0) (place-image (create-bulb 0) (/ SCENE_WIDTH 4) (/ SCENE_HEIGHT 2) EMPTY_TL)]
    [(= cs 1) (place-image (create-bulb 1) (- SCENE_WIDTH (/ SCENE_WIDTH 4)) (/ SCENE_HEIGHT 2) EMPTY_TL)]
    [(= cs 2) (place-image (create-bulb 2) (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2) EMPTY_TL)]
    )
  )

;; 2a. FUNCTION SIGNATURE: N-TrafficLight -> N-TrafficLight
;; 2b. PURPOSE STATEMENT: Simulates a clock-based American traffic light (tl).
;; 2c. HEADER:
;; (define (traffic-light-simulation initial-state)
;;  initial-state)
;; 3a. FUNCTIONAL EXAMPLES: NA
;; 3b. TESTS: NA
;; 4. TEMPLATE:
;; (define (traffic-light-simulation initial-state)
;;  (... initial-state ...))
;; 5. CODE:
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
            [to-draw tl-render]
            [on-tick tl-next-numeric 1]))

(traffic-light-simulation 0)
