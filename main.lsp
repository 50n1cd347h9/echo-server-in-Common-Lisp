(defun serve (request-handler)
  (let ((socket (socket-server 8080)))
	(unwind-protect
	  (loop (with-open-stream (my-stream (socket-accept socket))
			  (funcall request-handler my-stream)))
	  (socket-server-close socket))))


(defun client-echo (my-stream)
  (loop (let ((message (read my-stream)))
		  (prin1 message my-stream)
		  (fresh-line my-stream))))

(serve #'client-echo)


