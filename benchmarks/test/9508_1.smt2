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

(declare-sort var2429 0)
(declare-sort var2350 0)
(declare-sort var1769 0)
(declare-sort var1115 0)
(declare-sort var1113 0)
(declare-sort var1741 0)
(declare-sort var1293 0)
(declare-sort var195 0)
(declare-sort var3503 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2350-init () var2350)
(declare-fun <init>/-325640736 (var2350) void)
(declare-fun interfaceClass/-955518528 (var2429) ClassObject)
(declare-fun var1769_add/328494887 (var1769 var1115) Bool)
(declare-fun cast-from-var2350-to-var1769 (var2350) var1769)
(declare-fun cast-from-ClassObject-to-var1115 (ClassObject) var1115)
(declare-fun var1113_getInternalInterfaces/973257569 () (Array Int ClassObject))
(declare-fun var1741_addAll/1303872711 (var1293 (Array Int var1115)) Bool)
(declare-fun cast-from-var2350-to-var1293 (var2350) var1293)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1115__ ((Array Int ClassObject)) (Array Int var1115))
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun interfaceName/-955518528 (var2429) String)
(declare-fun var195_isEquals/882237642 (String String) Bool)
(declare-fun var3503_inNativeImage/-778320806 () Bool)
(declare-fun lazyProxy/-955518528 (var2429) var1115)
(declare-const null-var2429 var2429)
(declare-const null-var1115 var1115)
(declare-const var2877 var2429) ; Statement: r1 := @this: org.apache.dubbo.config.spring.ReferenceBean 
(assert (not (= var2877 null-var2429)))
(define-const var2137 var2350 var2350-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2137)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var2137!1 var2350)
(define-const var560 ClassObject (interfaceClass/-955518528 var2877)) ; Statement: $r2 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Class interfaceClass> 
;(assert (var1769_add/328494887 (cast-from-var2350-to-var1769 var2137!1) (cast-from-ClassObject-to-var1115 var560))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r2) 

(declare-const var2137!2 var2350)
(declare-const var560!1 ClassObject)
(define-const var517 (Array Int ClassObject) var1113_getInternalInterfaces/973257569) ; Statement: r3 = staticinvoke <org.apache.dubbo.rpc.proxy.AbstractProxyFactory: java.lang.Class[] getInternalInterfaces()>() 
;(assert (var1741_addAll/1303872711 (cast-from-var2350-to-var1293 var2137!2) (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1115__ var517))) ; Statement: staticinvoke <java.util.Collections: boolean addAll(java.util.Collection,java.lang.Object[])>($r0, r3) 

(declare-const var2137!3 var2350)
(declare-const var517!1 (Array Int ClassObject))
(define-const var3587 ClassObject (interfaceClass/-955518528 var2877)) ; Statement: $r4 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Class interfaceClass> 
(assert true)
(define-const var3354 String (getName/-1958580599 var3587)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.Class: java.lang.String getName()>() 
(define-const var451 String (interfaceName/-955518528 var2877)) ; Statement: $r5 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.String interfaceName> 
(define-const var2977 Bool (var195_isEquals/882237642 var3354 var451)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r6, $r5) 
 ; Statement: if $z0 != 0 goto $z3 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>() 
(assert (not (= (ite var2977 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2051 Bool var3503_inNativeImage/-778320806) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>() 
 ; Statement: if $z3 == 0 goto $r7 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Object lazyProxy> 
(assert (= (ite var2051 1 0) 0)) ; Cond: $z3 == 0 
(define-const var2384 var1115 (lazyProxy/-955518528 var2877)) ; Statement: $r7 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Object lazyProxy> 
 ; Statement: if $r7 != null goto $r15 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Object lazyProxy> 
(assert (not (= var2384 null-var1115))) ; Cond: $r7 != null 
(define-const var3370 var1115 (lazyProxy/-955518528 var2877)) ; Statement: $r15 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Object lazyProxy> 
 ; Statement: if $r15 != null goto return 
(assert (not (= var3370 null-var1115))) ; Cond: $r15 != null 
 ; Statement: return 
(check-sat)
; {var2350-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), interfaceClass/-955518528=([org.apache.dubbo.config.spring.ReferenceBean], java.lang.Class), var1769_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var2350-to-var1769=([java.util.ArrayList], java.util.List), cast-from-ClassObject-to-var1115=([java.lang.Class], java.lang.Object), var1113_getInternalInterfaces/973257569=([], java.lang.Class[]), var1741_addAll/1303872711=([java.util.Collection, java.lang.Object[]], boolean), cast-from-var2350-to-var1293=([java.util.ArrayList], java.util.Collection), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var1115__=([java.lang.Class[]], java.lang.Object[]), getName/-1958580599=([java.lang.Class], java.lang.String), interfaceName/-955518528=([org.apache.dubbo.config.spring.ReferenceBean], java.lang.String), var195_isEquals/882237642=([java.lang.String, java.lang.String], boolean), var3503_inNativeImage/-778320806=([], boolean), lazyProxy/-955518528=([org.apache.dubbo.config.spring.ReferenceBean], java.lang.Object)}
; {var2429=org.apache.dubbo.config.spring.ReferenceBean, var2877=r1, var2350=java.util.ArrayList, var2137=$r0, var560=$r2, var1769=java.util.List, var1115=java.lang.Object, var1113=org.apache.dubbo.rpc.proxy.AbstractProxyFactory, var517=r3, var1741=java.util.Collections, var1293=java.util.Collection, var3587=$r4, var3354=$r6, var451=$r5, var195=org.apache.dubbo.common.utils.StringUtils, var2977=$z0, var3503=org.apache.dubbo.common.aot.NativeDetector, var2051=$z3, var2384=$r7, var3370=$r15}
; {org.apache.dubbo.config.spring.ReferenceBean=var2429, r1=var2877, java.util.ArrayList=var2350, $r0=var2137, $r2=var560, java.util.List=var1769, java.lang.Object=var1115, org.apache.dubbo.rpc.proxy.AbstractProxyFactory=var1113, r3=var517, java.util.Collections=var1741, java.util.Collection=var1293, $r4=var3587, $r6=var3354, $r5=var451, org.apache.dubbo.common.utils.StringUtils=var195, $z0=var2977, org.apache.dubbo.common.aot.NativeDetector=var3503, $z3=var2051, $r7=var2384, $r15=var3370}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.spring.ReferenceBean;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r2 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Class interfaceClass>;	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r2);	r3 = staticinvoke <org.apache.dubbo.rpc.proxy.AbstractProxyFactory: java.lang.Class[] getInternalInterfaces()>();	staticinvoke <java.util.Collections: boolean addAll(java.util.Collection,java.lang.Object[])>($r0, r3);	$r4 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Class interfaceClass>;	$r6 = virtualinvoke $r4.<java.lang.Class: java.lang.String getName()>();	$r5 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.String interfaceName>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r6, $r5);	if $z0 != 0 goto $z3 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>();	$z3 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>();	if $z3 == 0 goto $r7 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Object lazyProxy>;	$r7 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Object lazyProxy>;	if $r7 != null goto $r15 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Object lazyProxy>;	$r15 = r1.<org.apache.dubbo.config.spring.ReferenceBean: java.lang.Object lazyProxy>;	if $r15 != null goto return;	return
;block_num 5