;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-156) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alist-world%29


;; 1a. DATA DEFINITIONS
;; #1: A List-of-shots is one of: 
;; – '()
;; – (cons Shot List-of-shots)
;; Interpretation: The collection of shots fired.
;; #2: A Shot is a Number.
;; interpretation represents the shot's y-coordinate
;; #3: A ShotWorld is List-of-numbers. 
;; Interpretation: Each number on such a list represents the y-coordinate of a
;; shot.


;; 1b. CONSTANT DEFINITIONS
(define HEIGHT 80) ; distances in terms of pixels 
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))
 
;; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))


;; 1c. FUNCTION WISH LIST
;; #1 HEADER
#; (define (to-image w) BACKGROUND)
;; SIGNATURE: ShotWorld -> Image
;; PURPOSE STATEMENT: Adds the image of a shot for each y on w at (XSHOTS,y} to
;; the background image.
;; #2 HEADER
#; (define (tock w) w)
;; SIGNATURE: ShotWorld -> ShotWorld
;; PURPOSE STATEMENT: Moves each shot on w up by one pixel.
;; #3 HEADER
#; (define (keyh w ke) w)
;; SIGNATURE: ShotWorld KeyEvent -> ShotWorld 
;; PURPOSE STATEMENT: Adds a shot to the world if the player pressed the space
;; bar.


;; 2a. FUNCTION SIGNATURE:
;; 2b. PURPOSE STATEMENT:
;; 2c. HEADER
;; 3a. FUNCTIONAL EXAMPLES
;; #1: Given: , Expect:
;; 3b. TESTS
#;1 
;; 4. TEMPLATE
;; 5. CODE