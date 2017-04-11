;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-153) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3anats%29


;; 1a. DATA DEFINITIONS
;; A N is one of: 
;; – 0
;; – (add1 N)
;; Interpretation: Represents the counting numbers.


;; 1b. CONSTANT DEFINITIONS
(define SEAT_SIZE 10)
(define SEAT (square SEAT_SIZE "outline" "black"))
(define SCENE_WIDTH 80)
(define SCENE_HEIGHT 180)
(define EMPTY_SCENE (empty-scene SCENE_WIDTH SCENE_HEIGHT))
(define BALLOON_SIZE 3)
(define BALLOON (circle BALLOON_SIZE "solid" "red"))


;; 2a. FUNCTION SIGNATURE: Number Image -> Image
;; 2b. PURPOSE STATEMENT: Consumes a natural number n and an image img. It
;; produces a column—a vertical arrangement—of n copies of img.
;; 2c. HEADER
#; (define (col n i) empty-image)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (col 0 SEAT) empty-image)
(check-expect (col 1 SEAT) SEAT)
(check-expect (col 2 SEAT) (above SEAT SEAT))
;; 4. TEMPLATE
#; (define (col n i)
     (cond
       [(zero? n) ...]
       [else (col ... n ... i ... )]
       )
     )
;; 5. CODE
(define (col n i)
  (cond
    [(zero? n) empty-image] 
    [else (above i (col (sub1 n) i))]
    )
  )


;; 2a. FUNCTION SIGNATURE: Number Image -> Image
;; 2b. PURPOSE STATEMENT: Consumes a natural number n and an image img. It
;; produces a row—a horizontal arrangement—of n copies of img.
;; 2c. HEADER
#; (define (row n i) empty-image)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (row 0 SEAT) empty-image)
(check-expect (row 1 SEAT) SEAT)
(check-expect (row 2 SEAT) (beside SEAT SEAT))
;; 4. TEMPLATE
#; (define (row n i)
     (cond
       [(zero? n) ...]
       [else (row ... n ... i ... )]
       )
     )
;; 5. CODE
(define (row n i)
  (cond
    [(zero? n) empty-image] 
    [else (beside i (row (sub1 n) i))]
    )
  )


(define CLASSROOM (place-image (col 18 (row 8 SEAT)) (/ SCENE_WIDTH 2)
                               (/ SCENE_HEIGHT 2) EMPTY_SCENE))


;; 2a. FUNCTION SIGNATURE: List-of-posns -> Image
;; 2b. PURPOSE STATEMENT: Consumes a list of Posn whose coordinates fit into the
;; dimensions of the lecture hall. It produces an image of the lecture hall with
;; red dots added as specified by the Posns.
;; 2c. HEADER
#; (define (add-balloons lops) EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (add-balloons '()) CLASSROOM)
(check-expect (add-balloons (cons (make-posn 40 90) '() ))
              (place-image BALLOON 40 90 CLASSROOM))
(check-expect
 (add-balloons (cons (make-posn 20 45) (cons (make-posn 40 90) '())))
 (place-image BALLOON 20 45 (place-image BALLOON 40 90 CLASSROOM)))
;; 4. TEMPLATE
#; (define (add-balloons lops)
     (cond
       [(empty? lops) ...]
       [else
        (... place-image ... (first lops) ... add-balloons ... (rest lops) ...)]
       )
     )
;; 5. CODE
(define (add-balloons lops)
  (cond
    [(empty? lops) CLASSROOM]
    [else (place-image BALLOON (posn-x (first lops)) (posn-y (first lops))
                       (add-balloons (rest lops)))]
    )
  )


;; first example
(add-balloons '())

;; second example
(add-balloons (cons (make-posn 67 29) (cons (make-posn 21 33) '())))

;;third example
(add-balloons (list (make-posn 0 0)
                    (make-posn 10 20)
                    (make-posn 20 40)
                    (make-posn 30 60)
                    (make-posn 40 80)
                    (make-posn 50 100)
                    (make-posn 60 120)
                    (make-posn 70 140)
                    ))

