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
;; NAME: spider-fits?
;; SIGNATURE: Spider Number -> Boolean
;; PURPOSE STATEMENT: Consumes a Spider (s) and the volument of a cage (v) and
;; determines whether the cage is large enough for the spider.
;; NAME: elephant-fits?
;; SIGNATURE: Number Number -> Boolean
;; PURPOSE STATEMENT: Consumes an Elephant (e) and the volument of a cage (v) and
;; determines whether the cage is large enough for the elephant.
;; NAME: boaconstrictor-fits?
;; SIGNATURE: BoaConstrictor Number -> Boolean
;; PURPOSE STATEMENT: Consumes a BoaConstrictor (bc) and the volument of a cage
;; (v) and determines whether the cage is large enough for the boa constrictor.
;; NAME: armadillo-fits?
;; SIGNATURE: Armadillo Number -> Boolean
;; PURPOSE STATEMENT: Consumes an Armadillo (a) and the volument of a cage (v) and
;; determines whether the cage is large enough for the armadillo.


;; 2a. FUNCTION SIGNATURE: BoaConstrictor Number -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a BoaConstrictor (bc) and the volument of a
;; cage (v) and determines whether the cage is large enough for the boa
;; constrictor.
;; 2c. HEADER
#;(define (boaconstrictor-fits? bc v) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (boaconstrictor-fits? (make-boaconstrictor 108 6) 647) #false)
(check-expect (boaconstrictor-fits? (make-boaconstrictor 108 6) 648) #true)
(check-expect (boaconstrictor-fits? (make-boaconstrictor 108 6) 649) #true)
;; 4. TEMPLATE
#;(define (boaconstrictor-fits? bc v)
    (... (boaconstrictor-length bc) ... (boaconstrictor-girth bc) ... v ...))
;; 5. CODE
(define (boaconstrictor-fits? bc v)
  (<= (* (boaconstrictor-length bc) (boaconstrictor-girth bc)) v))


;; 2a. FUNCTION SIGNATURE: Number Number -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes an Elephant (e) and the volument of a cage (v)
;; and determines whether the cage is large enough for the elephant.
;; 2c. HEADER
#;(define (elephant-fits? e v) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (elephant-fits? 1000 999) #false) 
(check-expect (elephant-fits? 1000 1000) #true) 
(check-expect (elephant-fits? 1000 1001) #true) 
;; 4. TEMPLATE
#;(define (elephant-fits? e v)
    (... e ... v ...))
;; 5. CODE
(define (elephant-fits? e v)
  (<= e v))


;; 2a. FUNCTION SIGNATURE: Spider Number -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a Spider (s) and the volument of a cage (v) and
;; determines whether the cage is large enough for the spider.
;; 2c. HEADER
#;(define (spider-fits? s v) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (spider-fits? (make-spider 7 10) 11) #true) 
(check-expect (spider-fits? (make-spider 7 10) 9) #false) 
;; 4. TEMPLATE
#;(define (spider-fits? s v)
    (... (spider-remaininglegs s) ... (spider-space s) ... v ...))
;; 5. CODE
(define (spider-fits? s v)
  (<= (spider-space s) v))


;; 2a. FUNCTION SIGNATURE: ZooAnimal Number -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a zoo animal (za) and the volume of a cage (v).
;; It determines whether the cage is large enough for the animal.
;; 2c. HEADER
(define (fits? za v) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (fits? (make-spider 8 10) 11) #true) 
(check-expect (fits? 1000 1001) #true) ; elephant
(check-expect (fits? (make-boaconstrictor 108 6) 700) #true) 
(check-expect (fits? (make-armadillo 18 10 12) 2500) #true) 
;; 4. TEMPLATE
#;(define (fits? za v)
    (cond
      [(spider? za) ...]
      [(number? za) ...]
      [(boaconstictor? za) ...]
      [(armadillo? za) ...]
      )
    )
;; 5. CODE
#;(define (fits? za v)
    (cond
      [(spider? za) (spider-fits? za v)]
      [(number? za) (elephant-fits? za v)]
      [(boaconstrictor? za) (boaconstrictor-fits? za v)]
      [(armadillo? za) (armadillo-fits? za v)]
      )
    )

