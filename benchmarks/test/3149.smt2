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

(declare-sort var3752 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var3752-init () (Array Int var3752))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var3752 (Int) var3752)
(declare-fun String_format/1339386452 (String (Array Int var3752)) String)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var3752__ (Array Int var3752))
(declare-const var984 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var984 null-Int)))
(define-const var2807 (Array Int var3752) arr-var3752-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var1891 Int (Int_valueOf/-1371140006 var984)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var2807!1 (Array Int var3752))
(assert (not (= var2807!1 null-__Array__Int__var3752__)))
(assert (= (select var2807!1 0) (cast-from-Int-to-var3752 var1891))) ; Statement: $r0[0] = $r1 
(define-const var408 String (String_format/1339386452 "arg%d" var2807!1)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("arg%d", $r0) 
 ; Statement: return $r2 
(check-sat)
; {arr-var3752-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var3752=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var984=i0, var3752=java.lang.Object, var2807=$r0, var1891=$r1, var408=$r2}
; {i0=var984, java.lang.Object=var3752, $r0=var2807, $r1=var1891, $r2=var408}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts i0 := @parameter0: int;	$r0 = newarray (java.lang.Object)[1];	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r0[0] = $r1;	$r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("arg%d", $r0);	return $r2
;block_num 1