(require "game.scm")
(require "minimax.scm")
(require "barranca.scm")
(require "evaluation.scm")
(require "tictactoe.scm")
(require "mancala.scm")
(require "alphabeta.scm")
(require "mancala-player.scm")
(require "cutoff-minimax.scm")

(define barranca (make-barranca-game 4 7))
(alpha-beta-search barranca (game-start-state barranca) 4 (barranca-utility-fun #t 7))
;(cutoff-minimax-search barranca (game-start-state barranca) 4 (barranca-utility-fun #t 7))

;(define barranca-player1 (make-alpha-beta-player barranca 3 (barranca-utility-fun #t 7)))
;(define barranca-player2 (make-alpha-beta-player barranca 3 (barranca-utility-fun #f 7)))

;(game-play barranca barranca-player1 barranca-player2)
 
;'(next-player player-1-numbers player-2-numbers available-numbers)
;
;(define ttt (make-tictactoe-game))
;(define ttt-smart-player1 (make-alpha-beta-player ttt 20 (tictactoe-utility-fun #t)))
;(define ttt-smart-player2 (make-minimax-player ttt (tictactoe-utility-fun #f)))
; ;(game-play ttt ttt-smart-player1 ttt-smart-player2)
;
; ;(game-play ttt ttt-smart-player1 ttt-lazy-player)
;  (game-play ttt ttt-smart-player1 ttt-smart-player2)


;
;(define mancala (make-mancala-game))
;(define mancala-player1-eval (simple-mancala-eval #t))
;(define mancala-player2-eval (best-mancala-eval #f))
;(define mancala-player1 
;  (make-alpha-beta-player mancala 3 mancala-player1-eval))
;(define mancala-player2
;  (make-alpha-beta-player mancala 3 mancala-player2-eval))
;((game-win? mancala) mancala-player1 (game-start-state mancala))
;(define mancala (make-mancala-game))
;(define mancala-simple-player-eval (simple-mancala-eval #t))
;(define mancala-best-player-eval (best-mancala-eval #f))
;
;(define mancala-simple-player
;  (make-alpha-beta-player mancala 3 simple-mancala-eval))
;(define mancala-best-player
;  (make-alpha-beta-player mancala 3 best-mancala-eval))
;(game-play mancala mancala-simple-player-eval mancala-best-player-eval)