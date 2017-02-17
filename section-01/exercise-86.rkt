;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-86) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)


;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_one.html#%28part._sec~3aedit1%29


;; 1a. DATA DEFINITIONS
(define-struct editor [pre post])
;; An Editor is a structure:
;;   (make-editor String String)
;; interpretation (make-editor s t) describes an editor whose visible text is
;; (string-append s t) with the cursor displayed between s and t


;; 1b. CONSTANT DEFINITIONS
(define EMPTY_SCENE (empty-scene 200 20))
(define TEXT_SIZE 16)
(define TEXT_COLOR "black")
(define CURSOR (rectangle 1 20 "solid" "red"))
(define MAX_TEXT_LENGTH 21)


;; 1c. FUNCTION WISH LIST
;; NAME: move-last-pre-to-first-post 
;; SIGNATURE: Editor -> Editor
;; PURPOSE STATEMENT: Consumes an editor and removes the last character of pre
;; and adds it to; the first position of post, unless pre is empty in which case
;; editor is returned unchanged.
;; NAME: move-first-post-to-last-pre
;; SIGNATURE: Editor -> Editor
;; PURPOSE STATEMENT: Consumes an editor and removes the first character of post
;; and adds it to the last position of pre, unless post is empty in which case
;; editor is returned unchanged.
;; NAME: insert-char
;; SIGNATURE: Editor 1String -> Editor
;; PURPOSE STATEMENT: Consumes an editor and a 1String; the 1String is appended
;; to pre.
;; NAME: remove-char
;; SIGNATURE: Editor -> Editor
;; PURPOSE STATEMENT: Consumes an editor and removes the last character of pre.


;; 2a. FUNCTION SIGNATURE: Editor -> Image
;; 2b. PURPOSE STATEMENT: Which consumes an Editor (e) and produces an image.
;; 2c. HEADER
;; (define (render e) EMPTY_SCENE)
;; 3a. FUNCTIONAL EXAMPLES
;; Given: "hello" "world", Expect: image with CURSOR between the words hello and world
;; Given: "hello" "", Expect: image with CURSOR after the word hello
;; Given: "" "world", Expect: image with CURSOR before the word world
;; Given: "" "", Expect: image with a CURSOR on the left and nothing else
;; 3b. TESTS
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
;; 4. TEMPLATE
;; (define (render e)
;;   (... (editor-pre e) ... (editor-post e) ...))
;; 5. CODE
(define (render e) 
  (overlay/align "left" "center"
                 (beside (text (editor-pre e) TEXT_SIZE TEXT_COLOR) CURSOR (text (editor-post e) TEXT_SIZE TEXT_COLOR))
                 EMPTY_SCENE))


;; 2a. FUNCTION SIGNATURE: Editor -> Editor
;; 2b. PURPOSE STATEMENT: Consumes an editor and removes the last character of
;; pre.
;; 2c. HEADER
;; (define (remove-char e) e)
;; 3a. FUNCTIONAL EXAMPLES
;; Given: "hello" "world", Expect: "hell" "world"
;; Given: "" "world", Expect: "" "world"
;; Given: "hello" "", Expect: "hell" ""
;; 3b. TESTS
(check-expect (remove-char (make-editor "hello" "world")) (make-editor "hell" "world"))
(check-expect (remove-char (make-editor "" "world")) (make-editor "" "world"))
(check-expect (remove-char (make-editor "hello" "")) (make-editor "hell" ""))
(check-expect (remove-char (make-editor "" "")) (make-editor "" ""))
;; 4. TEMPLATE
;; (define (remove-char e)
;;   (... (editor-pre e) ... (editor-post e) ... ))
;; 5. CODE
(define (remove-char e)
  (cond
    [(= (string-length (editor-pre e)) 0) e]
    [else (make-editor (substring (editor-pre e) 0 (- (string-length (editor-pre e)) 1)) (editor-post e))]
    )
  )


;; 2a. FUNCTION SIGNATURE: Editor 1String -> Editor
;; 2b. PURPOSE STATEMENT: Consumes an editor and a 1String; the 1String is
;; appended to pre.
;; 2c. HEADER
;; (define (insert-char e 1s) e)
;; 3a. FUNCTIONAL EXAMPLES
;; Given: {"hello" "world"} " ", Expect: {"hello " "world"}
;; Given: {"" "world"} " ", Expect: {" " "world"}
;; Given: {"hello" ""} " ", Expect: {"hello " ""}
;; 3b. TESTS
(check-expect (insert-char (make-editor "hello" "world") " ") (make-editor "hello " "world"))
(check-expect (insert-char (make-editor "" "world") " ") (make-editor " " "world"))
(check-expect (insert-char (make-editor "hello" "") " ") (make-editor "hello " ""))
(check-expect (insert-char (make-editor "" "") " ") (make-editor " " ""))
;; 4. TEMPLATE
;; (define (insert-char e 1s)
;;   (... (editor-pre e) ... (editor-post e) ... 1s ...))
;; 5. CODE
(define (insert-char e 1s)
  (make-editor (string-append (editor-pre e) 1s) (editor-post e)))


;; 2a. FUNCTION SIGNATURE: Editor -> Editor
;; 2b. PURPOSE STATEMENT: Consumes an editor and removes the last character of
;; pre and adds it to the first position of post, unless pre is empty in which
;; case editor is returned unchanged.
;; 2c. HEADER
;; (define (move-last-pre-to-first-post e) e)
;; 3a. FUNCTIONAL EXAMPLES
;; Given: "hello" "world" "left", Expect: "hell" "oworld"
;; Given: "hello" "" "left", Expect: "hell" "o"
;; Given: "" "world" "left", Expect: "" "world"
;; Given: "" "" "left", Expect: "" ""
;; 3b. TESTS
(check-expect (move-last-pre-to-first-post (make-editor "hello" "world")) (make-editor "hell" "oworld"))
(check-expect (move-last-pre-to-first-post (make-editor "hello" "")) (make-editor "hell" "o"))
(check-expect (move-last-pre-to-first-post (make-editor "" "world")) (make-editor "" "world"))
(check-expect (move-last-pre-to-first-post (make-editor "" "")) (make-editor "" ""))
;; 4. TEMPLATE
;; (define (move-last-pre-to-first-post e)
;;   (... (editor-pre e) ... (editor-post e) ...))
;; 5. CODE
(define (move-last-pre-to-first-post e)
  (cond
    [(= (string-length (editor-pre e)) 0) e]
    [else (make-editor
           (substring (editor-pre e) 0 (- (string-length (editor-pre e)) 1))
           (string-append (substring (editor-pre e) (- (string-length (editor-pre e)) 1) (string-length (editor-pre e))) (editor-post e)))]
    )
  )


;; 2a. FUNCTION SIGNATURE: Editor -> Editor
;; 2b. PURPOSE STATEMENT: Consumes an editor and removes the first character of
;; post and adds it to the last position of pre, unless post is empty in which
;; case editor is returned unchanged.
;; 2c. HEADER
;; (define (move-first-post-to-last-pre e) e)
;; 3a. FUNCTIONAL EXAMPLES
;; Given: "hello" "world" "right", Expect: "hellow" "orld"
;; Given: "hello" "" "right", Expect: "hello" ""
;; Given: "" "world" "right", Expect: "w" "orld"
;; Given: "" "" "right", Expect: "" ""
;; 3b. TESTS
(check-expect (move-first-post-to-last-pre (make-editor "hello" "world")) (make-editor "hellow" "orld"))
(check-expect (move-first-post-to-last-pre (make-editor "hello" "")) (make-editor "hello" ""))
(check-expect (move-first-post-to-last-pre (make-editor "" "world")) (make-editor "w" "orld"))
(check-expect (move-first-post-to-last-pre (make-editor "" "") ) (make-editor "" ""))
;; 4. TEMPLATE
;; (define (move-first-post-to-last-pre e)
;;   (... (editor-pre e) ... (editor-post e) ...))
;; 5. CODE
(define (move-first-post-to-last-pre e)
  (cond
    [(= (string-length (editor-post e)) 0) e]
    [else (make-editor
           (string-append (editor-pre e) (substring (editor-post e) 0 1))
           (substring (editor-post e) 1 (string-length (editor-post e))))]
    )
  )


;; 2a. FUNCTION SIGNATURE: Editor KeyEvent -> Editor 
;; 2b. PURPOSE STATEMENT: Consumes two inputs, an Editor (e) and a KeyEvent (ke), and it produces another editor.
;; 2c. HEADER
;; (define (edit e ke) e)
;; 3a. FUNCTIONAL EXAMPLES
;; Given: "hello" "world" "\t", Expect: "hello" "world"
;; Given: "hello" "" "\t", Expect: "hello" ""
;; Given: "" "world" "\t", Expect: "" "world"
;; Given: "" "" "\t", Expect: "" ""
;; Given: "hello" "world" "\r", Expect: "hello" "world"
;; Given: "hello" "" "\r", Expect: "hello" ""
;; Given: "" "world" "\r", Expect: "" "world"
;; Given: "" "" "\r", Expect: "" ""
;; Given: "hello" "world" "\b", Expect: "hell" "world"
;; Given: "" "world" "\b", Expect: "" "world"
;; Given: "hello" "" "\b", Expect: "hell" ""
;; Given: "" "" "\b", Expect: "" ""
;; Given: "hello" "world" "left", Expect: "hell" "oworld"
;; Given: "hello" "" "left", Expect: "hell" "o"
;; Given: "" "world" "left", Expect: "" "world"
;; Given: "" "" "left", Expect: "" ""
;; Given: "hello" "world" "right", Expect: "hellow" "orld"
;; Given: "hello" "" "right", Expect: "hello" ""
;; Given: "" "world" "right", Expect: "w" "orld"
;; Given: "" "" "right", Expect: "" ""
;; Given: "hello" "world" *, Expect: "hello*" "world" ; * = any single character string not covered above
;; Given: "hello" "" *, Expect: "hello*" "" ; * = any single character string not covered above
;; Given: "" "world" *, Expect: "*" "world" ; * = any single character string not covered above
;; Given: "" "" *, Expect: "*" "" ; * = any single character string not covered above
;; Given: "hello" "world" *', Expect: "hello" "world" ; *' = any key event not covered above
;; 3b. TESTS
(check-expect (edit (make-editor "hello" "world") "\t") (make-editor "hello" "world"))
(check-expect (edit (make-editor "hello" "") "\t") (make-editor "hello" ""))
(check-expect (edit (make-editor "" "world") "\t") (make-editor "" "world"))
(check-expect (edit (make-editor "" "") "\t") (make-editor "" ""))
(check-expect (edit (make-editor "hello" "world") "\r") (make-editor "hello" "world"))
(check-expect (edit (make-editor "hello" "") "\r") (make-editor "hello" ""))
(check-expect (edit (make-editor "" "world") "\r") (make-editor "" "world"))
(check-expect (edit (make-editor "" "") "\r") (make-editor "" ""))
(check-expect (edit (make-editor "hello" "world") "\b") (make-editor "hell" "world"))
(check-expect (edit (make-editor "hello" "") "\b") (make-editor "hell" ""))
(check-expect (edit (make-editor "" "world") "\b") (make-editor "" "world"))
(check-expect (edit (make-editor "" "") "\b") (make-editor "" ""))
(check-expect (edit (make-editor "hello" "world") "left") (make-editor "hell" "oworld"))
(check-expect (edit (make-editor "hello" "") "left") (make-editor "hell" "o"))
(check-expect (edit (make-editor "" "world") "left") (make-editor "" "world"))
(check-expect (edit (make-editor "" "") "left") (make-editor "" ""))
(check-expect (edit (make-editor "hello" "world") "right") (make-editor "hellow" "orld"))
(check-expect (edit (make-editor "hello" "") "right") (make-editor "hello" ""))
(check-expect (edit (make-editor "" "world") "right") (make-editor "w" "orld"))
(check-expect (edit (make-editor "" "") "right") (make-editor "" ""))
(check-expect (edit (make-editor "hello" "world") " ") (make-editor "hello " "world"))
(check-expect (edit (make-editor "hello" "") " ") (make-editor "hello " ""))
(check-expect (edit (make-editor "" "world") " ") (make-editor " " "world"))
(check-expect (edit (make-editor "" "") " ") (make-editor " " ""))
;; 4. TEMPLATE
;; (define (edit e ke)
;;   (... (editor-pre e) ... (editor-post e) ... ke ...))
;; 5. CODE
(define (edit e ke)
  (cond
    [(string=? "\r" ke) e]
    [(string=? "\t" ke) e]
    [(string=? "\b" ke) (remove-char e)]
    [(string=? "left" ke) (move-last-pre-to-first-post e)]
    [(string=? "right" ke) (move-first-post-to-last-pre e)]
    [(and (= (string-length ke) 1) (<= (+ (string-length (editor-pre e)) (string-length (editor-post e))) MAX_TEXT_LENGTH)) (insert-char e ke)]
    [else e]
    )
  )


;; 2a. FUNCTION SIGNATURE: String -> Editor
;; 2b. PURPOSE STATEMENT: Consumes a string, the pre field of an editor, and
;; launches an interactive editor, using render and edit.
;; 2c. HEADER
;; (define (run s) (make-editor s ""))
;; 3a. FUNCTIONAL EXAMPLES: NA
;; 3b. TESTS: NA
;; 4. TEMPLATE
;; (define (run s)
;;   (... s ...))
;; 5. CODE
(define (run s)
  (big-bang (make-editor s "")
            [to-draw render]
            [on-key edit]
            )
  )


(run "12345678901234567890")
