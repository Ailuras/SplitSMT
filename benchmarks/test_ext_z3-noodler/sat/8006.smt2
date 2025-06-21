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

(declare-sort var819 0)
(declare-sort var906 0)
(declare-sort var3488 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3488_isEmpty/-813097145 (String) Bool)
(declare-fun var3488_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getRelatedOrDefaultProtocol/-1570465508 (var819) String)
(declare-fun protocol/1679408145 (var819) String)
(declare-fun getThis/-892155725 (var819) var819)
(declare-const null-var819 var819)
(declare-const null-String String)
(declare-const var3351 var819) ; Statement: r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder 
(assert (not (= var3351 null-var819)))
(declare-const var1277 String) ; Statement: r6 := @parameter0: java.lang.String 
(assert (not (= var1277 null-String)))
(declare-const var334 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var334 null-String)))
(define-const var3553 Bool (var3488_isEmpty/-813097145 var1277)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r6) 
 ; Statement: if $z0 == 0 goto $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6) 
(assert (= (ite var3553 1 0) 0)) ; Cond: $z0 == 0 
(define-const var705 Bool (var3488_isNotEmpty/-1251449450 var1277)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6) 
 ; Statement: if $z3 == 0 goto $r7 = specialinvoke r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String getRelatedOrDefaultProtocol()>() 
(assert (= (ite var705 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var1759 String (getRelatedOrDefaultProtocol/-1570465508 var3351)) ; Statement: $r7 = specialinvoke r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String getRelatedOrDefaultProtocol()>() 
(assert true) ; Non Conditional
(declare-const var3351!1 var819)
(assert (not (= var3351!1 null-var819)))
(assert (= (protocol/1679408145 var3351!1) var1759)) ; Statement: r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> = $r7 
(assert true)
(define-const var2383 var819 (getThis/-892155725 var3351!1)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder getThis()>() 
 ; Statement: return $r1 
(check-sat)
; {var3488_isEmpty/-813097145=([java.lang.String], boolean), var3488_isNotEmpty/-1251449450=([java.lang.String], boolean), getRelatedOrDefaultProtocol/-1570465508=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.String), protocol/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.String), getThis/-892155725=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder)}
; {var819=org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder, var3351=r0, var1277=r6, var906=null_type, var334=r2, var3488=org.apache.dubbo.common.utils.StringUtils, var3553=$z0, var705=$z3, var1759=$r7, var2383=$r1}
; {org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder=var819, r0=var3351, r6=var1277, null_type=var906, r2=var334, org.apache.dubbo.common.utils.StringUtils=var3488, $z0=var3553, $z3=var705, $r7=var1759, $r1=var2383}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder;	r6 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r6);	if $z0 == 0 goto $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6);	$z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6);	if $z3 == 0 goto $r7 = specialinvoke r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String getRelatedOrDefaultProtocol()>();	$r7 = specialinvoke r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String getRelatedOrDefaultProtocol()>();	r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> = $r7;	$r1 = virtualinvoke r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder getThis()>();	return $r1
;block_num 4