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

(declare-sort var1932 0)
(declare-sort var781 0)
(declare-sort var2807 0)
(declare-sort var329 0)
(declare-sort var3061 0)
(declare-sort var3074 0)
(declare-sort var454 0)
(declare-sort var2011 0)
(declare-sort var3127 0)
(declare-sort var1016 0)
(declare-sort var2130 0)
(declare-sort var1414 0)
(declare-sort var2954 0)
(declare-sort var1276 0)
(declare-sort var3535 0)
(declare-sort var853 0)
(declare-sort var3263 0)
(declare-sort var2498 0)
(declare-sort var1556 0)
(declare-sort var242 0)
(declare-sort var2686 0)
(declare-sort var3888 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1016!class ClassObject)
(declare-fun getRemote/226840252 (var781) var329)
(declare-fun var3061_ofNullable/-1077078438 (var3074) var3061)
(declare-fun cast-from-var329-to-var3074 (var329) var3074)
(declare-fun var2011_bootstrap$/-1335414910 () var454)
(declare-fun map/1305667865 (var3061 var454) var3061)
(declare-fun var3127_requireNonNull/-961817614 (var3074) var3074)
(declare-fun cast-from-ClassObject-to-var3074 (ClassObject) var3074)
(declare-fun var2130_bootstrap$/-2066635725 (ClassObject) var454)
(declare-fun var1414_bootstrap$/-575610213 () var454)
(declare-fun orElse/-757175127 (var3061 var3074) var3074)
(declare-fun cast-from-var3074-to-var2954 (var3074) var2954)
(declare-fun getQosConfiguration/-783028813 (var781) var1276)
(declare-fun getAnonymousAllowCommands/-248263360 (var1276) String)
(declare-fun var3535_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var3263_stream/-1757820 ((Array Int var3074)) var853)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3074__ ((Array Int String)) (Array Int var3074))
(declare-fun var1556_bootstrap$/-846334374 () var2498)
(declare-fun var853_filter/320182972 (var853 var2498) var853)
(declare-fun var242_bootstrap$/-2047824260 () var454)
(declare-fun var853_map/130902797 (var853 var454) var853)
(declare-fun var2686_bootstrap$/-1620052580 (var781) var2498)
(declare-fun var853_anyMatch/-1059037355 (var853 var2498) Bool)
(declare-const null-var1932 var1932)
(declare-const null-var781 var781)
(declare-const null-var2807 var2807)
(declare-const null-NullType var3888)
(declare-const null-var3074 var3074)
(declare-const var3863 var1932) ; Statement: r23 := @this: org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker 
(assert (not (= var3863 null-var1932)))
(declare-const var2244 var781) ; Statement: r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var2244 null-var781)))
(declare-const var2551 var2807) ; Statement: r13 := @parameter1: org.apache.dubbo.qos.api.PermissionLevel 
(assert (not (= var2551 null-var2807)))
(assert true)
(define-const var207 var329 (getRemote/226840252 var2244)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: io.netty.channel.Channel getRemote()>() 
(define-const var1257 var3061 (var3061_ofNullable/-1077078438 (cast-from-var329-to-var3074 var207))) ; Statement: $r3 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>($r1) 
(define-const var2639 var454 var2011_bootstrap$/-1335414910) ; Statement: $r2 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$remoteAddress__892: java.util.function.Function bootstrap$()>() 
(assert true)
(define-const var3447 var3061 (map/1305667865 var1257 var2639)) ; Statement: $r5 = virtualinvoke $r3.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r2) 
;(assert (var3127_requireNonNull/-961817614 (cast-from-ClassObject-to-var3074 var1016!class))) ; Statement: staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object)>(class "Ljava/net/InetSocketAddress;") 

(declare-const var3841 ClassObject)
(define-const var1861 var454 (var2130_bootstrap$/-2066635725 var1016!class)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$cast__904: java.util.function.Function bootstrap$(java.lang.Class)>(class "Ljava/net/InetSocketAddress;") 
(assert true)
(define-const var563 var3061 (map/1305667865 var3447 var1861)) ; Statement: $r7 = virtualinvoke $r5.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r4) 
(define-const var2380 var454 var1414_bootstrap$/-575610213) ; Statement: $r6 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$getAddress__914: java.util.function.Function bootstrap$()>() 
(assert true)
(define-const var1913 var3061 (map/1305667865 var563 var2380)) ; Statement: $r8 = virtualinvoke $r7.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r6) 
(assert true)
(define-const var321 var3074 (orElse/-757175127 var1913 null-var3074)) ; Statement: $r9 = virtualinvoke $r8.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null) 
(define-const var752 var2954 (cast-from-var3074-to-var2954 var321)) ; Statement: r10 = (java.net.InetAddress) $r9 
(assert true)
(define-const var3208 var1276 (getQosConfiguration/-783028813 var2244)) ; Statement: r11 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: org.apache.dubbo.qos.api.QosConfiguration getQosConfiguration()>() 
(assert true)
(define-const var2058 String (getAnonymousAllowCommands/-248263360 var3208)) ; Statement: r12 = virtualinvoke r11.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String getAnonymousAllowCommands()>() 
(define-const var2711 Bool (var3535_isNotEmpty/-1251449450 var2058)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12) 
 ; Statement: if $z0 == 0 goto r24 = virtualinvoke r11.<org.apache.dubbo.qos.api.QosConfiguration: org.apache.dubbo.qos.api.PermissionLevel getAnonymousAccessPermissionLevel()>() 
(assert (not (= (ite var2711 1 0) 0))) ; Negate: Cond: $z0 == 0  
; split operation: var3659 = var2058.split(",") ; Statement: $r16 = virtualinvoke r12.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2744 var853 (var3263_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var3074__ var3659))) ; Statement: $r18 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r16) 
(define-const var485 var2498 var1556_bootstrap$/-846334374) ; Statement: $r17 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$isNotEmpty__923: java.util.function.Predicate bootstrap$()>() 
(define-const var3886 var853 (var853_filter/320182972 var2744 var485)) ; Statement: $r20 = interfaceinvoke $r18.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r17) 
(define-const var1473 var454 var242_bootstrap$/-2047824260) ; Statement: $r19 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$trim__928: java.util.function.Function bootstrap$()>() 
(define-const var193 var853 (var853_map/130902797 var3886 var1473)) ; Statement: $r22 = interfaceinvoke $r20.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r19) 
(define-const var1130 var2498 (var2686_bootstrap$/-1620052580 var2244)) ; Statement: $r21 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$lambda_access_0__934: java.util.function.Predicate bootstrap$(org.apache.dubbo.qos.api.CommandContext)>(r0) 
(define-const var776 Bool (var853_anyMatch/-1059037355 var193 var1130)) ; Statement: $z3 = interfaceinvoke $r22.<java.util.stream.Stream: boolean anyMatch(java.util.function.Predicate)>($r21) 
 ; Statement: if $z3 == 0 goto r24 = virtualinvoke r11.<org.apache.dubbo.qos.api.QosConfiguration: org.apache.dubbo.qos.api.PermissionLevel getAnonymousAccessPermissionLevel()>() 
(assert (not (= (ite var776 1 0) 0))) ; Negate: Cond: $z3 == 0  
 ; Statement: return 1 
(check-sat)
; {getRemote/226840252=([org.apache.dubbo.qos.api.CommandContext], io.netty.channel.Channel), var3061_ofNullable/-1077078438=([java.lang.Object], java.util.Optional), cast-from-var329-to-var3074=([io.netty.channel.Channel], java.lang.Object), var2011_bootstrap$/-1335414910=([], java.util.function.Function), map/1305667865=([java.util.Optional, java.util.function.Function], java.util.Optional), var3127_requireNonNull/-961817614=([java.lang.Object], java.lang.Object), cast-from-ClassObject-to-var3074=([java.lang.Class], java.lang.Object), var2130_bootstrap$/-2066635725=([java.lang.Class], java.util.function.Function), var1414_bootstrap$/-575610213=([], java.util.function.Function), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-var3074-to-var2954=([java.lang.Object], java.net.InetAddress), getQosConfiguration/-783028813=([org.apache.dubbo.qos.api.CommandContext], org.apache.dubbo.qos.api.QosConfiguration), getAnonymousAllowCommands/-248263360=([org.apache.dubbo.qos.api.QosConfiguration], java.lang.String), var3535_isNotEmpty/-1251449450=([java.lang.String], boolean), var3263_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var3074__=([java.lang.String[]], java.lang.Object[]), var1556_bootstrap$/-846334374=([], java.util.function.Predicate), var853_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var242_bootstrap$/-2047824260=([], java.util.function.Function), var853_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var2686_bootstrap$/-1620052580=([org.apache.dubbo.qos.api.CommandContext], java.util.function.Predicate), var853_anyMatch/-1059037355=([java.util.stream.Stream, java.util.function.Predicate], boolean)}
; {var1932=org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker, var3863=r23, var781=org.apache.dubbo.qos.api.CommandContext, var2244=r0, var2807=org.apache.dubbo.qos.api.PermissionLevel, var2551=r13, var329=io.netty.channel.Channel, var207=$r1, var3061=java.util.Optional, var3074=java.lang.Object, var1257=$r3, var454=java.util.function.Function, var2011=org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$remoteAddress__892, var2639=$r2, var3447=$r5, var3127=java.util.Objects, var1016=java.net.InetSocketAddress, var3841=class "Ljava/net/InetSocketAddress;", var2130=org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$cast__904, var1861=$r4, var563=$r7, var1414=org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$getAddress__914, var2380=$r6, var1913=$r8, var321=$r9, var2954=java.net.InetAddress, var752=r10, var1276=org.apache.dubbo.qos.api.QosConfiguration, var3208=r11, var2058=r12, var3535=org.apache.dubbo.common.utils.StringUtils, var2711=$z0, var3659=$r16, var853=java.util.stream.Stream, var3263=java.util.Arrays, var2744=$r18, var2498=java.util.function.Predicate, var1556=org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$isNotEmpty__923, var485=$r17, var3886=$r20, var242=org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$trim__928, var1473=$r19, var193=$r22, var2686=org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$lambda_access_0__934, var1130=$r21, var776=$z3, var3888=null_type}
; {org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker=var1932, r23=var3863, org.apache.dubbo.qos.api.CommandContext=var781, r0=var2244, org.apache.dubbo.qos.api.PermissionLevel=var2807, r13=var2551, io.netty.channel.Channel=var329, $r1=var207, java.util.Optional=var3061, java.lang.Object=var3074, $r3=var1257, java.util.function.Function=var454, org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$remoteAddress__892=var2011, $r2=var2639, $r5=var3447, java.util.Objects=var3127, java.net.InetSocketAddress=var1016, class "Ljava/net/InetSocketAddress;"=var3841, org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$cast__904=var2130, $r4=var1861, $r7=var563, org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$getAddress__914=var1414, $r6=var2380, $r8=var1913, $r9=var321, java.net.InetAddress=var2954, r10=var752, org.apache.dubbo.qos.api.QosConfiguration=var1276, r11=var3208, r12=var2058, org.apache.dubbo.common.utils.StringUtils=var3535, $z0=var2711, $r16=var3659, java.util.stream.Stream=var853, java.util.Arrays=var3263, $r18=var2744, java.util.function.Predicate=var2498, org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$isNotEmpty__923=var1556, $r17=var485, $r20=var3886, org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$trim__928=var242, $r19=var1473, $r22=var193, org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$lambda_access_0__934=var2686, $r21=var1130, $z3=var776, null_type=var3888}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r23 := @this: org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker;	r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r13 := @parameter1: org.apache.dubbo.qos.api.PermissionLevel;	$r1 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: io.netty.channel.Channel getRemote()>();	$r3 = staticinvoke <java.util.Optional: java.util.Optional ofNullable(java.lang.Object)>($r1);	$r2 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$remoteAddress__892: java.util.function.Function bootstrap$()>();	$r5 = virtualinvoke $r3.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r2);	staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object)>(class "Ljava/net/InetSocketAddress;");	$r4 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$cast__904: java.util.function.Function bootstrap$(java.lang.Class)>(class "Ljava/net/InetSocketAddress;");	$r7 = virtualinvoke $r5.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r4);	$r6 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$getAddress__914: java.util.function.Function bootstrap$()>();	$r8 = virtualinvoke $r7.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r6);	$r9 = virtualinvoke $r8.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>(null);	r10 = (java.net.InetAddress) $r9;	r11 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: org.apache.dubbo.qos.api.QosConfiguration getQosConfiguration()>();	r12 = virtualinvoke r11.<org.apache.dubbo.qos.api.QosConfiguration: java.lang.String getAnonymousAllowCommands()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12);	if $z0 == 0 goto r24 = virtualinvoke r11.<org.apache.dubbo.qos.api.QosConfiguration: org.apache.dubbo.qos.api.PermissionLevel getAnonymousAccessPermissionLevel()>();	$r16 = virtualinvoke r12.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r18 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r16);	$r17 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$isNotEmpty__923: java.util.function.Predicate bootstrap$()>();	$r20 = interfaceinvoke $r18.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r17);	$r19 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$trim__928: java.util.function.Function bootstrap$()>();	$r22 = interfaceinvoke $r20.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r19);	$r21 = staticinvoke <org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$lambda_access_0__934: java.util.function.Predicate bootstrap$(org.apache.dubbo.qos.api.CommandContext)>(r0);	$z3 = interfaceinvoke $r22.<java.util.stream.Stream: boolean anyMatch(java.util.function.Predicate)>($r21);	if $z3 == 0 goto r24 = virtualinvoke r11.<org.apache.dubbo.qos.api.QosConfiguration: org.apache.dubbo.qos.api.PermissionLevel getAnonymousAccessPermissionLevel()>();	return 1
;block_num 3