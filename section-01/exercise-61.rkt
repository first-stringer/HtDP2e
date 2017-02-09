;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-61) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(define RED 0)
(define GREEN 1)
(define YELLOW 2)

;; 1. DATA DEFINITIONS:
;; A S-TrafficLight is one of:
;; – RED
;; – GREEN
;; – YELLOW

;; 2a. FUNCTION SIGNATURE: S-TrafficLight -> S-TrafficLight
;; 2b. PURPOSE STATEMENT: Yields the next state given the current state (cs).
;; 2c. HEADER:
;; (define (tl-next-synbolic cs) cs)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: RED, Expect: GREEN 
;; Given: GREEN, Expect: YELLOW
;; Given: YELLOW, Expect: RED
;; 3b. TESTS:
(check-expect (tl-next-symbolic RED) GREEN)
(check-expect (tl-next-symbolic GREEN) YELLOW)
(check-expect (tl-next-symbolic YELLOW) RED)
;; 4. TEMPLATE:
;; (define (tl-next-symbolic cs)
;;   (cond
;;     [(equal? cs RED) ...]
;;     [(equal? cs GREEN) ...]
;;     [(equal? cs YELLOW) ...]
;;     )
;;   )
;; 5. CODE:
(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]
    )
  )

;; 2a. FUNCTION SIGNATURE: S-TrafficLight -> Image
;; 2b. PURPOSE STATEMENT: Creates the image of a one-color bulb.
;; 2c. HEADER:
;; (define (create-bulb color)
;;   EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 0, Expect: an activated red light bulb
;; Given: 1, Expect: an activated yellow light bulb
;; Given: 2, Expect: an activated green light bulb
;; 3b. TESTS:
(check-expect (create-bulb RED) (circle (/ SCENE_HEIGHT 4) "solid" "red"))
(check-expect (create-bulb GREEN) (circle (/ SCENE_HEIGHT 4) "solid" "green"))
(check-expect (create-bulb YELLOW) (circle (/ SCENE_HEIGHT 4) "solid" "yellow"))
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
    [(equal? color RED) (circle (/ SCENE_HEIGHT 4) "solid" "red")]
    [(equal? color GREEN) (circle (/ SCENE_HEIGHT 4) "solid" "green")]
    [(equal? color YELLOW) (circle (/ SCENE_HEIGHT 4) "solid" "yellow")]
    )
  )
  
;; 2a. FUNCTION SIGNATURE: S-TrafficLight -> Image
;; 2b. PURPOSE STATEMENT: Renders the current state (cs) as an image.
;; 2c. HEADER:
;; (define (tl-render current-state)
;;  (empty-scene 90 30))
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: RED, Expect: tl with red light on
;; Given: GREEN, Expect: tl with green light on
;; Given: YELLOW, Expect: tl with yellow light on
;; 3b. TESTS:
(check-expect (tl-render RED ) (place-image (create-bulb RED) (/ SCENE_WIDTH 4) (/ SCENE_HEIGHT 2) EMPTY_TL))
(check-expect (tl-render GREEN) (place-image (create-bulb GREEN) (- SCENE_WIDTH (/ SCENE_WIDTH 4)) (/ SCENE_HEIGHT 2) EMPTY_TL))
(check-expect (tl-render YELLOW) (place-image (create-bulb YELLOW) (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2) EMPTY_TL))
;; 4. TEMPLATE:
;; (define (tl-render cs)
;;   (cond
;;    [(= cs RED) ... ]
;;    [(= cs GREEN) ... ]
;;    [(= cs YELLOW) ... ]
;;    )
;;  )
;; 5. CODE:
(define (tl-render cs)
  (cond
    [(= cs RED) (place-image (create-bulb RED) (/ SCENE_WIDTH 4) (/ SCENE_HEIGHT 2) EMPTY_TL)]
    [(= cs GREEN) (place-image (create-bulb GREEN) (- SCENE_WIDTH (/ SCENE_WIDTH 4)) (/ SCENE_HEIGHT 2) EMPTY_TL)]
    [(= cs YELLOW) (place-image (create-bulb YELLOW) (/ SCENE_WIDTH 2) (/ SCENE_HEIGHT 2) EMPTY_TL)]
    )
  )

;; 2a. FUNCTION SIGNATURE: S-TrafficLight -> S-TrafficLight
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
            [on-tick tl-next-symbolic 1]))

(traffic-light-simulation RED)
