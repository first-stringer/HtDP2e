;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-130) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alists-records%29

(cons "Bob" (cons "Bill" (cons "Ben" (cons "Barry" (cons "Brad" '())))))

#; (cons "1" (cons "2" '())) ; is an element of List-of-names because it contains
;; only strings and the empty list

#; (cons 2 '()) ; is not an element of List-of-names because it contains a Number
;; and the empty list

