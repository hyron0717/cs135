;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bonus02) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 5.
;; Contract: Int Int Int -> Boolean
;; Purpose: Determine the numbers whether is arithmetic sequence or not
;; Example: 
(check-expect (arith-seq-math? 1 2 3) true)
(check-expect (arith-seq-math? 4 6 5) true)
;; Defination
(define (arith-seq-math? a b c)
  (= (/ (+ (max a b c) 
           (min a b c)) 2) 
     (/ (+ a b c) 3)))
;; Test:
(check-expect (arith-seq-math? 1 3 4) false)
(check-expect (arith-seq-math? 3 1 2) true)
(check-expect (arith-seq-math? 5 3 4) true)