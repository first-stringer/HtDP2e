;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-99) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
(define GAME_OVER_TEXT_FONT_SIZE 12)
(define GAME_OVER_TEXT_LOSING "GAME OVER. YOU LOSE!")
(define GAME_OVER_TEXT_LOSING_COLOR "red")
(define GAME_OVER_TEXT_WINNING "GAME OVER. YOU WIN!")
(define GAME_OVER_TEXT_WINNING_COLOR "green")
(define UFO_SPEED 2)
(define TANK_SPEED 3)
(define MISSILE_SPEED 5)


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
;; NAME: missile-hit?
;; SIGNATURE: UFO Missile -> Boolean
;; PURPOSE STATEMENT: Consumes a UFO and a Missile and returns true if the
;; Missile is close enough to the UFO to hit it.
;; NAME: si-render-final
;; SIGNATURE: SIGS -> Image
;; PURPOSE STATEMENT: Consumes a SIGS and displays "GAME OVER. YOU LOSE!" if the
;; UFO landed else it displays "GAME OVER. YOU WIN!" if a missile hit the UFO.


;; 2a. FUNCTION SIGNATURE: SIGS Number -> SIGS 
;; 2b. PURPOSE STATEMENT: Moves the UFO predictably by delta times UFO_SPEED and
;; the TANK by TANK_SPEED and the MISSILE by MISSILE_SPEED.
;; (d).
;; 2c. HEADER
#;(define (si-move-proper s d) s)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; test for not-fired, delta 1, UFO at center
(check-expect (si-move-proper (make-aim (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                        (make-tank (/ WIDTH 2) 1)) 1)
              (make-aim (make-posn (+ (/ WIDTH 2) UFO_SPEED)
                                   (+ (/ HEIGHT 2) UFO_SPEED))
                        (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)))
;; test for not-fired, delta -1, UFO at center
(check-expect (si-move-proper (make-aim (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                        (make-tank (/ WIDTH 2) 1)) -1)
              (make-aim (make-posn (- (/ WIDTH 2) UFO_SPEED)
                                   (+ (/ HEIGHT 2) UFO_SPEED))
                        (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)))
;; test for not-fired, delta 1, UFO at right edge
;; test for not-fired, delta -1, UFO at left edge
;; test for not-fired, delta 1, UFO at center landed
;; test for fired, delta 1, UFO at center
(check-expect (si-move-proper (make-fired
                               (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                               (make-tank (/ WIDTH 2) 1)
                               (make-posn (/ WIDTH 2)
                                          (- HEIGHT (image-height TANK))))
                              1)
              (make-fired (make-posn (+ (/ WIDTH 2) UFO_SPEED)
                                     (+ (/ HEIGHT 2) UFO_SPEED))
                          (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)
                          (make-posn
                           (/ WIDTH 2)
                           (- HEIGHT (image-height TANK) MISSILE_SPEED))))
;; test for fired, delta -1, UFO at center
(check-expect (si-move-proper (make-fired
                               (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                               (make-tank (/ WIDTH 2) 1)
                               (make-posn (/ WIDTH 2)
                                          (- HEIGHT (image-height TANK))))
                              -1)
              (make-fired (make-posn (- (/ WIDTH 2) UFO_SPEED)
                                     (+ (/ HEIGHT 2) UFO_SPEED))
                          (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)
                          (make-posn
                           (/ WIDTH 2)
                           (- HEIGHT (image-height TANK) MISSILE_SPEED))))
;; test for fired, delta 1, UFO at right edge
(check-expect (si-move-proper (make-fired
                               (make-posn WIDTH (/ HEIGHT 2))
                               (make-tank (/ WIDTH 2) 1)
                               (make-posn (/ WIDTH 2)
                                          (- HEIGHT (image-height TANK))))
                              1)
              (make-fired (make-posn WIDTH (+ (/ HEIGHT 2) UFO_SPEED))
                          (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)
                          (make-posn
                           (/ WIDTH 2)
                           (- HEIGHT (image-height TANK) MISSILE_SPEED))))
;; test for fired, delta -1, UFO at left edge
(check-expect (si-move-proper (make-fired
                               (make-posn 0 (/ HEIGHT 2))
                               (make-tank (/ WIDTH 2) 1)
                               (make-posn (/ WIDTH 2)
                                          (- HEIGHT (image-height TANK))))
                              -1)
              (make-fired (make-posn 0 (+ (/ HEIGHT 2) UFO_SPEED))
                          (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)
                          (make-posn
                           (/ WIDTH 2)
                           (- HEIGHT (image-height TANK) MISSILE_SPEED))))
;; test for fired, delta 1, UFO at center landed
(check-expect (si-move-proper (make-fired
                               (make-posn (/ WIDTH 2)
                                          (- HEIGHT (/ (image-height UFO) 2)))
                               (make-tank (/ WIDTH 2) 1)
                               (make-posn (/ WIDTH 2)
                                          (- HEIGHT (image-height TANK))))
                              1)
              (make-fired (make-posn (/ WIDTH 2)
                                     (- HEIGHT (/ (image-height UFO) 2)))
                          (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)
                          (make-posn
                           (/ WIDTH 2)
                           (- HEIGHT (image-height TANK) MISSILE_SPEED))))
;; 4. TEMPLATE
(define (si-move-proper s d)
  (cond
    [(aim? s) (... (aim-tank s) ... (aim-ufo s) ... d ...)]
    [(fired? s) (... (fired-tank s) ... (fired-ufo s) ... d 
                     ... (fired-missile s) ...)]))
;; 5. CODE




;; 2a. FUNCTION SIGNATURE: SIGS -> Image
;; 2b. PURPOSE STATEMENT: Consumes a SIGS and displays "GAME OVER. YOU LOSE!" if
;; the UFO landed else it displays "GAME OVER. YOU WIN!" if a missile hit the
;; UFO.
;; 2c. HEADER
#;(define (si-render-final s) EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; test no missile fired loss
(check-expect (si-render-final (make-aim (make-posn
                                          (/ WIDTH 4)
                                          (- HEIGHT (/ (image-height UFO) 2)))
                                         (make-tank (/ WIDTH 2) 3)))
              (place-image (text GAME_OVER_TEXT_LOSING GAME_OVER_TEXT_FONT_SIZE
                                 GAME_OVER_TEXT_LOSING_COLOR)
                           (/ WIDTH 2) (/ HEIGHT 2)
                           (si-render
                            (make-aim
                             (make-posn (/ WIDTH 4)
                                        (- HEIGHT (/ (image-height UFO) 2)))
                             (make-tank (/ WIDTH 2) 3)))))
;; test missile hit win
(check-expect (si-render-final
               (make-fired
                (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
                (make-posn (/ WIDTH 2)
                           (floor (+ (/ HEIGHT 2) (/ (image-height UFO) 2)
                                     (/ (image-height MISSILE) 2))))))
              (place-image (text GAME_OVER_TEXT_WINNING GAME_OVER_TEXT_FONT_SIZE
                                 GAME_OVER_TEXT_WINNING_COLOR)
                           (/ WIDTH 2) (/ HEIGHT 2)
                           (si-render
                            (make-fired
                             (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                             (make-tank (/ WIDTH 2) 3)
                             (make-posn
                              (/ WIDTH 2)
                              (floor
                               (+ (/ HEIGHT 2) (/ (image-height UFO) 2)
                                  (/ (image-height MISSILE) 2))))))))
;; test missile fired loss
(check-expect (si-render-final
               (make-fired
                (make-posn (/ WIDTH 4) (- HEIGHT (/ (image-height UFO) 2)))
                (make-tank (/ WIDTH 2) 3)
                (make-posn (/ WIDTH 2)
                           (floor (+ (/ HEIGHT 2) (/ (image-height UFO) 2)
                                     (/ (image-height MISSILE) 2))))))
              (place-image (text GAME_OVER_TEXT_LOSING GAME_OVER_TEXT_FONT_SIZE
                                 GAME_OVER_TEXT_LOSING_COLOR)
                           (/ WIDTH 2) (/ HEIGHT 2)
                           (si-render
                            (make-fired
                             (make-posn (/ WIDTH 4)
                                        (- HEIGHT (/ (image-height UFO) 2)))
                             (make-tank (/ WIDTH 2) 3)
                             (make-posn
                              (/ WIDTH 2)
                              (floor
                               (+ (/ HEIGHT 2) (/ (image-height UFO) 2)
                                  (/ (image-height MISSILE) 2))))))))
;; 4. TEMPLATE
#;(define (si-render-final s)
    (cond
      [(and (fired? s) (missile-hit? (fired-ufo s) (fired-missile s)))
       (... s ...)]
      [else (... s ...) ]
      )
    )
;; 5. CODE
(define (si-render-final s)
  (cond
    [(and (fired? s) (missile-hit? (fired-ufo s) (fired-missile s)))
     (place-image (text GAME_OVER_TEXT_WINNING GAME_OVER_TEXT_FONT_SIZE
                        GAME_OVER_TEXT_WINNING_COLOR)
                  (/ WIDTH 2) (/ HEIGHT 2)
                  (si-render s))]
    [else (place-image (text GAME_OVER_TEXT_LOSING GAME_OVER_TEXT_FONT_SIZE
                             GAME_OVER_TEXT_LOSING_COLOR)
                       (/ WIDTH 2) (/ HEIGHT 2)
                       (si-render s))]))


;; 2a. FUNCTION SIGNATURE: UFO Missile -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a UFO and a Missile and returns true if the
;; Missile is close enough to the UFO to hit it.
;; 2c. HEADER
#;(define (missile-hit? u m) false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; easy case
(check-expect (missile-hit? (make-posn 100 100) (make-posn 100 100)) true)
;; check verticals
;; bottom checks
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn 100 (+ 100 (floor (+ (/ (image-height UFO) 2)
                                               (/ (image-height MISSILE) 2))))))
              true)
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn 100 (+ 101 (floor (+ (/ (image-height UFO) 2)
                                               (/ (image-height MISSILE) 2))))))
              false)
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn 100 (+ 99 (floor (+ (/ (image-height UFO) 2)
                                              (/ (image-height MISSILE) 2))))))
              true)
;; top checks
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn 100 (- 100 (floor (+ (/ (image-height UFO) 2)
                                               (/ (image-height MISSILE) 2))))))
              true)
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn 100 (- 99 (floor (+ (/ (image-height UFO) 2)
                                              (/ (image-height MISSILE) 2))))))
              false)
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn 100 (- 101 (floor (+ (/ (image-height UFO) 2)
                                               (/ (image-height MISSILE) 2))))))
              true)
;; check horizontals
;; check left side
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn (- 100 (floor (+ (/ (image-width UFO) 2)
                                           (/ (image-width MISSILE) 2))))
                          100))
              true)
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn (- 99 (floor (+ (/ (image-width UFO) 2)
                                          (/ (image-width MISSILE) 2))))
                          100))
              false)
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn (- 101 (floor (+ (/ (image-width UFO) 2)
                                           (/ (image-width MISSILE) 2))))
                          100))
              true)
;; check right side
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn (+ 100 (floor (+ (/ (image-width UFO) 2)
                                           (/ (image-width MISSILE) 2))))
                          100))
              true)
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn (+ 101 (floor (+ (/ (image-width UFO) 2)
                                           (/ (image-width MISSILE) 2))))
                          100))
              false)
(check-expect (missile-hit?
               (make-posn 100 100)
               (make-posn (+ 99 (floor (+ (/ (image-width UFO) 2)
                                          (/ (image-width MISSILE) 2))))
                          100))
              true)
;; 4. TEMPLATE
#;(define (missile-hit? u m)
    (... (posn-x u) ... (posn-y u) ... (posn-x m) ... (posn-y m) ...))
;; 5. CODE
(define (missile-hit? u m)
  (and (<= (posn-y m) (+ (posn-y u) (floor (+ (/ (image-height UFO) 2)
                                              (/ (image-height MISSILE) 2)))))
       (>= (posn-y m) (- (posn-y u) (floor (+ (/ (image-height UFO) 2)
                                              (/ (image-height MISSILE) 2)))))
       (>= (posn-x m) (- (posn-x u) (floor (+ (/ (image-width UFO) 2)
                                              (/ (image-width MISSILE) 2)))))
       (<= (posn-x m) (+ (posn-x u) (floor (+ (/ (image-width UFO) 2)
                                              (/ (image-width MISSILE) 2)))))       
       )
  )


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
               (make-aim (make-posn
                          (/ WIDTH 2)
                          (floor (- HEIGHT (/ (image-height UFO) 2))))
                         (make-tank 10 -3))) true)
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
    (floor
     (+ (/ HEIGHT 2) (/ (image-height UFO) 2) (/ (image-height MISSILE) 2))))))
 true)
(check-expect
 (si-game-over
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (/ WIDTH 2)
    (+ 1 (floor (+ (/ HEIGHT 2)
                   (/ (image-height UFO) 2)
                   (/ (image-height MISSILE) 2)))))))
 false)
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
    [(fired? s) (missile-hit? (fired-ufo s) (fired-missile s))]
    )
  )
