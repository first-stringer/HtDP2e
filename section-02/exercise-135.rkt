;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-135) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alists-programming%29


;; 1a. DATA DEFINITIONS
;; A List-of-names is one of: 
;; – '()
;; – (cons String List-of-names)
;; interpretation a list of invitees, by last name


;; 1b. CONSTANT DEFINITIONS: NA


;; 2a. FUNCTION SIGNATURE: List-of-names -> Boolean
;; 2b. PURPOSE STATEMENT: Determines whether "Flatt" occurs in alon.
;; 2c. HEADER
#; (define (contains-flatt? alon) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (contains-flatt? '()) #false)
(check-expect (contains-flatt? (cons "Find" '())) #false)
(check-expect (contains-flatt? (cons "Flatt" '())) #true)
(check-expect (contains-flatt? (cons "X" (cons "Y"  (cons "Z" '())))) #false)
(check-expect (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '())))) #true)
;; 4. TEMPLATE
#; (define (contains-flatt? alon)
     (cond
       [(empty? alon) ...]
       [(cons? alon) (... (first alon) ... (rest alon) ...)]
       )
     )
;; 5. CODE
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]
    )
  )


(contains-flatt? (cons "Flatt" (cons "C" '())))


(contains-flatt? (cons "B" (cons "C" '())))

