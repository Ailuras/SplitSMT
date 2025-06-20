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

(declare-sort var1632 0)
(declare-sort var1474 0)
(declare-sort var1000 0)
(declare-sort var3693 0)
(declare-sort var1262 0)
(declare-sort var2776 0)
(declare-sort var3742 0)
(declare-sort var933 0)
(declare-sort var559 0)
(declare-sort var404 0)
(declare-sort var384 0)
(declare-sort var3933 0)
(declare-sort var2074 0)
(declare-sort var2087 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun acceptForeignIpWhitelist/-523071596 (var1632) String)
(declare-fun var1474_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var3693_stream/-1757820 ((Array Int var1262)) var1000)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1262__ ((Array Int String)) (Array Int var1262))
(declare-fun var3742_bootstrap$/-1318493854 () var2776)
(declare-fun var1000_map/130902797 (var1000 var2776) var1000)
(declare-fun var559_bootstrap$/685920240 () var933)
(declare-fun var1000_filter/320182972 (var1000 var933) var1000)
(declare-fun var404_bootstrap$/184623233 () var2776)
(declare-fun var3933_bootstrap$/2013228124 () var384)
(declare-fun var1000_reduce/440360374 (var1000 var384) var2074)
(declare-fun var2087_bootstrap$/1444813820 () var933)
(declare-fun orElse/-757175127 (var2074 var1262) var1262)
(declare-fun cast-from-var933-to-var1262 (var933) var1262)
(declare-fun cast-from-var1262-to-var933 (var1262) var933)
(declare-fun acceptForeignIpWhitelistPredicate/-523071596 (var1632) var933)
(declare-const null-var1632 var1632)
(declare-const var1896 var1632) ; Statement: r0 := @this: org.apache.dubbo.qos.api.QosConfiguration 
(assert (not (= var1896 null-var1632)))
(define-const var249 String (acceptForeignIpWhitelist/-523071596 var1896)) ; Statement: $r1 = r0.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String acceptForeignIpWhitelist> 
(define-const var2982 Bool (var1474_isNotEmpty/-1251449450 var249)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_3__844: java.util.function.Predicate bootstrap$()>() 
(assert (not (= (ite var2982 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2449 String (acceptForeignIpWhitelist/-523071596 var1896)) ; Statement: $r3 = r0.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String acceptForeignIpWhitelist> 
; split operation: var1161 = var2449.split(",") ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var3611 var1000 (var3693_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var1262__ var1161))) ; Statement: $r6 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r4) 
(define-const var776 var2776 var3742_bootstrap$/-1318493854) ; Statement: $r5 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$trim__858: java.util.function.Function bootstrap$()>() 
(define-const var1947 var1000 (var1000_map/130902797 var3611 var776)) ; Statement: $r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r5) 
(define-const var608 var933 var559_bootstrap$/685920240) ; Statement: $r7 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__871: java.util.function.Predicate bootstrap$()>() 
(define-const var110 var1000 (var1000_filter/320182972 var1947 var608)) ; Statement: $r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r7) 
(define-const var3926 var2776 var404_bootstrap$/184623233) ; Statement: $r9 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_1__874: java.util.function.Function bootstrap$()>() 
(define-const var1873 var1000 (var1000_map/130902797 var110 var3926)) ; Statement: $r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9) 
(define-const var1593 var384 var3933_bootstrap$/2013228124) ; Statement: $r11 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$or__890: java.util.function.BinaryOperator bootstrap$()>() 
(define-const var3630 var2074 (var1000_reduce/440360374 var1873 var1593)) ; Statement: $r14 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.Optional reduce(java.util.function.BinaryOperator)>($r11) 
(define-const var2516 var933 var2087_bootstrap$/1444813820) ; Statement: $r13 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_2__897: java.util.function.Predicate bootstrap$()>() 
(assert true)
(define-const var1252 var1262 (orElse/-757175127 var3630 (cast-from-var933-to-var1262 var2516))) ; Statement: $r15 = virtualinvoke $r14.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r13) 
(define-const var2562 var933 (cast-from-var1262-to-var933 var1252)) ; Statement: $r16 = (java.util.function.Predicate) $r15 
(declare-const var1896!1 var1632)
(assert (not (= var1896!1 null-var1632)))
(assert (= (acceptForeignIpWhitelistPredicate/-523071596 var1896!1) var2562)) ; Statement: r0.<org.apache.dubbo.qos.api.QosConfiguration: java.util.function.Predicate acceptForeignIpWhitelistPredicate> = $r16 
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {acceptForeignIpWhitelist/-523071596=([org.apache.dubbo.qos.api.QosConfiguration], java.lang.String), var1474_isNotEmpty/-1251449450=([java.lang.String], boolean), var3693_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var1262__=([java.lang.String[]], java.lang.Object[]), var3742_bootstrap$/-1318493854=([], java.util.function.Function), var1000_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var559_bootstrap$/685920240=([], java.util.function.Predicate), var1000_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var404_bootstrap$/184623233=([], java.util.function.Function), var3933_bootstrap$/2013228124=([], java.util.function.BinaryOperator), var1000_reduce/440360374=([java.util.stream.Stream, java.util.function.BinaryOperator], java.util.Optional), var2087_bootstrap$/1444813820=([], java.util.function.Predicate), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-var933-to-var1262=([java.util.function.Predicate], java.lang.Object), cast-from-var1262-to-var933=([java.lang.Object], java.util.function.Predicate), acceptForeignIpWhitelistPredicate/-523071596=([org.apache.dubbo.qos.api.QosConfiguration], java.util.function.Predicate)}
; {var1632=org.apache.dubbo.qos.api.QosConfiguration, var1896=r0, var249=$r1, var1474=org.apache.dubbo.common.utils.StringUtils, var2982=$z0, var2449=$r3, var1161=$r4, var1000=java.util.stream.Stream, var3693=java.util.Arrays, var1262=java.lang.Object, var3611=$r6, var2776=java.util.function.Function, var3742=org.apache.dubbo.qos.api.QosConfiguration$trim__858, var776=$r5, var1947=$r8, var933=java.util.function.Predicate, var559=org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__871, var608=$r7, var110=$r10, var404=org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_1__874, var3926=$r9, var1873=$r12, var384=java.util.function.BinaryOperator, var3933=org.apache.dubbo.qos.api.QosConfiguration$or__890, var1593=$r11, var2074=java.util.Optional, var3630=$r14, var2087=org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_2__897, var2516=$r13, var1252=$r15, var2562=$r16}
; {org.apache.dubbo.qos.api.QosConfiguration=var1632, r0=var1896, $r1=var249, org.apache.dubbo.common.utils.StringUtils=var1474, $z0=var2982, $r3=var2449, $r4=var1161, java.util.stream.Stream=var1000, java.util.Arrays=var3693, java.lang.Object=var1262, $r6=var3611, java.util.function.Function=var2776, org.apache.dubbo.qos.api.QosConfiguration$trim__858=var3742, $r5=var776, $r8=var1947, java.util.function.Predicate=var933, org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__871=var559, $r7=var608, $r10=var110, org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_1__874=var404, $r9=var3926, $r12=var1873, java.util.function.BinaryOperator=var384, org.apache.dubbo.qos.api.QosConfiguration$or__890=var3933, $r11=var1593, java.util.Optional=var2074, $r14=var3630, org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_2__897=var2087, $r13=var2516, $r15=var1252, $r16=var2562}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.qos.api.QosConfiguration;	$r1 = r0.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String acceptForeignIpWhitelist>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_3__844: java.util.function.Predicate bootstrap$()>();	$r3 = r0.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String acceptForeignIpWhitelist>;	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r6 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r4);	$r5 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$trim__858: java.util.function.Function bootstrap$()>();	$r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r5);	$r7 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$isNotEmpty__871: java.util.function.Predicate bootstrap$()>();	$r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r7);	$r9 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_1__874: java.util.function.Function bootstrap$()>();	$r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9);	$r11 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$or__890: java.util.function.BinaryOperator bootstrap$()>();	$r14 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.Optional reduce(java.util.function.BinaryOperator)>($r11);	$r13 = staticinvoke <org.apache.dubbo.qos.api.QosConfiguration$lambda_buildPredicate_2__897: java.util.function.Predicate bootstrap$()>();	$r15 = virtualinvoke $r14.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r13);	$r16 = (java.util.function.Predicate) $r15;	r0.<org.apache.dubbo.qos.api.QosConfiguration: java.util.function.Predicate acceptForeignIpWhitelistPredicate> = $r16;	goto [?= return];	return
;block_num 3