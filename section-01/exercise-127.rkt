;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-127) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aint1-structs%29


(define-struct ball [x y speed-x speed-y])


;; 1. (number? (make-ball 1 2 3 4)) = #false

;; 2. (ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3)) = 3

;; 3. (ball-y (make-ball (+ 1 2) (+ 3 3) 2 3)) = 6

;; 4. (ball-x (make-posn 1 2)) = ERROR: "ball-x: expects a ball, given (make-posn
;; 1 2)"

;; 5. (ball-speed-y 5) = ERROR: "ball-speed-y: expects a ball, given 5"

