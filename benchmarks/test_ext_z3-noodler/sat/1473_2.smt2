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

(declare-sort var1793 0)
(declare-sort var1137 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var1793 var1793)
(declare-const null-String String)
(declare-const var2437 var1793) ; Statement: r0 := @this: org.antlr.v4.tool.DOTGenerator 
(assert (not (= var2437 null-var1793)))
(declare-const var2727 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2727 null-String)))
(assert true)
(define-const var3754 String (replace/2138489945 var2727 (cast-from-String-to-String "\u005c") (cast-from-String-to-String "\u005c\u005c"))) ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\\", "\\\\") 
(assert true)
(define-const var350 String (replace/2138489945 var3754 (cast-from-String-to-String "\u0022") (cast-from-String-to-String "\u005c\u0022"))) ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\"", "\\\"") 
(assert true)
(define-const var3578 String (replace/2138489945 var350 (cast-from-String-to-String "\n") (cast-from-String-to-String "\u005c\u005cn"))) ; Statement: r4 = virtualinvoke r3.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\n", "\\\\n") 
(assert true)
(define-const var1543 String (replace/2138489945 var3578 (cast-from-String-to-String "\r") (cast-from-String-to-String ""))) ; Statement: r5 = virtualinvoke r4.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\r", "") 
 ; Statement: return r5 
(check-sat)
; {replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var1793=org.antlr.v4.tool.DOTGenerator, var2437=r0, var2727=r1, var1137=null_type, var3754=r2, var350=r3, var3578=r4, var1543=r5}
; {org.antlr.v4.tool.DOTGenerator=var1793, r0=var2437, r1=var2727, null_type=var1137, r2=var3754, r3=var350, r4=var3578, r5=var1543}
;seq <java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>
;cnt {"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 4}
;stmts r0 := @this: org.antlr.v4.tool.DOTGenerator;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r1.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\\", "\\\\");	r3 = virtualinvoke r2.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\"", "\\\"");	r4 = virtualinvoke r3.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\n", "\\\\n");	r5 = virtualinvoke r4.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\r", "");	return r5
;block_num 1