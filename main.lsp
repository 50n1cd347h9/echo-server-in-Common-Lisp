(defun serve (request-handler)
  (let ((socket (socket-server 8080)))
	(unwind-protect
	  (loop (with-open-stream (my-stream (socket-accept socket))
			  (let ((*standard-output* my-stream))
				(funcall request-handler))))
	  (socket-server-close socket))))


(defun client-echo ()
  (loop (let ((message (read *standard-output*)))
		  (prin1 message)
		  (fresh-line))))

(serve #'client-echo)


