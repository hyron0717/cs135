;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname beval) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))

;; A boolean expression (Bexp) is either
;; * a Boolean value (true or false),
;; * a comparison expression (Cexp), or
;; * a compound boolean expression (Cbexp)


(define-struct comp-exp (fn arg1 arg2))
;; A comparison expression (Cexp) is a structure
;; (make-comp-exp f a1 a2), where
;; * f is a Symbol from the set '>, '<, and '=
;; * a1 is a Num
;; * a2 is a Num

(define-struct compoundb-exp (op args))
;; A compound boolean expression (Cbexp) is a structure
;; (make-compoundb-exp b alist), where
;; * b is a Symbol from the set 'and and 'or
;; * alist is a Cbexplist

;; A Cbexplist is either
;; * empty, or
;; * (cons e alist), where e is a Bexp and alist is a Cbexplist


;; Templates (part (a))
;; my-Bexp-fn: Bexp -> Boolean
(define (my-Bexp-fn ex)
  (cond
    [(boolean? ex)...]
    [(comp-exp? ex) (my-Cexp-fn ex)]
    [(compoundb-exp? ex) (my-Cbexp-fn ex)]))

;; my-Cexp-fn: comp-exp -> Boolean
(define (my-Cexp-fn ex)
  (cond 
    [(symbol=? '= (comp-exp-fn ex))...]
    [(symbol=? '> (comp-exp-fn ex))...]
    [(symbol=? '< (comp-exp-fn ex))...]))

;; my-Cbexp-fn: compoundb-exp -> Boolean
(define (my-Cbexp-fn ex)
  (cond
    [(symbol=? 'and (compoundb-exp-op ex))...]
    [(symbol=? 'or (compoundb-exp-op ex))...]))

;; my-Chexplist-fn: Listof Cbexplist -> Boolean
(define (my-Chexplist-fn alist)
  (cond
    [(empty? alist)...]
    [else (... (first alist)...
               (rest alist)...)]))

;; bool-eval (part (b))

;; Contrast:
;; bool-eval: (Union Boolean comp-exp compoundb) -> Boolean
;; Purpose: Consumes a boolean expression then produces the boolean value.
;; Example: 
(check-expect (bool-eval (make-comp-exp '< 4 7)) true)
(check-expect (bool-eval (make-compoundb-exp 'or empty)) false)
(check-expect (bool-eval (make-compoundb-exp 'and (list (make-comp-exp '> 5 2) true true))) true)


;; Definition:
(define (bool-eval bexpr)
  (cond
    [(boolean? bexpr) bexpr]
    [(comp-exp? bexpr) (comp bexpr)]
    [(compoundb-exp? bexpr) (compoundb bexpr)]))


(define (comp a)
  (cond 
    [(symbol=? '= (comp-exp-fn a)) 
     (= (comp-exp-arg1 a)
        (comp-exp-arg2 a))]
    [(symbol=? '> (comp-exp-fn a))
     (> (comp-exp-arg1 a)
        (comp-exp-arg2 a))]
    [(symbol=? '< (comp-exp-fn a))     
     (< (comp-exp-arg1 a)
        (comp-exp-arg2 a))]))

(define (compoundb a)
  (cond 
    [(empty? (compoundb-exp-args a)) false]
    [(symbol=? 'and (compoundb-exp-op a))
     (and (exp-list (compoundb-exp-args a))
          (exp-list (rest (compoundb-exp-args a))))]
    
    [(symbol=? 'or (compoundb-exp-op a))
     (or (exp-list (compoundb-exp-args a))
         (exp-list (rest (compoundb-exp-args a))))]))

(define (exp-list alist)
  (cond
    [(empty? alist) empty]
    [else (bool-eval (first alist))]))

;; 
(check-expect (bool-eval (make-comp-exp '< 8 7)) false)
(check-expect (bool-eval (make-compoundb-exp 'and empty)) false)


