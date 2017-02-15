;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-83) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aedit1%29

;; 1a. DATA DEFINITIONS:
(define-struct editor [pre post])
;; An Editor is a structure:
;;   (make-editor String String)
;; interpretation (make-editor s t) describes an editor whose visible text is
;; (string-append s t) with the cursor displayed between s and t

;; 1b. CONSTANT DEFINITIONS:
(define EMPTY_SCENE (empty-scene 200 20))
(define TEXT_SIZE 16)
(define TEXT_COLOR "black")
(define CURSOR (rectangle 1 20 "solid" "red"))


;; 2a. FUNCTION SIGNATURE: Editor -> Image
;; 2b. PURPOSE STATEMENT: Which consumes an Editor (e) and produces an image.
;; 2c. HEADER:
;; (define (render e) EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES:
;; Given: "hello" "world", Expect: image with CURSOR between the words hello and world
;; Given: "hello" "", Expect: image with CURSOR after the word hello
;; Given: "" "world", Expect: image with CURSOR before the word world
;; Given: "" "", Expect: image with a CURSOR on the left and nothing else
;; 3b. TESTS:
(check-expect (render (make-editor "hello" "world"))
              (overlay/align "left" "center"
                             (beside (text "hello" TEXT_SIZE TEXT_COLOR) CURSOR (text "world" TEXT_SIZE TEXT_COLOR))
                             EMPTY_SCENE))
(check-expect (render (make-editor "hello" ""))
              (overlay/align "left" "center"
                             (beside (text "hello" TEXT_SIZE TEXT_COLOR) CURSOR (text "" TEXT_SIZE TEXT_COLOR))
                             EMPTY_SCENE))
(check-expect (render (make-editor "" "world"))
              (overlay/align "left" "center"
                             (beside (text "" TEXT_SIZE TEXT_COLOR) CURSOR (text "world" TEXT_SIZE TEXT_COLOR))
                             EMPTY_SCENE))
(check-expect (render (make-editor "" ""))
              (overlay/align "left" "center"
                             (beside (text "" TEXT_SIZE TEXT_COLOR) CURSOR (text "" TEXT_SIZE TEXT_COLOR))
                             EMPTY_SCENE))
;; 4. TEMPLATE:
;; (define (render e)
;;   (... (editor-pre e) ... (editor-post e) ...))
;; 5. CODE:
(define (render e) 
  (overlay/align "left" "center"
                 (beside (text (editor-pre e) TEXT_SIZE TEXT_COLOR) CURSOR (text (editor-post e) TEXT_SIZE TEXT_COLOR))
                 EMPTY_SCENE))