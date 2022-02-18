(defun mainloop()
      (setq time-count (+ time-count 1))
      (setq time (string-trim-right (shell-command-to-string
				     (concat "python3 " (getenv "HOME") "/bin/el-timer -st " (number-to-string time-count)  " -et " (number-to-string et)))))

      (setq time (concat time " ")
	    mode-line-format tmp-line
	    under-line mode-line-format
	    mode-line-format (cons time under-line))

      (if (equal (string-trim time) "00:00")
	  (progn
	    (message "finish timer, stop working")
	    (cancel-timer timer)
	    )
	)
      )


(defun delete-timer-mode-line()
  (setq start-window (selected-window)
	end-window (next-window (selected-window))
	mode-line-format tmp-line
	)

  (while (not (equal start-window end-window))
    (other-window 1)
    (setq mode-line-format tmp-line
	  end-window (next-window end-window)
	  )
    )
  
  (other-window 1)
  )

(defun el-timer-start(end-time)
  "start timer. The time-count variable is used to control the timer."
  (interactive "NEnter end time: ")
    (setq time-count 0
	  tmp-line mode-line-format
	  et end-time
	  timer (run-at-time 0 1 'mainloop))
    )


(defun el-timer-stop()
  "stop timer"
  (interactive)
  (cancel-timer timer)
  (delete-timer-mode-line)
  )

(defun el-timer-pause()
  "pause timer"
  (interactive)
  (cancel-timer timer)
  )

(defun el-timer-restart()
  "restart timer"
  (interactive)
  (delete-timer-mode-line)
  (setq tmp-line mode-line-format
	timer (run-at-time 0 1 'mainloop))
  )

(provide 'el-timer)

;; font-lock 色変える
;; play-sound-file 音ならす → wav or au format file
