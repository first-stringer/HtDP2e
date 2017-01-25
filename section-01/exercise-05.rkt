;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-05) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aarith-images%29

(define scene-x 100)
(define scene-y 100)

(define x-center (/ scene-x 2))
(define y-center (/ scene-y 2))
(define center-posn (make-posn x-center y-center))

(define my-images '())
(define posns '())

(define body (rectangle (/ scene-x 2) (/ scene-y 6) "solid" "blue"))
(define body-posn center-posn)

(define cab (rectangle (/ (image-width body) 2) (image-height body) "solid" "blue"))
(define cab-posn (make-posn (posn-x body-posn) (- (posn-y body-posn) (/ (image-height body) 2) (/ (image-height cab) 2))))


(define wheels-diameter (/ (image-width body) 8)) 

(define wheel1 (circle wheels-diameter "solid" "black"))
(define wheel1-posn (make-posn (- (posn-x body-posn) (/ (image-width body) 4)) (+ (posn-y body-posn) (/ (image-height body) 2))))

(define wheel2 (circle wheels-diameter "solid" "black"))
(define wheel2-posn (make-posn (+ (posn-x body-posn) (/ (image-width body) 4)) (+ (posn-y body-posn) (/ (image-height body) 2))))



(define scene (empty-scene scene-x scene-y))

(place-images (list wheel2 wheel1 cab body) (list wheel2-posn wheel1-posn cab-posn body-posn) scene)