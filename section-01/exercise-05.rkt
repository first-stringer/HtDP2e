;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-05) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aarith-images%29

(define scene-x 100)
(define scene-y 100)

(define x-center (/ scene-x 2))
(define y-center (/ scene-y 2))
(define center-posn (make-posn x-center y-center))

;; start simple car image
(define body (rectangle (/ scene-x 2) (/ scene-y 6) "solid" "blue"))
(define body-posn center-posn)

(define cab (rectangle (/ (image-width body) 2) (image-height body) "solid" "blue"))
(define cab-posn (make-posn (posn-x body-posn) (- (posn-y body-posn) (/ (image-height body) 2) (/ (image-height cab) 2))))

(define wheels-diameter (/ (image-width body) 8)) 

(define wheel1 (circle wheels-diameter "solid" "black"))
(define wheel1-posn (make-posn (- (posn-x body-posn) (/ (image-width body) 4)) (+ (posn-y body-posn) (/ (image-height body) 2))))

(define wheel2 (circle wheels-diameter "solid" "black"))
(define wheel2-posn (make-posn (+ (posn-x body-posn) (/ (image-width body) 4)) (+ (posn-y body-posn) (/ (image-height body) 2))))

(define scene (empty-scene scene-x scene-y))
(scale 1 (place-images (list wheel2 wheel1 cab body) (list wheel2-posn wheel1-posn cab-posn body-posn) scene))

;; start simple boat image
(define hull-length (/ scene-x 3))
(define hull-height (/ scene-y 6))
(define hull-middle (rectangle hull-length hull-height "solid" "brown"))
(define hull-middle-posn center-posn)

(define stern (rotate 180 (right-triangle hull-height hull-height "solid" "brown")))
(define stern-posn (make-posn (- (posn-x hull-middle-posn) (/ (image-width hull-middle) 2) (/ (image-width stern) 2)) (posn-y hull-middle-posn)))

(define bow (flip-horizontal (rotate 180 (right-triangle (* 1.75 hull-height) hull-height "solid" "brown"))))
(define bow-posn (make-posn (+ (posn-x hull-middle-posn) (/ (image-width hull-middle) 2) (/ (image-width bow) 2)) (posn-y hull-middle-posn)))

(scale 1 (place-images (list bow stern hull-middle) (list bow-posn stern-posn hull-middle-posn) scene))


;; start simple tree image
(define tree-trunk-width (/ scene-x 10))
(define tree-trunk-height (/ scene-y 3))
(define tree-trunk (rectangle tree-trunk-width tree-trunk-height "solid" "brown"))
(define tree-trunk-posn center-posn)

(define tree-foliage (circle (* 1.5 tree-trunk-width) "solid" "green"))
(define tree-foliage-posn (make-posn (posn-x center-posn) (- (posn-y center-posn) (/ tree-trunk-height 2) (/ (image-width tree-foliage) 2))))

(scale 1 (place-images (list tree-foliage tree-trunk) (list tree-foliage-posn tree-trunk-posn) scene))


