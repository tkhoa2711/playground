#!/usr/local/bin/sbcl --script

(defun count-line (filename)
  "Count number of lines within a file."
  (with-open-file (in filename
                      :direction :input
                      :if-does-not-exist nil)
    (do ((l (read-line in nil 'eof) (read-line in nil 'eof))
         (count 0 (1+ count)))
        (nil)
      (if (eql l 'eof)
          (return count)
          ()))))

(format t "~A~%" (count-line (second sb-ext:*posix-argv*)))
