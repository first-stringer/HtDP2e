;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-112) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3ainput-errors%29

;; Any -> Boolean
;; is a an element of the MissileOrNot collection
(define (missile-or-not? v)
  (cond
    [(false? v) #true]
    [(posn? v) #true]
    [else #false]))


;; Any -> Boolean
;; is a an element of the MissileOrNot collection
(define (missile-or-not.v2? v)
  (or (false? v) (posn? v)))


(check-expect (missile-or-not.v2? #false) #true)
(check-expect (missile-or-not.v2? (make-posn 1 1)) #true)
(check-expect (missile-or-not.v2? #true) #false)
(check-expect (missile-or-not.v2? "x") #false)

