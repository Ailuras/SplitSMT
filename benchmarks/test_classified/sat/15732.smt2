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

(declare-sort var927 0)
(declare-sort var3574 0)
(declare-sort var3766 0)
(declare-sort var3269 0)
(declare-sort var1852 0)
(declare-sort var2995 0)
(declare-sort var1479 0)
(declare-sort var2863 0)
(declare-sort var1991 0)
(declare-sort var2476 0)
(declare-sort var1275 0)
(declare-sort var3054 0)
(declare-sort var620 0)
(declare-sort var1732 0)
(declare-sort var2977 0)
(declare-sort var3879 0)
(declare-sort var432 0)
(declare-sort var320 0)
(declare-sort var3331 0)
(declare-sort var2019 0)
(declare-sort var2448 0)
(declare-sort var857 0)
(declare-sort var276 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1991!class ClassObject)
(declare-fun <init>/118137686 (var3269 var3574 var3766) void)
(declare-fun cast-from-var927-to-var3269 (var927) var3269)
(declare-fun var1852-init () var1852)
(declare-fun <init>/-2175807 (var1852) void)
(declare-fun cast-from-var1852-to-var2995 (var1852) var2995)
(declare-fun supportedUrls/-1669396139 (var927) var2995)
(declare-fun supportedHandlers/-1669396139 (var927) var2995)
(declare-fun getOrDefaultFrameworkModel/-1637556979 (var3574) var1479)
(declare-fun getExtensionLoader/-514331157 (var2476 ClassObject) var2863)
(declare-fun cast-from-var1479-to-var2476 (var1479) var2476)
(declare-fun arr-String-init () (Array Int String))
(declare-fun getActivateExtension/-383749130 (var2863 var3574 (Array Int String)) var1275)
(declare-fun var620_stream/-1288525013 (var620) var3054)
(declare-fun cast-from-var1275-to-var620 (var1275) var620)
(declare-fun var1732_requireNonNull/-961817614 (var2977) var2977)
(declare-fun cast-from-var2863-to-var2977 (var2863) var2977)
(declare-fun var432_bootstrap$/-1635387414 (var2863) var3879)
(declare-fun var3879_identity/-2017027883 () var3879)
(declare-fun var3331_toConcurrentMap/-1669911676 (var3879 var3879) var320)
(declare-fun var3054_collect/-2050842585 (var3054 var320) var2977)
(declare-fun cast-from-var2977-to-var2995 (var2977) var2995)
(declare-fun getParameter/-1307325648 (var3574 String) String)
(declare-fun var2019_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var2448_stream/-1757820 ((Array Int var2977)) var3054)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2977__ ((Array Int String)) (Array Int var2977))
(declare-fun var276_bootstrap$/338273379 (var2995 var2863) var857)
(declare-fun var3054_forEach/1037804367 (var3054 var857) void)
(declare-fun protocols/-1669396139 (var927) var2995)
(declare-const null-var927 var927)
(declare-const null-var3574 var3574)
(declare-const null-var3766 var3766)
(declare-const var482 var927) ; Statement: r0 := @this: org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer 
(assert (not (= var482 null-var927)))
(declare-const var1547 var3574) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1547 null-var3574)))
(declare-const var2154 var3766) ; Statement: r2 := @parameter1: org.apache.dubbo.remoting.ChannelHandler 
(assert (not (= var2154 null-var3766)))
(assert true)
;(assert (<init>/118137686 (cast-from-var927-to-var3269 var482) var1547 var2154)) ; Statement: specialinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: void <init>(org.apache.dubbo.common.URL,org.apache.dubbo.remoting.ChannelHandler)>(r1, r2) 

(declare-const var482!1 var927)
(declare-const var1547!1 var3574)
(declare-const var2154!1 var3766)
(define-const var3619 var1852 var1852-init) ; Statement: $r3 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var3619)) ; Statement: specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var3619!1 var1852)
(declare-const var482!2 var927)
(assert (not (= var482!2 null-var927)))
(assert (= (supportedUrls/-1669396139 var482!2) (cast-from-var1852-to-var2995 var3619!1))) ; Statement: r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map supportedUrls> = $r3 
(define-const var2044 var1852 var1852-init) ; Statement: $r4 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var2044)) ; Statement: specialinvoke $r4.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var2044!1 var1852)
(declare-const var482!3 var927)
(assert (not (= var482!3 null-var927)))
(assert (= (supportedHandlers/-1669396139 var482!3) (cast-from-var1852-to-var2995 var2044!1))) ; Statement: r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map supportedHandlers> = $r4 
(assert true)
(define-const var3996 var1479 (getOrDefaultFrameworkModel/-1637556979 var1547!1)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert true)
(define-const var3288 var2863 (getExtensionLoader/-514331157 (cast-from-var1479-to-var2476 var3996) var1991!class)) ; Statement: r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/api/WireProtocol;") 
(define-const var1225 (Array Int String) arr-String-init) ; Statement: $r7 = newarray (java.lang.String)[0] 
(assert true)
(define-const var1114 var1275 (getActivateExtension/-383749130 var3288 var1547!1 var1225)) ; Statement: $r8 = virtualinvoke r6.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[])>(r1, $r7) 
(define-const var1159 var3054 (var620_stream/-1288525013 (cast-from-var1275-to-var620 var1114))) ; Statement: $r12 = interfaceinvoke $r8.<java.util.List: java.util.stream.Stream stream()>() 
;(assert (var1732_requireNonNull/-961817614 (cast-from-var2863-to-var2977 var3288))) ; Statement: staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object)>(r6) 

(declare-const var3288!1 var2863)
(define-const var593 var3879 (var432_bootstrap$/-1635387414 var3288!1)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$getExtensionName__1201: java.util.function.Function bootstrap$(org.apache.dubbo.common.extension.ExtensionLoader)>(r6) 
(define-const var1840 var3879 var3879_identity/-2017027883) ; Statement: $r9 = staticinvoke <java.util.function.Function: java.util.function.Function identity()>() 
(define-const var2423 var320 (var3331_toConcurrentMap/-1669911676 var593 var1840)) ; Statement: $r11 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toConcurrentMap(java.util.function.Function,java.util.function.Function)>($r10, $r9) 
(define-const var2514 var2977 (var3054_collect/-2050842585 var1159 var2423)) ; Statement: $r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r11) 
(define-const var456 var2995 (cast-from-var2977-to-var2995 var2514)) ; Statement: r14 = (java.util.Map) $r13 
(assert true)
(define-const var2485 String (getParameter/-1307325648 var1547!1 "ext.protocol")) ; Statement: r15 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("ext.protocol") 
(define-const var182 Bool (var2019_isNotEmpty/-1251449450 var2485)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r15) 
 ; Statement: if $z0 == 0 goto r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map protocols> = r14 
(assert (not (= (ite var182 1 0) 0))) ; Negate: Cond: $z0 == 0  
; split operation: var2841 = var2485.split(",") ; Statement: $r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2640 var3054 (var2448_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var2977__ var2841))) ; Statement: $r18 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r16) 
(define-const var2077 var857 (var276_bootstrap$/338273379 var456 var3288!1)) ; Statement: $r17 = staticinvoke <org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$lambda_new_0__1203: java.util.function.Consumer bootstrap$(java.util.Map,org.apache.dubbo.common.extension.ExtensionLoader)>(r14, r6) 
;(assert (var3054_forEach/1037804367 var2640 var2077)) ; Statement: interfaceinvoke $r18.<java.util.stream.Stream: void forEach(java.util.function.Consumer)>($r17) 

(declare-const var2640!1 var3054)
(declare-const var2077!1 var857)
(assert true) ; Non Conditional
(declare-const var482!4 var927)
(assert (not (= var482!4 null-var927)))
(assert (= (protocols/-1669396139 var482!4) var456)) ; Statement: r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map protocols> = r14 
 ; Statement: return 
(check-sat)
; {<init>/118137686=([org.apache.dubbo.remoting.transport.AbstractServer, org.apache.dubbo.common.URL, org.apache.dubbo.remoting.ChannelHandler], void), cast-from-var927-to-var3269=([org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer], org.apache.dubbo.remoting.transport.AbstractServer), var1852-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var1852-to-var2995=([java.util.concurrent.ConcurrentHashMap], java.util.Map), supportedUrls/-1669396139=([org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer], java.util.Map), supportedHandlers/-1669396139=([org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer], java.util.Map), getOrDefaultFrameworkModel/-1637556979=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.FrameworkModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var1479-to-var2476=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.common.extension.ExtensionAccessor), arr-String-init=([], java.lang.String[]), getActivateExtension/-383749130=([org.apache.dubbo.common.extension.ExtensionLoader, org.apache.dubbo.common.URL, java.lang.String[]], java.util.List), var620_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var1275-to-var620=([java.util.List], java.util.Collection), var1732_requireNonNull/-961817614=([java.lang.Object], java.lang.Object), cast-from-var2863-to-var2977=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Object), var432_bootstrap$/-1635387414=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.function.Function), var3879_identity/-2017027883=([], java.util.function.Function), var3331_toConcurrentMap/-1669911676=([java.util.function.Function, java.util.function.Function], java.util.stream.Collector), var3054_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var2977-to-var2995=([java.lang.Object], java.util.Map), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2019_isNotEmpty/-1251449450=([java.lang.String], boolean), var2448_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var2977__=([java.lang.String[]], java.lang.Object[]), var276_bootstrap$/338273379=([java.util.Map, org.apache.dubbo.common.extension.ExtensionLoader], java.util.function.Consumer), var3054_forEach/1037804367=([java.util.stream.Stream, java.util.function.Consumer], void), protocols/-1669396139=([org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer], java.util.Map)}
; {var927=org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer, var482=r0, var3574=org.apache.dubbo.common.URL, var1547=r1, var3766=org.apache.dubbo.remoting.ChannelHandler, var2154=r2, var3269=org.apache.dubbo.remoting.transport.AbstractServer, var1852=java.util.concurrent.ConcurrentHashMap, var3619=$r3, var2995=java.util.Map, var2044=$r4, var1479=org.apache.dubbo.rpc.model.FrameworkModel, var3996=$r5, var2863=org.apache.dubbo.common.extension.ExtensionLoader, var1991=org.apache.dubbo.remoting.api.WireProtocol, var2476=org.apache.dubbo.common.extension.ExtensionAccessor, var3288=r6, var1225=$r7, var1275=java.util.List, var1114=$r8, var3054=java.util.stream.Stream, var620=java.util.Collection, var1159=$r12, var1732=java.util.Objects, var2977=java.lang.Object, var3879=java.util.function.Function, var432=org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$getExtensionName__1201, var593=$r10, var1840=$r9, var320=java.util.stream.Collector, var3331=java.util.stream.Collectors, var2423=$r11, var2514=$r13, var456=r14, var2485=r15, var2019=org.apache.dubbo.common.utils.StringUtils, var182=$z0, var2841=$r16, var2448=java.util.Arrays, var2640=$r18, var857=java.util.function.Consumer, var276=org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$lambda_new_0__1203, var2077=$r17}
; {org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer=var927, r0=var482, org.apache.dubbo.common.URL=var3574, r1=var1547, org.apache.dubbo.remoting.ChannelHandler=var3766, r2=var2154, org.apache.dubbo.remoting.transport.AbstractServer=var3269, java.util.concurrent.ConcurrentHashMap=var1852, $r3=var3619, java.util.Map=var2995, $r4=var2044, org.apache.dubbo.rpc.model.FrameworkModel=var1479, $r5=var3996, org.apache.dubbo.common.extension.ExtensionLoader=var2863, org.apache.dubbo.remoting.api.WireProtocol=var1991, org.apache.dubbo.common.extension.ExtensionAccessor=var2476, r6=var3288, $r7=var1225, java.util.List=var1275, $r8=var1114, java.util.stream.Stream=var3054, java.util.Collection=var620, $r12=var1159, java.util.Objects=var1732, java.lang.Object=var2977, java.util.function.Function=var3879, org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$getExtensionName__1201=var432, $r10=var593, $r9=var1840, java.util.stream.Collector=var320, java.util.stream.Collectors=var3331, $r11=var2423, $r13=var2514, r14=var456, r15=var2485, org.apache.dubbo.common.utils.StringUtils=var2019, $z0=var182, $r16=var2841, java.util.Arrays=var2448, $r18=var2640, java.util.function.Consumer=var857, org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$lambda_new_0__1203=var276, $r17=var2077}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer;	r1 := @parameter0: org.apache.dubbo.common.URL;	r2 := @parameter1: org.apache.dubbo.remoting.ChannelHandler;	specialinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: void <init>(org.apache.dubbo.common.URL,org.apache.dubbo.remoting.ChannelHandler)>(r1, r2);	$r3 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map supportedUrls> = $r3;	$r4 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r4.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map supportedHandlers> = $r4;	$r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/api/WireProtocol;");	$r7 = newarray (java.lang.String)[0];	$r8 = virtualinvoke r6.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[])>(r1, $r7);	$r12 = interfaceinvoke $r8.<java.util.List: java.util.stream.Stream stream()>();	staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object)>(r6);	$r10 = staticinvoke <org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$getExtensionName__1201: java.util.function.Function bootstrap$(org.apache.dubbo.common.extension.ExtensionLoader)>(r6);	$r9 = staticinvoke <java.util.function.Function: java.util.function.Function identity()>();	$r11 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toConcurrentMap(java.util.function.Function,java.util.function.Function)>($r10, $r9);	$r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r11);	r14 = (java.util.Map) $r13;	r15 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("ext.protocol");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r15);	if $z0 == 0 goto r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map protocols> = r14;	$r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r18 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r16);	$r17 = staticinvoke <org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$lambda_new_0__1203: java.util.function.Consumer bootstrap$(java.util.Map,org.apache.dubbo.common.extension.ExtensionLoader)>(r14, r6);	interfaceinvoke $r18.<java.util.stream.Stream: void forEach(java.util.function.Consumer)>($r17);	r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map protocols> = r14;	return
;block_num 3