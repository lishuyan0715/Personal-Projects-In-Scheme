;; Lab: Adversarial Search
;; CSC 261 
;;
;; File
;;   evaluation.scm
;;
;; Summary
;;   A collection of routines defining our evaluation 
;;    function for the game Mancala
;;
;; Provides
;;   (best-mancala-eval player)
;;   (mancala-total-stones hole limit sum-so-far board)
;;   (mancala-player-total-stones player board)
;;   (mancala-empty-ratio player board)
;;   (mancala-empty-holes board hole limit sum)

(module evaluation lang/plt-pretty-big
  (provide best-mancala-eval)
  (require "mancala.scm")

  ;;
  ;; Procedure
  ;;   best-mancala-eval
  ;;
  ;; Purpose
  ;;   Assesses the desirability of a state for player
  ;;
  ;; Parameters
  ;;   player, a boolean
  ;;
  ;; Produces
  ;;   eval, a procudure
  ;;
  ;; Preconditions
  ;;   [none]
  ;;
  ;; Postconditions
  ;;   eval takes a state and return a number that evaluates how desirable
  ;; the provided state is for player 
  (define best-mancala-eval
    (lambda (player)
      (lambda (state)
        (let ((board (cdr state)))
          (- (+ (* 1 (list-ref board (if player 6 13)))
                (* 1 (mancala-player-total-stones player board))
                (* 1 (mancala-empty-ratio player board)))
             (* 1 (mancala-player-total-stones (not player) board)))))))

  ;;
  ;; Procedure
  ;;   mancala-player-total-stones
  ;;
  ;; Purpose
  ;;   Chooses which side of the players' stones to count
  ;;
  ;; Parameters
  ;;   player, a boolean
  ;;   board, a list
  ;;
  ;; Produces
  ;;   stones, a positive interger
  ;;
  ;; Preconditions
  ;;   board is a list that represents a mancala board
  ;;
  ;; Postconditions
  ;;   stones is the number of total stones, minus the ones mancala
  (define mancala-player-total-stones
    (lambda (player board)
      (if player
          (mancala-total-stones 0 6 0 board)
          (mancala-total-stones 7 13 0 board))))

  ;;
  ;; Procedure
  ;;   mancala-total-stones
  ;;
  ;; Purpose
  ;;   Calculates the total number of stones on player's side
  ;;
  ;; Parameters
  ;;   hole, an integer
  ;;   limit, an integer
  ;;   sum-so-far, an integer
  ;;   board, a list
  ;;
  ;; Produces
  ;;   stones, a positive interger
  ;;
  ;; Preconditions
  ;;   limit does not exceed total number of holes on a board
  ;;
  ;; Postconditions
  ;;   stones is the number of total stones, minus the ones mancala
  (define mancala-total-stones
    (lambda (hole limit sum-so-far board)
      (if (< hole limit)
          (mancala-total-stones (+ 1 hole) limit
                                (+ sum-so-far (list-ref board hole)) board)
          sum-so-far)))
  
  ;;
  ;; Procedure
  ;;   mancala-empty-ratio
  ;;
  ;; Purpose
  ;;   Computes the ratio of empty holes between player and opponent
  ;;
  ;; Parameters
  ;;   player, a boolean
  ;;   board, a list
  ;;
  ;; Produces
  ;;   ratio, a number
  ;;
  ;; Preconditions
  ;;   [none]
  ;;
  ;; Postconditions
  ;;   ratio can be a positive or negative number
  (define mancala-empty-ratio
    (lambda (player board)
      (let ([weight 1])
        (- (* weight (mancala-player-empty-holes board 0 6 0))
           (* 0 (mancala-player-empty-holes board 7 13 0))))))


  ;;
  ;; Procedure
  ;;   mancala-empty-holes
  ;;
  ;; Purpose
  ;;   Computes the number of empty holes on player's side
  ;;
  ;; Parameters
  ;;   hole, an integer
  ;;   board, a list
  ;;   limit, an integer
  ;;   sum, an integer
  ;;
  ;; Produces
  ;;   sum, an integer
  ;;
  ;; Preconditions
  ;;   [none]
  ;;
  ;; Postconditions
  ;;   sum is the total number of empty holes on player's side
  (define mancala-player-empty-holes
    (lambda (board hole limit sum)
      (if (< hole limit)
          (if (zero? (list-ref board hole))
              (mancala-player-empty-holes board (+ hole 1) limit (+ sum 1))
              sum)
          sum)))
                     
) ; module