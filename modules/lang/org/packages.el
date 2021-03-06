;; -*- no-byte-compile: t; -*-
;;; lang/org/packages.el

;; Install cutting-edge version of org-mode, and from a mirror, because
;; code.orgmode.org runs on a potato.
(package! org-mode
  :recipe (:host github
           :repo "emacs-straight/org-mode"
           :files ("*.el" "lisp/*.el" "contrib/lisp/*.el")
           ;; HACK A necessary hack because org requires a compilation step
           ;;      after being cloned, and during that compilation a
           ;;      org-version.el is generated with these two functions, which
           ;;      return the output of a 'git describe ...'  call in the repo's
           ;;      root. Of course, this command won't work in a sparse clone,
           ;;      and more than that, initiating these compilation step is a
           ;;      hassle, so...
           :build (with-temp-file (expand-file-name "org-version.el" (straight--repos-dir "org-mode"))
                    (insert "(fset 'org-release (lambda () \"9.5\"))\n"
                            "(fset 'org-git-version #'ignore)\n"
                            "(provide 'org-version)\n")))
  :pin "7c8dce72bd5d86157dd1dda2ba0a21ac86084426"
  ;; Prevents built-in Org from sneaking into the byte-compilation of
  ;; `org-plus-contrib', and inform other packages that `org-mode' satisfies the
  ;; `org' dependency: https://github.com/raxod502/straight.el/issues/352
  :shadow 'org)

(package! avy)
(package! htmlize :pin "49205105898ba8993b5253beec55d8bddd820a70")
(package! org-yt
  :recipe (:host github :repo "TobiasZawada/org-yt")
  :pin "40cc1ac76d741055cbefa13860d9f070a7ade001")
(package! ox-clip :pin "f5eac28734ea33d0b7a3dbe10b777907a91cf9f9")
(package! toc-org :pin "aef220c266f53d36055f74f4a243c6483c563d2a")
(package! org-cliplink :pin "13e0940b65d22bec34e2de4bc8cba1412a7abfbc")

(when (featurep! :editor evil +everywhere)
  (package! evil-org
    :recipe (:host github :repo "hlissner/evil-org-mode")
    :pin "a9706da260c45b98601bcd72b1d2c0a24a017700"))
(when (featurep! :tools pdf)
  (package! org-pdftools :pin "3c2b9a413eb841c781cfb49d8c343bf07aa0ad1f"))
(when (featurep! :tools magit)
  (package! orgit :pin "ac9b1a42863a864fde9d225890ef5464bffdc646"))
(when (featurep! +brain)
  (package! org-brain :pin "1ae4fd46165fc56f34f36ce38cb2ae816b07e207"))
(when (featurep! +dragndrop)
  (package! org-download :pin "42ac361ef5502017e6fc1bceb00333eba90402f4"))
(when (featurep! +gnuplot)
  (package! gnuplot :pin "f0001c30010b2899e36d7d89046322467e923088")
  (package! gnuplot-mode :pin "601f6392986f0cba332c87678d31ae0d0a496ce7"))
(when (featurep! +ipython) ; DEPRECATED
  (package! ob-ipython :pin "7147455230841744fb5b95dcbe03320313a77124"))
(when (featurep! +jupyter)
  (package! jupyter :pin "360cae2c70ab28c7a7848c0c56473d984f0243e5"))
(when (featurep! +journal)
  (package! org-journal :pin "14ce0119fe2d89f2f2207788be2edce0b9372822"))
(when (featurep! +noter)
  (package! org-noter :pin "9ead81d42dd4dd5074782d239b2efddf9b8b7b3d"))
(when (featurep! +pomodoro)
  (package! org-pomodoro :pin "aa07c11318f91219336197e62c47bc7a3d090479"))
(when (featurep! +pretty)
  (package! org-superstar :pin "7f83636db215bf5a10edbfdf11d12a132864a914")
  (package! org-fancy-priorities :pin "819bb993b71e7253cefef7047306ab4e0f9d0a86"))
(when (featurep! +present)
  (package! centered-window
    :recipe (:host github :repo "anler/centered-window-mode")
    :pin "f50859941ab5c7cbeaee410f2d38716252b552ac")
  (package! org-tree-slide :pin "18034c476038adcc1c4697168b8068f4d0ce62fe")
  (package! org-re-reveal :pin "0062756e9a5b6ec96c7de5ca94372cc6495296a1")
  (package! revealjs
    :recipe (:host github :repo "hakimel/reveal.js"
             :files ("css" "dist" "js" "plugin"))
    :pin "0582f57517c97a4c7bfeb58762138c78883f94c5"))
(when (featurep! +roam)
  (package! org-roam :pin "be95b42d32d9707309ab373f1d8182c84db41c5c"))

;;; Babel
(package! ob-async :pin "de1cd6c93242a4cb8773bbe115b7be3d4dd6b97e")
(when (featurep! :lang crystal)
  (package! ob-crystal :pin "d84c1adee4b269cdba06a97caedb8071561a09af"))
(when (featurep! :lang go)
  (package! ob-go :pin "2067ed55f4c1d33a43cb3f6948609d240a8915f5"))
(when (featurep! :lang hy)
  (package! ob-hy :pin "a42ecaf440adc03e279afe43ee5ef6093ddd542a"))
(when (featurep! :lang nim)
  (package! ob-nim :pin "bf1642cb93f0a898804dc13fd9408d2964403bd2"))
(when (featurep! :lang racket)
  (package! ob-racket
    :recipe (:host github :repo "DEADB17/ob-racket")
    :pin "d8fd51bddb019b0eb68755255f88fc800cfe03cb"))
(when (featurep! :lang rest)
  (package! ob-restclient :pin "f7449b2068498fe9d8ab9589e0a638148861533f"))
(when (featurep! :lang scala)
  (package! ob-ammonite :pin "39937dff395e70aff76a4224fa49cf2ec6c57cca"))

;;; Export
(when (featurep! +pandoc)
  (package! ox-pandoc :pin "aa37dc7e94213d4ebedb85c384c1ba35007da18e"))
(when (featurep! +hugo)
  (package! ox-hugo
    :recipe (:host github :repo "kaushalmodi/ox-hugo" :nonrecursive t)
    :pin "f24c9bd522ae22bee2327c2b53858d0a5066707d"))
(when (featurep! :lang rst)
  (package! ox-rst :pin "99fa790da55b57a3f2e9aa187493ba434a64250e"))
