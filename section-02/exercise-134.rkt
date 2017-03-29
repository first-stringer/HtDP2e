;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-134) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alists-programming%29


;; 1a. DATA DEFINITIONS
;; A List-of-names is one of: 
;; – '()
;; – (cons String List-of-names)
;; interpretation a list of invitees, by last name


;; 1b. CONSTANT DEFINITIONS: NA


;; 2a. FUNCTION SIGNATURE: String List-of-names -> Boolean
;; 2b. PURPOSE STATEMENT: Determines whether String (s) occurs in alon.
;; 2c. HEADER
#; (define (contains? s alon) #false)
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (contains? "Bob" '()) #false)
(check-expect (contains? "Bob" (cons "Find" '())) #false)
(check-expect (contains? "Bob" (cons "Bob" '())) #true)
(check-expect (contains? "Bob" (cons "X" (cons "Y"  (cons "Z" '())))) #false)
(check-expect (contains? "Bob" (cons "A" (cons "Bob" (cons "C" '())))) #true)
;; 4. TEMPLATE
#; (define (contains? s alon)
     (cond
       [(empty? alon) ...]
       [(cons? alon) (... s ... (first alon) ... (rest alon) ...)]
       )
     )
;; 5. CODE
(define (contains? s alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) s)
         (contains? s (rest alon)))]
    )
  )


(define alon1 (cons "Fagan"
                    (cons "Findler"
                          (cons "Fisler"
                                (cons "Flanagan"
                                      (cons "Bob"
                                            (cons "Felleisen"
                                                  (cons "Friedman" '()))))))))


(contains? "Bob" alon1)

