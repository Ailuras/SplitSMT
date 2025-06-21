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

(declare-sort var3755 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lineWidth/1203940574 (var3755) Float64)
(declare-fun ps/1203940574 (var3755) String)
(declare-fun append/33611274 (String Float64) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-var3755 var3755)
(declare-const null-Float64 Float64)
(declare-const var1392 var3755) ; Statement: r0 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var1392 null-var3755)))
(declare-const var1751 Float64) ; Statement: d0 := @parameter0: double 
(assert (not (= var1751 null-Float64)))
(declare-const var1392!1 var3755)
(assert (not (= var1392!1 null-var3755)))
(assert (= (lineWidth/1203940574 var1392!1) var1751)) ; Statement: r0.<org.antlr.v4.gui.PostScriptDocument: double lineWidth> = d0 
(define-const var2488 String (ps/1203940574 var1392!1)) ; Statement: $r1 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> 
(assert true)
(define-const var2134 String (append/33611274 var2488 var1751)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(double)>(d0) 
(declare-const var2488!1 String)
(assert (str.prefixof var2488 var2488!1))
(assert true)
;(assert (append/672562846 var2134 " setlinewidth\n")) ; Statement: virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" setlinewidth\n") 
(declare-const var2134!1 String)
(assert (= var2134!1 (str.++ var2134 " setlinewidth\n")))
 ; Statement: return 
(check-sat)
; {lineWidth/1203940574=([org.antlr.v4.gui.PostScriptDocument], double), ps/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), append/33611274=([java.lang.StringBuilder, double], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var3755=org.antlr.v4.gui.PostScriptDocument, var1392=r0, var1751=d0, var2488=$r1, var2134=$r2}
; {org.antlr.v4.gui.PostScriptDocument=var3755, r0=var1392, d0=var1751, $r1=var2488, $r2=var2134}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(double)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(double)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.PostScriptDocument;	d0 := @parameter0: double;	r0.<org.antlr.v4.gui.PostScriptDocument: double lineWidth> = d0;	$r1 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps>;	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(double)>(d0);	virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" setlinewidth\n");	return
;block_num 1