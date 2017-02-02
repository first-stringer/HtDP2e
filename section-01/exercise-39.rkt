;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-39) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._.D.K._sec~3adesign-world%29

(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 50)

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL (circle WHEEL-RADIUS "solid" "black"))

(define SPACE (rectangle (* WHEEL-RADIUS 3) WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define CAR-BODY-HEIGHT (* WHEEL-RADIUS 2))
(define CAR-BODY-LENGTH (* WHEEL-RADIUS 8))
(define CAR-BODY (rectangle CAR-BODY-LENGTH CAR-BODY-HEIGHT "solid" "red"))

(define CAR-CAB-HEIGHT (/ CAR-BODY-HEIGHT 2))
(define CAR-CAB-LENGTH (/ CAR-BODY-LENGTH 2))
(define CAR-CAB (rectangle CAR-CAB-LENGTH CAR-CAB-HEIGHT "solid" "red"))

(define CAR (overlay/offset BOTH-WHEELS 0 (- 0 CAR-BODY-HEIGHT) (overlay/offset CAR-BODY 0 (- 0 (+ (/ CAR-BODY-HEIGHT 2) (/ CAR-CAB-HEIGHT 2))) CAR-CAB)))

(place-image CAR (/ WIDTH-OF-WORLD 2) (/ HEIGHT-OF-WORLD 2) (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))