;;; daytime.el - A simple daytime server

;; Daytime Protocol - http://tools.ietf.org/html/rfc867

(defvar daytime-server-port 13
  "Port of the daytime server.")

(defun daytime-server-start ()
  "Start a daytime server in Emacs."
  (interactive)
  (unless (process-status "daytime-server")
    (if (featurep 'make-network-process '(:server t))
        (make-network-process :name "daytime-server"
                              :buffer "*daytime-server*"
                              :service daytime-server-port
                              :server t
                              :noquery t
                              :sentinel nil
                              :log 'daytime-server-log))))

(defun daytime-server-stop ()
  "Stop the Emacs daytime server."
  (interactive)
  (delete-process "daytime-server"))

(defun daytime-server-log (server client message)
  (daytime-server-reply client)
  (with-current-buffer "*daytime-server*"
    (goto-char (point-max))
    (insert (format "%s %s %s\n" (current-time-string) (current-time-zone) client)))
  (delete-process client))

(defun daytime-server-reply (client)
  (process-send-string client (format "%s %s\n" (current-time-string) (current-time-zone))))

;;; daytime.el ends here
