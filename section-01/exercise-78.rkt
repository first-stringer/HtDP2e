;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-78) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._data-uni._sec~3adata-uni%29

;; A 3-letter word is a (make-3-letter-word (1String or #false) (1String or #false) (1String or #false)) where
;; first-letter is a 1String "a" through "z" or #false,
;; second-letter is a 1String "a" through "z" or #false, and
;; third-letter is a 1String "a" through "z" or #false.
(define-struct 3-letter-word [first-letter second-letter third-letter])