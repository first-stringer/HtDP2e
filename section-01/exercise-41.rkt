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

(define AUTO-BODY-HEIGHT (* WHEEL-RADIUS 2))
(define AUTO-BODY-LENGTH (* WHEEL-RADIUS 8))
(define AUTO-BODY (rectangle AUTO-BODY-LENGTH AUTO-BODY-HEIGHT "solid" "red"))

(define AUTO-CAB-HEIGHT (/ AUTO-BODY-HEIGHT 2))
(define AUTO-CAB-LENGTH (/ AUTO-BODY-LENGTH 2))
(define AUTO-CAB (rectangle AUTO-CAB-LENGTH AUTO-CAB-HEIGHT "solid" "red"))

(define AUTO (overlay/offset BOTH-WHEELS 0 (- 0 AUTO-BODY-HEIGHT) (overlay/offset AUTO-BODY 0 (- 0 (+ (/ AUTO-BODY-HEIGHT 2) (/ AUTO-CAB-HEIGHT 2))) AUTO-CAB)))

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
(check-expect (render 50) (place-image AUTO 50 Y-CAR BACKGROUND))
(check-expect (render 100) (place-image AUTO 100 Y-CAR BACKGROUND))
(check-expect (render 150) (place-image AUTO 150 Y-CAR BACKGROUND))
(check-expect (render 200) (place-image AUTO 200 Y-CAR BACKGROUND))
;; 4. TEMPLATE:
;; (define (render ws)
;;  (... ws ... ))
;; 5. CODE:
(define (render ws)
  (place-image AUTO ws Y-CAR BACKGROUND)
  )
