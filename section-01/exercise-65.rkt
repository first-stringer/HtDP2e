;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-65) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3astructures%29

(define-struct movie [title producer year])
(define my-movie (make-movie "Titanic" "Cameron" 1995))
(movie-title my-movie)
(movie-producer my-movie)
(movie-year my-movie)

(define-struct person [name hair eyes phone])
(define my-person (make-person "Jim" "Brown" "Brown" "555-555-5555"))
(person-name my-person)
(person-hair my-person)
(person-eyes my-person)
(person-phone my-person)

(define-struct pet [name number])
(define my-pet (make-pet "Fifi" 1))
(pet-name my-pet)
(pet-number my-pet)

(define-struct CD [artist title price])
(define my-CD (make-CD "Prince" "Purple Rain" 16.99))
(CD-artist my-CD)
(CD-title my-CD)
(CD-price my-CD)

(define-struct sweater [material size producer])
(define my-sweater (make-sweater "Cotton" 10 "China"))
(sweater-material my-sweater)
(sweater-size my-sweater)
(sweater-producer my-sweater)
