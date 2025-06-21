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

(declare-sort var828 0)
(declare-sort var2308 0)
(declare-sort var3304 0)
(declare-sort var2961 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2308_containsKey/792064469 (String) Bool)
(declare-fun var3304-init () var3304)
(declare-fun arr-var2961-init () (Array Int var2961))
(declare-fun cast-from-String-to-var2961 (String) var2961)
(declare-fun String_format/1339386452 (String (Array Int var2961)) String)
(declare-fun <init>/-1092629202 (var3304 String) void)
(declare-const null-String String)
(declare-const null-__Array__Int__var2961__ (Array Int var2961))
(declare-const var1740 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1740 null-String)))
(define-const var2290 Bool (var2308_containsKey/792064469 var1740)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: boolean containsKey(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.IllegalStateException 
(assert (= (ite var2290 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1946 var3304 var3304-init) ; Statement: $r1 = new java.lang.IllegalStateException 
(define-const var157 (Array Int var2961) arr-var2961-init) ; Statement: $r2 = newarray (java.lang.Object)[1] 
(declare-const var157!1 (Array Int var2961))
(assert (not (= var157!1 null-__Array__Int__var2961__)))
(assert (= (select var157!1 0) (cast-from-String-to-var2961 var1740))) ; Statement: $r2[0] = r0 
(define-const var1260 String (String_format/1339386452 "System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants" var157!1)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants", $r2) 
(assert true)
;(assert (<init>/-1092629202 var1946 var1260)) ; Statement: specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r3) 

(declare-const var1946!1 var3304)
(declare-const var1260!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var2308_containsKey/792064469=([java.lang.String], boolean), var3304-init=([], java.lang.IllegalStateException), arr-var2961-init=([], java.lang.Object[]), cast-from-String-to-var2961=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var1740=r0, var828=null_type, var2308=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2290=$z0, var3304=java.lang.IllegalStateException, var1946=$r1, var2961=java.lang.Object, var157=$r2, var1260=$r3}
; {r0=var1740, null_type=var828, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var2308, $z0=var2290, java.lang.IllegalStateException=var3304, $r1=var1946, java.lang.Object=var2961, $r2=var157, $r3=var1260}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: boolean containsKey(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = new java.lang.IllegalStateException;	$r1 = new java.lang.IllegalStateException;	$r2 = newarray (java.lang.Object)[1];	$r2[0] = r0;	$r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants", $r2);	specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r3);	throw $r1
;block_num 2