;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-111) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3ainput-errors%29


(define-struct vec [x y])
;; A vec is
;;   (make-vec PositiveNumber PositiveNumber)
;; interpretation represents a velocity vector


;; Any Any -> vec
;; constructs and returns a velocity vector if both x and y are positive numbers
(define (checked-make-vec x y)
  (cond
    [(and (number? x) (number? y) (positive? x) (positive? y)) (make-vec x y)]
    [else (error "make-vec: two positive numbers expected")]
    )
  )


(checked-make-vec 1 1)


(checked-make-vec 1 -1)

