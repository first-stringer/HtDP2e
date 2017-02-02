;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-43) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._.D.K._sec~3adesign-world%29

;; 1. DATA DEFINITIONS:
;; An AnimationState is a Number. Its interpretation is the number of clock ticks
;; since the animation started.

(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 50)
(define TREE (underlay/xy (circle 10 "solid" "green") 9 15 (rectangle 2 20 "solid" "brown")))
(define BACKGROUND (overlay TREE (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))

(define SPEED 3)

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL (circle WHEEL-RADIUS "solid" "black"))

(define SPACE (rectangle (* WHEEL-RADIUS 3) WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define CAR-BODY-HEIGHT (* WHEEL-RADIUS 2))
(define CAR-BODY-LENGTH (* WHEEL-RADIUS 8))
(define CAR-BODY (rectangle CAR-BODY-LENGTH CAR-BODY-HEIGHT "solid" "red"))

(define CAR-CAB-HEIGHT (/ CAR-BODY-HEIGHT 2))
(define CAR-CAB-LENGTH (/ CAR-BODY-LENGTH 2))
(define CAR-CAB (rectangle CAR-CAB-LENGTH CAR-CAB-HEIGHT "solid" "red"))

(define CAR (overlay/offset BOTH-WHEELS 0 (- 0 CAR-BODY-HEIGHT) (overlay/offset CAR-BODY 0 (- 0 (+ (/ CAR-BODY-HEIGHT 2) (/ CAR-CAB-HEIGHT 2))) CAR-CAB)))

(define Y-CAR (/ HEIGHT-OF-WORLD 2))

;; 2a. FUNCTION SIGNATURE: AnimationState -> x-car
;; 2b. PURPOSE STATEMENT: Takes the animation state and returns the x coordinate
;; for the center of the car.
;; 2c. HEADER:
;; (define (x-car as)
;;  0)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 1, Expect: 3
;; Given: 10, Expect: 30
;; Given: 15, Expect: 45
;; 3b. TESTS:
(check-expect (x-car 1) 3)
(check-expect (x-car 10) 30)
(check-expect (x-car 15) 45)
;; 4. TEMPLATE:
;; (define (x-car as)
;;  (... as ... SPEED))
;; 5. CODE:
(define (x-car as)
  (* as SPEED))

;; 2a. FUNCTION SIGNATURE: AnimationState -> AnimationState
;; 2b. PURPOSE STATEMENT: Advances the state of the world by one every clock tick.
;; 2c. HEADER:
;; (define (tock as)
;;  as)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 20, Expect: 21
;; Given: 78, Expect: 79
;; 3b. TESTS:
(check-expect (tock 20) 21)
(check-expect (tock 78) 79)
;; 4. TEMPLATE:
;; (define (tock as)
;;   (... as ...))
;; 5. CODE:
(define (tock as)
  (add1 as))

;; 2a. FUNCTION SIGNATURE: AnimationState -> Image
;; 2b. PURPOSE STATEMENT: Places the car into the BACKGROUND scene, according to
;; the given animation state.
;; 2c. HEADER:
;; (define (render as)
;;   BACKGROUND)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 5, Expect: (place-image CAR 45 Y-CAR BACKGROUND) 
;; Given: 10, Expect: (place-image CAR 30 Y-CAR BACKGROUND) 
;; Given: 15, Expect: (place-image CAR 45 Y-CAR BACKGROUND) 
;; Given: 20, Expect: (place-image CAR 60 Y-CAR BACKGROUND)
;; 3b. TESTS:
(check-expect (render 5) (place-image CAR 15 Y-CAR BACKGROUND))
(check-expect (render 10) (place-image CAR 30 Y-CAR BACKGROUND))
(check-expect (render 15) (place-image CAR 45 Y-CAR BACKGROUND))
(check-expect (render 20) (place-image CAR 60 Y-CAR BACKGROUND))
;; 4. TEMPLATE:
;; (define (render as)
;;  (... as ... ))
;; 5. CODE:
(define (render as)
  (place-image CAR (x-car as) Y-CAR BACKGROUND)
  )

;; 2a. FUNCTION SIGNATURE: AnimationState -> Boolean
;; 2b. PURPOSE STATEMENT: When needed, big-bang evaluates (end? as) to
;; determine whether the program should stop.  This program stops when
;; the car has disappeared on the right.
;; 2c. HEADER:
;; (define (end? as)
;;  #t)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: (x-car as) >= WIDTH-OF-WORLD + CAR width, Expect: true
;; Given: (x-car as) < WIDTH-OF-WORLD + CAR width, Expect: false
;; 3b. TESTS:
(check-expect (end? (ceiling (/ (+ 1 (+ WIDTH-OF-WORLD (/ (image-width CAR) 2))) SPEED))) #t)
(check-expect (end? (quotient (+ WIDTH-OF-WORLD (/ (image-width CAR) 2)) SPEED)) #f)
(check-expect (end? (quotient (- (+ WIDTH-OF-WORLD (/ (image-width CAR) 2)) 1) SPEED)) #f)
;; 4. TEMPLATE:
;; (define (end? as)
;;  (... as ... WIDTH-OF-WORLD))
;; 5. CODE:
(define (end? as)
  (if (> (x-car as) (+ WIDTH-OF-WORLD (/ (image-width CAR) 2))) true false))

;; 2a. FUNCTION SIGNATURE: AnimationState -> AnimationState
;; 2b. PURPOSE STATEMENT: Launches the program from some initial state.
;; 2c. HEADER:
;; (define (main as)
;;  as)
;; 3a. FUNCTIONAL EXAMPLES: NA
;; 3b. TESTS: NA
;; 4. TEMPLATE:
;; (define (main as)
;;  (... as ... big-bang ...))
;; 5. CODE:
(define (main as)
  (big-bang as
            [on-tick tock]
            [to-draw render]
            [stop-when end?]))

(main 0)