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
 
(define-struct tank [loc vel])
;; #2: A Tank is a structure:
;;   (make-tank Number Number). 
;; interpretation (make-tank x dx) specifies the position:
;; (x, (- HEIGHT (/ (image-height TANK) 2))) and the tank's speed: dx pixels/tick 
 
; #3: A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

;; #4: A SIGS is one of: 
;; – (make-aim UFO Tank)
;; – (make-fired UFO Tank Missile)
;; interpretation represents the complete state of a space invader game


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


(place-image TANK 28 (- HEIGHT (/ (image-height TANK) 2))
             (place-image UFO 20 10 BACKGROUND))

(place-image TANK 28 (- HEIGHT (/ (image-height TANK) 2))
             (place-image UFO 20 10
                          (place-image MISSILE
                                       28 (- HEIGHT (image-height TANK))
                                       BACKGROUND)))

(place-image TANK 100 (- HEIGHT (/ (image-height TANK) 2))
             (place-image UFO 20 100 (place-image MISSILE 22 103 BACKGROUND)))


;; 1c. FUNCTION WISH LIST
;; NAME:
;; SIGNATURE:
;; PURPOSE STATEMENT:


;; 2a. FUNCTION SIGNATURE:
;; 2b. PURPOSE STATEMENT:
;; 2c. HEADER
;; 3a. FUNCTIONAL EXAMPLES
;; #1: Given: , Expect:
;; 3b. TESTS
#;1 
;; 4. TEMPLATE
;; 5. CODE