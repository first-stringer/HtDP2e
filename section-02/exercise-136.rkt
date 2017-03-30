;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-136) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3aeval-list%29


;; A ConsPair is a structure:
;;   (make-pair Any Any).
(define-struct pair [left right])


;; A ConsOrEmpty is one of: 
;; – '()
;; – (cons Any ConsOrEmpty)
;; interpretation ConsOrEmpty is the class of all lists


;; Any ConsOrEmpty -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(pair? a-list) (make-pair a-value a-list)]
    [else (error "cons: second argument ...")]
    )
  )


;; ConsOrEmpty -> Any
;; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "List is empty!")
      (pair-left a-list)
      )
  )


;; ConsOrEmpty -> ConsOrEmpty
;; extracts the right part of the given pair
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-rest "List is empty!")
      (pair-right a-list)
      )
  )


(check-expect (our-first (our-cons "a" '())) "a")
(check-expect (our-rest (our-cons "a" '())) '())

