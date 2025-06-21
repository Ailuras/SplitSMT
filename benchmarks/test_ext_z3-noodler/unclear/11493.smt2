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

(declare-sort var2101 0)
(declare-sort var3359 0)
(declare-sort var3789 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun Float64_isNaN/-647401060 (Float64) Bool)
(declare-fun var3359-init () var3359)
(declare-fun arr-var3789-init () (Array Int var3789))
(declare-fun Float64_valueOf/679560954 (Float64) Float64)
(declare-fun cast-from-Float64-to-var3789 (Float64) var3789)
(declare-fun String_format/1339386452 (String (Array Int var3789)) String)
(declare-fun <init>/875830710 (var3359 String) void)
(declare-const null-var2101 var2101)
(declare-const null-Float64 Float64)
(declare-const null-__Array__Int__var3789__ (Array Int var3789))
(declare-const var798 var2101) ; Statement: r4 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest 
(assert (not (= var798 null-var2101)))
(declare-const var891 Float64) ; Statement: d0 := @parameter0: double 
(assert (not (= var891 null-Float64)))
(define-const var2971 Bool (Float64_isNaN/-647401060 var891)) ; Statement: $z0 = staticinvoke <java.lang.Double: boolean isNaN(double)>(d0) 
 ; Statement: if $z0 != 0 goto $r42 = new java.lang.IllegalArgumentException 
(assert (not (= (ite var2971 1 0) 0))) ; Cond: $z0 != 0 
(define-const var39 var3359 var3359-init) ; Statement: $r42 = new java.lang.IllegalArgumentException 
(define-const var1389 (Array Int var3789) arr-var3789-init) ; Statement: $r1 = newarray (java.lang.Object)[1] 
(define-const var239 Float64 (Float64_valueOf/679560954 var891)) ; Statement: $r2 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d0) 
(declare-const var1389!1 (Array Int var3789))
(assert (not (= var1389!1 null-__Array__Int__var3789__)))
(assert (= (select var1389!1 0) (cast-from-Float64-to-var3789 var239))) ; Statement: $r1[0] = $r2 
(define-const var783 String (String_format/1339386452 "Invalid value: %f" var1389!1)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Invalid value: %f", $r1) 
(assert true)
;(assert (<init>/875830710 var39 var783)) ; Statement: specialinvoke $r42.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r3) 

(declare-const var39!1 var3359)
(declare-const var783!1 String)
 ; Statement: throw $r42 
(check-sat)
; {Float64_isNaN/-647401060=([double], boolean), var3359-init=([], java.lang.IllegalArgumentException), arr-var3789-init=([], java.lang.Object[]), Float64_valueOf/679560954=([double], java.lang.Double), cast-from-Float64-to-var3789=([java.lang.Double], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2101=org.apache.dubbo.metrics.aggregate.DubboMergingDigest, var798=r4, var891=d0, var2971=$z0, var3359=java.lang.IllegalArgumentException, var39=$r42, var3789=java.lang.Object, var1389=$r1, var239=$r2, var783=$r3}
; {org.apache.dubbo.metrics.aggregate.DubboMergingDigest=var2101, r4=var798, d0=var891, $z0=var2971, java.lang.IllegalArgumentException=var3359, $r42=var39, java.lang.Object=var3789, $r1=var1389, $r2=var239, $r3=var783}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r4 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest;	d0 := @parameter0: double;	$z0 = staticinvoke <java.lang.Double: boolean isNaN(double)>(d0);	if $z0 != 0 goto $r42 = new java.lang.IllegalArgumentException;	$r42 = new java.lang.IllegalArgumentException;	$r1 = newarray (java.lang.Object)[1];	$r2 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d0);	$r1[0] = $r2;	$r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Invalid value: %f", $r1);	specialinvoke $r42.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r3);	throw $r42
;block_num 2