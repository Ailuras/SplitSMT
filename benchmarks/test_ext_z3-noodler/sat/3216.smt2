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

(declare-sort var271 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var271-init () (Array Int var271))
(declare-fun getCanonicalName/935544231 (ClassObject) String)
(declare-fun cast-from-String-to-var271 (String) var271)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var271 (Int) var271)
(declare-fun String_format/1339386452 (String (Array Int var271)) String)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-Int Int)
(declare-const null-__Array__Int__var271__ (Array Int var271))
(declare-const var2514 (Array Int ClassObject)) ; Statement: r1 := @parameter0: java.lang.Class[] 
(assert (not (= var2514 null-__Array__Int__ClassObject__)))
(declare-const var1918 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1918 null-Int)))
(define-const var3622 (Array Int var271) arr-var271-init) ; Statement: $r0 = newarray (java.lang.Object)[2] 
(define-const var193 ClassObject (select var2514 var1918)) ; Statement: $r2 = r1[i0] 
(assert true)
(define-const var1653 String (getCanonicalName/935544231 var193)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getCanonicalName()>() 
(declare-const var3622!1 (Array Int var271))
(assert (not (= var3622!1 null-__Array__Int__var271__)))
(assert (= (select var3622!1 0) (cast-from-String-to-var271 var1653))) ; Statement: $r0[0] = $r3 
(define-const var1740 Int (Int_valueOf/-1371140006 var1918)) ; Statement: $r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var3622!2 (Array Int var271))
(assert (not (= var3622!2 null-__Array__Int__var271__)))
(assert (= (select var3622!2 1) (cast-from-Int-to-var271 var1740))) ; Statement: $r0[1] = $r4 
(define-const var1068 String (String_format/1339386452 "%s arg%d" var3622!2)) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s arg%d", $r0) 
 ; Statement: return $r5 
(check-sat)
; {arr-var271-init=([], java.lang.Object[]), getCanonicalName/935544231=([java.lang.Class], java.lang.String), cast-from-String-to-var271=([java.lang.String], java.lang.Object), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var271=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var2514=r1, var1918=i0, var271=java.lang.Object, var3622=$r0, var193=$r2, var1653=$r3, var1740=$r4, var1068=$r5}
; {r1=var2514, i0=var1918, java.lang.Object=var271, $r0=var3622, $r2=var193, $r3=var1653, $r4=var1740, $r5=var1068}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @parameter0: java.lang.Class[];	i0 := @parameter1: int;	$r0 = newarray (java.lang.Object)[2];	$r2 = r1[i0];	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getCanonicalName()>();	$r0[0] = $r3;	$r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r0[1] = $r4;	$r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s arg%d", $r0);	return $r5
;block_num 1