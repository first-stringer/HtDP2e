;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-62) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aworlds-more%29

(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

; A DoorState is one of:
; – LOCKED
; – CLOSED
; – OPEN

;; FUNCTION WISH LIST:
;; door-closer, which closes the door during one tick;
;; door-actions, which manipulates the door in response to pressing a key; and
;; door-render, which translates the current state into an image.

;; 2a. FUNCTION SIGNATURE: DoorState -> DoorState
;; 2b. PURPOSE STATEMENT: Closes an open door over the period of one tick.
;; 2c. HEADER:
;; (define (door-closer ds) ds)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: LOCKED, Expect: LOCKED
;; Given: CLOSED, Expect: CLOSED
;; Given: OPEN, Expect: CLOSED
;; 3b. TESTS:
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)
;; 4. TEMPLATE:
;; (define (door-closer ds)
;;  (cond
;;    [(equal? ds LOCKED) ...]
;;    [(equal? ds CLOSED) ...]
;;    [(equal? ds OPEN) ...]
;;    )
;;  )
;; 5. CODE:
(define (door-closer ds)
  (cond
    [(equal? ds LOCKED) LOCKED]
    [(equal? ds CLOSED) CLOSED]
    [(equal? ds OPEN) CLOSED]
    )
  )

;; 2a. FUNCTION SIGNATURE: DoorState KeyEvent -> DoorState
;; 2b. PURPOSE STATEMENT: Turn key event ke into an action on state ds.
;; 2c. HEADER:
;; (define (door-actions ds ke) ds)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: LOCKED "u", Expect: CLOSED
;; Given: CLOSED "l", Expect: LOCKED
;; Given: CLOSED " ", Expect: OPEN
;; Given: OPEN ---, Expect: OPEN
;; 3b. TESTS:
(check-expect (door-actions LOCKED "u") CLOSED)
(check-expect (door-actions CLOSED "l") LOCKED)
(check-expect (door-actions CLOSED " ") OPEN)
(check-expect (door-actions OPEN "X") OPEN)
(check-expect (door-actions CLOSED "X") CLOSED)
(check-expect (door-actions LOCKED "X") LOCKED)
;; 4. TEMPLATE:
;; (define (door-actions ds ke)
;;  (cond
;;    [(and (equal? ds LOCKED) (equal? ke "u")) ...]
;;    [(and (equal? ds CLOSED) (equal? ke "l")) ...]
;;    [(and (equal? ds CLOSED) (equal? ke " ")) ...]
;;    [else ...]
;;    )
;;  )
;; 5. CODE:
(define (door-actions ds ke)
  (cond
    [(and (equal? ds LOCKED) (equal? ke "u")) CLOSED]
    [(and (equal? ds CLOSED) (equal? ke "l")) LOCKED]
    [(and (equal? ds CLOSED) (equal? ke " ")) OPEN] 
    [else ds]
    )
  )

;; 2a. FUNCTION SIGNATURE: DoorState -> Image
;; 2b. PURPOSE STATEMENT: Translates the state ds into a large text image.
;; 2c. HEADER:
;; (define (door-render ds) ds)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: , Expect:
;; 3b. TESTS:
(check-expect (door-render LOCKED) (text LOCKED 40 "red"))
(check-expect (door-render CLOSED) (text CLOSED 40 "red"))
(check-expect (door-render OPEN) (text OPEN 40 "red"))
;; 4. TEMPLATE:
;; (define (door-render ds)
;;  (... ds ...))
;; 5. CODE:
(define (door-render s)
  (text s 40 "red"))

;; 2a. FUNCTION SIGNATURE: DoorState -> DoorState
;; 2b. PURPOSE STATEMENT: Simulates a door with an automatic door closer.
;; 2c. HEADER:
;; (define (door-simulation ds) ds)
;; 3a. FUNCTIONAL EXAMPLES: NA
;; 3b. TESTS: NA
;; 4. TEMPLATE:
;; (define (door-simulation ds)
;;  (... ds ...))
;; 5. CODE:
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer 3]
    [on-key door-actions]
    [to-draw door-render]))

(door-simulation LOCKED)