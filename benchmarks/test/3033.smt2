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

(declare-sort var1654 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var1654-init () (Array Int var1654))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var1654 (Int) var1654)
(declare-fun String_format/1339386452 (String (Array Int var1654)) String)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var1654__ (Array Int var1654))
(declare-const var169 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var169 null-Int)))
(define-const var538 (Array Int var1654) arr-var1654-init) ; Statement: $r0 = newarray (java.lang.Object)[2] 
(define-const var2507 Int (Int_valueOf/-1371140006 var169)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var538!1 (Array Int var1654))
(assert (not (= var538!1 null-__Array__Int__var1654__)))
(assert (= (select var538!1 0) (cast-from-Int-to-var1654 var2507))) ; Statement: $r0[0] = $r1 
(define-const var3041 Int (Int_valueOf/-1371140006 var169)) ; Statement: $r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var538!2 (Array Int var1654))
(assert (not (= var538!2 null-__Array__Int__var1654__)))
(assert (= (select var538!2 1) (cast-from-Int-to-var1654 var3041))) ; Statement: $r0[1] = $r2 
(define-const var1927 String (String_format/1339386452 "if (arg%d == null) throw new IllegalArgumentException(\u0022invocation == null\u0022); String methodName = arg%d.getMethodName();\n" var538!2)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("if (arg%d == null) throw new IllegalArgumentException(\"invocation == null\"); String methodName = arg%d.getMethodName();\n", $r0) 
 ; Statement: return $r3 
(check-sat)
; {arr-var1654-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var1654=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var169=i0, var1654=java.lang.Object, var538=$r0, var2507=$r1, var3041=$r2, var1927=$r3}
; {i0=var169, java.lang.Object=var1654, $r0=var538, $r1=var2507, $r2=var3041, $r3=var1927}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts i0 := @parameter0: int;	$r0 = newarray (java.lang.Object)[2];	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r0[0] = $r1;	$r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r0[1] = $r2;	$r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("if (arg%d == null) throw new IllegalArgumentException(\"invocation == null\"); String methodName = arg%d.getMethodName();\n", $r0);	return $r3
;block_num 1