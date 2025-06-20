(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1057 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun boundingBox/1203940574 (var1057) String)
(declare-const null-var1057 var1057)
(declare-const var3267 var1057) ; Statement: r1 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var3267 null-var1057)))
(define-const var2134 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2134)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2134!1 String)
(assert (= var2134!1 ""))
(assert true)
;(assert (append/672562846 var2134!1 "%!PS-Adobe-3.0 EPSF-3.0\n")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%!PS-Adobe-3.0 EPSF-3.0\n") 
(declare-const var2134!2 String)
(assert (= var2134!2 (str.++ var2134!1 "%!PS-Adobe-3.0 EPSF-3.0\n")))
(define-const var926 String (boundingBox/1203940574 var3267)) ; Statement: $r2 = r1.<org.antlr.v4.gui.PostScriptDocument: java.lang.String boundingBox> 
(assert true)
(define-const var2418 String (append/672562846 var2134!2 var926)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2134!3 String)
(assert (= var2134!3 (str.++ var2134!2 var926)))
(assert true)
;(assert (append/672562846 var2418 "\n")) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var2418!1 String)
(assert (= var2418!1 (str.++ var2418 "\n")))
(assert true)
;(assert (append/672562846 var2134!3 "0.3 setlinewidth\n")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("0.3 setlinewidth\n") 
(declare-const var2134!4 String)
(assert (= var2134!4 (str.++ var2134!3 "0.3 setlinewidth\n")))
(assert true)
;(assert (append/672562846 var2134!4 "%% x y w h highlight\n/highlight {\n        4 dict begin\n        /h exch def\n        /w exch def\n        /y exch def\n        /x exch def\n        gsave\n        newpath\n        x y moveto\n        0 h rlineto     % up to left corner\n        w 0 rlineto     % to upper right corner\n        0 h neg rlineto % to lower right corner\n        w neg 0 rlineto % back home to lower left corner\n        closepath\n        .95 .83 .82 setrgbcolor\n        fill\n        grestore\n        end\n} def\n")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%% x y w h highlight\n/highlight {\n        4 dict begin\n        /h exch def\n        /w exch def\n        /y exch def\n        /x exch def\n        gsave\n        newpath\n        x y moveto\n        0 h rlineto     % up to left corner\n        w 0 rlineto     % to upper right corner\n        0 h neg rlineto % to lower right corner\n        w neg 0 rlineto % back home to lower left corner\n        closepath\n        .95 .83 .82 setrgbcolor\n        fill\n        grestore\n        end\n} def\n") 
(declare-const var2134!5 String)
(assert (= var2134!5 (str.++ var2134!4 "%% x y w h highlight\n/highlight {\n        4 dict begin\n        /h exch def\n        /w exch def\n        /y exch def\n        /x exch def\n        gsave\n        newpath\n        x y moveto\n        0 h rlineto     % up to left corner\n        w 0 rlineto     % to upper right corner\n        0 h neg rlineto % to lower right corner\n        w neg 0 rlineto % back home to lower left corner\n        closepath\n        .95 .83 .82 setrgbcolor\n        fill\n        grestore\n        end\n} def\n")))
 ; Statement: return $r0 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), boundingBox/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.String)}
; {var1057=org.antlr.v4.gui.PostScriptDocument, var3267=r1, var2134=$r0, var926=$r2, var2418=$r3}
; {org.antlr.v4.gui.PostScriptDocument=var1057, r1=var3267, $r0=var2134, $r2=var926, $r3=var2418}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5}
;stmts r1 := @this: org.antlr.v4.gui.PostScriptDocument;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%!PS-Adobe-3.0 EPSF-3.0\n");	$r2 = r1.<org.antlr.v4.gui.PostScriptDocument: java.lang.String boundingBox>;	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("0.3 setlinewidth\n");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%% x y w h highlight\n/highlight {\n        4 dict begin\n        /h exch def\n        /w exch def\n        /y exch def\n        /x exch def\n        gsave\n        newpath\n        x y moveto\n        0 h rlineto     % up to left corner\n        w 0 rlineto     % to upper right corner\n        0 h neg rlineto % to lower right corner\n        w neg 0 rlineto % back home to lower left corner\n        closepath\n        .95 .83 .82 setrgbcolor\n        fill\n        grestore\n        end\n} def\n");	return $r0
;block_num 1