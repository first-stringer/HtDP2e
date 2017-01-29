;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-29) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3acomposing%29

(define starting-ticket-price 5.0)
(define starting-ticket-price-attendance 120)
(define ticket-price-delta 0.1)
(define ticket-price-delta-attendance 15)
(define fixed-overhead-per-show 0)
(define variable-overhead-per-show 1.50)

(define (attendees ticket-price)
  (- starting-ticket-price-attendance (* (- ticket-price starting-ticket-price) (/ ticket-price-delta-attendance ticket-price-delta))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ fixed-overhead-per-show (* variable-overhead-per-show (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 1.0)
(profit 2.0)
(profit 3.0)
(profit 4.0)
(profit 5.0)

(write-file 'stdout "Result checks below.\n")
(define (profit2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 0
        (* 1.50
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))

(profit2 1.0)
(profit2 2.0)
(profit2 3.0)
(profit2 4.0)
(profit2 5.0)

