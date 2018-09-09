
;; Lab: Adversarial Search
;; CSC 261 
;;
;; File
;;   driver.scm
;;
;; Summary
;;   A driver program to demonstrate correctness of 
;;     evaluation function and alpha-beta-search
;;

(require "game.scm")
(require "evaluation.scm")
(require "alphabeta.scm")
(require "mancala.scm")
(require "mancala-player.scm")
(require "tictactoe.scm")
(require "barranca.scm")
(require "cutoff-minimax.scm")
;

;Test for Evaluation Function
;;Game Definitions - )
(define mancala (make-mancala-game))

;;Evaluation Definition - A-star search & heuristic)
(define mancala-player1-eval (simple-mancala-eval #t))
(define mancala-player2-eval (best-mancala-eval #f))

;Short mancala game (piles = 3,4)

(define mancala-player1-3 
  (make-cutoff-minimax-player mancala 3 mancala-player1-eval))
(define mancala-player2-3
  (make-cutoff-minimax-player mancala 3 mancala-player2-eval))
(define mancala-player1-4 
  (make-cutoff-minimax-player mancala 4 mancala-player1-eval))
(define mancala-player2-4
  (make-cutoff-minimax-player mancala 4 mancala-player2-eval))
;Long mancala game (piles = 5)
(define mancala-player1-5 
  (make-cutoff-minimax-player mancala 5 mancala-player1-eval))
(define mancala-player2-5
  (make-cutoff-minimax-player mancala 5 mancala-player2-eval))

;Edge cases
;Pile = 1
(define mancala-player1-1 
  (make-cutoff-minimax-player mancala 1 mancala-player1-eval))
(define mancala-player2-1
  (make-cutoff-minimax-player mancala 1 mancala-player2-eval))

;Results of cases
(game-play mancala mancala-player1-3 mancala-player2-3)
(game-play mancala mancala-player1-4 mancala-player2-4)
;The test takes long time, uncomment it if you want to check it
;(game-play mancala mancala-player1-5 mancala-player2-5)

(game-play mancala mancala-player1-1 mancala-player2-1)

;Since in each game, player 2 wins or draws, we conclude that our evaluation
;works better than the simple mancala evaluation.

;Test for Alpha-Beta search algorithm

;Test for barranca game
(newline)

(define barranca-1 (make-barranca-game 4 7))
(define barranca-player1-utility (barranca-utility-fun #t 7))
(alpha-beta-search barranca-1 (game-start-state barranca-1) 5
                   barranca-player1-utility)

(newline)

(define barranca-2 (make-barranca-game 3 2))
(define barranca-player2-utility (barranca-utility-fun #t 2))
(alpha-beta-search barranca-1 (game-start-state barranca-2) 5
                   barranca-player1-utility)

(newline)

;Test for tic-tac-toe game
(define ttt (make-tictactoe-game))
(define ttt-player1 (make-alpha-beta-player ttt 5 (tictactoe-utility-fun #t)))
(define ttt-player2 (make-alpha-beta-player ttt 5 (tictactoe-utility-fun #f)))
(game-play ttt ttt-player1 ttt-player2)

;Since alpha-beta-serach display the correct min, max values as well as
;pruning alpha and beta accurately, we believe that our procudure works
;as what we expected.
