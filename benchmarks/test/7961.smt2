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

(declare-sort var1118 0)
(declare-sort var3743 0)
(declare-sort var572 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var572_isEmpty/-813097145 (String) Bool)
(declare-fun var572_isNotEmpty/-1251449450 (String) Bool)
(declare-fun protocol/1679408145 (var1118) String)
(declare-fun getThis/-892155725 (var1118) var1118)
(declare-const null-var1118 var1118)
(declare-const null-String String)
(declare-const var3829 var1118) ; Statement: r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder 
(assert (not (= var3829 null-var1118)))
(declare-const var1793 String) ; Statement: r6 := @parameter0: java.lang.String 
(assert (not (= var1793 null-String)))
(declare-const var838 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var838 null-String)))
(define-const var1299 Bool (var572_isEmpty/-813097145 var1793)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r6) 
 ; Statement: if $z0 == 0 goto $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6) 
(assert (= (ite var1299 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3286 Bool (var572_isNotEmpty/-1251449450 var1793)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6) 
 ; Statement: if $z3 == 0 goto $r7 = specialinvoke r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String getRelatedOrDefaultProtocol()>() 
(assert (not (= (ite var3286 1 0) 0))) ; Negate: Cond: $z3 == 0  
(define-const var2177 String var1793) ; Statement: $r7 = r6 
 ; Statement: goto [?= r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> = $r7] 
(assert true) ; Non Conditional
(declare-const var3829!1 var1118)
(assert (not (= var3829!1 null-var1118)))
(assert (= (protocol/1679408145 var3829!1) var2177)) ; Statement: r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> = $r7 
(assert true)
(define-const var2645 var1118 (getThis/-892155725 var3829!1)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder getThis()>() 
 ; Statement: return $r1 
(check-sat)
; {var572_isEmpty/-813097145=([java.lang.String], boolean), var572_isNotEmpty/-1251449450=([java.lang.String], boolean), protocol/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.String), getThis/-892155725=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder)}
; {var1118=org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder, var3829=r0, var1793=r6, var3743=null_type, var838=r2, var572=org.apache.dubbo.common.utils.StringUtils, var1299=$z0, var3286=$z3, var2177=$r7, var2645=$r1}
; {org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder=var1118, r0=var3829, r6=var1793, null_type=var3743, r2=var838, org.apache.dubbo.common.utils.StringUtils=var572, $z0=var1299, $z3=var3286, $r7=var2177, $r1=var2645}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder;	r6 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r6);	if $z0 == 0 goto $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6);	$z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6);	if $z3 == 0 goto $r7 = specialinvoke r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String getRelatedOrDefaultProtocol()>();	$r7 = r6;	goto [?= r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> = $r7];	r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> = $r7;	$r1 = virtualinvoke r0.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder getThis()>();	return $r1
;block_num 4