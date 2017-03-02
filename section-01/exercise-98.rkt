;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-98) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._ch~3amix%29


;; 1a. DATA DEFINITIONS
;; #1: A UFO is a Posn. 
;; interpretation (make-posn x y) is the UFO's location 
;; (using the top-down, left-to-right convention)
;; #2: A Tank is a structure:
;;   (make-tank Number Number). 
;; interpretation (make-tank x dx) specifies the position:
;; (x, (- HEIGHT (/ (image-height TANK) 2))) and the tank's speed: dx
;; pixels/tick 
(define-struct tank [loc vel])
; #3: A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place
;; #4: A SIGS is one of: 
;; – (make-aim UFO Tank)
;; – (make-fired UFO Tank Missile)
;; interpretation represents the complete state of a space invader game
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])


;; 1b. CONSTANT DEFINITIONS
(define WIDTH 200)
(define HEIGHT 200)
(define EMPTY_SCENE (empty-scene WIDTH HEIGHT))
(define SUN (overlay (circle 20 "solid" "yellow")
                     (circle 25 "solid" "orange")
                     (circle 28 "solid" "red")))
(define TREE (above (overlay (circle 25 "solid" "yellowgreen")
                             (circle 30 "solid" "green"))
                    (rectangle 10 20 "solid" "brown")))
(define UFO (overlay (circle 5 "solid" "gray")
                     (circle 8 "solid" "black")
                     (rectangle 27 6 "solid" "red")
                     (rectangle 30 8 "solid" "black")))
(define TANK (above (rectangle 5 8 "solid" "black")
                    (rectangle 15 6 "solid" "darkolivegreen")
                    (add-line (rectangle 25 8 "solid" "darkolivegreen")
                              2 5 23 5 
                              (make-pen "black" 3 "solid" "round" "round")
                              )))
(define MISSILE (isosceles-triangle 25 20 "solid" "red"))
(define BACKGROUND
  (place-image TREE (- WIDTH 35) (- HEIGHT (/ (image-height TREE) 2))
               (place-image SUN 35 35 EMPTY_SCENE)))
(define INITIAL_SCENE
  (place-image TANK 15 (- HEIGHT (/ (image-height TANK) 2))
               (place-image UFO (/ WIDTH 2) (image-height UFO) BACKGROUND)))


;; 1c. FUNCTION WISH LIST
;; NAME: tank-render
;; SIGNATURE: Tank Image -> Image
;; PURPOSE STATEMENT: Adds t to the given image im.
;(define (tank-render t im) im)
;; NAME: ufo-render 
;; SIGNATURE: UFO Image -> Image 
;; PURPOSE STATEMENT: Adds u to the given image im.
;(define (ufo-render u im) im)
;; NAME: missile-render
;; SIGNATURE: Missile Image -> Image 
;; PURPOSE STATEMENT: Adds m to the given image im.
;(define (missile-render m im) im)


;; 2a. FUNCTION SIGNATURE: Missile Image -> Image
;; 2b. PURPOSE STATEMENT: Adds u to the given image im.
;; 2c. HEADER
#;(define (missile-render m im) EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (missile-render (make-posn (/ WIDTH 2) (/ HEIGHT 2)) BACKGROUND)
              (place-image MISSILE (/ WIDTH 2) (/ HEIGHT 2) BACKGROUND))
(check-expect (missile-render (make-posn 0 0) BACKGROUND)
              (place-image MISSILE 0 0 BACKGROUND))
(check-expect (missile-render (make-posn WIDTH HEIGHT) BACKGROUND)
              (place-image MISSILE WIDTH (- HEIGHT (image-height TANK))
                           BACKGROUND))
(check-expect (missile-render
               (make-posn WIDTH (- HEIGHT (image-height TANK))) BACKGROUND)
              (place-image
               MISSILE WIDTH (- HEIGHT (image-height TANK)) BACKGROUND))
(check-expect (missile-render (make-posn
                               WIDTH (+ 1 (- HEIGHT (image-height TANK))
                                        )) BACKGROUND)
              (place-image MISSILE WIDTH (- HEIGHT (image-height TANK))
                           BACKGROUND))
;; 4. TEMPLATE
#;(define (missile-render m im)
    (cond
      [(> (posn-y m) (- HEIGHT (image-height TANK)))
       (... (posn-x m) ... (posn-y m) ... im ...)]
      [else (... (posn-x m) ... (posn-y m) ... im ...)]
      )
    )
;; 5. CODE
(define (missile-render m im)
  (cond
    [(> (posn-y m) (- HEIGHT (image-height TANK)))
     (place-image MISSILE (posn-x m) (- HEIGHT (image-height TANK)) im)]
    [else (place-image MISSILE (posn-x m) (posn-y m) im)]
    )
  )


;; 2a. FUNCTION SIGNATURE: UFO Image -> Image
;; 2b. PURPOSE STATEMENT: Adds u to the given image im.
;; 2c. HEADER
#;(define (ufo-render u im) EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (ufo-render (make-posn (/ WIDTH 2) (/ HEIGHT 2)) BACKGROUND)
              (place-image UFO (/ WIDTH 2) (/ HEIGHT 2) BACKGROUND))
(check-expect (ufo-render (make-posn 0 0) BACKGROUND)
              (place-image UFO 0 0 BACKGROUND))
(check-expect (ufo-render (make-posn WIDTH HEIGHT) BACKGROUND)
              (place-image UFO WIDTH (- HEIGHT (/ (image-height UFO) 2))
                           BACKGROUND))
(check-expect (ufo-render (make-posn WIDTH
                                     (- HEIGHT (/ (image-height UFO) 2)))
                          BACKGROUND)
              (place-image UFO WIDTH (- HEIGHT (/ (image-height UFO) 2))
                           BACKGROUND))
(check-expect (ufo-render (make-posn
                           WIDTH
                           (+ 1 (- HEIGHT (/ (image-height UFO) 2))))
                          BACKGROUND)
              (place-image UFO WIDTH (- HEIGHT (/ (image-height UFO) 2))
                           BACKGROUND))
;; 4. TEMPLATE
#;(define (ufo-render u im)
    (cond
      [(> (posn-y u) (- HEIGHT (/ (image-height UFO) 2)))
       (... (posn-x u) ... (posn-y u) ... im ...)]
      [else (... (posn-x u) ... (posn-y u) ... im ...)]
      ))
;; 5. CODE
(define (ufo-render u im)
  (cond
    [(> (posn-y u) (- HEIGHT (/ (image-height UFO) 2)))
     (place-image UFO (posn-x u) (- HEIGHT (/ (image-height UFO) 2)) im)]
    [else (place-image UFO (posn-x u) (posn-y u) im)]
    ))

  
;; 2a. FUNCTION SIGNATURE: Tank Image -> Image
;; 2b. PURPOSE STATEMENT: Adds t to the given image im.
;; 2c. HEADER
#; (define (tank-render t im) EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (tank-render (make-tank (/ WIDTH 2) 3) BACKGROUND)
              (place-image TANK
                           (/ WIDTH 2) (- HEIGHT (/ (image-height TANK) 2))
                           BACKGROUND))
(check-expect (tank-render (make-tank 0 3) BACKGROUND)
              (place-image TANK
                           0 (- HEIGHT (/ (image-height TANK) 2))
                           BACKGROUND))
(check-expect (tank-render (make-tank WIDTH 3) BACKGROUND)
              (place-image TANK
                           WIDTH (- HEIGHT (/ (image-height TANK) 2))
                           BACKGROUND))
(check-expect (tank-render (make-tank
                            (- 0 (/ (image-width TANK) 2)) 3) BACKGROUND)
              BACKGROUND)
(check-expect (tank-render (make-tank
                            (+ WIDTH (/ (image-width TANK) 2)) 3) BACKGROUND)
              BACKGROUND)
;; 4. TEMPLATE
#; (define (tank-render t im)
     ( ... (tank-loc t) ... (tank-vel t) ... im ...))
;; 5. CODE
(define (tank-render t im)
  (place-image TANK (tank-loc t) (- HEIGHT (/ (image-height TANK) 2)) im))


;; 2a. FUNCTION SIGNATURE: SIGS -> Image
;; 2b. PURPOSE STATEMENT: Adds TANK, UFO, and possibly MISSILE to the
;; BACKGROUND
;; scene.
;; 2c. HEADER
#;(define (si-render s) BACKGROUND)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (si-render (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (place-image TANK 28 (- HEIGHT (/ (image-height TANK) 2))
                           (place-image UFO 20 10 BACKGROUND)))
(check-expect (si-render (make-fired
                          (make-posn 20 10)
                          (make-tank 28 -3)
                          (make-posn 28 (- HEIGHT (image-height TANK)))))
              (place-image TANK 28 (- HEIGHT (/ (image-height TANK) 2))
                           (place-image UFO 20 10
                                        (place-image
                                         MISSILE
                                         28 (- HEIGHT (image-height TANK))
                                         BACKGROUND))))
(check-expect (si-render (make-fired (make-posn 20 100)
                                     (make-tank 100 3)
                                     (make-posn 22 103)) )
              (place-image TANK 100 (- HEIGHT (/ (image-height TANK) 2))
                           (place-image UFO 20 100
                                        (place-image MISSILE 22 103
                                                     BACKGROUND))))
;; 4. TEMPLATE
#;(define (si-render s)
    (cond
      [(aim? s) (... (aim-tank s) ... (aim-ufo s) ...)]
      [(fired? s) (... (fired-tank s) ...
                       (fired-ufo s) ...
                       (fired-missile s) ...)]))
;; 5. CODE
(define (si-render s)
  (cond
    [(aim? s) (tank-render (aim-tank s) (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s) (tank-render (fired-tank s)
                             (ufo-render (fired-ufo s)
                                         (missile-render (fired-missile s)
                                                         BACKGROUND)))]
    )
  )

;; 2a. FUNCTION SIGNATURE: SIGS -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a SIGS and returns true if the UFO lands or
;; if the missile hits the UFO.
;; 2c. HEADER
#;(define (si-game-over s) false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (si-game-over (make-aim (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                      (make-tank (/ WIDTH 2) -3))) false)
(check-expect (si-game-over
               (make-aim (make-posn (/ WIDTH 2)
                                    (- HEIGHT (/ (image-height UFO) 2) 1))
                         (make-tank 10 -3)))
              false)
(check-expect (si-game-over
               (make-aim (make-posn (/ WIDTH 2)
                                    (- HEIGHT (/ (image-height UFO) 2)))
                         (make-tank 10 -3)))
              true)
(check-expect (si-game-over
               (make-aim (make-posn (/ WIDTH 2)
                                    (+ 1 (- HEIGHT (/ (image-height UFO) 2))))
                         (make-tank 10 -3)))
              true)

(check-expect
 (si-game-over 
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn  (/ WIDTH 2) (/ HEIGHT 2))))
 true)
(check-expect
 (si-game-over
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (/ WIDTH 2)
    (+ (/ HEIGHT 2) (/ (image-height UFO) 2) (/ (image-height MISSILE) 2)))))
 true)
(check-expect
 (si-game-over
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (/ WIDTH 2)
    (- (+ (/ HEIGHT 2) (/ (image-height UFO) 2) (/ (image-height MISSILE) 2))
       1))))
 true)
(check-expect
 (si-game-over
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (/ WIDTH 2)
    (+ 1 (/ HEIGHT 2) (/ (image-height UFO) 2) (/ (image-height MISSILE) 2)))))
 false)
(check-expect
 (si-game-over
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (- (/ WIDTH 2) (/ (image-width UFO) 2) (/ (image-width MISSILE) 2))
    (/ HEIGHT 2))))
 true)
(check-expect
 (si-game-over
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (- (/ WIDTH 2) (/ (image-width UFO) 2) (/ (image-width MISSILE) 2) 1)
    (/ HEIGHT 2))))
 false)
(check-expect
 (si-game-over
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (+ 1 (/ WIDTH 2) (/ (image-width UFO) 2) (/ (image-width MISSILE) 2))
    (/ HEIGHT 2))))
 true)
(check-expect
 (si-game-over
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (+ (/ WIDTH 2) (/ (image-width UFO) 2) (/ (image-width MISSILE) 2))
    (/ HEIGHT 2))))
 true)
(check-expect
 (si-game-over
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (+ 1 (/ WIDTH 2) (/ (image-width UFO) 2) (/ (image-width MISSILE) 2))
    (/ HEIGHT 2))))
 false)
(check-expect
 (si-game-over
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (- (+ (/ WIDTH 2) (/ (image-width UFO) 2) (/ (image-width MISSILE) 2)) 1)
    (/ HEIGHT 2))))
 true)
;; 4. TEMPLATE
#;(define (si-game-over s)
    (cond
      [(aim? s) (... (aim-tank s) ... (aim-ufo s) ...)]
      [(fired? s) (... (fired-tank s) ...
                       (fired-ufo s) ...
                       (fired-missile s) ...)]))
;; 5. CODE
(define (si-game-over s)
  (cond
    [(aim? s) (>= (posn-y (aim-ufo s)) (- HEIGHT (/ (image-height UFO) 2)))]
    [(fired? s) false]))
