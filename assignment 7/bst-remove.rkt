;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname bst-remove) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************
;;
;; CS 135 Assignment 7, Question 2
;; HaoJun Luo, 20528243
;;
;; *************************************************


(define-struct node (key val left right))
(define t 
  (make-node 5 "" 
             (make-node 3 "" 
                        (make-node 2 "" 
                                   (make-node 1 "" empty empty) 
                                   empty) 
                        (make-node 4 "" empty empty)) 
             (make-node 7 "" 
                        (make-node 6 "" empty empty) 
                        empty)))

;; Contrast:
;; bst-remove: Bst Num -> Bst
;; Purpose: remove an element in the binary search tree.
;; Example:
(check-expect (bst-remove empty 1) empty)
(check-expect (bst-remove t 1) 
              (make-node 5 "" 
                         (make-node 3 "" 
                                    (make-node 2 "" empty empty) 
                                    (make-node 4 "" empty empty)) 
                         (make-node 7 "" 
                                    (make-node 6 "" empty empty) empty)))
;; Definition:
(define (bst-remove t k)
  (cond
    [(empty? t) empty]
    
    [(< k (node-key t)) 
     (make-node (node-key t) 
                (node-val t) 
                (bst-remove (node-left t) k) 
                (node-right t))]
    
    [(> k (node-key t)) 
     (make-node (node-key t) 
                (node-val t) 
                (node-left t) 
                (bst-remove (node-right t) k))]
    
    [(= k (node-key t)) 
     (cond
       [(and (empty? (node-left t))
             (empty? (node-right t)))
        empty]
       
       [(and (node? (node-left t))
             (empty? (node-right t)))
        (node-left t)]
       
       [(and (empty? (node-left t))
             (node? (node-right t)))
        (node-right t)]
       
       [(and (node? (node-left t))
             (node? (node-right t)))
        (local
          [(define (inorder-successor t)
             (cond
               [(empty? (node-left t)) t]
               [else (inorder-successor (node-left t))]))]
          
          (make-node (node-key (inorder-successor (node-right t)))
                     (node-val (inorder-successor (node-right t)))
                     (node-left t)
                     (node-right 
                      (bst-remove t 
                                  (node-key (inorder-successor (node-right t)))))))])]))

;; Test:
(check-expect (bst-remove t 7) 
              (make-node 5 "" 
                         (make-node 3 "" 
                                    (make-node 2 "" 
                                               (make-node 1 "" empty empty) empty) 
                                    (make-node 4 "" empty empty))
                         (make-node 6 "" empty empty)))
