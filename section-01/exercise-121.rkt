;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-121) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3asynsem~3asem%29

;; 1.
(+ (* (/ 12 8) 2/3) (- 20 (sqrt 4)))
#; (+ (* 3/2 2/3) (- 20 (sqrt 4)))
#; (+ 1 (- 20 (sqrt 4)))
#; (+ 1 (- 20 2))
#; (+ 1 18)
#;19

;; 2.
(cond
  [(= 0 0) #false]
  [(> 0 1) (string=? "a" "a")]
  [else (= (/  1 0) 9)]
  )
#; (cond
     [#true #false]
     [(> 0 1) (string=? "a" "a")]
     [else (= (/  1 0) 9)]
     )
#; #false

;; 3.
(cond
  [(= 2 0) #false]
  [(> 2 1) (string=? "a" "a")]
  [else (= (/  1 2) 9)]
  )
#; (cond
     [#false #false]
     [(> 2 1) (string=? "a" "a")]
     [else (= (/  1 2) 9)]
     )
#; (cond
     [(> 2 1) (string=? "a" "a")]
     [else (= (/  1 2) 9)]
     )
#; (cond
     [#true (string=? "a" "a")]
     [else (= (/  1 2) 9)]
     )
#; (string=? "a" "a")
#; #true
