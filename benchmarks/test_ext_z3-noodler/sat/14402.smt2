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

(declare-sort var2415 0)
(declare-sort var3238 0)
(declare-sort var905 0)
(declare-sort var1686 0)
(declare-sort var1118 0)
(declare-sort var3146 0)
(declare-sort var2513 0)
(declare-sort var723 0)
(declare-sort var1591 0)
(declare-sort var3721 0)
(declare-sort var1593 0)
(declare-sort var668 0)
(declare-sort var1777 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const String!class ClassObject)
(declare-fun var3238_getMetadata/1968437424 (var3238) var905)
(declare-fun var905_get/1088891777 (var905 var1686) var1686)
(declare-fun cast-from-String-to-var1686 (String) var1686)
(declare-fun cast-from-var1686-to-String (var1686) String)
(declare-fun var1118_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2513_toJavaList/401030934 (String ClassObject) var3146)
(declare-fun var1591_stream/-1288525013 (var1591) var723)
(declare-fun cast-from-var3146-to-var1591 (var3146) var1591)
(declare-fun var1593_bootstrap$/-19783972 () var3721)
(declare-fun var723_map/130902797 (var723 var3721) var723)
(declare-fun var1777_toList/714215649 () var668)
(declare-fun var723_collect/-2050842585 (var723 var668) var1686)
(declare-fun cast-from-var1686-to-var3146 (var1686) var3146)
(declare-const null-var2415 var2415)
(declare-const null-var3238 var3238)
(declare-const var3285 var2415) ; Statement: r12 := @this: org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder 
(assert (not (= var3285 null-var2415)))
(declare-const var3582 var3238) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var3582 null-var3238)))
(define-const var1694 var905 (var3238_getMetadata/1968437424 var3582)) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(define-const var2411 var1686 (var905_get/1088891777 var1694 (cast-from-String-to-var1686 "dubbo.metadata-service.urls"))) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.urls") 
(define-const var2592 String (cast-from-var1686-to-String var2411)) ; Statement: r3 = (java.lang.String) $r2 
(define-const var118 Bool (var1118_isBlank/-523695098 (cast-from-String-to-String var2592))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3) 
 ; Statement: if $z0 == 0 goto r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.util.List toJavaList(java.lang.String,java.lang.Class)>(r3, class "Ljava/lang/String;") 
(assert (= (ite var118 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1402 var3146 (var2513_toJavaList/401030934 var2592 String!class)) ; Statement: r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.util.List toJavaList(java.lang.String,java.lang.Class)>(r3, class "Ljava/lang/String;") 
(define-const var2870 var723 (var1591_stream/-1288525013 (cast-from-var3146-to-var1591 var1402))) ; Statement: $r6 = interfaceinvoke r4.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var988 var3721 var1593_bootstrap$/-19783972) ; Statement: $r5 = staticinvoke <org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder$valueOf__1036: java.util.function.Function bootstrap$()>() 
(define-const var2707 var723 (var723_map/130902797 var2870 var988)) ; Statement: $r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r5) 
(define-const var3269 var668 var1777_toList/714215649) ; Statement: $r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>() 
(define-const var2343 var1686 (var723_collect/-2050842585 var2707 var3269)) ; Statement: $r9 = interfaceinvoke $r8.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r7) 
(define-const var1090 var3146 (cast-from-var1686-to-var3146 var2343)) ; Statement: $r10 = (java.util.List) $r9 
 ; Statement: return $r10 
(check-sat)
; {var3238_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), var905_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1686=([java.lang.String], java.lang.Object), cast-from-var1686-to-String=([java.lang.Object], java.lang.String), var1118_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2513_toJavaList/401030934=([java.lang.String, java.lang.Class], java.util.List), var1591_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var3146-to-var1591=([java.util.List], java.util.Collection), var1593_bootstrap$/-19783972=([], java.util.function.Function), var723_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var1777_toList/714215649=([], java.util.stream.Collector), var723_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1686-to-var3146=([java.lang.Object], java.util.List)}
; {var2415=org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder, var3285=r12, var3238=org.apache.dubbo.registry.client.ServiceInstance, var3582=r0, var905=java.util.Map, var1694=r1, var1686=java.lang.Object, var2411=$r2, var2592=r3, var1118=org.apache.dubbo.common.utils.StringUtils, var118=$z0, var3146=java.util.List, var2513=org.apache.dubbo.common.utils.JsonUtils, var1402=r4, var723=java.util.stream.Stream, var1591=java.util.Collection, var2870=$r6, var3721=java.util.function.Function, var1593=org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder$valueOf__1036, var988=$r5, var2707=$r8, var668=java.util.stream.Collector, var1777=java.util.stream.Collectors, var3269=$r7, var2343=$r9, var1090=$r10}
; {org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder=var2415, r12=var3285, org.apache.dubbo.registry.client.ServiceInstance=var3238, r0=var3582, java.util.Map=var905, r1=var1694, java.lang.Object=var1686, $r2=var2411, r3=var2592, org.apache.dubbo.common.utils.StringUtils=var1118, $z0=var118, java.util.List=var3146, org.apache.dubbo.common.utils.JsonUtils=var2513, r4=var1402, java.util.stream.Stream=var723, java.util.Collection=var1591, $r6=var2870, java.util.function.Function=var3721, org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder$valueOf__1036=var1593, $r5=var988, $r8=var2707, java.util.stream.Collector=var668, java.util.stream.Collectors=var1777, $r7=var3269, $r9=var2343, $r10=var1090}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r12 := @this: org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder;	r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	$r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("dubbo.metadata-service.urls");	r3 = (java.lang.String) $r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3);	if $z0 == 0 goto r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.util.List toJavaList(java.lang.String,java.lang.Class)>(r3, class "Ljava/lang/String;");	r4 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.util.List toJavaList(java.lang.String,java.lang.Class)>(r3, class "Ljava/lang/String;");	$r6 = interfaceinvoke r4.<java.util.List: java.util.stream.Stream stream()>();	$r5 = staticinvoke <org.apache.dubbo.registry.client.metadata.SpringCloudMetadataServiceURLBuilder$valueOf__1036: java.util.function.Function bootstrap$()>();	$r8 = interfaceinvoke $r6.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r5);	$r7 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>();	$r9 = interfaceinvoke $r8.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r7);	$r10 = (java.util.List) $r9;	return $r10
;block_num 2