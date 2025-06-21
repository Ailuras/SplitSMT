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

(declare-sort var2790 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun close/-1808667991 (var2790) void)
(declare-fun header/1063112382 (var2790) String)
(declare-fun ps/1203940574 (var2790) String)
(define-fun toString/-2075883882 ((s String)) String s)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2790 var2790)
(declare-const var1268 var2790) ; Statement: r0 := @this: org.antlr.v4.gui.PostScriptDocument 
(assert (not (= var1268 null-var2790)))
(assert true)
;(assert (close/-1808667991 var1268)) ; Statement: virtualinvoke r0.<org.antlr.v4.gui.PostScriptDocument: void close()>() 

(declare-const var1268!1 var2790)
(assert true)
(define-const var2665 String (header/1063112382 var1268!1)) ; Statement: $r3 = virtualinvoke r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder header()>() 
(define-const var2650 String (ps/1203940574 var1268!1)) ; Statement: $r1 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps> 
(assert true)
(define-const var843 String (toString/-2075883882 var2650)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3240 String (str.++ "\u0001\u0001" (cast-from-String-to-String var2665) var843)) ; Statement: $r4 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.StringBuilder,java.lang.String)>($r3, $r2) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001\u0001") 
 ; Statement: return $r4 
(check-sat)
; {close/-1808667991=([org.antlr.v4.gui.PostScriptDocument], void), header/1063112382=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), ps/1203940574=([org.antlr.v4.gui.PostScriptDocument], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), cast-from-String-to-String=([java.lang.StringBuilder], java.lang.String)}
; {var2790=org.antlr.v4.gui.PostScriptDocument, var1268=r0, var2665=$r3, var2650=$r1, var843=$r2, var3240=$r4}
; {org.antlr.v4.gui.PostScriptDocument=var2790, r0=var1268, $r3=var2665, $r1=var2650, $r2=var843, $r4=var3240}
;seq <java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.antlr.v4.gui.PostScriptDocument;	virtualinvoke r0.<org.antlr.v4.gui.PostScriptDocument: void close()>();	$r3 = virtualinvoke r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder header()>();	$r1 = r0.<org.antlr.v4.gui.PostScriptDocument: java.lang.StringBuilder ps>;	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.StringBuilder,java.lang.String)>($r3, $r2) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001\u0001");	return $r4
;block_num 1