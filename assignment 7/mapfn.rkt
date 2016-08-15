;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************
;;
;; CS 135 Assignment 7, Question 4
;; HaoJun Luo, 20528243
;;
;; *************************************************

;; Contrast: 
;; mapfn: (listof (Num -> Num)) (listof Num) -> (listof Num)

;; Purpose: consumes a list of functions and a list of two numbers then produces a list of number.
;; Example:
(check-expect (mapfn empty empty) empty)
(check-expect (mapfn empty (list 1 2)) empty)

;; Definition:
(define (mapfn lof lon)
  (cond
    [(empty? lof) empty]
    [(equal? + (first lof))
     (cons (+ (first lon) (second lon))
           (mapfn (rest lof) lon))]
    
    [(equal? - (first lof))
     (cons (- (first lon) (second lon))
           (mapfn (rest lof) lon))]
    
    [(equal? * (first lof))
     (cons (* (first lon) (second lon))
           (mapfn (rest lof) lon))]
    
    [(equal? / (first lof))
     (cons (/ (first lon) (second lon))
           (mapfn (rest lof) lon))]
    
    [(equal? list (first lof))
     (cons (list (first lon) (second lon))
           (mapfn (rest lof) lon))]))

;; Test:
(check-expect (mapfn (list + - * / list) '(3 2))
              (list 5 1 6 1.5 (list 3 2)))
(check-expect (mapfn (list + - * / list) '(8 2))
              (list 10 6 16 4 (list 8 2)))
