;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-125) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aint1-structs%29

;; 1. (define-struct oops []) = Illegal.  At least one variable name is required
;; to be inside the brackets.

;; 2. (define-struct child [parents dob date]) = Legal.

;; 3. (define-struct (child person) [dob date]) = Illegal. The first term after
;; the keyword define-struct must be a variable name and a list (two in this case)
;; of parenthesis/brackets is not allowed.

