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

(declare-sort var2795 0)
(declare-sort var754 0)
(declare-sort var2060 0)
(declare-sort var776 0)
(declare-sort var912 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun parameters/-202604121 (var2795) var2060)
(declare-fun var2060_get/1088891777 (var2060 var776) var776)
(declare-fun cast-from-String-to-var776 (String) var776)
(declare-fun cast-from-var776-to-String (var776) String)
(declare-fun var912_isEmpty/-813097145 (String) Bool)
(declare-const null-var2795 var2795)
(declare-const null-String String)
(declare-const var2993 var2795) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var2993 null-var2795)))
(declare-const var1647 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1647 null-String)))
(define-const var2922 var2060 (parameters/-202604121 var2993)) ; Statement: $r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters> 
(define-const var1987 var776 (var2060_get/1088891777 var2922 (cast-from-String-to-var776 var1647))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var1428 String (cast-from-var776-to-String var1987)) ; Statement: r22 = (java.lang.String) $r3 
(define-const var1968 Bool (var912_isEmpty/-813097145 var1428)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
(assert (= (ite var1968 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2874 Bool (var912_isEmpty/-813097145 var1428)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z1 == 0 goto $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
(assert (= (ite var2874 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2299 Bool (var912_isEmpty/-813097145 var1428)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z2 == 0 goto return r22 
(assert (= (ite var2299 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r22 
(check-sat)
; {parameters/-202604121=([org.apache.dubbo.common.Parameters], java.util.Map), var2060_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var776=([java.lang.String], java.lang.Object), cast-from-var776-to-String=([java.lang.Object], java.lang.String), var912_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2795=org.apache.dubbo.common.Parameters, var2993=r0, var1647=r1, var754=null_type, var2060=java.util.Map, var2922=$r2, var776=java.lang.Object, var1987=$r3, var1428=r22, var912=org.apache.dubbo.common.utils.StringUtils, var1968=$z0, var2874=$z1, var2299=$z2}
; {org.apache.dubbo.common.Parameters=var2795, r0=var2993, r1=var1647, null_type=var754, java.util.Map=var2060, $r2=var2922, java.lang.Object=var776, $r3=var1987, r22=var1428, org.apache.dubbo.common.utils.StringUtils=var912, $z0=var1968, $z1=var2874, $z2=var2299}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 3}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r22 = (java.lang.String) $r3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z1 == 0 goto $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z2 == 0 goto return r22;	return r22
;block_num 4