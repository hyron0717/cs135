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


(define sample-bst (make-node 75 "75" sample-bst-1 sample-bst-2))


(define sample-full-bst
  (make-node 2 "b" (make-node 1 "a" empty empty)
             (make-node 4 "d" (make-node 3 "c" empty empty)
                        (make-node 6 "f" (make-node 5 "e" empty empty)
                                   (make-node 8 "h" (make-node 7 "g" empty empty)
                                              (make-node 9 "i" empty empty))))))

(define sample-perfect-bst
  (make-node 2 "b" (make-node 1 "a" (make-node 0 "c" empty empty) (make-node 1.5 "aa" empty empty))
             (make-node 4 "d" (make-node 3 "c" empty empty) (make-node 6 "f" empty empty))))

