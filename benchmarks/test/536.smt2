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

(declare-sort var2998 0)
(declare-sort var2282 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var2282-init () (Array Int var2282))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var2282 (Int) var2282)
(declare-fun String_format/1339386452 (String (Array Int var2282)) String)
(declare-const null-var2998 var2998)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var2282__ (Array Int var2282))
(declare-const var3824 var2998) ; Statement: r3 := @this: org.antlr.v4.codegen.target.DartTarget 
(assert (not (= var3824 null-var2998)))
(declare-const var2955 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2955 null-Int)))
(define-const var2857 (Array Int var2282) arr-var2282-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var1402 Int (Int_valueOf/-1371140006 var2955)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var2857!1 (Array Int var2282))
(assert (not (= var2857!1 null-__Array__Int__var2282__)))
(assert (= (select var2857!1 0) (cast-from-Int-to-var2282 var1402))) ; Statement: $r0[0] = $r1 
(define-const var3950 String (String_format/1339386452 "\u005cu{%X}" var2857!1)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\u{%X}", $r0) 
 ; Statement: return $r2 
(check-sat)
; {arr-var2282-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var2282=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var2998=org.antlr.v4.codegen.target.DartTarget, var3824=r3, var2955=i0, var2282=java.lang.Object, var2857=$r0, var1402=$r1, var3950=$r2}
; {org.antlr.v4.codegen.target.DartTarget=var2998, r3=var3824, i0=var2955, java.lang.Object=var2282, $r0=var2857, $r1=var1402, $r2=var3950}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r3 := @this: org.antlr.v4.codegen.target.DartTarget;	i0 := @parameter0: int;	$r0 = newarray (java.lang.Object)[1];	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r0[0] = $r1;	$r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\u{%X}", $r0);	return $r2
;block_num 1