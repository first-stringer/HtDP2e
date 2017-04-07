;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-148) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alists~3ane%29

;; I think it depends on what is being designed and is somewhat subjective.
;; Reasoning about and coding the base case is easier when accommodating empty
;; lists.  On the other hand, not accommodating them made average easier to code
;; because we never had to worry about dividing by zero when taking the average
;; of an empty list.  The same scenario can be used to detail how not
;; accommodating them allows us to create a total function instead of just a
;; partial function when we do.

