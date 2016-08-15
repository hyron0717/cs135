;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname bst-height) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
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

(define (bst-height abst) 
  (cond
    [(empty? abst) 0]
    [else 
     (cond
       [(and (empty? (node-left abst))
             (node? (node-right abst))) 
        (+ 1 (bst-height (node-right abst)))]
       [(and (empty? (node-right abst))
             (node? (node-left abst)))
        (+ 1 (bst-height (node-left abst)))]
       [(and (node? (node-left abst))
             (node? (node-right abst)))
        (max (helper1 abst) (helper2 abst))]
       [else 1])]))

(define (helper1 abst)
  (cond 
    [(empty? (node-left abst)) 1]
    [(and (node? (node-left abst))
          (node? (node-right abst)))
     (+ 1 (helper1 (node-left abst)))]
    [else (+ 1 (helper2 (node-right abst)))]))

(define (helper2 abst)
  (cond 
    [(empty? (node-right abst)) 1]
    [(and (node? (node-left abst))
          (node? (node-right abst)))
     (+ 1 (helper2 (node-right abst)))]
    [else (+ 1 (helper2 (node-right abst)))]))

(check-expect (bst-height sample-bst-1) 4)
(check-expect (bst-height sample-bst-2) 5)