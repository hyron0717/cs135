;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname llt-height) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; A leaf-labelled tree (Llt) is one of the following:
;; * empty
;; * (cons l1 l2), where l1 is a non-empty Llt and l2 is an Llt
;; * (cons v l), where v is an Int and l is an Llt

;; Contrast:
;; height: Llt -> Int

;; Purpose: find the height of a leaf-lablled tree.
;; example:
(check-expect (height empty) 0)
(check-expect (height (list 1 2 3)) 1)

;; Definition:
(define (height t)
  (cond
    [(empty? t) 0]
    [(and (number? (first t))
          (empty? (rest t))) 1]
    [(and (number? (first t))
          (cons? (rest t))) 
     (height (rest t))]
    [(cons? (first t)) (max (+ 1 (height(first t))) (height (rest t)))]))

;; Test:
(check-expect (height (list (list 1) (list (list 8 9 10)))) 3)
(check-expect (height (list 4 (list (list 1) (list (list 8 9 10))))) 4)

