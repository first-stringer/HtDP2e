;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-57) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._itemization._sec~3aitemization%29

(define HEIGHT 300) ; distances in pixels
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))

(define ROCKET (rectangle 5 30 "solid" "red"))
(define CENTER (/ (image-height ROCKET) 2))

;; A LRCD (for launching rocket count down) is one of:
;; – "resting"
;; – a Number between -3 and -1
;; – a NonnegativeNumber 
;; interpretation a grounded rocket, in count-down mode,
;; a number denotes the number of pixels between the
;; bottom of the rocket and the ground
;; Examples:
;; Rocket at its maximum fully displayed height on the scene (y = 0 + the height
;; of the rocket) given that the rocket's reference point is its bottom center.
(place-image ROCKET (/ WIDTH 2) CENTER BACKG)
;; Rocket at SCENE_HEIGHT (i.e. y=0).
(place-image ROCKET (/ WIDTH 2) (- 0 CENTER) BACKG)
;; Rocket at resting.
(place-image ROCKET (/ WIDTH 2) (- HEIGHT CENTER) BACKG)
;; Rocket at 0 height.
(place-image ROCKET (/ WIDTH 2) (- HEIGHT CENTER) BACKG)
;; interpretation "resting" represents a grounded rocket
;; a number denotes the height of a rocket in flight as the number of pixels
;; between its bottom and the ground (i.e. HEIGHT).

; LRCD -> Image
; renders the state of a flying rocket 
(define (show-rocket x)
  (place-image ROCKET 10 (- HEIGHT x CENTER) BACKG))

; LRCD -> Image
; renders the state as a resting or flying rocket 
(check-expect (show "resting") (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))
(check-expect (show -2) (place-image (text "-2" 20 "red") 10 (* 3/4 WIDTH) (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)))
(check-expect (show HEIGHT) (place-image ROCKET 10 (- 0 CENTER) BACKG))
(check-expect (show 53) (place-image ROCKET 10 (- HEIGHT 53 CENTER) BACKG))
(define (show x)
  (cond
    [(or (and (string? x) (string=? "resting" x)) (> x HEIGHT))
     (show-rocket 0)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (show-rocket 0))]
    [(>= x 0)
     (show-rocket x)]))

; LRCD KeyEvent -> LRCD
; starts the count-down when space bar is pressed, 
; if the rocket is still resting 
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)
(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) 0)
(check-expect (fly 10) (+ 10 YDELTA))
(check-expect (fly 22) (+ 22 YDELTA))
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) 0 (+ x 1))]
    [(>= x 0) (+ x YDELTA)]))

; LRCD -> LRCD
(define (main1 s)
  (big-bang s
            [to-draw show]
            [on-key launch]))

; LRCD -> LRCD
(check-expect (stop? HEIGHT) #t)
(check-expect (stop? (+ HEIGHT 1)) #t)
(check-expect (stop? (- HEIGHT 1)) #f)
(define (stop? s)
  (if (>= s HEIGHT) #t #f))

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
            [to-draw show]
            [on-key launch]
            [on-tick fly]
            [stop-when stop?]))

(main2 -3)