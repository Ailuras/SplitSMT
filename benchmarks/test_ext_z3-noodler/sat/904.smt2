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

(declare-sort var309 0)
(declare-sort var2288 0)
(declare-sort var1845 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2288-init () var2288)
(declare-fun arr-var1845-init () (Array Int var1845))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var1845 (Int) var1845)
(declare-fun String_format/1339386452 (String (Array Int var1845)) String)
(declare-fun <init>/875830710 (var2288 String) void)
(declare-const null-var309 var309)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var1845__ (Array Int var1845))
(declare-const var357 var309) ; Statement: r4 := @this: org.antlr.v4.codegen.Target 
(assert (not (= var357 null-var309)))
(declare-const var3082 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3082 null-Int)))
 ; Statement: if i0 < 0 goto $r13 = new java.lang.IllegalArgumentException 
(assert (< var3082 0)) ; Cond: i0 < 0 
(define-const var1372 var2288 var2288-init) ; Statement: $r13 = new java.lang.IllegalArgumentException 
(define-const var2437 (Array Int var1845) arr-var1845-init) ; Statement: $r1 = newarray (java.lang.Object)[1] 
(define-const var1481 Int (Int_valueOf/-1371140006 var3082)) ; Statement: $r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var2437!1 (Array Int var1845))
(assert (not (= var2437!1 null-__Array__Int__var1845__)))
(assert (= (select var2437!1 0) (cast-from-Int-to-var1845 var1481))) ; Statement: $r1[0] = $r2 
(define-const var2643 String (String_format/1339386452 "Cannot encode the specified value: %d" var2437!1)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Cannot encode the specified value: %d", $r1) 
(assert true)
;(assert (<init>/875830710 var1372 var2643)) ; Statement: specialinvoke $r13.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r3) 

(declare-const var1372!1 var2288)
(declare-const var2643!1 String)
 ; Statement: throw $r13 
(check-sat)
; {var2288-init=([], java.lang.IllegalArgumentException), arr-var1845-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var1845=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var309=org.antlr.v4.codegen.Target, var357=r4, var3082=i0, var2288=java.lang.IllegalArgumentException, var1372=$r13, var1845=java.lang.Object, var2437=$r1, var1481=$r2, var2643=$r3}
; {org.antlr.v4.codegen.Target=var309, r4=var357, i0=var3082, java.lang.IllegalArgumentException=var2288, $r13=var1372, java.lang.Object=var1845, $r1=var2437, $r2=var1481, $r3=var2643}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r4 := @this: org.antlr.v4.codegen.Target;	i0 := @parameter0: int;	if i0 < 0 goto $r13 = new java.lang.IllegalArgumentException;	$r13 = new java.lang.IllegalArgumentException;	$r1 = newarray (java.lang.Object)[1];	$r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r1[0] = $r2;	$r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Cannot encode the specified value: %d", $r1);	specialinvoke $r13.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r3);	throw $r13
;block_num 2