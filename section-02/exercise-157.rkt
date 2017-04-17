;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-157) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)


;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alist-world%29


;; 1a. DATA DEFINITIONS
;; #1: A List-of-shots is one of: 
;; – '()
;; – (cons Shot List-of-shots)
;; Interpretation: The collection of shots fired.
;; #2: A Shot is a Number.
;; interpretation represents the shot's y-coordinate
;; #3: A ShotWorld is List-of-numbers. 
;; Interpretation: Each number on such a list represents the y-coordinate of a
;; shot.


;; 1b. CONSTANT DEFINITIONS
(define HEIGHT 220) ; distances in terms of pixels 
(define WIDTH 30)
(define XSHOTS (/ (/ WIDTH 2) 2))
 
;; graphical constants 
(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "green"))
(define SHOT (scale 2 (rectangle 3 10 "solid" "black")))


;; 1c. FUNCTION WISH LIST
;; #1 HEADER
#; (define (to-image w) BACKGROUND)
;; SIGNATURE: ShotWorld -> Image
;; PURPOSE STATEMENT: Adds the image of a shot for each y on w at (XSHOTS,y} to
;; the background image.
;; #2 HEADER
#; (define (tock w) w)
;; SIGNATURE: ShotWorld -> ShotWorld
;; PURPOSE STATEMENT: Moves each shot on w up by one pixel.
;; #3 HEADER
#; (define (keyh w ke) w)
;; SIGNATURE: ShotWorld KeyEvent -> ShotWorld 
;; PURPOSE STATEMENT: Adds a shot to the world if the player pressed the space
;; bar.


;; 2a. FUNCTION SIGNATURE: ShotWorld KeyEvent -> ShotWorld 
;; 2b. PURPOSE STATEMENT: Adds a shot to the world if the player pressed the
;; space bar.
;; 2c. HEADER
#; (define (keyh w ke) w)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (keyh '() " ") (cons HEIGHT '()))
(check-expect (keyh (cons (/ HEIGHT 2) '()) " ")
              (cons HEIGHT (cons (/ HEIGHT 2) '())))
(check-expect (keyh '() "*") '())
(check-expect (keyh (cons (/ HEIGHT 2) '()) "*")
              (cons (/ HEIGHT 2) '()))
;; 4. TEMPLATE
#; (define (keyh w ke)
     (cond
       [(and (key=? ke " ") (empty? w)) ...] 
       [(and (key=? ke " ") (not (empty? w)))
        (... (first w) ... (keyh (rest w) ke) ...)]
       [else ...] 
       )
     )
;; 5. CODE
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w)
  )


;; 2a. FUNCTION SIGNATURE: SIGNATURE: ShotWorld -> ShotWorld
;; 2b. PURPOSE STATEMENT: Moves each shot on w up by one pixel.
;; 2c. HEADER
#; (define (tock w) w)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (tock '()) '())
(check-expect (tock (cons 10 '())) (cons 9 '()))
(check-expect (tock (cons 41 (cons 10 '()))) (cons 40 (cons 9 '())))
;; 4. TEMPLATE
#; (define (tock w)
     (cond
       [(empty? w) ...]
       [else (... (first w) ... (tock (rest w)) ...)]
       )
     )
;; 5. CODE
(define (tock w)
  (cond
    [(empty? w) '()]
    [else (cons (sub1 (first w)) (tock (rest w)))]
    )
  )


;; 2a. FUNCTION SIGNATURE: ShotWorld -> Image
;; 2b. PURPOSE STATEMENT: Adds the image of a shot for each y on w at (XSHOTS,y}
;; to the background image.
;; 2c. HEADER
#; (define (to-image w) BACKGROUND)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (to-image '()) BACKGROUND)
(check-expect (to-image (cons 9 '())) (place-image SHOT XSHOTS 9 BACKGROUND))
(check-expect (to-image (cons 40 (cons 9 '())))
              (place-image SHOT XSHOTS 40
                           (place-image SHOT XSHOTS 9 BACKGROUND)))
;; 4. TEMPLATE
#; (define (to-image w)
     (cond
       [(empty? w) ...]
       [else (... (first w) ... (to-image (rest w)) ...)]
       )
     )
;; 5. CODE
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w) (to-image (rest w)))]
    )
  )


;; 2a. FUNCTION SIGNATURE: ShotWorld -> ShotWorld 
;; 2b. PURPOSE STATEMENT: Initiates ShotWorld with a no-shots-fired state.
;; 2c. HEADER
#; (define (main w0) w0)
;; 3a. FUNCTIONAL EXAMPLES & TESTS: NA
;; 4. TEMPLATE
#; (define (main w0)
     (big-bang w0
               [on-tick ...]
               [on-key ...]
               [to-draw ...]
               )
     )
;; 5. CODE
(define (main w0)
  (big-bang w0
            [on-tick tock]
            [on-key keyh]
            [to-draw to-image]
            )
  )


(main '())


;; Main initiates the ShotWorld program with a no-shots-fired state.

