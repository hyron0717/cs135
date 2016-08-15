;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname eval-apply) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************
;;
;; CS 135 Assignment 7, Question 3
;; HaoJun Luo, 20528243
;;
;; *************************************************

;; a.
;; An arithmetic expression (AE) is one of 
;; * a Num 
;; * a Symbol (compliant with Scheme rules for identifiers) 
;; * (cons Symbol AEList) (where Symbol is either ’+ or ’*) 
;; 
;; A list of arithmetic expressions (AEList) is one of 
;; * empty 
;; * (cons AE AEList) 
;; 
;; A list of defines and one expression (LODOE) is one of: 
;; * an AE 
;; * (cons ’(define Symbol Num) LODOE)

(define testlist-1
  (list (list 'one 1) 
        (list 'two 2) 
        (list 'three 3)
        (list 'four 4)))

;; Contrast:
;; lookup-al: (listof AL) Symbol -> (Union false Num)

;; Purpose: look up the value from the association list.
;; Example: 
(check-expect (lookup-al empty '+) false)
(check-expect (lookup-al (list (list '+ 1)) '+) 1)

;; Definition:
(define (lookup-al list-of-al k)
  (cond
    [(empty? list-of-al) false]
    
    [(equal? k (first (first list-of-al)))
     (second (first list-of-al))]
    
    [else (lookup-al (rest list-of-al) k)]))
;; Test:
(check-expect (lookup-al testlist-1 'four) 4)
(check-expect (lookup-al testlist-1 'five) false)

;; b.
;; Contrast:
;; eval1: AE (listof AL) -> Num

;; Purpose: consume an arithmetic expression and an association list and produce a value.
;; Example:
(check-expect (eval1 1 testlist-1) 1)
(check-expect (eval1 '+ testlist-1) 0)
(check-expect (eval1 '* testlist-1) 1)

;; Definition:
(define (eval1 ae list-of-al)
  (cond
    [(number? ae) ae]
    
    [(symbol? ae) 
     (cond 
       [(symbol=? ae '+) (+)]
       [(symbol=? ae '*) (*)]
       [else (lookup-al list-of-al ae)])]
    
    [else 
     (apply1 (first ae) (rest ae) list-of-al)]))

;; Test:
(check-expect (eval1 '(+ x (* y 2)) '((x 2) (y 3) (z 4))) 8)
(check-expect (eval1 '(+ 2 x (* y 2 z)) '((x 2) (y 3) (z 4))) 28)

;; Contrast:
;; apply1: Symbol AE (listof AL) -> Num

;; Purpose: consume a Symbol, an arithmetic expression and an association list and produce a value.
;; Example:
(check-expect (apply1 '+ empty testlist-1) 0)
(check-expect (apply1 '* empty testlist-1) 1)

;; Definition: 
(define (apply1 s ae list-of-al)
  (cond
    [(and (empty? ae) (symbol=? s '*)) 1]
    
    [(and (empty? ae) (symbol=? s '+)) 0]
    
    [(symbol=? s '*)
     (* (eval1 (first ae) list-of-al) 
        (apply1 s (rest ae) list-of-al))]
    
    [(symbol=? s '+)
     (+ (eval1 (first ae) list-of-al) 
        (apply1 s (rest ae) list-of-al))]))


;; Test:
(check-expect (apply1 '+ '(x (* y 2)) '((x 2) (y 3) (z 4))) 8)
(check-expect (apply1 '* '(x (* y 2)) '((x 2) (y 3) (z 4))) 12)


;; c.
;; Contrast:
;; eval2: LODOE -> Num

;; Purpose: consume a list of defines and one expression and an association list and produce a value.
;; Example:
(check-expect (eval2 '((define x 2) (+))) 0)
(check-expect (eval2 '((define x 2) (+ x 1))) 3)

;; Definition:
(define (eval2 lodoe)
  (local
    [(define (exp t)
       (cond
         [(empty? t) empty]
         
         [(symbol=? 'define (first (first t)))
          (exp (rest t))]
         
         [else (first t)]))
     
     (define (al-list t)
       (cond
         [(empty? t) empty]
         
         [(symbol=? 'define (first (first t)))
          (append (list (rest (first t))) (al-list (rest t)))]
         
         [else empty]))]
    (cond
      [(number? lodoe) lodoe]
      
      [else 
       (apply2 (first (exp lodoe)) (rest (exp lodoe)) (al-list lodoe))])))

;; Test:
(check-expect (eval2 '((define x 2) (define y 3) (define z 4) (+ x (* y 2)))) 8)
(check-expect (eval2 '((define x 2) (define y 3) (define z 4) (+ x y z))) 9)


;; Contrast:
;; apply2: Symbol AE (listof AL) -> Num

;; Purpose: consume a Symbol, an arithmetic expression and an association list and produce a value.
;; Example:
(check-expect (apply2 '+ empty testlist-1) 0)
(check-expect (apply2 '* empty testlist-1) 1)

(define (apply2 s lodoe list-of-al)
  (local
    [(define (ae-eval ae list-of-al)
       (cond
         [(number? ae) ae]
         
         [(symbol? ae) 
          (cond 
            [(symbol=? ae '+) (+)]
            [(symbol=? ae '*) (*)]
            [else (lookup-al list-of-al ae)])]
         
         [else (apply2 (first ae) (rest ae) list-of-al)]))]
    
    (cond
      [(and (empty? lodoe) (symbol=? s '*)) 1]
      
      [(and (empty? lodoe) (symbol=? s '+)) 0]
      
      [(symbol=? s '*)
       (* (ae-eval (first lodoe) list-of-al) 
          (apply2 s (rest lodoe) list-of-al))]
      
      [(symbol=? s '+)
       (+ (ae-eval (first lodoe) list-of-al) 
          (apply2 s (rest lodoe) list-of-al))])))

;; Test:
(check-expect (apply2 '+ '(x (* y 2)) '((x 2) (y 3) (z 4))) 8)
(check-expect (apply2 '* '(x (* y 2)) '((x 2) (y 3) (z 4))) 12)