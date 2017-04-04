;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-141) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3afinger-lists%29


;; 2a. FUNCTION SIGNATURE: List-of-string -> String
;; 2b. PURPOSE STATEMENT: Concatenates all strings in l into one long string.
;; 2c. HEADER
(define (cat l) "")
;; 3a. FUNCTIONAL EXAMPLES & TESTS
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect (cat (cons "ab" (cons "cd" (cons "ef" '())))) "abcdef")
;; 4. TEMPLATE
#; (define (cat l)
     (cond
       [(empty? l) ""]
       [else (... (first l) ... (cat (rest l)) ...)]))
;; 5. CODE
#;(define (cat l)
    (cond
      [(empty? l) ""]
      [else (... (first l) ... (cat (rest l)) ...)]))

