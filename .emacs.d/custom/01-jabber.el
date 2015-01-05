;; Define a list of my jabber.el accounts
;; ...

;; Disable jabber.el presence notifications
(remove-hook 'jabber-alert-presence-hooks
             'sr-jabber-alert-presence-func)

;; Define location of gnutls-cli on OS X, installed via
;;
;;   brew install coreutils
;;   brew install gnutls --default-names
;;
(setq starttls-use-gnutls t
      starttls-gnutls-program "/usr/local/bin/gnutls-cli"
      starttls-extra-arguments nil)
