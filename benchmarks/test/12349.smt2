(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3122 0)
(declare-sort var3828 0)
(declare-sort var2473 0)
(declare-sort var808 0)
(declare-sort var1380 0)
(declare-sort var2136 0)
(declare-sort var515 0)
(declare-sort var3990 0)
(declare-sort var2276 0)
(declare-sort var3376 0)
(declare-sort var2435 0)
(declare-sort var3676 0)
(declare-sort var3770 0)
(declare-sort var2274 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun acceptForeignIpWhitelist/-523071596 (var3122) String)
(declare-fun var3828_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var808_stream/-1757820 ((Array Int var1380)) var2473)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1380__ ((Array Int String)) (Array Int var1380))
(declare-fun var515_bootstrap$/1755587909 () var2136)
(declare-fun var2473_map/130902797 (var2473 var2136) var2473)
(declare-fun var2276_bootstrap$/168527058 () var3990)
(declare-fun var2473_filter/320182972 (var2473 var3990) var2473)
(declare-fun var3376_bootstrap$/-643879076 () var2136)
(declare-fun var3676_bootstrap$/2013228124 () var2435)
(declare-fun var2473_reduce/440360374 (var2473 var2435) var3770)
(declare-fun var2274_bootstrap$/-1956667138 () var3990)
(declare-fun orElse/-757175127 (var3770 var1380) var1380)
(declare-fun cast-from-var3990-to-var1380 (var3990) var1380)
(declare-fun cast-from-var1380-to-var3990 (var1380) var3990)
(declare-fun acceptForeignIpWhitelistPredicate/-523071596 (var3122) var3990)
(declare-const null-var3122 var3122)
(declare-const var824 var3122) ; Statement: r0 := @this: org.apache.dubbo.qos.api.QosConfiguration 
(assert (not (= var824 null-var3122)))
(define-const var759 String (acceptForeignIpWhitelist/-523071596 var824)) ; Statement: $r1 = r0.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String acceptForeignIpWhitelist> 
(define-const var432 Bool (var3828_isNotEmpty/-1251449450 var759)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_3__842: java.util.function.Predicate bootstrap$()>() 
(assert (not (= (ite var432 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2985 String (acceptForeignIpWhitelist/-523071596 var824)) ; Statement: $r3 = r0.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String acceptForeignIpWhitelist> 
; split operation: var2648 = var2985.split(",") ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var240 var2473 (var808_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var1380__ var2648))) ; Statement: $r6 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r4) 
(define-const var1608 var2136 var515_bootstrap$/1755587909) ; Statement: $r5 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$trim__855: java.util.function.Function bootstrap$()>() 
(define-const var3089 var2473 (var2473_map/130902797 var240 var1608)) ; Statement: $r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r5) 
(define-const var1985 var3990 var2276_bootstrap$/168527058) ; Statement: $r7 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__862: java.util.function.Predicate bootstrap$()>() 
(define-const var3219 var2473 (var2473_filter/320182972 var3089 var1985)) ; Statement: $r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r7) 
(define-const var378 var2136 var3376_bootstrap$/-643879076) ; Statement: $r9 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_1__879: java.util.function.Function bootstrap$()>() 
(define-const var3572 var2473 (var2473_map/130902797 var3219 var378)) ; Statement: $r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9) 
(define-const var2775 var2435 var3676_bootstrap$/2013228124) ; Statement: $r11 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$or__890: java.util.function.BinaryOperator bootstrap$()>() 
(define-const var2255 var3770 (var2473_reduce/440360374 var3572 var2775)) ; Statement: $r14 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.Optional reduce(java.util.function.BinaryOperator)>($r11) 
(define-const var1227 var3990 var2274_bootstrap$/-1956667138) ; Statement: $r13 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_2__899: java.util.function.Predicate bootstrap$()>() 
(assert true)
(define-const var2590 var1380 (orElse/-757175127 var2255 (cast-from-var3990-to-var1380 var1227))) ; Statement: $r15 = virtualinvoke $r14.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r13) 
(define-const var2091 var3990 (cast-from-var1380-to-var3990 var2590)) ; Statement: $r16 = (java.util.function.Predicate) $r15 
(declare-const var824!1 var3122)
(assert (not (= var824!1 null-var3122)))
(assert (= (acceptForeignIpWhitelistPredicate/-523071596 var824!1) var2091)) ; Statement: r0.<org.apache.dubbo.qos.api.QosConfiguration: java.util.function.Predicate acceptForeignIpWhitelistPredicate> = $r16 
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {acceptForeignIpWhitelist/-523071596=([org.apache.dubbo.qos.api.QosConfiguration], java.lang.String), var3828_isNotEmpty/-1251449450=([java.lang.String], boolean), var808_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var1380__=([java.lang.String[]], java.lang.Object[]), var515_bootstrap$/1755587909=([], java.util.function.Function), var2473_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var2276_bootstrap$/168527058=([], java.util.function.Predicate), var2473_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var3376_bootstrap$/-643879076=([], java.util.function.Function), var3676_bootstrap$/2013228124=([], java.util.function.BinaryOperator), var2473_reduce/440360374=([java.util.stream.Stream, java.util.function.BinaryOperator], java.util.Optional), var2274_bootstrap$/-1956667138=([], java.util.function.Predicate), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-var3990-to-var1380=([java.util.function.Predicate], java.lang.Object), cast-from-var1380-to-var3990=([java.lang.Object], java.util.function.Predicate), acceptForeignIpWhitelistPredicate/-523071596=([org.apache.dubbo.qos.api.QosConfiguration], java.util.function.Predicate)}
; {var3122=org.apache.dubbo.qos.api.QosConfiguration, var824=r0, var759=$r1, var3828=org.apache.dubbo.common.utils.StringUtils, var432=$z0, var2985=$r3, var2648=$r4, var2473=java.util.stream.Stream, var808=java.util.Arrays, var1380=java.lang.Object, var240=$r6, var2136=java.util.function.Function, var515=org.apache.dubbo.qos.api.QosConfiguration$trim__855, var1608=$r5, var3089=$r8, var3990=java.util.function.Predicate, var2276=org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__862, var1985=$r7, var3219=$r10, var3376=org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_1__879, var378=$r9, var3572=$r12, var2435=java.util.function.BinaryOperator, var3676=org.apache.dubbo.qos.api.QosConfiguration$or__890, var2775=$r11, var3770=java.util.Optional, var2255=$r14, var2274=org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_2__899, var1227=$r13, var2590=$r15, var2091=$r16}
; {org.apache.dubbo.qos.api.QosConfiguration=var3122, r0=var824, $r1=var759, org.apache.dubbo.common.utils.StringUtils=var3828, $z0=var432, $r3=var2985, $r4=var2648, java.util.stream.Stream=var2473, java.util.Arrays=var808, java.lang.Object=var1380, $r6=var240, java.util.function.Function=var2136, org.apache.dubbo.qos.api.QosConfiguration$trim__855=var515, $r5=var1608, $r8=var3089, java.util.function.Predicate=var3990, org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__862=var2276, $r7=var1985, $r10=var3219, org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_1__879=var3376, $r9=var378, $r12=var3572, java.util.function.BinaryOperator=var2435, org.apache.dubbo.qos.api.QosConfiguration$or__890=var3676, $r11=var2775, java.util.Optional=var3770, $r14=var2255, org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_2__899=var2274, $r13=var1227, $r15=var2590, $r16=var2091}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.qos.api.QosConfiguration;	$r1 = r0.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String acceptForeignIpWhitelist>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_3__842: java.util.function.Predicate bootstrap$()>();	$r3 = r0.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String acceptForeignIpWhitelist>;	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r6 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r4);	$r5 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$trim__855: java.util.function.Function bootstrap$()>();	$r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r5);	$r7 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__862: java.util.function.Predicate bootstrap$()>();	$r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r7);	$r9 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_1__879: java.util.function.Function bootstrap$()>();	$r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9);	$r11 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$or__890: java.util.function.BinaryOperator bootstrap$()>();	$r14 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.Optional reduce(java.util.function.BinaryOperator)>($r11);	$r13 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_2__899: java.util.function.Predicate bootstrap$()>();	$r15 = virtualinvoke $r14.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r13);	$r16 = (java.util.function.Predicate) $r15;	r0.<org.apache.dubbo.qos.api.QosConfiguration: java.util.function.Predicate acceptForeignIpWhitelistPredicate> = $r16;	goto [?= return];	return
;block_num 3