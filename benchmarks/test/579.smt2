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

(declare-sort var1893 0)
(declare-sort var314 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var314-init () (Array Int var314))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var314 (Int) var314)
(declare-fun String_format/1339386452 (String (Array Int var314)) String)
(declare-const null-var1893 var1893)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var314__ (Array Int var314))
(declare-const var2237 var1893) ; Statement: r3 := @this: org.antlr.v4.codegen.target.CSharpTarget 
(assert (not (= var2237 null-var1893)))
(declare-const var2512 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2512 null-Int)))
(define-const var1223 (Array Int var314) arr-var314-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var3915 Int (Int_valueOf/-1371140006 var2512)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var1223!1 (Array Int var314))
(assert (not (= var1223!1 null-__Array__Int__var314__)))
(assert (= (select var1223!1 0) (cast-from-Int-to-var314 var3915))) ; Statement: $r0[0] = $r1 
(define-const var3917 String (String_format/1339386452 "\u005cx%X" var1223!1)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\x%X", $r0) 
 ; Statement: return $r2 
(check-sat)
; {arr-var314-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var314=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var1893=org.antlr.v4.codegen.target.CSharpTarget, var2237=r3, var2512=i0, var314=java.lang.Object, var1223=$r0, var3915=$r1, var3917=$r2}
; {org.antlr.v4.codegen.target.CSharpTarget=var1893, r3=var2237, i0=var2512, java.lang.Object=var314, $r0=var1223, $r1=var3915, $r2=var3917}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r3 := @this: org.antlr.v4.codegen.target.CSharpTarget;	i0 := @parameter0: int;	$r0 = newarray (java.lang.Object)[1];	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r0[0] = $r1;	$r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\x%X", $r0);	return $r2
;block_num 1