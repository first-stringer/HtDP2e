;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-103) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._mix._sec~3aitemization-design2%29

;; 1a. DATA DEFINITIONS
;; #1: A ZooAnimal (za) is one of four types of animals: Spider, Elephant,
;; BoaConstrictor, or Armadillo.
;; #2: A Spider is a structure: (make-spider Number Number).
;; Interpretation: (make-spider rl s) specifies the number of remaining legs (rl)
;; the spider has and the amount of space (s) the spider requires for transport.
(define-struct spider [remaining-legs space])
;; #3: An Elephant is a Number.
;; Interpretation: the amount of space (s) the elephant requires for transport.
;; #4: A BoaConstrictor is a structure: (make-boaconstrictor Number Number).
;; Interpretation: (make-boaconstrictor l g) specifies the length (l) and girth
;; (g) of the snake.
(define-struct boaconstrictor [length girth])
;; #5: An Armadillo is a structure: (make-armadillo Number Number Number).
;; Interpretation: (make-armadillo l w h) specifies the length (l), width (w), and
;; height (h) of the animal.
(define-struct armadillo [length width height])
;; 1c. FUNCTION WISH LIST
;; NAME:
;; SIGNATURE:
;; PURPOSE STATEMENT:


;; 2a. FUNCTION SIGNATURE: ZooAnimal Number -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a zoo animal (za) and the volume of a cage (v).
;; It determines whether the cage is large enough for the animal.
;; 2c. HEADER
#;(define (fits? za v) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (fits? (make-spider 8 10) 11) #true) 
(check-expect (fits? 1000 (* 11 11 11)) #true) ; elephant
(check-expect (fits? (make-boaconstrictor 108 6) 700) #true) 
(check-expect (fits? (make-armadillo 18 10 12) 2500) #true) 
;; 4. TEMPLATE
#;(define (fits? za v)
    (cond
      [(spider? za) ...]
      [(boaconstictor? za) ...]
      [(armadillo? za) ...]
      [(number? za) ...]
      )
    )
;; 5. CODE
(define (fits? za v)
  (cond
    [(spider? za) (spider-fits? za v)]
    [(number? za) (elephant-fits? za v)]
    [(boaconstrictor? za) (boaconstrictor-fits? za v)]
    [(armadillo? za) (armadillo-fits? za v)]
    )
  )

