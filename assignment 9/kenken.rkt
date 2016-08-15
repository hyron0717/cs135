;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname kenken) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define-struct puzzle (size board constraints))
;; A Puzzle = (make-puzzle 
;;               Nat 
;;               (listof (listof (union Symbol Nat Guess))
;;               (listof (list Symbol Nat Symbol)))
(define-struct guess (symbol number))
;; A Guess = (make-guess Symbol Nat)

;; Some useful constants
;; from assignment specification
(define puzzle1
  (make-puzzle 
   4
   (list
    (list 'a 'b 'b 'c)
    (list 'a 'd 'e 'e)
    (list 'f 'd 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'd 5 '+)
    (list 'e 3 '-)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1
(define puzzle1partial
  (make-puzzle 
   4
   (list
    (list 'a 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1 with a cage partially filled in
(define puzzle1partial2
  (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1 with a cage partially filled in
;; but not yet verified 
(define puzzle1partial3
  (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) 'b 'b 'c)
    (list (make-guess 'a 3) 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; The solution to puzzle 1
(define puzzle1soln
  (make-puzzle
   4
   '((2 1 4 3)
     (3 2 1 4)
     (4 3 2 1)
     (1 4 3 2))
   empty))

;; wikipedia KenKen example
(define puzzle2
  (make-puzzle
   6
   '((a b b c d d)
     (a e e c f d)
     (h h i i f d)
     (h h j k l l)
     (m m j k k g)
     (o o o p p g))
   '((a 11 +)
     (b 2 /)
     (c 20 *)
     (d 6 *)
     (e 3 -)
     (f 3 /)
     (g 9 +)
     (h 240 *)
     (i 6 *)
     (j 6 *)
     (k 7 +)
     (l 30 *)
     (m 6 *)
     (o 8 +)
     (p 2 /))))

;; The solution to puzzle 2
(define puzzle2soln
  (make-puzzle
   6
   '((5 6 3 4 1 2)
     (6 1 4 5 2 3)
     (4 5 2 3 6 1)
     (3 4 1 2 5 6)
     (2 3 6 1 4 5)
     (1 2 5 6 3 4))
   empty))

;; Tiny board
(define puzzle3
  (make-puzzle 
   2 
   '((a b) 
     (c b)) 
   '((b 3 +) 
     (c 2 =)
     (a 1 =))))

(define puzzle3partial
  (make-puzzle
   2 
   (list
    (list 'a (make-guess 'b 1))
    (list 'c (make-guess 'b 2)))
   '((b 3 +) 
     (c 2 =)
     (a 1 =))))  

;; a big board:  will take a *long* time without trying the bonus
(define puzzle4
  (make-puzzle
   9
   '((a a b c d e e f f)
     (g h b c d i j k l)
     (g h m m i i j k l)
     (n o m p p q q r s)
     (n o t u p v v r s)
     (n w t u x x y z z)
     (A w B C C C y D D)
     (A B B E E F G H I)
     (J J K K F F G H I))
   '((a 2 /)
     (b 11 +)
     (c 1 -)
     (d 7 *)
     (e 4 -)
     (f 9 +)
     (g 1 -)
     (h 4 /)
     (i 108 *)
     (j 13 +)
     (k 2 -)
     (l 5 -)
     (m 84 *)
     (n 24 *)
     (o 40 *)
     (p 18 *)
     (q 2 /)
     (r 2 -)
     (s 13 +)
     (t 10 +)
     (u 13 +)
     (v 2 -)
     (w 63 *)
     (x 1 -)
     (y 3 /)
     (z 2 /)
     (A 7 +)
     (B 13 +)
     (C 336 *)
     (D 1 -)
     (E 15 +)
     (F 12 *)
     (G 9 +)
     (H 5 -)
     (I 18 *)
     (J 3 /)
     (K 40 *))))

;;==============================================================================
;; Part (a)
;; find-blank: Puzzle -> (union Posn false 'guess)
;; find a blank space in the puzzle, or return false if the puzzle is complete

;; Example:
(check-expect (find-blank puzzle1) (make-posn 0 0))
(check-expect (find-blank puzzle4) (make-posn 0 0))

;; Definition:
(define (find-blank puz)
  (local
    [(define (posn-acc lst c acc)
       (cond
         [(empty? lst) false]
         
         [(and (member? c (first lst)) 
               (equal? c (first (first lst)))) acc]
         
         [(member? c (first lst))
          (posn-acc (list (rest (first lst))) c (make-posn (add1 (posn-x acc))
                                                           (posn-y acc)))]
         
         [else (posn-acc (rest lst) c
                         (make-posn 0 (add1 (posn-y acc))))]))]
    (cond
      [(empty? (puzzle-constraints puz)) false]
      
      [(and (false? (posn-acc (puzzle-board puz)
                              (first (first (puzzle-constraints puz))) 
                              (make-posn 0 0)))
            (fn-guess? (puzzle-board puz) 
                       (first (first (puzzle-constraints puz))))) 
       'guess]
      
      [else (posn-acc (puzzle-board puz)
                      (first (first (puzzle-constraints puz))) 
                      (make-posn 0 0))])))

;; Tests
(check-expect (find-blank puzzle1soln) false)
(check-expect (find-blank puzzle1partial2) (make-posn 0 1))
(check-expect (find-blank puzzle1partial3) 'guess)
(check-expect (find-blank puzzle3partial) 'guess)

;; Helpers:
;; listof (Union Num Symbol Guess) -> Boolean
;; Purpose: check the board whether contain a guess with first constraint

(define (fn-guess? lst c)
  (cond
    [(empty? lst) false]
    
    [(equal? true (guess?-row (first lst) c)) true]
    
    [else
     (fn-guess? (rest lst) c)]))

(define (guess?-row lst a)
  (cond 
    [(empty? lst) false]
    [else
     (cond 
       [(and (guess? (first lst))
             (equal? a (guess-symbol (first lst))))
        true]
       [else (guess?-row (rest lst) a)])]))

(check-expect (fn-guess? (puzzle-board puzzle1partial3) 'a) true)
(check-expect (fn-guess? (puzzle-board puzzle3partial) 'b) true)

;;==============================================================================
;; Part (b)
;; used-in-row: Puzzle Posn -> (listof nat)
;; produce the list of numbers used in the same row as the (x,y) location
;; in the puzzle

;; Example:
(check-expect (used-in-row puzzle1 (make-posn 1 1)) empty)
(check-expect (used-in-row puzzle1partial3 (make-posn 0 2)) (list 3))

;; Definition:
(define (used-in-row puz pos)
  (quicksort
   (filter number? 
           (map
            (lambda (a)
              (cond
                [(guess? a) (guess-number a)]
                [else a]))
            (list-ref (puzzle-board puz)
                      (posn-y pos)))) <))

;; Test: 
(check-expect (used-in-row puzzle1partial (make-posn 2 2)) (list 3))
(check-expect (used-in-row puzzle1partial2 (make-posn 0 1)) (list 1 2 4))

;; used-in-column: puzzle posn -> (listof nat)
;; produce the list of numbers used in the same column as the (x,y) location
;; in the puzzle
(check-expect (used-in-column puzzle1 (make-posn 1 1)) empty)
(check-expect (used-in-column puzzle1partial (make-posn 2 2)) (list 1))
(check-expect (used-in-column puzzle1partial2 (make-posn 0 1)) (list 2))

;; Definition:
(define (used-in-column puz pos)
  (quicksort
   (map
    (lambda (a)
      (cond
        [(guess? a) (guess-number a)]
        [else a]))
    (filter
     (lambda (x)
       (or (number? x) (guess? x)))
     (map 
      (lambda (lst)
        (list-ref lst
                  (posn-x pos)))
      (puzzle-board puz)))) <))

;; Test:
(check-expect (used-in-column puzzle4 (make-posn 0 0)) empty)
(check-expect (used-in-column puzzle2soln (make-posn 0 1)) (list 1 2 3 4 5 6))

;;==============================================================================
;; Part (c)

;; This function may be useful in available-vals
(define (allvals n) (build-list n (lambda (x) (add1 x))))
(check-expect (allvals 3) (list 1 2 3))

;; available-vals: Puzzle Posn -> (listof Nat)
;; produce the list of valid entries for the (x,y) location of the puzzle
(check-expect (available-vals puzzle1 (make-posn 2 3)) '(1 2 3 4))
(define (available-vals puz pos)
  (filter
   (lambda (x)
     (not (member? x (used-in-row puz pos))))
   (filter
    (lambda (y)
      (not (member? y (used-in-column puz pos))))
    (allvals (puzzle-size puz)))))

(check-expect (available-vals puzzle1partial (make-posn 2 2)) '(2 4))
(check-expect (available-vals puzzle1partial2 (make-posn 0 1)) '(3))
(check-expect (available-vals puzzle1soln (make-posn 0 1)) '())


;;==============================================================================
;; Part (d)
;;
;; place-guess: (listof (listof (union Symbol Nat Guess))) Posn Nat 
;;              -> (listof (listof (union Symbol Nat Guess)))
;; fill in the (x,y) location of the board puz with val

;; Example:
(check-expect (place-guess (puzzle-board puzzle1) (make-posn 3 2) 5)
              (list
               (list 'a 'b 'b 'c)
               (list 'a 'd 'e 'e)
               (list 'f 'd 'g (make-guess 'g 5))
               (list 'f 'h 'i 'i)))

(check-expect (place-guess (puzzle-board puzzle3) (make-posn 1 1) 1)
              (list (list 'a 'b)
                    (list 'c (make-guess 'b 1))))

;; Definition:
(define (place-guess brd pos val)
  (local
    [(define (acc-fn lst y)
       (cond
         [(empty? lst) empty]
         
         [(= y (posn-y pos))
          (cons
           (change-in-row brd pos val)
           (acc-fn (rest lst) (add1 y)))]
         
         [else (cons (first lst)
                     (acc-fn (rest lst) (add1 y)))]))]
    
    (acc-fn brd 0)))

;; Test:
(check-expect (place-guess (puzzle-board puzzle1partial2) (make-posn 1 0) 1)
              (list
               (list (make-guess 'a 2) (make-guess 'b 1) 'b 'c)
               (list 'a 2 1 4)
               (list 'f 3 'g 'g)
               (list 'f 'h 'i 'i)))


;; helper:
(define (change-in-row brd pos val)
  (local
    [(define (acc-row-fn lst x)
       (cond
         [(empty? lst) empty]
         
         [(= x (posn-x pos)) 
          (cons 
           (make-guess (first lst) val)
           (acc-row-fn (rest lst) (add1 x)))]
         
         [else (cons 
                (first lst)
                (acc-row-fn (rest lst) (add1 x)))]))]
    
    (acc-row-fn (list-ref brd (posn-y pos)) 0)))

(check-expect (change-in-row (puzzle-board puzzle1) (make-posn 3 2) 5) 
              (list 'f 'd 'g (make-guess 'g 5)))

;; fill-in-guess: Puzzle Posn Nat -> Puzzle
;; fill in the (x,y) location of puz with val
(check-expect (fill-in-guess puzzle1 (make-posn 3 2) 5)
              (make-puzzle
               4
               (list
                (list 'a 'b 'b 'c)
                (list 'a 'd 'e 'e)
                (list 'f 'd 'g (make-guess 'g 5))
                (list 'f 'h 'i 'i))
               (puzzle-constraints puzzle1)))
(define (fill-in-guess puz pos val)
  (make-puzzle (puzzle-size puz) 
               (place-guess (puzzle-board puz) pos val) 
               (puzzle-constraints puz)))

;;==============================================================================
;; Part (e)
;;
;; guess-valid?: Puzzle -> Boolean
;; guess-valid?:  verify that the guesses made on the board are valid

;; Example:
(check-expect (guess-valid? puzzle1partial3) true)

;; Definition:
(define (guess-valid? puz)
  (local
    [(define guess-list
       (quicksort
        (map
         guess-number
         (filter
          (lambda (x)
            (and (guess? x)
                 (equal? (first (first (puzzle-constraints puz))) 
                         (guess-symbol x))))
          (foldr append empty (puzzle-board puz)))) 
        <))]
    
    (cond
      [(equal? (third (first (puzzle-constraints puz))) '+)
       (equal? (second (first (puzzle-constraints puz))) (foldr + 0 guess-list))]
      
      [(equal? (third (first (puzzle-constraints puz))) '-)
       (equal? (second (first (puzzle-constraints puz))) (foldr - 0 guess-list))]
      
      [(equal? (third (first (puzzle-constraints puz))) '*)
       (equal? (second (first (puzzle-constraints puz))) (foldr * 1 guess-list))]
      
      [(equal? (third (first (puzzle-constraints puz))) '/)
       (equal? (second (first (puzzle-constraints puz))) (foldr / 1 guess-list))]
      
      [(equal? (third (first (puzzle-constraints puz))) '=)
       (= (second (first (puzzle-constraints puz))) (first guess-list))])))

(check-expect (guess-valid? puzzle3partial) true)

;;==============================================================================
;; Part (f)
;; 
;; apply-guess:  Puzzle -> Puzzle
;; apply the guesses by converting them into numbers and removing the first element
;; from the constraints

;; Example:

(check-expect (apply-guess puzzle1partial3)
  (make-puzzle 
   4
   (list
    (list 2 'b 'b 'c)
    (list 3 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; Definition:
(define (apply-guess puz)
  (make-puzzle
   (puzzle-size puz)
   (foldr
    (lambda (x y)
      (cond
        [(empty? x) y]
        [else (cons 
               (map (lambda (a) 
                      (cond
                        [(guess? a) (guess-number a)]
                        [else a]))
                    x) y)]))
    empty
    (puzzle-board puz))
   (rest (puzzle-constraints puz))))

;; Test:
(check-expect (apply-guess puzzle3partial)
              (make-puzzle
               2 
               (list
                (list 'a 1)
                (list 'c 2))
               '((c 2 =)
                 (a 1 =))))  
;
;;==============================================================================
;; Part (g)
;;
;; neighbours: Puzzle -> (listof Puzzle)
;; produce a list of next puzzles in the implicit graph
;; Example:
(check-expect (neighbours puzzle3)
              (list 
               (make-puzzle 
                2 
                (list 
                 (list 'a (make-guess 'b 1)) 
                 (list 'c 'b)) 
                '((b 3 +) 
                  (c 2 =)
                  (a 1 =)))
               (make-puzzle 
                2 
                (list 
                 (list 'a (make-guess 'b 2)) 
                 (list 'c 'b)) 
                '((b 3 +) 
                  (c 2 =)
                  (a 1 =)))))

(check-expect (neighbours puzzle1partial3)
              (list 
               (make-puzzle 
                4
                (list
                 (list 2 'b 'b 'c)
                 (list 3 2 1 4)
                 (list 'f 3 'g 'g)
                 (list 'f 'h 'i 'i))
                (list
                 (list 'b 3 '-)
                 (list 'c 3 '=)
                 (list 'f 3 '-)
                 (list 'g 2 '/)
                 (list 'h 4 '=)
                 (list 'i 1 '-)))))

;; Definition:
(define (neighbours puz)
  (cond 
    [(false? (find-blank puz)) empty]
    
    [(equal? 'guess (find-blank puz)) (list (apply-guess puz))]
    
    [else (map 
           (lambda (x)
             (make-puzzle
              (puzzle-size puz)
              (place-guess (puzzle-board puz) 
                           (find-blank puz)
                           x)
              (puzzle-constraints puz)))
           (available-vals puz (find-blank puz)))]))

;; Test:
(check-expect (neighbours puzzle2soln) empty)

(check-expect (neighbours puzzle3partial)
              (list 
               (make-puzzle
                2 
                (list
                 (list 'a 1)
                 (list 'c 2))
                '((c 2 =)
                  (a 1 =))))) 
(check-expect (neighbours puzzle1)
              (list
               (make-puzzle
                4
                (list 
                 (list (make-guess 'a 1) 'b 'b 'c) 
                 (list 'a 'd 'e 'e) 
                 (list 'f 'd 'g 'g) 
                 (list 'f 'h 'i 'i))
                (list (list 'a 6 '*) 
                      (list 'b 3 '-) 
                      (list 'c 3 '=) 
                      (list 'd 5 '+) 
                      (list 'e 3 '-) 
                      (list 'f 3 '-) 
                      (list 'g 2 '/) 
                      (list 'h 4 '=) 
                      (list 'i 1 '-)))
               (make-puzzle
                4
                (list 
                 (list (make-guess 'a 2) 'b 'b 'c) 
                 (list 'a 'd 'e 'e) 
                 (list 'f 'd 'g 'g) 
                 (list 'f 'h 'i 'i))
                (list (list 'a 6 '*) 
                      (list 'b 3 '-) 
                      (list 'c 3 '=) 
                      (list 'd 5 '+) 
                      (list 'e 3 '-) 
                      (list 'f 3 '-) 
                      (list 'g 2 '/) 
                      (list 'h 4 '=) 
                      (list 'i 1 '-)))
               (make-puzzle
                4
                (list 
                 (list (make-guess 'a 3) 'b 'b 'c) 
                 (list 'a 'd 'e 'e) 
                 (list 'f 'd 'g 'g) 
                 (list 'f 'h 'i 'i))
                (list (list 'a 6 '*) 
                      (list 'b 3 '-) 
                      (list 'c 3 '=) 
                      (list 'd 5 '+) 
                      (list 'e 3 '-) 
                      (list 'f 3 '-) 
                      (list 'g 2 '/) 
                      (list 'h 4 '=) 
                      (list 'i 1 '-)))
               (make-puzzle
                4
                (list 
                 (list (make-guess 'a 4) 'b 'b 'c) 
                 (list 'a 'd 'e 'e) 
                 (list 'f 'd 'g 'g) 
                 (list 'f 'h 'i 'i))
                (list (list 'a 6 '*) 
                      (list 'b 3 '-) 
                      (list 'c 3 '=) 
                      (list 'd 5 '+) 
                      (list 'e 3 '-) 
                      (list 'f 3 '-) 
                      (list 'g 2 '/) 
                      (list 'h 4 '=) 
                      (list 'i 1 '-)))))


;; This is just the find-route function from Module 12, slides
;; 30-36.  (Read a bit ahead if you want the deatils.) The explicit
;; graph G has been removed, and the termination condition (the desired
;; destination) is when the puzzle is complete (that is, find-blank
;; returns false).

;; solve-kenken: Puzzle -> (union Puzzle false)
;; find a solution to a KenKen puzzle, or return false if there is no
;; solution
(check-expect (time (solve-kenken puzzle1)) puzzle1soln)
(define (solve-kenken orig)
  (local
    [(define (solve-kenken-helper to-visit visited)
       (cond
         [(empty? to-visit) false]
         [(boolean? (find-blank (first to-visit))) (first to-visit)]
         [(member (first to-visit) visited)
          (solve-kenken-helper (rest to-visit) visited)]
         [else
          (local [(define nbrs (neighbours (first to-visit)))
                  (define new (filter (lambda (x) (not (member x visited))) nbrs))
                  (define new-to-visit (append new (rest to-visit)))
                  (define new-visited (cons (first to-visit) visited))]
            (solve-kenken-helper new-to-visit new-visited))]))]
    (solve-kenken-helper (list orig) empty)))
;;; The time special form shows you the number of milliseconds spent
;;; evaluating the given expression.  The first number (cpu time) is
;;; the important one.
(check-expect (time (solve-kenken puzzle2)) puzzle2soln)
(check-expect (solve-kenken puzzle3partial) false)