;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-133) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; http://www.ccs.neu.edu/home/matthias/HtDP2e/part_two.html#%28part._sec~3alists-programming%29


;; The cond clause functions as an or because it has two condition expressions:
;; one that checks if the first position equals "Flatt" and the second checks if
;; the rest of alon contains "Flatt".


;; The version using or is better because it does not contain a nested cond
;; clause and is therefore easier to read.

