;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-123) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3asynsem~3aand-or%29

#; (if exp-test exp-then exp-else)

;; is short for

#; (cond
     [exp-test exp-then]
     [else exp-else]
     )

