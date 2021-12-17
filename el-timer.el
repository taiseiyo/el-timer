(progn
  ;; (defun el-timer(end-time)
  ;; (interactive "n:Enter end time: ")
    (setq time-count 0
	  tmp-line mode-line-format)

    (defun mainloop()
      (setq time-count (+ time-count 1))
      (setq time (s-trim-right (shell-command-to-string
			  (concat "el-timer -st " (number-to-string time-count)  " -et " "0.1"))))
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
    ;; )
    )

(progn
  ;; (defun cancel-el-timer()
  ;; (interactive)
    (cancel-timer el-timer)
    (setq mode-line-format tmp-line)
    ;; )
  )

