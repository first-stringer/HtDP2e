;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-76) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._data-uni._sec~3adata-uni%29

;; A Movie is (make-movie String String Number).
(define-struct movie [title producer year])

;; A Person is (make-person String String String String).
(define-struct person [name hair eyes phone])

;; A Pet is (make-pet String Number).
(define-struct pet [name number])

;; A CD is (make-CD String String Number).
(define-struct CD [artist title price])

;; A Sweater is (make-sweater String 1String String).
(define-struct sweater [material size producer])