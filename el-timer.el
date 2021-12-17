(defun el-timer-start(end-time)
  (interactive "nEnter end time: ")
    (setq time-count 0
	  tmp-line mode-line-format
	  et end-time)
    
    (defun mainloop()
      (setq time-count (+ time-count 1))
      (setq time (s-trim-right (shell-command-to-string
			  (concat "el-timer -st " (number-to-string time-count)  " -et " et))))
      (setq time (concat time " "))
      (setq mode-line-format tmp-line)
      (setq under-line mode-line-format)
      (setq mode-line-format (cons time under-line))

      (if (equal (s-trim time) "00:00")
	  (progn
	    (cancel-timer el-timer)
	    )
	)
      )
    
    (setq el-timer (run-at-time 0 1 'mainloop))
    
    )

(defun el-timer-stop()
  (interactive)
    (cancel-timer el-timer)
    (setq mode-line-format tmp-line)
  )

(provide 'el-timer)
;; 00:00 の 10 秒後に mini-buffer から time を消したい
;; 出力に色付けたい -> defface ?
