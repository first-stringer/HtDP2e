;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3azoo1%29

;; 1. DATA DEFINITIONS: HappinessLevel (hl) is a Number representing the amount
;; of happiness experienced with a maximum happiness of 100 and a minimum
;; happiness of 0.

(define MAX_HAPPINESS 100)
(define MIN_HAPPINESS 0)
(define RATE 0.1)

(define SCENE_WIDTH 1000)
(define SCENE_HEIGHT 100)
(define SCENE (empty-scene SCENE_WIDTH SCENE_HEIGHT))

;; 2a. FUNCTION SIGNATURE: HappinessLevel -> HappinessLevel
;; 2b. PURPOSE STATEMENT: Decreases hl by RATE amount on every clock tick.
;; 2c. HEADER:
;;(define (tock hl)
;;  0)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 0, Expect: 0
;; Given: 100, Expect: 99.9
;; 3b. TESTS:
(check-expect (tock 0) 0)
(check-expect (tock 100) 99.9)
;; 4. TEMPLATE:
;;(define (tock hl)
;;  (... hl ... RATE ...))
;; 5. CODE:
(define (tock hl)
  (if (> hl MIN_HAPPINESS)
      (- hl RATE)
      MIN_HAPPINESS 
      )
  )

;; 2a. FUNCTION SIGNATURE: Happiness-Level (hl) -> Gauge-Length (gl)
;; 2b. PURPOSE STATEMENT: Uses the hl and SCENE_WIDTH to calculate the gl.
;; 2c. HEADER:
;; (define (calc-gl hl) 0)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: hl, Expect: (* (/ hl MAX_HAPPINESS) SCENE_WIDTH)
;; Given: MIN_HAPPINESS, Expect: 0
;; Given: MAX_HAPPINESS, Expect: SCENE_WIDTH
;; 3b. TESTS:
(check-expect (calc-gl MIN_HAPPINESS) 0)
(check-expect (calc-gl MAX_HAPPINESS) SCENE_WIDTH)
;; 4. TEMPLATE:
;; (define (calc-gl hl)
;;   (... hl ... MIN_HAPPINESS ... MAX_HAPPINESS ... SCENE_WIDTH...))
;; 5. CODE:
(define (calc-gl hl)
  (* (/ hl MAX_HAPPINESS) SCENE_WIDTH))

;; 2a. FUNCTION SIGNATURE: HappinessLevel -> Image
;; 2b. PURPOSE STATEMENT: Displays the happiness level using a blank scene with a solid, red rectangle with a black frame.
;; 2c. HEADER:
;; (define (render hl) SCENE)
;; 3a. FUNCTIONAL EXAMPLES 7 TESTS:
;; Given: hl, Expect: (place-image (frame (rectangle (calc-gl hl) (ceiling (/ SCENE_HEIGHT 2)) "solid" "red")) 0 (ceiling (/ SCENE_HEIGHT 2)) SCENE))
(check-expect (render 8) (place-image (frame (rectangle (calc-gl 8) (ceiling (/ SCENE_HEIGHT 2)) "solid" "red")) 0 (ceiling (/ SCENE_HEIGHT 2)) SCENE))
(check-expect (render MIN_HAPPINESS) (place-image (frame (rectangle 0 (ceiling (/ SCENE_HEIGHT 2)) "solid" "red")) 0 (ceiling (/ SCENE_HEIGHT 2)) SCENE))
(check-expect (render MAX_HAPPINESS) (place-image (frame (rectangle SCENE_WIDTH (ceiling (/ SCENE_HEIGHT 2)) "solid" "red")) 0 (ceiling (/ SCENE_HEIGHT 2)) SCENE))
;; 4. TEMPLATE:
;; (define (render hl)
;;  (... hl ... (calc-gl hl) ... SCENE_HEIGHT ... SCENE_WIDTH ... MAX_HAPPINESS...))
;; 5. CODE:
(define (render hl)
  (place-image (frame (rectangle (calc-gl hl) (ceiling (/ SCENE_HEIGHT 2)) "solid" "red")) 0 (ceiling (/ SCENE_HEIGHT 2)) SCENE)
  )


