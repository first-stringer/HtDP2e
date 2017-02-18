;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-87) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)


;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aedit1%29


;; 1a. DATA DEFINITIONS
(define-struct editor [text index])
;; An Editor is a structure:
;;   (make-editor String Number)
;; interpretation (make-editor s i) describes an editor whose visible text is
;; s with the cursor displayed after position i and before position i+1 in s
;; where 0 indicates the cursor is before the first character in s


;; 1b. CONSTANT DEFINITIONS
(define SCENE_WIDTH 200)
(define SCENE_HEIGHT 20)
(define EMPTY_SCENE (empty-scene SCENE_WIDTH SCENE_HEIGHT))
(define TEXT_SIZE 16)
(define TEXT_COLOR "black")
(define CURSOR (rectangle 1 20 "solid" "red"))
(define MAX_EDITOR_TEXT_IMAGE_LENGTH SCENE_WIDTH)


;; 1c. FUNCTION WISH LIST
;; NAME: before-string
;; SIGNATURE: Editor -> String
;; PURPOSE STATEMENT: Consumes an editor and returns the portion of the string
;; before the cursor.
;; NAME: after-string
;; SIGNATURE: Editor -> String
;; PURPOSE STATEMENT: Consumes an editor and returns the portion of the string
;; after the cursor.
;string-first
;string-rest
;string-last
;string-remove-last


;; 2a. FUNCTION SIGNATURE: Editor -> String
;; 2b. PURPOSE STATEMENT: Consumes an editor and returns the portion of the
;; string before the cursor.
;; 2c. HEADER
;; (define (before-string e) "")
;; 3a. FUNCTIONAL EXAMPLES
;; Given: {"helloworld" 5}, Expect: "hello"
;; Given: {"helloworld" 0}, Expect: ""
;; Given: {"helloworld" <0}, Expect: ""
;; Given: {"helloworld" 10}, Expect: "helloworld"
;; Given: {"helloworld" >10}, Expect: "helloworld"
;; 3b. TESTS
(check-expect (before-string (make-editor "helloworld" 5)) "hello")
(check-expect (before-string (make-editor "helloworld" 0)) "")
(check-expect (before-string (make-editor "helloworld" -1)) "")
(check-expect (before-string (make-editor "helloworld" 10)) "helloworld")
(check-expect (before-string (make-editor "helloworld" 100)) "helloworld")
;; 4. TEMPLATE
;; (define (before-string e)
;;   (... (editor-text e) ... (editor-index e) ...))
;; 5. CODE
(define (before-string e)
  (cond
    [(<= (editor-index e) 0) ""]
    [(>= (editor-index e) (string-length (editor-text e))) (editor-text e)]
    [else (substring (editor-text e) 0 (editor-index e))]
    )
  )


;; 2a. FUNCTION SIGNATURE: Editor -> String
;; 2b. PURPOSE STATEMENT: Consumes an editor and returns the portion of the
;; string after the cursor.
;; 2c. HEADER
;; (define (after-string e) "")
;; 3a. FUNCTIONAL EXAMPLES
;; Given: {"helloworld" 5}, Expect: "world"
;; Given: {"helloworld" 0}, Expect: "helloworld"
;; Given: {"helloworld" <0}, Expect: "helloworld"
;; Given: {"helloworld" 10}, Expect: ""
;; Given: {"helloworld" >10}, Expect: ""
;; 3b. TESTS
(check-expect (after-string (make-editor "helloworld" 5)) "world")
(check-expect (after-string (make-editor "helloworld" 0)) "helloworld")
(check-expect (after-string (make-editor "helloworld" -1)) "helloworld")
(check-expect (after-string (make-editor "helloworld" 10)) "")
(check-expect (after-string (make-editor "helloworld" 100)) "")
;; 4. TEMPLATE
;; (define (after-string e)
;;   (... (editor-text e) ... (editor-index e) ...))
;; 5. CODE
(define (after-string e)
  (cond
    [(<= (editor-index e) 0) (editor-text e)]
    [(>= (editor-index e) (string-length (editor-text e))) ""]
    [else
     (substring
      (editor-text e)
      (editor-index e)
      (string-length (editor-text e)))]
    )
  )


;; 2a. FUNCTION SIGNATURE: Editor -> Image
;; 2b. PURPOSE STATEMENT: Which consumes an Editor (e) and produces an image.
;; 2c. HEADER
;; (define (render e) EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES
;; Given: {"helloworld" 5}, Expect: image with CURSOR between the words o and w
;; Given: {"helloworld" 0}, Expect: image with CURSOR before h
;; Given: {"helloworld" 10}, Expect: image with CURSOR after d
;; Given: {"helloworld" >10}, Expect: image with CURSOR after d
;; 3b. TESTS
(check-expect (render (make-editor "helloworld" 5))
              (overlay/align "left" "center"
                             (beside (text "hello" TEXT_SIZE TEXT_COLOR)
                                     CURSOR
                                     (text "world" TEXT_SIZE TEXT_COLOR))
                             EMPTY_SCENE))
(check-expect (render (make-editor "helloworld" 0))
              (overlay/align "left" "center"
                             (beside CURSOR
                                     (text "helloworld" TEXT_SIZE TEXT_COLOR))
                             EMPTY_SCENE))
(check-expect (render (make-editor "helloworld" 10))
              (overlay/align "left" "center"
                             (beside
                              (text "helloworld" TEXT_SIZE TEXT_COLOR) CENTER)
                             EMPTY_SCENE))
(check-expect (render (make-editor "helloworld" 100))
              (overlay/align "left" "center"
                             (beside
                              (text "helloworld" TEXT_SIZE TEXT_COLOR) CENTER)
                             EMPTY_SCENE))
;; 4. TEMPLATE
;; (define (render e)
;;   (... (editor-pre e) ... (editor-post e) ...))
;; 5. CODE
(define (render e)
  (overlay/align "left" "center"
                 (beside (text (before-string e) TEXT_SIZE TEXT_COLOR)
                         CURSOR
                         (text (after-string e) TEXT_SIZE TEXT_COLOR))
                 EMPTY_SCENE))



