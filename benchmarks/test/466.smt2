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

(declare-sort var1100 0)
(declare-sort var1762 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var1762-init () (Array Int var1762))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var1762 (Int) var1762)
(declare-fun String_format/1339386452 (String (Array Int var1762)) String)
(declare-const null-var1100 var1100)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var1762__ (Array Int var1762))
(declare-const var20 var1100) ; Statement: r3 := @this: org.antlr.v4.codegen.target.SwiftTarget 
(assert (not (= var20 null-var1100)))
(declare-const var2703 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2703 null-Int)))
(define-const var1448 (Array Int var1762) arr-var1762-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var1380 Int (Int_valueOf/-1371140006 var2703)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var1448!1 (Array Int var1762))
(assert (not (= var1448!1 null-__Array__Int__var1762__)))
(assert (= (select var1448!1 0) (cast-from-Int-to-var1762 var1380))) ; Statement: $r0[0] = $r1 
(define-const var976 String (String_format/1339386452 "\u005cu{%X}" var1448!1)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\u{%X}", $r0) 
 ; Statement: return $r2 
(check-sat)
; {arr-var1762-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var1762=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var1100=org.antlr.v4.codegen.target.SwiftTarget, var20=r3, var2703=i0, var1762=java.lang.Object, var1448=$r0, var1380=$r1, var976=$r2}
; {org.antlr.v4.codegen.target.SwiftTarget=var1100, r3=var20, i0=var2703, java.lang.Object=var1762, $r0=var1448, $r1=var1380, $r2=var976}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r3 := @this: org.antlr.v4.codegen.target.SwiftTarget;	i0 := @parameter0: int;	$r0 = newarray (java.lang.Object)[1];	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r0[0] = $r1;	$r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\u{%X}", $r0);	return $r2
;block_num 1