;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-54) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._itemization._sec~3aitemization%29

;; First, you must check if x is a string before checking if it equals
;; "resting".  Otherwise an error will occur if you try to compare a Number to
;; the string "resting". Second, it ignores the scenario where x is greater than
;; HEIGHT (and therefore outside the bounds of the scene). This would lead to
;; the rocket being displayed partially or completely below ground.  

(or (and (string? x) (string=? "resting" x)) (> x HEIGHT))
