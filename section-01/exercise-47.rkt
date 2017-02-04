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

(define DOWN_KEY_AMOUNT 6/5)
(define UP_KEY_AMOUNT 4/3)

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
  (if (< hl MAX_HAPPINESS)
      (* (/ hl MAX_HAPPINESS) SCENE_WIDTH)
      SCENE_WIDTH
      )
  )

;; 2a. FUNCTION SIGNATURE: HappinessLevel -> Image
;; 2b. PURPOSE STATEMENT: Displays the happiness level using a blank scene with a solid, red rectangle with a black frame.
;; 2c. HEADER:
;; (define (render hl) SCENE)
;; 3a. FUNCTIONAL EXAMPLES 7 TESTS:
;; Given: hl, Expect: (place-image (frame (rectangle (calc-gl hl) (ceiling (/ SCENE_HEIGHT 2)) "solid" "red")) 0 (ceiling (/ SCENE_HEIGHT 2)) SCENE))
(check-expect (render 8) (place-image/align (frame (rectangle (calc-gl 8) (ceiling (/ SCENE_HEIGHT 2)) "solid" "red")) 0 (ceiling (/ SCENE_HEIGHT 2)) "left" "center" SCENE))
(check-expect (render MIN_HAPPINESS) (place-image/align (frame (rectangle 0 (ceiling (/ SCENE_HEIGHT 2)) "solid" "red")) 0 (ceiling (/ SCENE_HEIGHT 2)) "left" "center" SCENE))
(check-expect (render MAX_HAPPINESS) (place-image/align (frame (rectangle SCENE_WIDTH (ceiling (/ SCENE_HEIGHT 2)) "solid" "red")) 0 (ceiling (/ SCENE_HEIGHT 2)) "left" "center" SCENE))
;; 4. TEMPLATE:
;; (define (render hl)
;;  (... hl ... (calc-gl hl) ... SCENE_HEIGHT ... SCENE_WIDTH ... MAX_HAPPINESS...))
;; 5. CODE:
(define (render hl)
  (place-image/align (frame (rectangle (calc-gl hl) (ceiling (/ SCENE_HEIGHT 2)) "solid" "red")) 0 (ceiling (/ SCENE_HEIGHT 2)) "left" "center" SCENE)
  )

;; 2a. FUNCTION SIGNATURE: HappinessLevel (hl) KeyEvent (ke) -> hl
;; 2b. PURPOSE STATEMENT: Process keyboard events (ke). Every time the down
;; arrow key is pressed, happiness increases by 1/5; every time the up arrow is
;; pressed, happiness jumps by 1/3.
;; 2c. HEADER:
;; (define (handle-ke hl ke) hl)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: 10 "down", Expect: 12
;; Given: 10 "up", Expect: 13
;; 3b. TESTS:
(check-expect (handle-ke 10 "down") 12)
(check-expect (handle-ke 10 "up") 13)
;; 4. TEMPLATE:
;; (define (handle-ke hl ke)
;;  (... hl ... ke ...))
;; 5. CODE:
(define (handle-ke hl ke)
  (cond
    [(key=? ke "down") (if (< (floor (* hl DOWN_KEY_AMOUNT)) MAX_HAPPINESS) (floor (* hl DOWN_KEY_AMOUNT)) MAX_HAPPINESS)]
    [(key=? ke "up") (if (< (floor (* hl UP_KEY_AMOUNT)) MAX_HAPPINESS) (floor (* hl UP_KEY_AMOUNT)) MAX_HAPPINESS)]
    [else hl]
    )
  )

;; 2a. FUNCTION SIGNATURE: HappinessLevel (hl) -> hl
;; 2b. PURPOSE STATEMENT: Initiates the happiness gauge with the maximum level
;; of happiness.
;; 2c. HEADER:
;; (define (gauge-prog hl) hl)
;; 3a. FUNCTIONAL EXAMPLES: NA
;; 4. TEMPLATE:
;; (define (gauge-prog hl)
;;  (... hl ...))
;; 5. CODE:
(define (gauge-prog hl)
  (big-bang hl
            [on-tick tock]
            [to-draw render]
            [on-key handle-ke]
            ))

(gauge-prog MAX_HAPPINESS)