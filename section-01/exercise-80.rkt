;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-80) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3adesignstructs%29

(define-struct movie [title director year])
(define (movie-consumer m)
  (... (movie-title m) ... (movie-director m) ... (movie-year m) ...))

(define-struct person [name hair eyes phone])
(define (person-consumer p)
  (... (person-name p) ... (person-hair p) ... (person-eye p) ... (person-phone p) ...))

(define-struct pet [name number])
(define (pet-consumer p)
  (... (pet-name p) ... (pet-number p) ...))

(define-struct CD [artist title price])
(define (CD-consumer d)
  (... (CD-artist d) ... (CD-title d) ... (CD-price d) ...))

(define-struct sweater [material size color])
(define (sweater-consumer s)
  (... (sweater-material s) ... (sweater-size s) ... (sweater-color s) ...))

