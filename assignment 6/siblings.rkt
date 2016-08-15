;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname siblings) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; Contrast:
;; num-siblings: Bst Num -> (Union Num false)

;; Purpose: find how many siblings n have
;; Example: 
(check-expect (num-siblings (list (list 1 2) 3 (list 4)) 3) 0)
(check-expect (num-siblings empty 1) false)

;; Definition:
(define (num-siblings abst n)
  (count (searcher abst n) n))

;; Helper1:
;; Contrast: 
;; searcher: Llt Int -> (Union Llt false)

;; Purpose: find the list with n.
;; Example: 
(check-expect (searcher (list (list 1 2 3) (list (list 4 5 6))) 3) (list 1 2 3))
(check-expect (searcher empty 1) false)

(define (searcher abst n)
  (cond
    [(empty? abst) false]
    [(cons? (num-searcher (first abst) n)) 
     (num-searcher (first abst) n)]
    [(false? (num-searcher (first abst) n))
     (num-searcher (rest abst) n)]))

;; Helper2:
;; Contrast:
;; num-searcher: Llt Int -> (Union Llt false)
;; Purpose: find the list from Llt with n.
(define (num-searcher abst n)
  (cond 
    [(empty? abst) false]
    [(member? n abst) abst]
    [else 
     (cond
       [(cons? (first abst))
        (num-searcher (first abst) n)]
       
       [else 
        (num-searcher (rest abst) n)])]))

;; Helper3:
;; Contrast: 
;; count: Llt Int -> Num 
;; Purpose: find out how many siblings with same parents.

;; Example:
(define (count alist n)
  (cond
    [(false? alist) false]
    [(empty? alist) 0]
    [(and (number? (first alist))
          (not (= (first alist) n)))
     (+ 1 (count (rest alist) n))]
    [else (count (rest alist) n)]))

;; Test:
(check-expect (num-siblings (list (list 1 2 3) (list (list 4 5 6))) 5) 2)
(check-expect (num-siblings (list (list 1 2 3) (list (list 4 5 6))) 9) false)