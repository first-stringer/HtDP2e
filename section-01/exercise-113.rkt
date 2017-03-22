;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-113) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3ainput-errors%29


;; A SIGS is one of: 
;; – (make-aim UFO Tank)
;; – (make-fired UFO Tank Missile)
;; interpretation represents the complete state of a space invader game


;; Any -> Boolean
;; is s an element of the SIGS collection
(define (sigs? s)
  (cond
    [(aim? s) #true] 
    [(fired? s) #true]
    [else #false]
    )
  )


;; A Coordinate is one of: 
;; – a NegativeNumber 
;; interpretation on the y axis, distance from top
;; – a PositiveNumber 
;; interpretation on the x axis, distance from left
;; – a Posn
;; interpretation an ordinary Cartesian point


;; Any -> Boolean
;; is c an element of the Coordinate collection
(define (coordinate? c)
  (cond
    [(number? c) #true]
    [(posn? c) #true]
    [else #false]
    )
  )


;; A VAnimal is either
;; – a VCat
;; – a VCham


;; Any -> Boolean
;; is va an element of the VAnimal collection
(define (vanimal? va)
  (cond
    [(vcat? va) #true]
    [(vcham? va) #true]
    [else #false]
    )
  )

