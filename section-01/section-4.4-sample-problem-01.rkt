;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname section-4.4-sample-problem-01) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aintervals%29

; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green") (circle 12 "solid" "red")))

; WorldState -> WorldState
(define (main y0)
  (big-bang y0
            [on-tick nxt]
            [to-draw render]
            [stop-when stop?]))

; WorldState -> WorldState
; determines when to stop the program, in this case whene the UFO has landed
(check-expect (stop? (- HEIGHT (ceiling (/ (image-height UFO) 2)))) #t)
(check-expect (stop? (- HEIGHT (+ 1 (ceiling (/ (image-height UFO) 2))))) #f)
(define (stop? ws)
  (if (>= ws (- HEIGHT (ceiling (/ (image-height UFO) 2)))) #t #f))

; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
  (+ y 3))
 
; WorldState -> Image
; place UFO at given height into the center of MTSCN
;;(check-expect (render 11) (place-image UFO (floor (/ WIDTH 2)) 11 MTSCN))
(define (render y)
  (place-image UFO (floor (/ WIDTH 2)) y MTSCN))

(main 10)


