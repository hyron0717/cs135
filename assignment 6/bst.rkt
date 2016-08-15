;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname bst) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************
;;
;; CS 135 Assignment 5
;; HaoJun Luo, 20528243
;; Question 1
;;
;; *************************************************
(define-struct node (key val left right))

(define sample-bst-1
  (make-node 8 "8" 
             (make-node 4 "4" 
                        (make-node 2 "2" 
                                   (make-node 1 "1" empty empty)
                                   (make-node 3 "3" empty empty))
                        (make-node 6 "6"
                                   (make-node 5 "5" empty empty)
                                   (make-node 7 "7" empty empty)))
             (make-node 12 "12"
                        (make-node 10 "10"
                                   (make-node 9 "9" empty empty)
                                   (make-node 11 "11" empty empty))
                        (make-node 14 "14"
                                   (make-node 13 "13" empty empty) empty))))

(define sample-bst-2
  (make-node 154 "150" 
             (make-node 110 "110" empty
                        (make-node 142 "142" 
                                   (make-node 111 "111" empty empty)
                                   (make-node 144 "144" empty empty)))
             (make-node 212 "212"
                        (make-node 177 "177" empty empty)
                        (make-node 242 "242" empty
                                   (make-node 266 "266" empty
                                              (make-node 391 "391" 
                                                         (make-node 305 "305" empty empty) empty))))))
(define my-bst-1
  (make-node 10 "10" 
             empty (make-node 15 "15" empty 
                              (make-node 20 "20" empty
                                         (make-node 25 "25" empty empty)))))

(define my-bst-2
  (make-node 10 "10" 
             (make-node 5 "5" empty empty) (make-node 15 "15" empty 
                                                      (make-node 20 "20" empty
                                                                 (make-node 25 "25" empty empty)))))

;; a.
;; Contrast:
;; bst-add: Bst Symbol Num -> Bst
;; Purpose: add a binary search tree in abst.

;; Example:
(check-expect (bst-add my-bst-1 5 "5") 
              (make-node 10 "10" 
                         (make-node 5 "5" empty empty) 
                         (make-node 15 "15" empty 
                                    (make-node 20 "20" empty
                                               (make-node 25 "25" empty empty)))))

(check-expect (bst-add empty 15 "15") (make-node 15 "15" empty empty))

;; Definition:
(define (bst-add abst k v)
  (cond
    [(empty? abst) (make-node k v empty empty)]
    
    [(= k (node-key abst)) (make-node k 
                                      v
                                      (node-left abst) 
                                      (node-right abst))]
    
    [(< k (node-key abst)) 
     (make-node (node-key abst) 
                (node-val abst) 
                (bst-add (node-left abst) k v) 
                (node-right abst))]
    
    [(> k (node-key abst)) 
     (make-node (node-key abst) 
                (node-val abst) 
                (node-left abst) 
                (bst-add (node-right abst) k v))]))

;; Test:
(check-expect (bst-add sample-bst-1 15 "15")
              (make-node 8 "8" 
                         (make-node 4 "4" 
                                    (make-node 2 "2" 
                                               (make-node 1 "1" empty empty)
                                               (make-node 3 "3" empty empty))
                                    (make-node 6 "6"
                                               (make-node 5 "5" empty empty)
                                               (make-node 7 "7" empty empty)))
                         (make-node 12 "12"
                                    (make-node 10 "10"
                                               (make-node 9 "9" empty empty)
                                               (make-node 11 "11" empty empty))
                                    (make-node 14 "14"
                                               (make-node 13 "13" empty empty) 
                                               (make-node 15 "15" empty empty)))))

(check-expect (bst-add sample-bst-1 10 "15")
              (make-node 8 "8" 
                         (make-node 4 "4" 
                                    (make-node 2 "2" 
                                               (make-node 1 "1" empty empty)
                                               (make-node 3 "3" empty empty))
                                    (make-node 6 "6"
                                               (make-node 5 "5" empty empty)
                                               (make-node 7 "7" empty empty)))
                         (make-node 12 "12"
                                    (make-node 10 "15"
                                               (make-node 9 "9" empty empty)
                                               (make-node 11 "11" empty empty))
                                    (make-node 14 "14"
                                               (make-node 13 "13" empty empty) 
                                               empty))))

;; b.
;; Contrast: 
;; bst-full?: Bst -> Boolean
;; Purpose: determine whether the binary tree is full or not.

;; Example: 
(check-expect (bst-full? empty) true)
(check-expect (bst-full? my-bst-1) false)

;; Definition:
(define (bst-full? abst)
  (cond 
    [(empty? abst) true]
    [else (and (full? abst)
               (full? (node-left abst))
               (full? (node-right abst)))]))
  

;; Helper funtion:
;; Contrast: 
;; full?: Bst -> Boolean

;; Purpose: determine whether a element in the binary tree is full or not.
;; Example: 
(check-expect (bst-full? empty) true)
(check-expect (bst-full? (make-node 2 "2" 
                                    (make-node 1 "1" empty empty) 
                                    (make-node 3 "3" empty empty))) true)

;; Definition:
(define (full? abst)
  (cond 
    [(or (and (empty? (node-left abst))
              (empty? (node-right abst)))
         (and (node? (node-left abst))
              (node? (node-right abst))))
     true]
    [else false]))

;; Test: 
(check-expect (bst-full? sample-bst-1) true)
(check-expect (bst-full? sample-bst-2) false)

;; c.
;; Contrast: 
;; bst-height: Bst -> Int

;; Purpose: determine the height of a binary tree.
;; Example:
(check-expect (bst-height empty) 0)
(check-expect (bst-height my-bst-1) 4)

;; Definition
(define (bst-height abst) 
  (cond
    [(empty? abst) 0]
    [else 
     (+ 1 (max (bst-height (node-left abst))
               (bst-height (node-right abst))))]))

;; Test:
(check-expect (bst-height sample-bst-1) 4)
(check-expect (bst-height sample-bst-2) 6)
(check-expect (bst-height (make-node 2 "" 
                                     (make-node 1 "" empty empty)
                                     (make-node 3 "" empty 
                                                (make-node 4 "" empty empty)))) 3)

;; d.
;; Contrast: 
;; bst-perfect?: Bst -> Boolean

;; Purpose: determine a binary tree is perfect or not.
;; Example: 
(check-expect (bst-perfect? empty) true)
(check-expect (bst-perfect? sample-bst-1) false)

;; Definition:
(define (bst-perfect? abst)
  (cond
    [(empty? abst) true]
    [(and (empty? (node-left abst))
          (empty? (node-right abst)))
     true]
    [(bst-full? abst)
     (equal? (bst-perfect? (node-left abst))
             (bst-perfect? (node-right abst)))]
    [else false]))

;; Test:
(check-expect (bst-perfect? (bst-add sample-bst-1 15 "15")) true)
(check-expect (bst-perfect? my-bst-1) false)
(check-expect (bst-perfect? my-bst-2) false)
(check-expect (bst-perfect? sample-bst-2) false)

;; e. 
;; Contrast: 
;; bst->sal: Bst-> (listof AL)

;; Purpose: make a list of AL contains the elements in the binary search tree.
;; Example: 
(check-expect (bst->sal empty) empty)
(check-expect (bst->sal my-bst-1)
              (list (list 10 "10") 
                    (list 15 "15") 
                    (list 20 "20") 
                    (list 25 "25")))


;; Definition:
(define (bst->sal abst)
  (cond 
    [(empty? abst) empty]
    
    [(and (empty? (node-left abst))
          (node? (node-right abst)))
     (append (list (list (node-key abst)
                         (node-val abst)))
             (bst->sal (node-right abst)))]
    
    [(and (empty? (node-right abst))
          (node? (node-left abst)))
     (append (bst->sal (node-left abst))
             (list (list (node-key abst)
                         (node-val abst))))]
    
    [else
     (append (bst->sal (node-left abst))
             (list (list (node-key abst)
                         (node-val abst)))
             (bst->sal (node-right abst)))]))

;; Test: 
(check-expect (bst->sal my-bst-2)
              (list (list 5 "5") 
                    (list 10 "10") 
                    (list 15 "15") 
                    (list 20 "20") 
                    (list 25 "25")))

(check-expect (bst->sal sample-bst-1)
              (list(list 1 "1")
                   (list 2 "2")
                   (list 3 "3")
                   (list 4 "4")
                   (list 5 "5")
                   (list 6 "6")
                   (list 7 "7")
                   (list 8 "8")
                   (list 9 "9")
                   (list 10 "10")
                   (list 11 "11")
                   (list 12 "12")
                   (list 13 "13")
                   (list 14 "14")))