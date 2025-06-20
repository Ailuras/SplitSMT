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

(declare-sort var3937 0)
(declare-sort var3111 0)
(declare-sort var1534 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var3111-init () var3111)
(declare-fun arr-var1534-init () (Array Int var1534))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var1534 (Int) var1534)
(declare-fun String_format/1339386452 (String (Array Int var1534)) String)
(declare-fun <init>/875830710 (var3111 String) void)
(declare-const null-var3937 var3937)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var1534__ (Array Int var1534))
(declare-const var45 var3937) ; Statement: r4 := @this: org.antlr.v4.codegen.Target 
(assert (not (= var45 null-var3937)))
(declare-const var2463 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2463 null-Int)))
 ; Statement: if i0 < 0 goto $r13 = new java.lang.IllegalArgumentException 
(assert (not (< var2463 0))) ; Negate: Cond: i0 < 0  
(define-const var2688 Int (cast-from-Int-to-Int 65535)) ; Statement: $i4 = (int) 65535 
 ; Statement: if i0 <= $i4 goto $z0 = virtualinvoke r4.<org.antlr.v4.codegen.Target: boolean isATNSerializedAsInts()>() 
(assert (not (<= var2463 var2688))) ; Negate: Cond: i0 <= $i4  
(define-const var1934 var3111 var3111-init) ; Statement: $r13 = new java.lang.IllegalArgumentException 
(define-const var1346 (Array Int var1534) arr-var1534-init) ; Statement: $r1 = newarray (java.lang.Object)[1] 
(define-const var1239 Int (Int_valueOf/-1371140006 var2463)) ; Statement: $r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var1346!1 (Array Int var1534))
(assert (not (= var1346!1 null-__Array__Int__var1534__)))
(assert (= (select var1346!1 0) (cast-from-Int-to-var1534 var1239))) ; Statement: $r1[0] = $r2 
(define-const var1706 String (String_format/1339386452 "Cannot encode the specified value: %d" var1346!1)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Cannot encode the specified value: %d", $r1) 
(assert true)
;(assert (<init>/875830710 var1934 var1706)) ; Statement: specialinvoke $r13.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r3) 

(declare-const var1934!1 var3111)
(declare-const var1706!1 String)
 ; Statement: throw $r13 
(check-sat)
; {cast-from-Int-to-Int=([int], int), var3111-init=([], java.lang.IllegalArgumentException), arr-var1534-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var1534=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3937=org.antlr.v4.codegen.Target, var45=r4, var2463=i0, var2688=$i4, var3111=java.lang.IllegalArgumentException, var1934=$r13, var1534=java.lang.Object, var1346=$r1, var1239=$r2, var1706=$r3}
; {org.antlr.v4.codegen.Target=var3937, r4=var45, i0=var2463, $i4=var2688, java.lang.IllegalArgumentException=var3111, $r13=var1934, java.lang.Object=var1534, $r1=var1346, $r2=var1239, $r3=var1706}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r4 := @this: org.antlr.v4.codegen.Target;	i0 := @parameter0: int;	if i0 < 0 goto $r13 = new java.lang.IllegalArgumentException;	$i4 = (int) 65535;	if i0 <= $i4 goto $z0 = virtualinvoke r4.<org.antlr.v4.codegen.Target: boolean isATNSerializedAsInts()>();	$r13 = new java.lang.IllegalArgumentException;	$r1 = newarray (java.lang.Object)[1];	$r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r1[0] = $r2;	$r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Cannot encode the specified value: %d", $r1);	specialinvoke $r13.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r3);	throw $r13
;block_num 3