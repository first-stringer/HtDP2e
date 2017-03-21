;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-109) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)


;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aworlds-mix%29


;; 1a. DATA DEFINITIONS
;; ExpectsToSee is one of:
;; – AA
;; – BB
;; – DD 
;; – ER 
 

;; 1b. CONSTANT DEFINITIONS
(define AA "start, ...")
(define BB "expect ...")
(define DD "finished")
(define ER "error, ...")
(define WIDTH 100)
(define HEIGHT 100)
(define WHITE_RECTANGLE (rectangle WIDTH HEIGHT "solid" "white"))
(define YELLOW_RECTANGLE (rectangle WIDTH HEIGHT "solid" "yellow"))
(define GREEN_RECTANGLE (rectangle WIDTH HEIGHT "solid" "green"))
(define RED_RECTANGLE (rectangle WIDTH HEIGHT "solid" "red"))


;; 1c. FUNCTION WISH LIST
;; NAME:
;; SIGNATURE:
;; PURPOSE STATEMENT:



;; 2a. FUNCTION SIGNATURE: ExpectsToSee KeyboardEvent -> ExpectsToSee
;; 2b. PURPOSE STATEMENT: Returns the next ExpectsToSee state based on the
;; consumes ExpectsToSee state and KeyboardEvent.
;; 2c. HEADER
#; (define (handle-ke ets ke) ets)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (handle-ke AA "a") BB)
(check-expect (handle-ke AA " ") ER)
(check-expect (handle-ke BB "b") BB)
(check-expect (handle-ke BB "c") BB)
(check-expect (handle-ke BB "d") DD)
(check-expect (handle-ke BB " ") ER)
(check-expect (handle-ke DD " ") DD)
(check-expect (handle-ke ER " ") ER)
;; 4. TEMPLATE
#; (define (handle-ke ets ke)
     (cond
       [(and (eq? ets AA) (key=? ke "a")) ...]
       [(and (eq? ets BB) (key=? ke "b")) ...]
       [(and (eq? ets BB) (key=? ke "c")) ...]
       [(and (eq? ets BB) (key=? ke "d")) ...]
       [(eq? ets DD) ...]
       [else ...] 
       )
     )
;; 5. CODE
(define (handle-ke ets ke)
  (cond
    [(and (eq? ets AA) (key=? ke "a")) BB]
    [(and (eq? ets BB) (key=? ke "b")) BB]
    [(and (eq? ets BB) (key=? ke "c")) BB]
    [(and (eq? ets BB) (key=? ke "d")) DD]
    [(eq? ets DD) DD]
    [else ER] 
    )
  )


;; 2a. FUNCTION SIGNATURE: ExpectsToSee -> Boolean
;; 2b. PURPOSE STATEMENT: Returns to true when ExpectsToSee is DD or ER, false
;; otherwise.
;; 2c. HEADER
#; (define (stop? ets) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (stop? AA) #false)
(check-expect (stop? BB) #false)
(check-expect (stop? DD) #true)
(check-expect (stop? ER) #true)
;; 4. TEMPLATE
#; (define (stop? ets)
     (cond
       [(eq? ets AA) ...]
       [(eq? ets BB) ...]
       [(eq? ets DD) ...]
       [(eq? ets ER) ...]
       )
     )
;; 5. CODE
(define (stop? ets)
  (cond
    [(eq? ets DD) #true]
    [(eq? ets ER) #true]
    [else #false]
    )
  )


;; 2a. FUNCTION SIGNATURE: ExpectsToSee -> Image
;; 2b. PURPOSE STATEMENT: Returns the correct rectangule image for the consumes
;; ExpectsToSee state.
;; 2c. HEADER
#; (define (render ets) WHITE_RECTANGLE)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (render AA) WHITE_RECTANGLE)
(check-expect (render BB) YELLOW_RECTANGLE)
(check-expect (render DD) GREEN_RECTANGLE)
(check-expect (render ER) RED_RECTANGLE)
;; 4. TEMPLATE
#; (define (render ets)
     (cond
       [(eq? ets AA) ...]
       [(eq? ets BB) ...]
       [(eq? ets DD) ...]
       [(eq? ets ER) ...]
       )
     )
;; 5. CODE
(define (render ets)
  (cond
    [(eq? ets AA) WHITE_RECTANGLE]
    [(eq? ets BB) YELLOW_RECTANGLE]
    [(eq? ets DD) GREEN_RECTANGLE]
    [(eq? ets ER) RED_RECTANGLE]
    )
  )

;; 2a. FUNCTION SIGNATURE: ExpectsToSee -> ExpectsToSee
;; 2b. PURPOSE STATEMENT: Initiates the Pattern Matcher Program with the initial
;; state.
;; 2c. HEADER
#; (define (pattern-matcher-program ets) ets)
;; 3a. FUNCTIONAL EXAMPLES & TESTS: NA
;; 4. TEMPLATE
#; (define (pattern-matcher-program ets)
     (big-bang ets
               (to-draw ...)
               (on-key ...)
               (stop-when ...)
               ))
;; 5. CODE
#;(define (pattern-matcher-program ets)
    (big-bang ets
              (to-draw render)
              (on-key handle-ke)
              (stop-when stop?)
              ))


;(pattern-matcher-program AA)

