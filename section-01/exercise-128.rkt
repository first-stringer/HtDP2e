;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-128) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3a1-2testing%29

(check-expect 3 4) ; 3 does not equal 4

(check-member-of "green" "red" "yellow" "grey") ; green is not red, yellow, or
                                                ; grey
 
(check-within (make-posn #i1.0 #i1.1)
              (make-posn #i0.9 #i1.2)
              0.01) ; the second posn is not 0.01 distance from the first posn

(check-range #i0.9 #i0.6 #i0.8) ; the first number is not between the second and
                                ; third numbers

(check-error (/ 1 1)) ; equals 1 and does not generate an error

(check-random (make-posn (random 3) (random 9))
              (make-posn (random 9) (random 3))) ; does not call the random
                                                 ; function with the same
                                                 ; arguments in the same order

(check-satisfied 4 odd?) ; 4 is even not odd

