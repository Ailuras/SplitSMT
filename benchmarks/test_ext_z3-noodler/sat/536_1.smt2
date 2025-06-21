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

(declare-sort var120 0)
(declare-sort var1783 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var1783-init () (Array Int var1783))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var1783 (Int) var1783)
(declare-fun String_format/1339386452 (String (Array Int var1783)) String)
(declare-const null-var120 var120)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var1783__ (Array Int var1783))
(declare-const var126 var120) ; Statement: r3 := @this: org.antlr.v4.codegen.target.PHPTarget 
(assert (not (= var126 null-var120)))
(declare-const var2888 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2888 null-Int)))
(define-const var2825 (Array Int var1783) arr-var1783-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var345 Int (Int_valueOf/-1371140006 var2888)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var2825!1 (Array Int var1783))
(assert (not (= var2825!1 null-__Array__Int__var1783__)))
(assert (= (select var2825!1 0) (cast-from-Int-to-var1783 var345))) ; Statement: $r0[0] = $r1 
(define-const var231 String (String_format/1339386452 "\u005cu{%X}" var2825!1)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\u{%X}", $r0) 
 ; Statement: return $r2 
(check-sat)
; {arr-var1783-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var1783=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var120=org.antlr.v4.codegen.target.PHPTarget, var126=r3, var2888=i0, var1783=java.lang.Object, var2825=$r0, var345=$r1, var231=$r2}
; {org.antlr.v4.codegen.target.PHPTarget=var120, r3=var126, i0=var2888, java.lang.Object=var1783, $r0=var2825, $r1=var345, $r2=var231}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r3 := @this: org.antlr.v4.codegen.target.PHPTarget;	i0 := @parameter0: int;	$r0 = newarray (java.lang.Object)[1];	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r0[0] = $r1;	$r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\u{%X}", $r0);	return $r2
;block_num 1