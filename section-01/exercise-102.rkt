;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-102) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
; #4: A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game
(define-struct sigs [ufo tank missile])
; #5: A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location.


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
;; NAME: move-ufo
;; SIGNATURE: UFO Number -> UFO
;; PURPOSE STATEMENT: Consumes a UFO and a number.  Updates the UFO's y-crd by
;; UFO_SPEED and the UFO's x-crd by UFO_SPEED times Number (delta).  If UFO is at
;; either edge the x-crd is not updated. If the UFO has landed the UFO is not
;; updated.
;; NAME: move-tank
;; SIGNATURE: Tank -> Tank
;; PURPOSE STATEMENT: Updates the tanks's x-crd by TANK_SPEED times the tank's
;; velocity.
;; NAME: move-missile
;; SIGNATURE: Missile -> Missile
;; PURPOSE STATEMENT: Updates the missile's y-crd by subtracting MISSILE_SPEED
;; from it.
;; NAME: random-positive-or-negative-one
;; SIGNATURE: -> Number (-1 or 1)
;; PURPOSE STATEMENT: Ramdomly returns a -1 or 1.


;; 2a. FUNCTION SIGNATURE: -> Number (-1 or 1)
;; 2b. PURPOSE STATEMENT: Ramdomly returns a -1 or 1.
;; 2c. HEADER
#;(define (random-positive-or-negative-one n) 0)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; define t helper function for tests
(define (t n) (or (eq? n -1) (eq? n 1)))
(check-satisfied (random-positive-or-negative-one 2) t)
(check-satisfied (random-positive-or-negative-one 2) t)
(check-satisfied (random-positive-or-negative-one 2) t)
(check-satisfied (random-positive-or-negative-one 2) t)
;; 4. TEMPLATE
#;(define (random-positive-or-negative-one n)
    ( ... n ... random ...))
;; 5. CODE
(define (random-positive-or-negative-one n)
  (if (eq? (random n) 1) 1 -1))


;; 2a. FUNCTION SIGNATURE: Missile -> Missile
;; 2b. PURPOSE STATEMENT: Updates the missile's y-crd by subtracting
;; MISSILE_SPEED from it.
;; 2c. HEADER
#;(define (move-missile m) m)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (move-missile (make-posn (/ WIDTH 2) (/ HEIGHT 2)))
              (make-posn (/ WIDTH 2) (- (/ HEIGHT 2) MISSILE_SPEED)))
;; 4. TEMPLATE
#;(define (move-missile m)
    (... (posn-x m) ... (posn-y m) ... MISSILE_SPEED ...))
;; 5. CODE
(define (move-missile m)
  (make-posn (posn-x m) (- (posn-y m) MISSILE_SPEED)))


;; 2a. FUNCTION SIGNATURE: Tank -> Tank
;; 2b. PURPOSE STATEMENT: Updates the tanks's x-crd by TANK_SPEED times the
;; tank's velocity. The tank's x-crd is not updated to fall below 0 nor to exceed
;; WIDTH.
;; 2c. HEADER
#;(define (move-tank t) t)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; move right
(check-expect (move-tank (make-tank (/ WIDTH 2) 1))
              (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1))
;; move left
(check-expect (move-tank (make-tank (/ WIDTH 2) -1))
              (make-tank (- (/ WIDTH 2) TANK_SPEED) -1))
;; no move left because at left edge
(check-expect (move-tank (make-tank (/ (image-width TANK) 2) -1))
              (make-tank (/ (image-width TANK) 2) -1))
;; only move left to the very edge
(check-expect (move-tank (make-tank (add1 (/ (image-width TANK) 2)) -1))
              (make-tank (/ (image-width TANK) 2) -1))
;; no move right because at the right edge
(check-expect (move-tank (make-tank (- WIDTH (/ (image-width TANK) 2)) 1))
              (make-tank (- WIDTH (/ (image-width TANK) 2)) 1))
;; only move right to the very edge
(check-expect (move-tank (make-tank (- WIDTH (/ (image-width TANK) 2) 1) 1))
              (make-tank (- WIDTH (/ (image-width TANK) 2)) 1))
;; 4. TEMPLATE
#;(define (move-tank t)
    (... (tank-loc t) ... TANK_SPEED ... (tank-vel t) ...))
;; 5. CODE
(define (move-tank t)
  (cond
    [(>= (+ (tank-loc t) (* TANK_SPEED (tank-vel t)))
         (- WIDTH (/ (image-width TANK) 2)))
     (make-tank (- WIDTH (/ (image-width TANK) 2)) (tank-vel t))]
    [(<= (+ (tank-loc t) (* TANK_SPEED (tank-vel t)))
         (/ (image-width TANK) 2))
     (make-tank (/ (image-width TANK) 2) (tank-vel t))]
    [else (make-tank (+ (tank-loc t) (* TANK_SPEED (tank-vel t))) (tank-vel t))]
    )
  )


;; 2a. FUNCTION SIGNATURE: UFO Number -> UFO
;; 2b. PURPOSE STATEMENT: Consumes a UFO and a number.  Updates the UFO's y-crd
;; by UFO_SPEED and the UFO's x-crd by UFO_SPEED times Number (delta).  If UFO is
;; at either edge the x-crd is not updated. If the UFO has landed the UFO is not
;; updated.
;; 2c. HEADER
#;(define (move-ufo u d) u)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; move right
(check-expect (move-ufo (make-posn (/ WIDTH 2) (/ HEIGHT 2)) 1)
              (make-posn (+ (/ WIDTH 2) (* 1 UFO_SPEED))
                         (+ UFO_SPEED (/ HEIGHT 2))))
;; move left
(check-expect (move-ufo (make-posn (/ WIDTH 2) (/ HEIGHT 2)) -1)
              (make-posn (+ (/ WIDTH 2) (* -1 UFO_SPEED))
                         (+ UFO_SPEED (/ HEIGHT 2))))
;; no move when landed
(check-expect (move-ufo (make-posn (/ WIDTH 2)
                                   (- HEIGHT (/ (image-height UFO) 2))) 1)
              (make-posn (/ WIDTH 2) (- HEIGHT (/ (image-height UFO) 2))))
;; no move right or left when landing
(check-expect (move-ufo (make-posn (/ WIDTH 2)
                                   (- HEIGHT (/ (image-height UFO) 2) 1)) 1)
              (make-posn (/ WIDTH 2) (- HEIGHT (/ (image-height UFO) 2))))
;; no move left when at left edge
(check-expect (move-ufo (make-posn (/ (image-width UFO) 2) (/ HEIGHT 2)) -1)
              (make-posn (/ (image-width UFO) 2) (+ UFO_SPEED (/ HEIGHT 2))))
;; no move beyond left edge
(check-expect (move-ufo (make-posn (add1 (/ (image-width UFO) 2))
                                   (/ HEIGHT 2)) -1)
              (make-posn (/ (image-width UFO) 2) (+ UFO_SPEED (/ HEIGHT 2))))
;; no move right when at right edge
(check-expect (move-ufo (make-posn (- WIDTH (/ (image-width UFO) 2))
                                   (/ HEIGHT 2)) 1)
              (make-posn (- WIDTH (/ (image-width UFO) 2))
                         (+ UFO_SPEED (/ HEIGHT 2))))
;; no move beyond right edge
(check-expect (move-ufo (make-posn (- WIDTH (/ (image-width UFO) 2) 1)
                                   (/ HEIGHT 2)) 1)
              (make-posn (- WIDTH (/ (image-width UFO) 2))
                         (+ UFO_SPEED (/ HEIGHT 2))))
;; 4. TEMPLATE
#;(define (move-ufo u d)
    (... (posn-x u) ... (posn-y u) ... d ...))
;; 5. CODE
(define (move-ufo u d)
  (cond
    [(>= (+ (posn-y u) UFO_SPEED) (- HEIGHT (/ (image-height UFO) 2)))
     (make-posn (posn-x u) (- HEIGHT (/ (image-height UFO) 2)))]
    [(<= (+ (posn-x u) (* d UFO_SPEED)) (/ (image-width UFO) 2))
     (make-posn (/ (image-width UFO) 2) (+ (posn-y u) UFO_SPEED))]
    [(>= (+ (posn-x u) (* d UFO_SPEED)) (- WIDTH (/ (image-width UFO) 2)))
     (make-posn (- WIDTH (/ (image-width UFO) 2)) (+ (posn-y u) UFO_SPEED))]
    [else (make-posn (+ (posn-x u) (* d UFO_SPEED)) (+ UFO_SPEED (posn-y u)))]
    )
  )


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
                               (make-posn (- WIDTH (/ (image-width UFO) 2))
                                          (/ HEIGHT 2))
                               (make-tank (/ WIDTH 2) 1)
                               (make-posn (/ WIDTH 2)
                                          (- HEIGHT (image-height TANK))))
                              1)
              (make-fired (make-posn (- WIDTH (/ (image-width UFO) 2))
                                     (+ (/ HEIGHT 2) UFO_SPEED))
                          (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)
                          (make-posn
                           (/ WIDTH 2)
                           (- HEIGHT (image-height TANK) MISSILE_SPEED))))
;; test for fired, delta -1, UFO at left edge
(check-expect (si-move-proper (make-fired
                               (make-posn (/ (image-width UFO) 2) (/ HEIGHT 2))
                               (make-tank (/ WIDTH 2) 1)
                               (make-posn (/ WIDTH 2)
                                          (- HEIGHT (image-height TANK))))
                              -1)
              (make-fired (make-posn (/ (image-width UFO) 2) (+ (/ HEIGHT 2) UFO_SPEED))
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
#;(define (si-move-proper s d)
    (cond
      [(aim? s) (... (aim-ufo s) ... d ... (aim-tank s) ...)]
      [(fired? s) (... (fired-ufo s) ... d ... (fired-tank s) ...
                       (fired-missile s) ...)]))
;; 5. CODE
(define (si-move-proper s d)
  (cond
    [(aim? s) (make-aim (move-ufo (aim-ufo s) d) (move-tank (aim-tank s)))]
    [(fired? s) (make-fired (move-ufo (fired-ufo s) d)
                            (move-tank (fired-tank s))
                            (move-missile (fired-missile s))
                            )]))


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
#;(define (si-game-over? s) false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (si-game-over? (make-aim (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                       (make-tank (/ WIDTH 2) -3))) false)
(check-expect (si-game-over?
               (make-aim (make-posn
                          (/ WIDTH 2)
                          (floor (- HEIGHT (/ (image-height UFO) 2))))
                         (make-tank 10 -3))) true)
(check-expect
 (si-game-over? 
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn  (/ WIDTH 2) (/ HEIGHT 2))))
 true)
(check-expect
 (si-game-over?
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (/ WIDTH 2)
    (floor
     (+ (/ HEIGHT 2) (/ (image-height UFO) 2) (/ (image-height MISSILE) 2))))))
 true)
;; test fire and miss scenario
(check-expect
 (si-game-over?
  (make-fired
   (make-posn (/ WIDTH 4) (floor (- HEIGHT (/ (image-height UFO) 2))))
   (make-tank (/ WIDTH 2) 3)
   (make-posn
    (/ WIDTH 2)
    (floor
     (+ (/ HEIGHT 2) (/ (image-height UFO) 2) (/ (image-height MISSILE) 2))))))
 true)
(check-expect
 (si-game-over?
  (make-fired
   (make-posn (/ WIDTH 2) (/ HEIGHT 2)) (make-tank (/ WIDTH 2) 3)
   (make-posn
    (/ WIDTH 2)
    (+ 1 (floor (+ (/ HEIGHT 2)
                   (/ (image-height UFO) 2)
                   (/ (image-height MISSILE) 2)))))))
 false)
;; 4. TEMPLATE
#;(define (si-game-over? s)
    (cond
      [(aim? s) (... (aim-tank s) ... (aim-ufo s) ...)]
      [(fired? s) (... (fired-tank s) ...
                       (fired-ufo s) ...
                       (fired-missile s) ...)]))
;; 5. CODE
(define (si-game-over? s)
  (cond
    [(aim? s) (>= (posn-y (aim-ufo s)) (- HEIGHT (/ (image-height UFO) 2)))]
    [(fired? s)
     (or (missile-hit? (fired-ufo s) (fired-missile s))
         (>= (posn-y (fired-ufo s)) (- HEIGHT (/ (image-height UFO) 2))))]
    )
  )


;; 2a. FUNCTION SIGNATURE: SIGS -> SIGS
;; 2b. PURPOSE STATEMENT: This function is called for every clock tick to
;; determine to which position the objects move now. Accordingly it consumes an
;; element of SIGS and produces another one. Moving the tank and the missile
;; (if any) is relatively straightforward. They move in straight lines at a
;; constant speed. Moving the UFO calls for small random jumps to the left or the
;; right. 
;; 2c. HEADER
#;(define (si-move s) s)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; NA due to random function use.
;; 4. TEMPLATE
#;(define (si-move s)
    (si-move-proper ... s ... (random ...)))
;; 5. CODE
(define (si-move s)
  (si-move-proper s (random-positive-or-negative-one 2)))


;; 2a. FUNCTION SIGNATURE: SIGS KeyEvent -> SIGS
;; 2b. PURPOSE STATEMENT: The key event handler. It consumes a game state and a
;; KeyEvent and produces a new game state. It reacts to three different keys: 1)
;; pressing the left arrow ensures that the tank moves left; 2) pressing the
;; right arrow ensures that the tank moves right; and 3) pressing the space bar
;; fires the missile if it hasn’t been launched yet.
;; 2c. HEADER
#;(define (si-control s ke) s)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; change tank direction (left) when not yet fired (aim)
(check-expect (si-control (make-aim (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                    (make-tank (/ WIDTH 2) 1)) "left")
              (make-aim (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                        (make-tank (/ WIDTH 2) -1))) 
;; change tank direction (right) when not yet fired (aim)
(check-expect (si-control (make-aim (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                    (make-tank (/ WIDTH 2) -1)) "right")
              (make-aim (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                        (make-tank (/ WIDTH 2) 1)))
;; change tank direction (left) when fired (fired)
(check-expect (si-control (make-fired (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                      (make-tank (/ WIDTH 2) 1)
                                      (make-posn
                                       (/ WIDTH 2)
                                       (- HEIGHT (/ (image-height TANK) 2))))
                          "left")
              (make-fired (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                          (make-tank (/ WIDTH 2) -1)
                          (make-posn
                           (/ WIDTH 2)
                           (- HEIGHT (/ (image-height TANK) 2)))))
;; change tank direction (right) when fired (fired)
(check-expect (si-control (make-fired (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                      (make-tank (/ WIDTH 2) -1)
                                      (make-posn
                                       (/ WIDTH 2)
                                       (- HEIGHT (/ (image-height TANK) 2))))
                          "right")
              (make-fired (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                          (make-tank (/ WIDTH 2) 1)
                          (make-posn
                           (/ WIDTH 2)
                           (- HEIGHT (/ (image-height TANK) 2)))))
;; fire missile (aim)
(check-expect (si-control (make-aim (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                    (make-tank (/ WIDTH 2) 1)) " ")
              (make-fired (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                          (make-tank (/ WIDTH 2) 1)
                          (make-posn
                           (/ WIDTH 2)
                           (- HEIGHT (/ (image-height TANK) 2)))))
;; 4. TEMPLATE
#;(define (si-control s ke)
    (cond
      [(and (aim? s) (or (key=? ke "left") (key=? ke "right"))) (... s ...)] 
      [(and (fired? s) (or (key=? ke "left") (key=? ke "right"))) (... s ...)] 
      [(and (aim? s) (key=? ke " ")) (... s ...)] 
      [else (... s ...)] 
      )
    )
;; 5. CODE
(define (si-control s ke)
  (cond
    [(and (aim? s) (or (key=? ke "left") (key=? ke "right")))
     (make-aim (aim-ufo s) (change-tank-dir (aim-tank s) ke))] 
    [(and (fired? s) (or (key=? ke "left") (key=? ke "right")))
     (make-fired (fired-ufo s) (change-tank-dir (fired-tank s) ke)
                 (fired-missile s))] 
    [(and (aim? s) (key=? ke " "))
     (make-fired (aim-ufo s) (aim-tank s) (fire-missile (aim-tank s)))] 
    [else s] 
    )
  )


;; 2a. FUNCTION SIGNATURE: Tank KeyEvent -> Tank
;; 2b. PURPOSE STATEMENT: Consumes a Tank and KeyEvent and changes the direction
;; of the tank based on the keyevent.
;; 2c. HEADER
#;(define (change-tank-dir t ke) t)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; move left when heading right
(check-expect (change-tank-dir (make-tank (/ WIDTH 2) 1) "left")
              (make-tank (/ WIDTH 2) -1))
;; move left when already heading left
(check-expect (change-tank-dir (make-tank (/ WIDTH 2) -1) "left")
              (make-tank (/ WIDTH 2) -1))
;; move right when heading left
(check-expect (change-tank-dir (make-tank (/ WIDTH 2) -1) "right")
              (make-tank (/ WIDTH 2) 1))
;; move right when already heading right
(check-expect (change-tank-dir (make-tank (/ WIDTH 2) 1) "right")
              (make-tank (/ WIDTH 2) 1))
;; 4. TEMPLATE
#;(define (change-tank-dir t ke)
    (cond
      [(key=? ke "left") (... (tank-loc t) ... (tank-vel t) ...)]
      [(key=? ke "right") (... (tank-loc t) ... (tank-vel t) ...)]
      )
    )
;; 5. CODE
(define (change-tank-dir t ke)
  (cond
    [(key=? ke "left") (make-tank (tank-loc t) -1)]
    [(key=? ke "right") (make-tank (tank-loc t) 1)]
    )
  )


;; 2a. FUNCTION SIGNATURE: Tank -> Missile
;; 2b. PURPOSE STATEMENT: Consumes a Tank and returns a fired Missile.
;; 2c. HEADER
#;(define (fire-missile t) (make-posn 0 0))
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (fire-missile (make-tank (/ WIDTH 2) 1))
              (make-posn (/ WIDTH 2) (- HEIGHT (/ (image-height TANK) 2))))
;; 4. TEMPLATE
#;(define (fire-missile t)
    (... (tank-loc t) ... (tank-vel t) ...))
;; 5. CODE
(define (fire-missile t)
  (make-posn (tank-loc t) (- HEIGHT (/ (image-height TANK) 2))))


;; 2a. FUNCTION SIGNATURE: SIGS -> SIGS
;; 2b. PURPOSE STATEMENT: Initiates the Space Invader game in an aim state with
;; UFO in the top middle and tank on the left.
;; 2c. HEADER
#;(define (si-main s) s)
;; 3a. FUNCTIONAL EXAMPLES & TESTS: NA
;; 4. TEMPLATE
#;(define (si-main s)
    (big-bang s
              (on-tick ...)
              (to-draw ...)
              (on-key ...)
              (stop-when ...)
              ))
;; 5. CODE
(define (si-main s)
  (big-bang s
            (on-tick si-move 1/10)
            (to-draw si-render)
            (on-key si-control)
            (stop-when si-game-over? si-render-final)
            ))


#;(si-main (make-aim (make-posn (/ WIDTH 2) (image-height UFO))
                     (make-tank 15 1)))



;; 2a. FUNCTION SIGNATURE: MissileOrNot Image -> Image 
;; 2b. PURPOSE STATEMENT: Adds an image of missile m to scene s. 
;; 2c. HEADER
#;(define (missile-render.v2 m s) EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (missile-render.v2 #false BACKGROUND) BACKGROUND)
(check-expect (missile-render.v2 #false INITIAL_SCENE) INITIAL_SCENE)
(check-expect (missile-render.v2 (make-posn (/ WIDTH 2) (/ HEIGHT 2)) BACKGROUND)
              (missile-render (make-posn (/ WIDTH 2) (/ HEIGHT 2)) BACKGROUND))
(check-expect (missile-render.v2
               (make-posn (/ WIDTH 2) (/ HEIGHT 2)) INITIAL_SCENE)
              (missile-render
               (make-posn (/ WIDTH 2) (/ HEIGHT 2)) INITIAL_SCENE))
;; 4. TEMPLATE
#;(define (missile-render.v2 m s)
    (cond
      [(boolean? m) ...]
      [(posn? m) (... (posn-x m) ... (posn-y m) ...)]
      )
    )
;; 5. CODE
(define (missile-render.v2 m s)
  (cond
    [(boolean? m) s]
    [(posn? m) (place-image MISSILE (posn-x m) (posn-y m) s)]
    )
  )


;; 2a. FUNCTION SIGNATURE: SIGS.v2 -> Image 
;; 2b. PURPOSE STATEMENT: Renders the given game state on top of BACKGROUND.
;; 2c. HEADER
#;(define (si-render.v2 s) BACKGROUND)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (si-render.v2
               (make-sigs (make-posn 20 10) (make-tank 28 -3) #false))
              (place-image TANK 28 (- HEIGHT (/ (image-height TANK) 2))
                           (place-image UFO 20 10 BACKGROUND)))
(check-expect (si-render.v2 (make-sigs
                             (make-posn 20 10)
                             (make-tank 28 -3)
                             (make-posn 28 (- HEIGHT (image-height TANK)))))
              (place-image TANK 28 (- HEIGHT (/ (image-height TANK) 2))
                           (place-image UFO 20 10
                                        (place-image
                                         MISSILE
                                         28 (- HEIGHT (image-height TANK))
                                         BACKGROUND))))
(check-expect (si-render.v2 (make-sigs (make-posn 20 100)
                                       (make-tank 100 3)
                                       (make-posn 22 103)))
              (place-image TANK 100 (- HEIGHT (/ (image-height TANK) 2))
                           (place-image UFO 20 100
                                        (place-image MISSILE 22 103
                                                     BACKGROUND))))
;; 4. TEMPLATE
#;(define (si-render.v2 s)
    (... (sigs-tank s) ... (sigs-ufo s) ... (sigs-missile s) ... ))
;; 5. CODE
(define (si-render.v2 s)
  (tank-render (sigs-tank s)
               (ufo-render (sigs-ufo s)
                           (missile-render.v2 (sigs-missile s) BACKGROUND))))


;; 2a. FUNCTION SIGNATURE: UFO Missile -> Boolean
;; 2b. PURPOSE STATEMENT: Consumes a UFO and a Missile and returns true if the
;; Missile is close enough to the UFO to hit it.
;; 2c. HEADER
#;(define (missile-hit.v2? u m) false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; easy case
(check-expect (missile-hit.v2? (make-posn 100 100) (make-posn 100 100)) true)
;; check verticals
;; bottom checks
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn 100 (+ 100 (floor (+ (/ (image-height UFO) 2)
                                               (/ (image-height MISSILE) 2))))))
              true)
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn 100 (+ 101 (floor (+ (/ (image-height UFO) 2)
                                               (/ (image-height MISSILE) 2))))))
              false)
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn 100 (+ 99 (floor (+ (/ (image-height UFO) 2)
                                              (/ (image-height MISSILE) 2))))))
              true)
;; top checks
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn 100 (- 100 (floor (+ (/ (image-height UFO) 2)
                                               (/ (image-height MISSILE) 2))))))
              true)
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn 100 (- 99 (floor (+ (/ (image-height UFO) 2)
                                              (/ (image-height MISSILE) 2))))))
              false)
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn 100 (- 101 (floor (+ (/ (image-height UFO) 2)
                                               (/ (image-height MISSILE) 2))))))
              true)
;; check horizontals
;; check left side
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn (- 100 (floor (+ (/ (image-width UFO) 2)
                                           (/ (image-width MISSILE) 2))))
                          100))
              true)
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn (- 99 (floor (+ (/ (image-width UFO) 2)
                                          (/ (image-width MISSILE) 2))))
                          100))
              false)
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn (- 101 (floor (+ (/ (image-width UFO) 2)
                                           (/ (image-width MISSILE) 2))))
                          100))
              true)
;; check right side
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn (+ 100 (floor (+ (/ (image-width UFO) 2)
                                           (/ (image-width MISSILE) 2))))
                          100))
              true)
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn (+ 101 (floor (+ (/ (image-width UFO) 2)
                                           (/ (image-width MISSILE) 2))))
                          100))
              false)
(check-expect (missile-hit.v2?
               (make-posn 100 100)
               (make-posn (+ 99 (floor (+ (/ (image-width UFO) 2)
                                          (/ (image-width MISSILE) 2))))
                          100))
              true)
;; 4. TEMPLATE
#;(define (missile-hit.v2? u m)
    (cond
      [(boolean? m)
       (... (posn-x u) ... (posn-y u) ... (posn-x m) ... (posn-y m) ...)]
      [(posn? m)
       (... (posn-x u) ... (posn-y u) ... (posn-x m) ... (posn-y m) ...)]
      )
    )
;; 5. CODE
(define (missile-hit.v2? u m)
  (cond
    [(boolean? m) #false]
    [(posn? m)
     (and (<= (posn-y m) (+ (posn-y u)
                            (floor (+ (/ (image-height UFO) 2)
                                      (/ (image-height MISSILE) 2)))))
          (>= (posn-y m) (- (posn-y u)
                            (floor (+ (/ (image-height UFO) 2)
                                      (/ (image-height MISSILE) 2)))))
          (>= (posn-x m) (- (posn-x u)
                            (floor (+ (/ (image-width UFO) 2)
                                      (/ (image-width MISSILE) 2)))))
          (<= (posn-x m) (+ (posn-x u)
                            (floor (+ (/ (image-width UFO) 2)
                                      (/ (image-width MISSILE) 2))))) 
          )]
    )
  )


;; 2a. FUNCTION SIGNATURE: SIGS -> Image
;; 2b. PURPOSE STATEMENT: Consumes a SIGS.v2 and displays "GAME OVER. YOU LOSE!"
;; if the UFO landed else it displays "GAME OVER. YOU WIN!" if a missile hit the
;; UFO.
;; 2c. HEADER
#;(define (si-render-final.v2 s) EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; test no missile fired loss
(check-expect (si-render-final.v2
               (make-sigs (make-posn (/ WIDTH 4)
                                     (- HEIGHT (/ (image-height UFO) 2)))
                          (make-tank (/ WIDTH 2) 3) #false))
              (place-image (text GAME_OVER_TEXT_LOSING GAME_OVER_TEXT_FONT_SIZE
                                 GAME_OVER_TEXT_LOSING_COLOR)
                           (/ WIDTH 2) (/ HEIGHT 2)
                           (si-render.v2
                            (make-sigs
                             (make-posn (/ WIDTH 4)
                                        (- HEIGHT (/ (image-height UFO) 2)))
                             (make-tank (/ WIDTH 2) 3) #false))))
;; test missile hit win
(check-expect (si-render-final.v2
               (make-sigs
                (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                (make-tank (/ WIDTH 2) 3)
                (make-posn (/ WIDTH 2)
                           (floor (+ (/ HEIGHT 2) (/ (image-height UFO) 2)
                                     (/ (image-height MISSILE) 2))))))
              (place-image (text GAME_OVER_TEXT_WINNING GAME_OVER_TEXT_FONT_SIZE
                                 GAME_OVER_TEXT_WINNING_COLOR)
                           (/ WIDTH 2) (/ HEIGHT 2)
                           (si-render.v2
                            (make-sigs
                             (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                             (make-tank (/ WIDTH 2) 3)
                             (make-posn
                              (/ WIDTH 2)
                              (floor
                               (+ (/ HEIGHT 2) (/ (image-height UFO) 2)
                                  (/ (image-height MISSILE) 2))))))))
;; test missile fired loss
(check-expect (si-render-final.v2
               (make-sigs
                (make-posn (/ WIDTH 4) (- HEIGHT (/ (image-height UFO) 2)))
                (make-tank (/ WIDTH 2) 3)
                (make-posn (/ WIDTH 2)
                           (floor (+ (/ HEIGHT 2) (/ (image-height UFO) 2)
                                     (/ (image-height MISSILE) 2))))))
              (place-image (text GAME_OVER_TEXT_LOSING GAME_OVER_TEXT_FONT_SIZE
                                 GAME_OVER_TEXT_LOSING_COLOR)
                           (/ WIDTH 2) (/ HEIGHT 2)
                           (si-render.v2
                            (make-sigs
                             (make-posn (/ WIDTH 4)
                                        (- HEIGHT (/ (image-height UFO) 2)))
                             (make-tank (/ WIDTH 2) 3)
                             (make-posn
                              (/ WIDTH 2)
                              (floor
                               (+ (/ HEIGHT 2) (/ (image-height UFO) 2)
                                  (/ (image-height MISSILE) 2))))))))
;; 4. TEMPLATE
#;(define (si-render-final.v2 s)
    (cond
      [(missile-hit.v2? (sigs-ufo s) (sigs-missile s)) (... s ...)]
      [else (... s ...)]
      )
    )
;; 5. CODE
(define (si-render-final.v2 s)
  (cond
    [(missile-hit.v2? (sigs-ufo s) (sigs-missile s))
     (place-image (text GAME_OVER_TEXT_WINNING GAME_OVER_TEXT_FONT_SIZE
                        GAME_OVER_TEXT_WINNING_COLOR)
                  (/ WIDTH 2) (/ HEIGHT 2)
                  (si-render.v2 s))]
    [else (place-image (text GAME_OVER_TEXT_LOSING GAME_OVER_TEXT_FONT_SIZE
                             GAME_OVER_TEXT_LOSING_COLOR)
                       (/ WIDTH 2) (/ HEIGHT 2)
                       (si-render.v2 s))]
    )
  )






;; 2a. FUNCTION SIGNATURE: SIGS.v2 KeyEvent -> SIGS.v2
;; 2b. PURPOSE STATEMENT: The key event handler. It consumes a game state and a
;; KeyEvent and produces a new game state. It reacts to three different keys: 1)
;; pressing the left arrow ensures that the tank moves left; 2) pressing the
;; right arrow ensures that the tank moves right; and 3) pressing the space bar
;; fires the missile if it hasn’t been launched yet.
;; 2c. HEADER
#;(define (si-control.v2 s ke) s)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; change tank direction (left) when not yet fired (aim)
(check-expect (si-control.v2
               (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                          (make-tank (/ WIDTH 2) 1) #false) "left")
              (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                         (make-tank (/ WIDTH 2) -1) #false)) 
;; change tank direction (right) when not yet fired (aim)
(check-expect (si-control.v2 (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                        (make-tank (/ WIDTH 2) -1) #false) "right")
              (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                         (make-tank (/ WIDTH 2) 1) #false))
;; change tank direction (left) when fired (fired)
(check-expect (si-control.v2 (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                        (make-tank (/ WIDTH 2) 1)
                                        (make-posn
                                         (/ WIDTH 2)
                                         (- HEIGHT (/ (image-height TANK) 2))))
                             "left")
              (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                         (make-tank (/ WIDTH 2) -1)
                         (make-posn
                          (/ WIDTH 2)
                          (- HEIGHT (/ (image-height TANK) 2)))))
;; change tank direction (right) when fired (fired)
(check-expect (si-control.v2 (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                        (make-tank (/ WIDTH 2) -1)
                                        (make-posn
                                         (/ WIDTH 2)
                                         (- HEIGHT (/ (image-height TANK) 2))))
                             "right")
              (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                         (make-tank (/ WIDTH 2) 1)
                         (make-posn
                          (/ WIDTH 2)
                          (- HEIGHT (/ (image-height TANK) 2)))))
;; fire missile (aim)
(check-expect (si-control.v2 (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                        (make-tank (/ WIDTH 2) 1) #false) " ")
              (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                         (make-tank (/ WIDTH 2) 1)
                         (make-posn
                          (/ WIDTH 2)
                          (- HEIGHT (/ (image-height TANK) 2)))))
;; 4. TEMPLATE
#;(define (si-control.v2 s ke)
    (cond
      [(or (key=? ke "left") (key=? ke "right")) (... s ... ke ...)] 
      [(and (boolean? (sigs-missile s)) (key=? ke " ")) (... s ...)] 
      [else (... s ...)] 
      )
    )
;; 5. CODE
(define (si-control.v2 s ke)
  (cond
    [(or (key=? ke "left") (key=? ke "right"))
     (make-sigs (sigs-ufo s)
                (change-tank-dir (sigs-tank s) ke)
                (sigs-missile s))] 
    [(and (boolean? (sigs-missile s)) (key=? ke " "))
     (make-sigs (sigs-ufo s) (sigs-tank s) (fire-missile (sigs-tank s)))] 
    [else s] 
    )
  )


;; 2a. FUNCTION SIGNATURE: Missile -> Missile
;; 2b. PURPOSE STATEMENT: If the missile has been fired, updates the missile's
;; y-crd by subtracting MISSILE_SPEED from it, else returns false.
;; 2c. HEADER
#;(define (move-missile.v2 m) m)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (move-missile.v2 #false) #false)
(check-expect (move-missile.v2 (make-posn (/ WIDTH 2) (/ HEIGHT 2)))
              (make-posn (/ WIDTH 2) (- (/ HEIGHT 2) MISSILE_SPEED)))
;; 4. TEMPLATE
#;(define (move-missile.v2 m)
    (cond
      [(Boolean? m) (... (posn-x m) ... (posn-y m) ... MISSILE_SPEED ...)]
      [(posn? m) (... (posn-x m) ... (posn-y m) ... MISSILE_SPEED ...)]
      )
    )
;; 5. CODE
(define (move-missile.v2 m)
  (cond
    [(boolean? m) #false]
    [(posn? m) (make-posn (posn-x m) (- (posn-y m) MISSILE_SPEED))]
    )  
  )


;; 2a. FUNCTION SIGNATURE: SIGS.v2 Number -> SIGS.v2 
;; 2b. PURPOSE STATEMENT: Moves the UFO predictably by delta times UFO_SPEED and
;; the TANK by TANK_SPEED and the MISSILE by MISSILE_SPEED (d).
;; 2c. HEADER
#;(define (si-move-proper.v2 s d) s)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; test for not-fired, delta 1, UFO at center
(check-expect (si-move-proper.v2 (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                            (make-tank (/ WIDTH 2) 1) #false) 1)
              (make-sigs (make-posn (+ (/ WIDTH 2) UFO_SPEED)
                                    (+ (/ HEIGHT 2) UFO_SPEED))
                         (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1) #false))
;; test for not-fired, delta -1, UFO at center
(check-expect (si-move-proper.v2 (make-sigs (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                            (make-tank (/ WIDTH 2) 1) #false) -1)
              (make-sigs (make-posn (- (/ WIDTH 2) UFO_SPEED)
                                    (+ (/ HEIGHT 2) UFO_SPEED))
                         (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1) #false))
;; test for not-fired, delta 1, UFO at right edge
;; test for not-fired, delta -1, UFO at left edge
;; test for not-fired, delta 1, UFO at center landed
;; test for fired, delta 1, UFO at center
(check-expect (si-move-proper.v2 (make-sigs
                                  (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                  (make-tank (/ WIDTH 2) 1)
                                  (make-posn (/ WIDTH 2)
                                             (- HEIGHT (image-height TANK))))
                                 1)
              (make-sigs (make-posn (+ (/ WIDTH 2) UFO_SPEED)
                                    (+ (/ HEIGHT 2) UFO_SPEED))
                         (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)
                         (make-posn
                          (/ WIDTH 2)
                          (- HEIGHT (image-height TANK) MISSILE_SPEED))))
;; test for fired, delta -1, UFO at center
(check-expect (si-move-proper.v2 (make-sigs
                                  (make-posn (/ WIDTH 2) (/ HEIGHT 2))
                                  (make-tank (/ WIDTH 2) 1)
                                  (make-posn (/ WIDTH 2)
                                             (- HEIGHT (image-height TANK))))
                                 -1)
              (make-sigs (make-posn (- (/ WIDTH 2) UFO_SPEED)
                                    (+ (/ HEIGHT 2) UFO_SPEED))
                         (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)
                         (make-posn
                          (/ WIDTH 2)
                          (- HEIGHT (image-height TANK) MISSILE_SPEED))))
;; test for fired, delta 1, UFO at right edge
(check-expect (si-move-proper.v2 (make-sigs
                                  (make-posn (- WIDTH (/ (image-width UFO) 2))
                                             (/ HEIGHT 2))
                                  (make-tank (/ WIDTH 2) 1)
                                  (make-posn (/ WIDTH 2)
                                             (- HEIGHT (image-height TANK))))
                                 1)
              (make-sigs (make-posn (- WIDTH (/ (image-width UFO) 2))
                                    (+ (/ HEIGHT 2) UFO_SPEED))
                         (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)
                         (make-posn
                          (/ WIDTH 2)
                          (- HEIGHT (image-height TANK) MISSILE_SPEED))))
;; test for fired, delta -1, UFO at left edge
(check-expect (si-move-proper.v2 (make-sigs
                                  (make-posn (/ (image-width UFO) 2) (/ HEIGHT 2))
                                  (make-tank (/ WIDTH 2) 1)
                                  (make-posn (/ WIDTH 2)
                                             (- HEIGHT (image-height TANK))))
                                 -1)
              (make-sigs
               (make-posn (/ (image-width UFO) 2) (+ (/ HEIGHT 2) UFO_SPEED))
               (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)
               (make-posn
                (/ WIDTH 2)
                (- HEIGHT (image-height TANK) MISSILE_SPEED))))
;; test for fired, delta 1, UFO at center landed
(check-expect (si-move-proper.v2 (make-sigs
                                  (make-posn (/ WIDTH 2)
                                             (- HEIGHT (/ (image-height UFO) 2)))
                                  (make-tank (/ WIDTH 2) 1)
                                  (make-posn (/ WIDTH 2)
                                             (- HEIGHT (image-height TANK))))
                                 1)
              (make-sigs (make-posn (/ WIDTH 2)
                                    (- HEIGHT (/ (image-height UFO) 2)))
                         (make-tank (+ (/ WIDTH 2) TANK_SPEED) 1)
                         (make-posn
                          (/ WIDTH 2)
                          (- HEIGHT (image-height TANK) MISSILE_SPEED))))
;; 4. TEMPLATE
#;(define (si-move-proper.v2 s d)
    (... (sigs-ufo s) ... d ... (sigs-tank s) ... (sigs-missile s) ...)
    )
;; 5. CODE
(define (si-move-proper.v2 s d)
  (make-sigs (move-ufo (sigs-ufo s) d)
             (move-tank (sigs-tank s))
             (move-missile.v2 (sigs-missile s))
             )
  )


;; 2a. FUNCTION SIGNATURE: SIGS -> SIGS
;; 2b. PURPOSE STATEMENT: This function is called for every clock tick to
;; determine to which position the objects move now. Accordingly it consumes an
;; element of SIGS and produces another one. Moving the tank and the missile
;; (if any) is relatively straightforward. They move in straight lines at a
;; constant speed. Moving the UFO calls for small random jumps to the left or the
;; right. 
;; 2c. HEADER
#;(define (si-move.v2 s) s)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
;; NA due to random function use.
;; 4. TEMPLATE
#;(define (si-move.v2 s)
    (si-move-proper.v2 ... s ... (random ...)))
;; 5. CODE
(define (si-move.v2 s)
  (si-move-proper.v2 s (random-positive-or-negative-one 2)))


;; 2a. FUNCTION SIGNATURE: SIGS -> SIGS
;; 2b. PURPOSE STATEMENT: Initiates the Space Invader game with UFO in the top
;; middle and tank on the left.
;; 2c. HEADER
#;(define (si-main.v2 s) s)
;; 3a. FUNCTIONAL EXAMPLES & TESTS: NA
;; 4. TEMPLATE
#;(define (si-main.v2 s)
    (big-bang s
              (on-tick ...)
              (to-draw ...)
              (on-key ...)
              (stop-when ...)
              ))
;; 5. CODE
(define (si-main.v2 s)
  (big-bang s
            (on-tick si-move.v2 1/10)
            (to-draw si-render.v2)
            (on-key si-control.v2)
            (stop-when si-game-over? si-render-final.v2)
            ))


#;(si-main.v2 (make-sigs (make-posn (/ WIDTH 2) (image-height UFO))
                         (make-tank 15 1) #false))

