;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-83) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aedit1%29

;; 1. DATA DEFINITIONS:
(define-struct editor [pre post])
;; An Editor is a structure:
;;   (make-editor String String)
;; interpretation (make-editor s t) describes an editor whose visible text is
;; (string-append s t) with the cursor displayed between s and t

;; 2a. FUNCTION SIGNATURE:
;; 2b. PURPOSE STATEMENT:
;; 2c. HEADER:
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: , Expect:
;; 3b. TESTS:
;; 4. TEMPLATE:
;; 5. CODE: