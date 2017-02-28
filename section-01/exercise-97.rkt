;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-97) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._ch~3amix%29


;; 1a. DATA DEFINITIONS
;; #1: A UFO is a Posn. 
;; interpretation (make-posn x y) is the UFO's location 
;; (using the top-down, left-to-right convention)
;; #2: A Tank is a structure:
;;   (make-tank Number Number). 
;; interpretation (make-tank x dx) specifies the position:
;; (x, (- HEIGHT (/ (image-height TANK) 2))) and the tank's speed: dx
;; pixels/tick 
(define-struct tank [loc vel])
; #3: A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place
;; #4: A SIGS is one of: 
;; – (make-aim UFO Tank)
;; – (make-fired UFO Tank Missile)
;; interpretation represents the complete state of a space invader game
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])


;; 1b. CONSTANT DEFINITIONS
(define WIDTH 200)
(define HEIGHT 200)
(define EMPTY_SCENE (empty-scene WIDTH HEIGHT))
(define SUN (overlay (circle 20 "solid" "yellow")
                     (circle 25 "solid" "orange")
                     (circle 28 "solid" "red")))
(define TREE (above (overlay (circle 25 "solid" "yellowgreen")
                             (circle 30 "solid" "green"))
                    (rectangle 10 20 "solid" "brown")))
(define UFO (overlay (circle 5 "solid" "gray")
                     (circle 8 "solid" "black")
                     (rectangle 27 6 "solid" "red")
                     (rectangle 30 8 "solid" "black")))
(define TANK (above (rectangle 5 8 "solid" "black")
                    (rectangle 15 6 "solid" "darkolivegreen")
                    (add-line (rectangle 25 8 "solid" "darkolivegreen")
                              2 5 23 5 
                              (make-pen "black" 3 "solid" "round" "round")
                              )))
(define MISSILE (isosceles-triangle 25 20 "solid" "red"))
(define BACKGROUND
  (place-image TREE (- WIDTH 35) (- HEIGHT (/ (image-height TREE) 2))
               (place-image SUN 35 35 EMPTY_SCENE)))
(define INITIAL_SCENE
  (place-image TANK 15 (- HEIGHT (/ (image-height TANK) 2))
               (place-image UFO (/ WIDTH 2) (image-height UFO) BACKGROUND)))


;; 1c. FUNCTION WISH LIST
;; NAME:
;; SIGNATURE:
;; PURPOSE STATEMENT:


;; 2a. FUNCTION SIGNATURE: SIGS -> Image
;; 2b. PURPOSE STATEMENT: Adds TANK, UFO, and possibly MISSILE to the
;; BACKGROUND
;; scene.
;; 2c. HEADER
(define (si-render s) BACKGROUND)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (si-render (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (place-image TANK 28 (- HEIGHT (/ (image-height TANK) 2))
                           (place-image UFO 20 10 BACKGROUND)))
(check-expect (si-render (make-fired
                          (make-posn 20 10)
                          (make-tank 28 -3)
                          (make-posn 28 (- HEIGHT (/ (image-height TANK) 2)))))
              (place-image TANK 28 (- HEIGHT (/ (image-height TANK) 2))
                           (place-image UFO 20 10
                                        (place-image
                                         MISSILE
                                         28 (- HEIGHT (image-height TANK))
                                         BACKGROUND))))
(check-expect (si-render (make-fired (make-posn 20 100)
                                     (make-tank 100 3)
                                     (make-posn 22 103)) )
              (place-image TANK 100 (- HEIGHT (/ (image-height TANK) 2))
                           (place-image UFO 20 100
                                        (place-image MISSILE 22 103 BACKGROUND)))              )
;; 4. TEMPLATE
(define (si-render s)
  (cond
    [(aim? s) (... (aim-tank s) ...
                   (aim-ufo s) ...)]
    [(fired? s) (... (fired-tank s) ...
                     (fired-ufo s) ...
                     (fired-missile s) ...)]))
;; 5. CODE

