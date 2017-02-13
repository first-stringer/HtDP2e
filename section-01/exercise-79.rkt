;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-79) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._data-uni._sec~3adata-uni%29

;; A Color is one of:
;; — "white"
;; — "yellow"
;; — "orange"
;; — "green"
;; — "red"
;; — "blue"
;; — "black"
;; (define color "red")

;; H is a Number between 0 and 100.
;; interpretation represents a “happiness value”
;; (define hv-lowest 0)
;; (define hv-middle 50)
;; (define hv-highest 100)

(define-struct person [fstname lstname male?])
;; A Person is a structure:
;;   (make-person String String Boolean)
;; (define p1 (make-person "John" "Doe" #true))
;; (define p2 (make-person "Jane" "Doe" #false))

(define-struct dog [owner name age happiness])
;; A Dog is a structure:
;;   (make-dog Person String PositiveInteger H)
;; interpretation Name represents the dog's name as a String
;; interpretation Age represents the dog's age as a positive integer
;; (define d1 (make-dog (make-person "John" "Doe" #true) "Bud" 7 50))
;; (define d2 (make-dog (make-person "Jane" "Doe" #false) "Fifi" 3 75))

;; A Weapon is one of:
;; — #false
;; — Posn
;; interpretation #false means the missile hasn't been fired yet; a Posn means
;; it is in flight
;; (define w1 #false)
;; (define w2 (make-posn 90 90))

