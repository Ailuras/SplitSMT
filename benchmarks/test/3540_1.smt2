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

(declare-sort var3490 0)
(declare-sort var2620 0)
(declare-sort var1100 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1100-init () var1100)
(declare-fun String_format/1339386452 (String (Array Int var3490)) String)
(declare-fun <init>/875830710 (var1100 String) void)
(declare-const null-var3490 var3490)
(declare-const null-String String)
(declare-const null-__Array__Int__var3490__ (Array Int var3490))
(declare-const var2510 var3490) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var2510 null-var3490)))
(declare-const var938 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var938 null-String)))
(declare-const var2881 (Array Int var3490)) ; Statement: r3 := @parameter2: java.lang.Object[] 
(assert (not (= var2881 null-__Array__Int__var3490__)))
 ; Statement: if r0 != null goto return 
(assert (not (not (= var2510 null-var3490)))) ; Negate: Cond: r0 != null  
(define-const var3979 var1100 var1100-init) ; Statement: $r1 = new java.lang.IllegalArgumentException 
(define-const var800 String (String_format/1339386452 var938 var2881)) ; Statement: $r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>(r2, r3) 
(assert true)
;(assert (<init>/875830710 var3979 var800)) ; Statement: specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r4) 

(declare-const var3979!1 var1100)
(declare-const var800!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var1100-init=([], java.lang.IllegalArgumentException), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3490=java.lang.Object, var2510=r0, var938=r2, var2620=null_type, var2881=r3, var1100=java.lang.IllegalArgumentException, var3979=$r1, var800=$r4}
; {java.lang.Object=var3490, r0=var2510, r2=var938, null_type=var2620, r3=var2881, java.lang.IllegalArgumentException=var1100, $r1=var3979, $r4=var800}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @parameter0: java.lang.Object;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.Object[];	if r0 != null goto return;	$r1 = new java.lang.IllegalArgumentException;	$r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>(r2, r3);	specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r4);	throw $r1
;block_num 2