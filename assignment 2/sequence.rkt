;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname sequence) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; 2.
;; a.
;; Contrart: Num Num Num -> Symbol
;; Purpose: Determine the numbers whether is arithmetic sequence or not
;; Example: 
(check-expect (arith-seq-cond? 1 2 3) true)
(check-expect (arith-seq-cond? 5 7 9) true)
;;Defination:

;;difference between two numbers
(define (arith-seq-cond? a b c) 
  (cond [(= (abs (- b a)) (abs (- c b))) true]
        [else(cond [(= (abs (- c a)) (abs (- c b))) true]
                   [else(cond [(= (abs (- c a)) (abs (- b a))) true]
                              [else false])])]))
;;Test:
(check-expect (arith-seq-cond? 9 5 7) true)
(check-expect (arith-seq-cond? 4 6 7) false)
(check-expect (arith-seq-cond? 7 9 5) true)

;; b.
;; Contrart: Num Num Num -> Boolean
;; Purpose: Determine the numbers whether is arithmetic sequence or not
;; Example: 
(check-expect (arith-seq-bool? 1 2 3) true)
(check-expect (arith-seq-bool? 5 7 9) true)
;;Defination:

;;difference between two numbers
(define (arith-seq-bool? a b c) 
  (or (= (abs (- b a)) (abs (- c b)))
      (= (abs (- c a)) (abs (- c b)))
      (= (abs (- c a)) (abs (- b a)))))
;;Test:
(check-expect (arith-seq-bool? 9 5 7) true)
(check-expect (arith-seq-bool? 4 6 7) false)
(check-expect (arith-seq-bool? 7 9 5) true)