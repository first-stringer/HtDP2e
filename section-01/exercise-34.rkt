;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-34) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3afinger-design%29

;; 1. DATA DEFINITIONS: 1String represents a string of length one.
;; 2a. FUNCTION SIGNATURE: String -> 1String
;; 2b. PURPOSE STATMENT: Extracts the first 1String from a non-empty string.
;; 2c. HEADER:
;; (define (string-first str)
;;   "a")
;; 3. FUNCTIONAL EXAMPLES:
;; Given: "test", Expect #\s.
;; 4. TEMPLATE:
;; (define (string-first str)
;;  (... str ...)) 
;; 5. CODE:
(define (string-first str)
 (string-ref str 0)) 