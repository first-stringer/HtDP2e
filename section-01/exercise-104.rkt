;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-104) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._mix._sec~3aitemization-design2%29

;; 1a. DATA DEFINITIONS
;; #1: A Vehicle (v) is a structure: (make-vehicle Number String Number).
;; Intepretation: (make-vehicle np lp mpg) specifies the number of comfortable
;; passengers that can be transported (np), the license plate identifier (lp), and
;; the fuel efficiency in miles per gallon (mpg).
(define-struct vehicle [numberpassengers licenseplate milespergallon])
(make-vehicle 4 "ABC123" 25) ;; data example
(make-vehicle 8 "XYZ456" 10) ;; data example


;; 4. TEMPLATE
#;(define (vehicle-consumer v)
    (... (vehicle-numberpassengers v) ...
         (vehicle-licenseplate v) ...
         (vehicle-milespergallon v) ... ))

