;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-142) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3afinger-lists%29


;; 1a. DATA DEFINITIONS
;; ImageOrFalse is one of:
;; – Image
;; – #false 


;; 2a. FUNCTION SIGNATURE: Image Number -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes an image and a number. Returns #true if the
;; image is a n by n sized rectangle (square), else #false.
;; 2c. HEADER
#; (define (is-n-square? i n) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (is-n-square? (rectangle 5 5 "solid" "red") 5) #true)
(check-expect (is-n-square? (rectangle 6 5 "solid" "red") 5) #false)
(check-expect (is-n-square? (rectangle 5 6 "solid" "red") 5) #false)
(check-expect (is-n-square? (circle 6 "solid" "red") 5) #false)
(check-expect (is-n-square? (circle 5 "solid" "red") 10) #true)
;; 4. TEMPLATE
#; (define (is-n-square? i n)
     (cond
       [(not (image? i)) ...]
       [else (... (image-width i) ... (image-height i) ... n ...)]
       )
     )
;; 5. CODE
(define (is-n-square? i n)
  (and (image? i) (= (image-width i) n) (= (image-height i) n))
  )


;; 2a. FUNCTION SIGNATURE: List-of-images -> ImageOrFalse
;; 2b. PURPOSE STATEMENT: Consumes a list of images (loi) and a positive number
;; n. It produces the first image on loi that is not an n by n square; if it
;; cannot find such an image, it produces #false.
;; 2c. HEADER
#; (define (ill-sized? loi n) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (ill-sized? (cons (rectangle 5 5 "solid" "red") '()) 5) #false)
(check-expect (ill-sized? (cons (rectangle 5 5 "solid" "red") '()) 4)
              (rectangle 5 5 "solid" "red"))
(check-expect (ill-sized? (cons (rectangle 4 4 "solid" "red")
                                (cons (rectangle 5 4 "solid" "red") '())) 4)
              (rectangle 5 4 "solid" "red"))
(check-expect (ill-sized? (cons (rectangle 4 5 "solid" "red")
                                (cons (rectangle 5 5 "solid" "red") '())) 5)
              (rectangle 4 5 "solid" "red"))
;; 4. TEMPLATE
#; (define (ill-sized? loi n)
     (cond
       [(empty? loi) ...]
       [(not (is_n_square? (first loi) n)) ...]
       [else (... (rest loi) ... n ...)]
       )
     )
;; 5. CODE
(define (ill-sized? loi n)
  (cond
    [(empty? loi) #false]
    [(not (is-n-square? (first loi) n)) (first loi)]
    [else (ill-sized? (rest loi) n)]
    )
  )

