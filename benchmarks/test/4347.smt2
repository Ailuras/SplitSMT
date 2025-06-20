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

(declare-sort var1886 0)
(declare-sort var2636 0)
(declare-sort var3591 0)
(declare-sort var2167 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2636_containsKey/792064469 (String) Bool)
(declare-fun var3591-init () var3591)
(declare-fun arr-var2167-init () (Array Int var2167))
(declare-fun cast-from-String-to-var2167 (String) var2167)
(declare-fun String_format/1339386452 (String (Array Int var2167)) String)
(declare-fun <init>/-1092629202 (var3591 String) void)
(declare-const null-String String)
(declare-const null-__Array__Int__var2167__ (Array Int var2167))
(declare-const var646 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var646 null-String)))
(define-const var2996 Bool (var2636_containsKey/792064469 var646)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: boolean containsKey(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.IllegalStateException 
(assert (= (ite var2996 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2708 var3591 var3591-init) ; Statement: $r1 = new java.lang.IllegalStateException 
(define-const var2500 (Array Int var2167) arr-var2167-init) ; Statement: $r2 = newarray (java.lang.Object)[1] 
(declare-const var2500!1 (Array Int var2167))
(assert (not (= var2500!1 null-__Array__Int__var2167__)))
(assert (= (select var2500!1 0) (cast-from-String-to-var2167 var646))) ; Statement: $r2[0] = r0 
(define-const var3864 String (String_format/1339386452 "System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants" var2500!1)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants", $r2) 
(assert true)
;(assert (<init>/-1092629202 var2708 var3864)) ; Statement: specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r3) 

(declare-const var2708!1 var3591)
(declare-const var3864!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var2636_containsKey/792064469=([java.lang.String], boolean), var3591-init=([], java.lang.IllegalStateException), arr-var2167-init=([], java.lang.Object[]), cast-from-String-to-var2167=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var646=r0, var1886=null_type, var2636=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2996=$z0, var3591=java.lang.IllegalStateException, var2708=$r1, var2167=java.lang.Object, var2500=$r2, var3864=$r3}
; {r0=var646, null_type=var1886, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var2636, $z0=var2996, java.lang.IllegalStateException=var3591, $r1=var2708, java.lang.Object=var2167, $r2=var2500, $r3=var3864}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: boolean containsKey(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = new java.lang.IllegalStateException;	$r1 = new java.lang.IllegalStateException;	$r2 = newarray (java.lang.Object)[1];	$r2[0] = r0;	$r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants", $r2);	specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r3);	throw $r1
;block_num 2