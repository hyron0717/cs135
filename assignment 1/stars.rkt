;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname stars) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 5.
(define (row n) 
  (ceiling (/ n 2))) 

(define (firstnumber n) 
  (- n (* (- (row n) 1) 2)))

(define (starstep-stars n) 
  (/ (* (+ (firstnumber n) 
           n) 
        (row n)) 
     2))