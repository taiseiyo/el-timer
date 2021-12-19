(defun el-timer-start(end-time)
  (interactive "NEnter end time: ")
    (setq time-count 0
	  tmp-line mode-line-format
	  et end-time)

    (defun mainloop()
      (setq time-count (+ time-count 1))
      (setq time (s-trim-right (shell-command-to-string
				(concat "el-timer -st " (number-to-string time-count)  " -et " (number-to-string et)))))
      
      (setq time (concat time " ")
	    mode-line-format tmp-line
	    under-line mode-line-format
	    mode-line-format (cons time under-line))

      (if (equal (s-trim time) "00:00")
	  (progn
	    (cancel-timer timer)
	    )
	)
      )
    
    (setq timer (run-at-time 0 1 'mainloop))
    
    )

(defun el-timer-stop()
  (interactive)
  (cancel-timer timer)
  
  (setq start-window (selected-window)
	end-window (next-window (selected-window))
	window-counter 1)
  
  (while (equal nil (equal start-window end-window))
    (other-window window-counter)
    (setq mode-line-format tmp-line
	  end-window (next-window end-window)
    	  window-counter (+ window-counter 1)
	  )
    )
  
  (other-window (+ window-counter 1))
  (setq mode-line-format tmp-line)
  )

(provide 'el-timer)

;; 00:00 の 10 秒後に mini-buffer から time を消したい
;; 出力に色付けたい -> defface ?
