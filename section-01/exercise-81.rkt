;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-81) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3adesignstructs%29

;; 1. DATA DEFINITIONS:
;; A Time-point-since-midnight is a (make-time-point-since-midnight Number Number Number) where
;; hours is an integer from 0 to 23,
;; minutes is an integer from 0 to 59, and
;; seconds is an integer from 0 to 59.
;; This DD copied from exercise number 77.
(define-struct time-point-since-midnight [hours minutes seconds])

;; 2a. FUNCTION SIGNATURE:
;; 2b. PURPOSE STATEMENT:
;; 2c. HEADER:
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: , Expect:
;; 3b. TESTS:
;; 4. TEMPLATE:
;; 5. CODE: