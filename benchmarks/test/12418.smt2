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

(declare-sort var3119 0)
(declare-sort var1569 0)
(declare-sort var2377 0)
(declare-sort var3580 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun acceptForeignIpWhitelist/-523071596 (var3119) String)
(declare-fun var1569_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var3580_bootstrap$/-661670275 () var2377)
(declare-fun acceptForeignIpWhitelistPredicate/-523071596 (var3119) var2377)
(declare-const null-var3119 var3119)
(declare-const var3982 var3119) ; Statement: r0 := @this: org.apache.dubbo.qos.api.QosConfiguration 
(assert (not (= var3982 null-var3119)))
(define-const var1628 String (acceptForeignIpWhitelist/-523071596 var3982)) ; Statement: $r1 = r0.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String acceptForeignIpWhitelist> 
(define-const var54 Bool (var1569_isNotEmpty/-1251449450 var1628)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_3__844: java.util.function.Predicate bootstrap$()>() 
(assert (= (ite var54 1 0) 0)) ; Cond: $z0 == 0 
(define-const var593 var2377 var3580_bootstrap$/-661670275) ; Statement: $r2 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_3__844: java.util.function.Predicate bootstrap$()>() 
(declare-const var3982!1 var3119)
(assert (not (= var3982!1 null-var3119)))
(assert (= (acceptForeignIpWhitelistPredicate/-523071596 var3982!1) var593)) ; Statement: r0.<org.apache.dubbo.qos.api.QosConfiguration: java.util.function.Predicate acceptForeignIpWhitelistPredicate> = $r2 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {acceptForeignIpWhitelist/-523071596=([org.apache.dubbo.qos.api.QosConfiguration], java.lang.String), var1569_isNotEmpty/-1251449450=([java.lang.String], boolean), var3580_bootstrap$/-661670275=([], java.util.function.Predicate), acceptForeignIpWhitelistPredicate/-523071596=([org.apache.dubbo.qos.api.QosConfiguration], java.util.function.Predicate)}
; {var3119=org.apache.dubbo.qos.api.QosConfiguration, var3982=r0, var1628=$r1, var1569=org.apache.dubbo.common.utils.StringUtils, var54=$z0, var2377=java.util.function.Predicate, var3580=org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_3__844, var593=$r2}
; {org.apache.dubbo.qos.api.QosConfiguration=var3119, r0=var3982, $r1=var1628, org.apache.dubbo.common.utils.StringUtils=var1569, $z0=var54, java.util.function.Predicate=var2377, org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_3__844=var3580, $r2=var593}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.qos.api.QosConfiguration;	$r1 = r0.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String acceptForeignIpWhitelist>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_3__844: java.util.function.Predicate bootstrap$()>();	$r2 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_3__844: java.util.function.Predicate bootstrap$()>();	r0.<org.apache.dubbo.qos.api.QosConfiguration: java.util.function.Predicate acceptForeignIpWhitelistPredicate> = $r2;	return
;block_num 3