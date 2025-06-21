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

(declare-sort var3943 0)
(declare-sort var1728 0)
(declare-sort var1832 0)
(declare-sort var3022 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1728_containsKey/792064469 (String) Bool)
(declare-fun var1832-init () var1832)
(declare-fun arr-var3022-init () (Array Int var3022))
(declare-fun cast-from-String-to-var3022 (String) var3022)
(declare-fun String_format/1339386452 (String (Array Int var3022)) String)
(declare-fun <init>/-1092629202 (var1832 String) void)
(declare-const null-String String)
(declare-const null-__Array__Int__var3022__ (Array Int var3022))
(declare-const var2392 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2392 null-String)))
(declare-const var2151 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var2151 null-String)))
(define-const var3081 Bool (var1728_containsKey/792064469 var2392)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: boolean containsKey(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.IllegalStateException 
(assert (= (ite var3081 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2278 var1832 var1832-init) ; Statement: $r1 = new java.lang.IllegalStateException 
(define-const var3718 (Array Int var3022) arr-var3022-init) ; Statement: $r2 = newarray (java.lang.Object)[1] 
(declare-const var3718!1 (Array Int var3022))
(assert (not (= var3718!1 null-__Array__Int__var3022__)))
(assert (= (select var3718!1 0) (cast-from-String-to-var3022 var2392))) ; Statement: $r2[0] = r0 
(define-const var675 String (String_format/1339386452 "System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants" var3718!1)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants", $r2) 
(assert true)
;(assert (<init>/-1092629202 var2278 var675)) ; Statement: specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r3) 

(declare-const var2278!1 var1832)
(declare-const var675!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var1728_containsKey/792064469=([java.lang.String], boolean), var1832-init=([], java.lang.IllegalStateException), arr-var3022-init=([], java.lang.Object[]), cast-from-String-to-var3022=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2392=r0, var3943=null_type, var2151=r4, var1728=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var3081=$z0, var1832=java.lang.IllegalStateException, var2278=$r1, var3022=java.lang.Object, var3718=$r2, var675=$r3}
; {r0=var2392, null_type=var3943, r4=var2151, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var1728, $z0=var3081, java.lang.IllegalStateException=var1832, $r1=var2278, java.lang.Object=var3022, $r2=var3718, $r3=var675}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @parameter0: java.lang.String;	r4 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: boolean containsKey(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = new java.lang.IllegalStateException;	$r1 = new java.lang.IllegalStateException;	$r2 = newarray (java.lang.Object)[1];	$r2[0] = r0;	$r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants", $r2);	specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r3);	throw $r1
;block_num 2