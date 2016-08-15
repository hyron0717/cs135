;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cards) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;
;; *************************************************
;;
;; CS 135 Assignment 3, Question 3
;; HaoJun Luo, 20528243
;;
;; *************************************************

;; 3.
;; a.
(define-struct card (suit rank))
;; A Card = (make-Card Symbol Int)
;; my-Card-fn: Card -> Any
(define (my-Card-fn info)
  (... (card-suit info)...
   ... (card-rank info)...))



;; b.
;; Contract: better-Card: Card Card -> Card
;; Purpose: Determine which Card is better.

;; Exapmle:
(check-expect (better-Card (make-card 'diamonds 1) (make-card 'diamond 2)) (make-card 'diamond 2))
(check-expect (better-Card (make-card 'clubs 9) (make-card 'diamond 1)) (make-card 'diamond 1))

;; Defination:
(define (better-Card Card1 Card2)
  (cond
    [(and (symbol=? (card-suit Card1) (card-suit Card2)) 
          (> (card-rank Card1) (card-rank Card2))) 
     Card1]
    
    [(and (symbol=? (card-suit Card1) 'diamonds) 
          (symbol=? (card-suit Card2) 'clubs)) 
     Card1]
    
    [(or (and (symbol=? (card-suit Card1) 'heart) 
              (symbol=? (card-suit Card2) 'clubs))
         (and (symbol=? (card-suit Card1) 'heart) 
              (symbol=? (card-suit Card2) 'diamonds))) 
     Card1]
    
    [(or (and (symbol=? (card-suit Card1) 'spades) 
              (symbol=? (card-suit Card2) 'clubs))
         (and (symbol=? (card-suit Card1) 'spades) 
              (symbol=? (card-suit Card2) 'diamonds))
         (and (symbol=? (card-suit Card1) 'spades) 
              (symbol=? (card-suit Card2) 'hearts))) 
     Card1]
    
    [else Card2]))

;; Test:
(check-expect (better-Card (make-card 'diamonds 1) (make-card 'diamonds 1)) (make-card 'diamonds 1))
(check-expect (better-Card (make-card 'spades 13) (make-card 'diamonds 2)) (make-card 'spades 13))



;; c.
;; Contract: hand-value: Card Card Card -> Symbol
;; Purpose: Determine the hand value of three cards

;; Example:
(check-expect (hand-value (make-card 'diamonds 1) (make-card 'diamonds 2) (make-card 'diamonds 3)) 'straight-flush)
(check-expect (hand-value (make-card 'clubs 1) (make-card 'diamonds 2) (make-card 'heart 3)) 'straight)

;; Defination:
(define d 1) ;; consecutive integers mean the difference between two numbers is 1

(define (hand-value Card1 Card2 Card3)
  (cond
    [(and (symbol=? (card-suit Card1) (card-suit Card2)) 
          (symbol=? (card-suit Card1) (card-suit Card3))) 
     
     (cond [(or (and (= (abs (- (card-rank Card1) 
                                (card-rank Card2))) d)
                     (= (abs (- (card-rank Card3) 
                                (card-rank Card2))) d))
                
                (and (= (abs (- (card-rank Card1) 
                                (card-rank Card2))) d)
                     (= (abs (- (card-rank Card1) 
                                (card-rank Card3))) d))
                
                (and (= (abs (- (card-rank Card1) 
                                (card-rank Card3))) d)
                     (= (abs (- (card-rank Card3) 
                                (card-rank Card2))) d)))
             'straight-flush]
           
           [else 'flush])]
    
    [else 
     (cond 
       [(and (= (card-rank Card1) (card-rank Card2)) 
             (= (card-rank Card2) (card-rank Card3)))
            'three-of-a-kind]
       
       [(or (= (card-rank Card1) (card-rank Card2)) 
                (= (card-rank Card2) (card-rank Card3))
                (= (card-rank Card1) (card-rank Card3)))
            'pair]
       
       [(or (and (= (abs (- (card-rank Card1) 
                            (card-rank Card2))) d)
                 (= (abs (- (card-rank Card3) 
                            (card-rank Card2))) d))
                
            (and (= (abs (- (card-rank Card1) 
                            (card-rank Card2))) d)
                 (= (abs (- (card-rank Card1) 
                            (card-rank Card3))) d))
               
            (and (= (abs (- (card-rank Card1) 
                            (card-rank Card3))) d)
                 (= (abs (- (card-rank Card3) 
                            (card-rank Card2))) d)))
            'straight]
       
           [else 'high-card])]))

;; Test: 
(check-expect (hand-value (make-card 'clubs 5) (make-card 'diamonds 4) (make-card 'heart 6)) 'straight)
(check-expect (hand-value (make-card 'clubs 1) (make-card 'diamonds 1) (make-card 'heart 1)) 'three-of-a-kind)
(check-expect (hand-value (make-card 'clubs 1) (make-card 'diamonds 2) (make-card 'heart 1)) 'pair)
(check-expect (hand-value (make-card 'clubs 1) (make-card 'clubs 5) (make-card 'clubs 7)) 'flush)
(check-expect (hand-value (make-card 'clubs 1) (make-card 'clubs 3) (make-card 'clubs 2)) 'straight-flush)
(check-expect (hand-value (make-card 'clubs 1) (make-card 'spades 3) (make-card 'clubs 10)) 'high-card)

