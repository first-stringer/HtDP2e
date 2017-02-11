;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-72) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aprogstructs%29

(define-struct phone [area number])
;; A Phone is a structure:
;; (make-phone Number String)
;; interpretation an area code and the number with local switch prefix

(define-struct phone# [area switch num])
;; A Phone# is a structure:
;; (make-phone Number Number Number)
;; interpretation an area code (000...999), a local switch prefix (000...999), and the number (0000...9999)