;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-105) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._mix._sec~3aitemization-design2%29


;; 1a. DATA DEFINITIONS
;; A Coordinate is one of: 
;; – a NegativeNumber
-10 ; data example
(place-image (circle 2 "solid" "red") 0 10 (rectangle 100 100 "solid" "white"))
-90 ; data example
(place-image (circle 2 "solid" "red") 0 90 (rectangle 100 100 "solid" "white"))
;; interpretation on the y axis, distance from top
;; – a PositiveNumber 
;; interpretation on the x axis, distance from left
10 ; data example
(place-image (circle 2 "solid" "red") 10 0 (rectangle 100 100 "solid" "white"))
90 ; data example
(place-image (circle 2 "solid" "red") 90 0 (rectangle 100 100 "solid" "white"))
;; – a Posn
;; interpretation an ordinary Cartesian point
(make-posn 10 -10) ; data example
(place-image (circle 2 "solid" "red") 10 10 (rectangle 100 100 "solid" "white"))
(make-posn 90 -90) ; data example
(place-image (circle 2 "solid" "red") 90 90 (rectangle 100 100 "solid" "white"))

