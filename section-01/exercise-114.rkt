;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-114) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3ainput-errors%29


;; A SIGS is one of: 
;; – (make-aim UFO Tank)
;; – (make-fired UFO Tank Missile)
;; interpretation represents the complete state of a space invader game


;; Any -> Boolean
;; is s an element of the SIGS collection
(define (sigs? s)
  (cond
    [(aim? s) #true] 
    [(fired? s) #true]
    [else #false]
    )
  )


(define (si-main.v2 s)
  (big-bang s
            [on-tick si-move.v2 1/10]
            [to-draw si-render.v2]
            [on-key si-control.v2]
            [stop-when si-game-over.v2? si-render-final.v2]
            [check-with sigs?]
            ))


;; A VAnimal is either
;; – a VCat
;; – a VCham


;; Any -> Boolean
;; is va an element of the VAnimal collection
(define (vanimal? va)
  (cond
    [(vcat? va) #true]
    [(vcham? va) #true]
    [else #false]
    )
  )


(define (cat-cham-prog va)
  (big-bang va
            [on-tick tock]
            [to-draw render]
            [on-key handle-ke]
            [stop-when stop?]
            [check-with vanimal?]
            ))


;; An Editor is a structure:
;;   (make-editor String String)
;; interpretation (make-editor pre post) describes an editor whose visible text is
;; (string-append pre post) with the cursor displayed between pre and post 
(define-struct editor [pre post])

;; Any -> Boolean
;; is e composed of two Strings
(define (editor? e)
  (and (String? (editor-pre e) (String? editor-post e))
    )
  )


(define (run s)
  (big-bang (make-editor s "")
            [to-draw render]
            [on-key edit]
            [check-with editor?]
            )
  )


;; An Editor is a structure:
;;   (make-editor String Number)
;; interpretation (make-editor s i) describes an editor whose visible text is
;; s with the cursor displayed after position i and before position i+1 in s
;; where 0 indicates the cursor is before the first character in s
(define-struct editor [text index])


;; Any -> Boolean
;; is e composed of a String and a Number
(define (editor? e)
  (and (String? (editor-text e) (Number? editor-index e))
    )
  )


(define (run s)
  (big-bang (make-editor s (string-length s))
            [to-draw render]
            [on-key edit]
            [check-with editor?]
            )
  )

