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

(declare-sort var3751 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun closed/1203940574 (var3751) Bool)
(declare-fun ps/1203940574 (var3751) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-var3751 var3751)
(declare-const var2079 var3751) ; Statement: r0 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var2079 null-var3751)))
(define-const var928 Bool (closed/1203940574 var2079)) ; Statement: $z0 = r0.<org.antlr.v4.gui.PostScriptDocument: boolean closed> 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> 
(assert (= (ite var928 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3706 String (ps/1203940574 var2079)) ; Statement: $r1 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> 
(assert true)
;(assert (append/672562846 var3706 "%%Trailer\n")) ; Statement: virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%%Trailer\n") 
(declare-const var3706!1 String)
(assert (= var3706!1 (str.++ var3706 "%%Trailer\n")))
(declare-const var2079!1 var3751)
(assert (not (= var2079!1 null-var3751)))
(assert (= (closed/1203940574 var2079!1) (ite (= 1 1) true false))) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: boolean closed> = 1 
 ; Statement: return 
(check-sat)
; {closed/1203940574=([org.antlr.v4.gui.PostScriptDocument], boolean), ps/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var3751=org.antlr.v4.gui.PostScriptDocument, var2079=r0, var928=$z0, var3706=$r1}
; {org.antlr.v4.gui.PostScriptDocument=var3751, r0=var2079, $z0=var928, $r1=var3706}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.PostScriptDocument;	$z0 = r0.<org.antlr.v4.gui.PostScriptDocument: boolean closed>;	if $z0 == 0 goto $r1 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps>;	$r1 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps>;	virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%%Trailer\n");	r0.<org.antlr.v4.gui.PostScriptDocument: boolean closed> = 1;	return
;block_num 2