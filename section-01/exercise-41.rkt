;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-41) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._.D.K._sec~3adesign-world%29

(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 50)
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))
  
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

;; 1. DATA DEFINITIONS: A WorldState is a Number.
;; 2a. FUNCTION SIGNATURE: WorldState -> WorldState
;; 2b. PURPOSE STATEMENT: Moves the car by 3 pixels for every clock tick.
;; 2c. HEADER:
;; (define (tock ws)
;;  ws)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 20, Expect: 23
;; Given: 78, Expect: 81
;; 3b. TESTS:
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)
;; 4. TEMPLATE:
;; (define (tock ws)
;;   (... ws ...))
;; 5. CODE:
(define (tock ws)
  (+ ws 3))

;; 1. DATA DEFINITIONS: A WorldState is a Number.
;; 2a. FUNCTION SIGNATURE: WorldState -> Image
;; 2b. PURPOSE STATEMENT: Places the car into the BACKGROUND scene, according to the given world state.
;; 2c. HEADER:
;; (define (render ws)
;;   BACKGROUND)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 50, Expect: (place-image CAR 50 Y-CAR BACKGROUND) 
;; Given: 100, Expect: (place-image CAR 100 Y-CAR BACKGROUND) 
;; Given: 150, Expect: (place-image CAR 150 Y-CAR BACKGROUND) 
;; Given: 200, Expect: (place-image CAR 200 Y-CAR BACKGROUND)
;; 3b. TESTS:
(check-expect (render 50) (place-image CAR 50 Y-CAR BACKGROUND))
(check-expect (render 100) (place-image CAR 100 Y-CAR BACKGROUND))
(check-expect (render 150) (place-image CAR 150 Y-CAR BACKGROUND))
(check-expect (render 200) (place-image CAR 200 Y-CAR BACKGROUND))
;; 4. TEMPLATE:
;; (define (render ws)
;;  (... ws ... ))
;; 5. CODE:
(define (render ws)
  (place-image CAR ws Y-CAR BACKGROUND)
  )

;; 1. DATA DEFINITIONS: A WorldState is a Number.
;; 2a. FUNCTION SIGNATURE: WorldState -> Boolean
;; 2b. PURPOSE STATEMENT: When needed, big-bang evaluates (end? cw) to determine whether the program should stop.
;; 2c. HEADER:
;; (define (end? cw)
;;  #t)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: >= WIDTH-OF-WORLD + CAR width / 2, Expect: true
;; Given: < WIDTH-OF-WORLD + CAR width / 2, Expect: false
;; 3b. TESTS:
(check-expect (end? (- WIDTH-OF-WORLD (/ (image-width CAR) 2))) #t)
(check-expect (end? (+ 1 (- WIDTH-OF-WORLD (/ (image-width CAR) 2)))) #t)
(check-expect (end? (- (- WIDTH-OF-WORLD (/ (image-width CAR) 2)) 1)) #f)
;; 4. TEMPLATE:
;; (define (end? cw)
;;  (... cw ... WIDTH-OF-WORLD))
;; 5. CODE:
(define (end? cw)
  (if (< cw (- WIDTH-OF-WORLD (/ (image-width CAR) 2))) false true))

;; 1. DATA DEFINITIONS: A WorldState is a Number.
;; 2a. FUNCTION SIGNATURE: WorldState -> WorldState
;; 2b. PURPOSE STATEMENT: Launches the program from some initial state.
;; 2c. HEADER:
;; (define (main ws)
;;  ws)
;; 3a. FUNCTIONAL EXAMPLES: NA
;; 3b. TESTS: NA
;; 4. TEMPLATE:
;; (define (main ws)
;;  (... ws ... big-bang ...))
;; 5. CODE:
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [stop-when end?]))

(main 13)
