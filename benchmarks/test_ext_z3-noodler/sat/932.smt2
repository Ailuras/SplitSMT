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

(declare-sort var322 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ps/1203940574 (var322) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-var322 var322)
(declare-const var698 var322) ; Statement: r0 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var698 null-var322)))
(define-const var3968 String (ps/1203940574 var698)) ; Statement: $r1 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> 
(assert true)
;(assert (append/672562846 var3968 "stroke\n")) ; Statement: virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("stroke\n") 
(declare-const var3968!1 String)
(assert (= var3968!1 (str.++ var3968 "stroke\n")))
 ; Statement: return 
(check-sat)
; {ps/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var322=org.antlr.v4.gui.PostScriptDocument, var698=r0, var3968=$r1}
; {org.antlr.v4.gui.PostScriptDocument=var322, r0=var698, $r1=var3968}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.PostScriptDocument;	$r1 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps>;	virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("stroke\n");	return
;block_num 1