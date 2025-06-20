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

(declare-sort var642 0)
(declare-sort var286 0)
(declare-sort var3904 0)
(declare-sort var1255 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var286_containsKey/792064469 (String) Bool)
(declare-fun var3904-init () var3904)
(declare-fun arr-var1255-init () (Array Int var1255))
(declare-fun cast-from-String-to-var1255 (String) var1255)
(declare-fun String_format/1339386452 (String (Array Int var1255)) String)
(declare-fun <init>/-1092629202 (var3904 String) void)
(declare-const null-String String)
(declare-const null-__Array__Int__var1255__ (Array Int var1255))
(declare-const var3513 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3513 null-String)))
(declare-const var350 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var350 null-String)))
(define-const var721 Bool (var286_containsKey/792064469 var3513)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: boolean containsKey(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.IllegalStateException 
(assert (= (ite var721 1 0) 0)) ; Cond: $z0 == 0 
(define-const var944 var3904 var3904-init) ; Statement: $r1 = new java.lang.IllegalStateException 
(define-const var3052 (Array Int var1255) arr-var1255-init) ; Statement: $r2 = newarray (java.lang.Object)[1] 
(declare-const var3052!1 (Array Int var1255))
(assert (not (= var3052!1 null-__Array__Int__var1255__)))
(assert (= (select var3052!1 0) (cast-from-String-to-var1255 var3513))) ; Statement: $r2[0] = r0 
(define-const var1197 String (String_format/1339386452 "System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants" var3052!1)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants", $r2) 
(assert true)
;(assert (<init>/-1092629202 var944 var1197)) ; Statement: specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r3) 

(declare-const var944!1 var3904)
(declare-const var1197!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var286_containsKey/792064469=([java.lang.String], boolean), var3904-init=([], java.lang.IllegalStateException), arr-var1255-init=([], java.lang.Object[]), cast-from-String-to-var1255=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3513=r0, var642=null_type, var350=r4, var286=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var721=$z0, var3904=java.lang.IllegalStateException, var944=$r1, var1255=java.lang.Object, var3052=$r2, var1197=$r3}
; {r0=var3513, null_type=var642, r4=var350, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var286, $z0=var721, java.lang.IllegalStateException=var3904, $r1=var944, java.lang.Object=var1255, $r2=var3052, $r3=var1197}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @parameter0: java.lang.String;	r4 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: boolean containsKey(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = new java.lang.IllegalStateException;	$r1 = new java.lang.IllegalStateException;	$r2 = newarray (java.lang.Object)[1];	$r2[0] = r0;	$r3 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("System property [%s] does not define in org.apache.dubbo.common.constants.CommonConstants", $r2);	specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r3);	throw $r1
;block_num 2