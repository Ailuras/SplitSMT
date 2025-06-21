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

(declare-sort var2205 0)
(declare-sort var2678 0)
(declare-sort var2420 0)
(declare-sort var2615 0)
(declare-sort var2877 0)
(declare-sort var658 0)
(declare-sort var151 0)
(declare-sort var17 0)
(declare-sort var3832 0)
(declare-sort var2250 0)
(declare-sort var3545 0)
(declare-sort var1644 0)
(declare-sort var1295 0)
(declare-sort var2803 0)
(declare-sort var794 0)
(declare-sort var58 0)
(declare-sort var885 0)
(declare-sort var2595 0)
(declare-sort var1067 0)
(declare-sort var2683 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3832!class ClassObject)
(declare-fun <init>/118137686 (var2615 var2678 var2420) void)
(declare-fun cast-from-var2205-to-var2615 (var2205) var2615)
(declare-fun var2877-init () var2877)
(declare-fun <init>/-2175807 (var2877) void)
(declare-fun cast-from-var2877-to-var658 (var2877) var658)
(declare-fun supportedUrls/-1669396139 (var2205) var658)
(declare-fun supportedHandlers/-1669396139 (var2205) var658)
(declare-fun getOrDefaultFrameworkModel/-1637556979 (var2678) var151)
(declare-fun getExtensionLoader/-514331157 (var2250 ClassObject) var17)
(declare-fun cast-from-var151-to-var2250 (var151) var2250)
(declare-fun arr-String-init () (Array Int String))
(declare-fun getActivateExtension/-383749130 (var17 var2678 (Array Int String)) var3545)
(declare-fun var1295_stream/-1288525013 (var1295) var1644)
(declare-fun cast-from-var3545-to-var1295 (var3545) var1295)
(declare-fun var2803_requireNonNull/-961817614 (var794) var794)
(declare-fun cast-from-var17-to-var794 (var17) var794)
(declare-fun var885_bootstrap$/-2077141909 (var17) var58)
(declare-fun var58_identity/-2017027883 () var58)
(declare-fun var1067_toConcurrentMap/-1669911676 (var58 var58) var2595)
(declare-fun var1644_collect/-2050842585 (var1644 var2595) var794)
(declare-fun cast-from-var794-to-var658 (var794) var658)
(declare-fun getParameter/-1307325648 (var2678 String) String)
(declare-fun var2683_isNotEmpty/-1251449450 (String) Bool)
(declare-fun protocols/-1669396139 (var2205) var658)
(declare-const null-var2205 var2205)
(declare-const null-var2678 var2678)
(declare-const null-var2420 var2420)
(declare-const var976 var2205) ; Statement: r0 := @this: org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer 
(assert (not (= var976 null-var2205)))
(declare-const var2858 var2678) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2858 null-var2678)))
(declare-const var541 var2420) ; Statement: r2 := @parameter1: org.apache.dubbo.remoting.ChannelHandler 
(assert (not (= var541 null-var2420)))
(assert true)
;(assert (<init>/118137686 (cast-from-var2205-to-var2615 var976) var2858 var541)) ; Statement: specialinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: void <init>(org.apache.dubbo.common.URL,org.apache.dubbo.remoting.ChannelHandler)>(r1, r2) 

(declare-const var976!1 var2205)
(declare-const var2858!1 var2678)
(declare-const var541!1 var2420)
(define-const var3212 var2877 var2877-init) ; Statement: $r3 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var3212)) ; Statement: specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var3212!1 var2877)
(declare-const var976!2 var2205)
(assert (not (= var976!2 null-var2205)))
(assert (= (supportedUrls/-1669396139 var976!2) (cast-from-var2877-to-var658 var3212!1))) ; Statement: r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map supportedUrls> = $r3 
(define-const var135 var2877 var2877-init) ; Statement: $r4 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var135)) ; Statement: specialinvoke $r4.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var135!1 var2877)
(declare-const var976!3 var2205)
(assert (not (= var976!3 null-var2205)))
(assert (= (supportedHandlers/-1669396139 var976!3) (cast-from-var2877-to-var658 var135!1))) ; Statement: r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map supportedHandlers> = $r4 
(assert true)
(define-const var3912 var151 (getOrDefaultFrameworkModel/-1637556979 var2858!1)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert true)
(define-const var3999 var17 (getExtensionLoader/-514331157 (cast-from-var151-to-var2250 var3912) var3832!class)) ; Statement: r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/api/WireProtocol;") 
(define-const var1668 (Array Int String) arr-String-init) ; Statement: $r7 = newarray (java.lang.String)[0] 
(assert true)
(define-const var3117 var3545 (getActivateExtension/-383749130 var3999 var2858!1 var1668)) ; Statement: $r8 = virtualinvoke r6.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[])>(r1, $r7) 
(define-const var643 var1644 (var1295_stream/-1288525013 (cast-from-var3545-to-var1295 var3117))) ; Statement: $r12 = interfaceinvoke $r8.<java.util.List: java.util.stream.Stream stream()>() 
;(assert (var2803_requireNonNull/-961817614 (cast-from-var17-to-var794 var3999))) ; Statement: staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object)>(r6) 

(declare-const var3999!1 var17)
(define-const var1635 var58 (var885_bootstrap$/-2077141909 var3999!1)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$getExtensionName__1202: java.util.function.Function bootstrap$(org.apache.dubbo.common.extension.ExtensionLoader)>(r6) 
(define-const var2434 var58 var58_identity/-2017027883) ; Statement: $r9 = staticinvoke <java.util.function.Function: java.util.function.Function identity()>() 
(define-const var2183 var2595 (var1067_toConcurrentMap/-1669911676 var1635 var2434)) ; Statement: $r11 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toConcurrentMap(java.util.function.Function,java.util.function.Function)>($r10, $r9) 
(define-const var1321 var794 (var1644_collect/-2050842585 var643 var2183)) ; Statement: $r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r11) 
(define-const var2892 var658 (cast-from-var794-to-var658 var1321)) ; Statement: r14 = (java.util.Map) $r13 
(assert true)
(define-const var2744 String (getParameter/-1307325648 var2858!1 "ext.protocol")) ; Statement: r15 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("ext.protocol") 
(define-const var676 Bool (var2683_isNotEmpty/-1251449450 var2744)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r15) 
 ; Statement: if $z0 == 0 goto r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map protocols> = r14 
(assert (= (ite var676 1 0) 0)) ; Cond: $z0 == 0 
(declare-const var976!4 var2205)
(assert (not (= var976!4 null-var2205)))
(assert (= (protocols/-1669396139 var976!4) var2892)) ; Statement: r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map protocols> = r14 
 ; Statement: return 
(check-sat)
; {<init>/118137686=([org.apache.dubbo.remoting.transport.AbstractServer, org.apache.dubbo.common.URL, org.apache.dubbo.remoting.ChannelHandler], void), cast-from-var2205-to-var2615=([org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer], org.apache.dubbo.remoting.transport.AbstractServer), var2877-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var2877-to-var658=([java.util.concurrent.ConcurrentHashMap], java.util.Map), supportedUrls/-1669396139=([org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer], java.util.Map), supportedHandlers/-1669396139=([org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer], java.util.Map), getOrDefaultFrameworkModel/-1637556979=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.FrameworkModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var151-to-var2250=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.common.extension.ExtensionAccessor), arr-String-init=([], java.lang.String[]), getActivateExtension/-383749130=([org.apache.dubbo.common.extension.ExtensionLoader, org.apache.dubbo.common.URL, java.lang.String[]], java.util.List), var1295_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var3545-to-var1295=([java.util.List], java.util.Collection), var2803_requireNonNull/-961817614=([java.lang.Object], java.lang.Object), cast-from-var17-to-var794=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Object), var885_bootstrap$/-2077141909=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.function.Function), var58_identity/-2017027883=([], java.util.function.Function), var1067_toConcurrentMap/-1669911676=([java.util.function.Function, java.util.function.Function], java.util.stream.Collector), var1644_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var794-to-var658=([java.lang.Object], java.util.Map), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2683_isNotEmpty/-1251449450=([java.lang.String], boolean), protocols/-1669396139=([org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer], java.util.Map)}
; {var2205=org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer, var976=r0, var2678=org.apache.dubbo.common.URL, var2858=r1, var2420=org.apache.dubbo.remoting.ChannelHandler, var541=r2, var2615=org.apache.dubbo.remoting.transport.AbstractServer, var2877=java.util.concurrent.ConcurrentHashMap, var3212=$r3, var658=java.util.Map, var135=$r4, var151=org.apache.dubbo.rpc.model.FrameworkModel, var3912=$r5, var17=org.apache.dubbo.common.extension.ExtensionLoader, var3832=org.apache.dubbo.remoting.api.WireProtocol, var2250=org.apache.dubbo.common.extension.ExtensionAccessor, var3999=r6, var1668=$r7, var3545=java.util.List, var3117=$r8, var1644=java.util.stream.Stream, var1295=java.util.Collection, var643=$r12, var2803=java.util.Objects, var794=java.lang.Object, var58=java.util.function.Function, var885=org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$getExtensionName__1202, var1635=$r10, var2434=$r9, var2595=java.util.stream.Collector, var1067=java.util.stream.Collectors, var2183=$r11, var1321=$r13, var2892=r14, var2744=r15, var2683=org.apache.dubbo.common.utils.StringUtils, var676=$z0}
; {org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer=var2205, r0=var976, org.apache.dubbo.common.URL=var2678, r1=var2858, org.apache.dubbo.remoting.ChannelHandler=var2420, r2=var541, org.apache.dubbo.remoting.transport.AbstractServer=var2615, java.util.concurrent.ConcurrentHashMap=var2877, $r3=var3212, java.util.Map=var658, $r4=var135, org.apache.dubbo.rpc.model.FrameworkModel=var151, $r5=var3912, org.apache.dubbo.common.extension.ExtensionLoader=var17, org.apache.dubbo.remoting.api.WireProtocol=var3832, org.apache.dubbo.common.extension.ExtensionAccessor=var2250, r6=var3999, $r7=var1668, java.util.List=var3545, $r8=var3117, java.util.stream.Stream=var1644, java.util.Collection=var1295, $r12=var643, java.util.Objects=var2803, java.lang.Object=var794, java.util.function.Function=var58, org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$getExtensionName__1202=var885, $r10=var1635, $r9=var2434, java.util.stream.Collector=var2595, java.util.stream.Collectors=var1067, $r11=var2183, $r13=var1321, r14=var2892, r15=var2744, org.apache.dubbo.common.utils.StringUtils=var2683, $z0=var676}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer;	r1 := @parameter0: org.apache.dubbo.common.URL;	r2 := @parameter1: org.apache.dubbo.remoting.ChannelHandler;	specialinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: void <init>(org.apache.dubbo.common.URL,org.apache.dubbo.remoting.ChannelHandler)>(r1, r2);	$r3 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map supportedUrls> = $r3;	$r4 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r4.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map supportedHandlers> = $r4;	$r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/api/WireProtocol;");	$r7 = newarray (java.lang.String)[0];	$r8 = virtualinvoke r6.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String[])>(r1, $r7);	$r12 = interfaceinvoke $r8.<java.util.List: java.util.stream.Stream stream()>();	staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object)>(r6);	$r10 = staticinvoke <org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer$getExtensionName__1202: java.util.function.Function bootstrap$(org.apache.dubbo.common.extension.ExtensionLoader)>(r6);	$r9 = staticinvoke <java.util.function.Function: java.util.function.Function identity()>();	$r11 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toConcurrentMap(java.util.function.Function,java.util.function.Function)>($r10, $r9);	$r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r11);	r14 = (java.util.Map) $r13;	r15 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("ext.protocol");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r15);	if $z0 == 0 goto r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map protocols> = r14;	r0.<org.apache.dubbo.remoting.api.pu.AbstractPortUnificationServer: java.util.Map protocols> = r14;	return
;block_num 2