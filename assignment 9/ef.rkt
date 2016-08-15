;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ef) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
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
;; Part (e)

;; guess-valid?:  verify that the guesses made on the board are valid
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
;; neighbours: Puzzle -> (listof Puzzle)
;; produce a list of next puzzles in the implicit graph
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
(define (neighbours puz)
 ...)
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


;; This is just the find-route function from Module 12, slides
;; 30-36.  (Read a bit ahead if you want the deatils.) The explicit
;; graph G has been removed, and the termination condition (the desired
;; destination) is when the puzzle is complete (that is, find-blank
;; returns false).

;; solve-kenken: Puzzle -> (union Puzzle false)
;; find a solution to a KenKen puzzle, or return false if there is no
;; solution
