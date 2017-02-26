;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-94) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._ch~3amix%29


;; 1a. DATA DEFINITIONS


;; 1b. CONSTANT DEFINITIONS
(define WIDTH 800)
(define HEIGHT 150)
(define EMPTY_SCENE (empty-scene WIDTH HEIGHT))
(define SUN (overlay (circle 30 "solid" "yellow")
                     (circle 35 "solid" "orange")
                     (circle 38 "solid" "red")))
(define TREE (above (overlay (circle 25 "solid" "yellowgreen")
                             (circle 30 "solid" "green"))
                    (rectangle 10 20 "solid" "brown")))
(define UFO (overlay (circle 7 "solid" "gray")
                     (circle 10 "solid" "black")
                     (rectangle 46 5 "solid" "red")
                     (rectangle 50 10 "solid" "black")))
(define TANK (above (rectangle 5 10 "solid" "black")
                    (rectangle 25 10 "solid" "darkolivegreen")
                    (add-line (rectangle 50 15 "solid" "darkolivegreen")
                              8 12 42 12 
                              (make-pen "black" 5 "solid" "round" "round")
                              )))
(define BACKGROUND
  (place-image TREE (- WIDTH 100) (- HEIGHT (/ (image-height TREE) 2))
               (place-image SUN 45 45 EMPTY_SCENE)))

(place-image TANK 200 (- HEIGHT (/ (image-height TANK) 2))
             (place-image UFO 100 100 BACKGROUND))



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