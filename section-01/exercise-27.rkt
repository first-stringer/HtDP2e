;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-27) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3acomposing%29

(define STARTING-TICKET-PRICE 5.0)
(define STARTING-TICKET-PRICE-ATTENDANCE 120)
(define TICKET-PRICE-DELTA 0.1)
(define TICKET-PRICE-DELTA-ATTENDANCE 15)
(define FIXED-OVERHEAD-PER-SHOW 180)
(define VARIABLE-OVERHEAD-PER-SHOW 0.04)

(define (attendees ticket-price)
  (- STARTING-TICKET-PRICE-ATTENDANCE (* (- ticket-price STARTING-TICKET-PRICE) (/ TICKET-PRICE-DELTA-ATTENDANCE TICKET-PRICE-DELTA))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-OVERHEAD-PER-SHOW (* VARIABLE-OVERHEAD-PER-SHOW (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))
