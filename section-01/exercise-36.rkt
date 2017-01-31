;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-36) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3afinger-design%29

;; 1. DATA DEFINITIONS: We use numbers to represent pixels.
;; 2a. FUNCTION SIGNATURE: Image -> Number
;; 2b. PURPOSE STATMENT: Counts the number of pixels in a given image.
;; 2c. HEADER:
;; (define (image-area img)
;;  0 )
;; 3. FUNCTIONAL EXAMPLES:
;; Given: (rectangle 10 10 "solid" "brown"), Expect 100.
;; Given: (circle 10 "solid" "brown"), Expect 400.
;; 4. TEMPLATE:
;; (define (image-area img)
;;  (... img ...))
;; 5. CODE:
(define (image-area img)
  (* (image-height img) (image-width img)))