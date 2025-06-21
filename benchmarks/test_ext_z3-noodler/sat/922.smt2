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

(declare-sort var802 0)
(declare-sort var1852 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var1852-init () (Array Int var1852))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var1852 (Int) var1852)
(declare-fun String_format/1339386452 (String (Array Int var1852)) String)
(declare-const null-var802 var802)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var1852__ (Array Int var1852))
(declare-const var1232 var802) ; Statement: r3 := @this: org.antlr.v4.codegen.Target 
(assert (not (= var1232 null-var802)))
(declare-const var1381 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1381 null-Int)))
(define-const var2575 (Array Int var1852) arr-var1852-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var2281 Int (Int_valueOf/-1371140006 var1381)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var2575!1 (Array Int var1852))
(assert (not (= var2575!1 null-__Array__Int__var1852__)))
(assert (= (select var2575!1 0) (cast-from-Int-to-var1852 var2281))) ; Statement: $r0[0] = $r1 
(define-const var2007 String (String_format/1339386452 "\u005cu%04x" var2575!1)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\u%04x", $r0) 
 ; Statement: return $r2 
(check-sat)
; {arr-var1852-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var1852=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var802=org.antlr.v4.codegen.Target, var1232=r3, var1381=i0, var1852=java.lang.Object, var2575=$r0, var2281=$r1, var2007=$r2}
; {org.antlr.v4.codegen.Target=var802, r3=var1232, i0=var1381, java.lang.Object=var1852, $r0=var2575, $r1=var2281, $r2=var2007}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r3 := @this: org.antlr.v4.codegen.Target;	i0 := @parameter0: int;	$r0 = newarray (java.lang.Object)[1];	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r0[0] = $r1;	$r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\u%04x", $r0);	return $r2
;block_num 1