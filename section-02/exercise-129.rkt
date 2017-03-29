;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-129) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alists-records%29

;; 1.
(cons "Neptune"
      (cons "Uranus"
            (cons "Saturn"
                  (cons "Jupiter"
                        (cons "Mars"
                              (cons "Earth"
                                    (cons "Venus" (cons "Mercury" '()))))))))

;; 2.
(cons "mochi" (cons "sushi" (cons "miso soup" (cons "tsukemono" '()))))

;; 3.
(cons "white" (cons "red" (cons "yellow" (cons "blue" (cons "black" '())))))

