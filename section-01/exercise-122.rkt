;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-122) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3asynsem~3asem%29

(define (f x y)
  (+ (* 3 x) (* y y)))

;; 1.
(+ (f 1 2) (f 2 1))
(+ (+ (* 3 1) (* 2 2)) (f 2 1))
(+ (+ 3 (* 2 2)) (f 2 1))
(+ (+ 3 4) (f 2 1))
(+ 7 (f 2 1))
(+ 7 (+ (* 3 2) (* 1 1)))
(+ 7 (+ 6 (* 1 1)))
(+ 7 (+ 6 1))
(+ 7 7)
14

;; 2.
(f 1 (* 2 3))
(f 1 6)
(+ (* 3 1) (* 6 6))
(+ 3 (* 6 6))
(+ 3 36)
39

