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

(declare-sort var1269 0)
(declare-sort var1165 0)
(declare-sort var179 0)
(declare-sort var3246 0)
(declare-sort var1526 0)
(declare-sort var2864 0)
(declare-sort var2153 0)
(declare-sort var385 0)
(declare-sort var279 0)
(declare-sort var3062 0)
(declare-sort var669 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3246!class ClassObject)
(declare-fun applicationModel/1424178328 (var1269) var1165)
(declare-fun getExtensionLoader/-514331157 (var1526 ClassObject) var179)
(declare-fun cast-from-var1165-to-var1526 (var1165) var1526)
(declare-fun getDefaultExtension/1470219142 (var179) var2864)
(declare-fun cast-from-var2864-to-var3246 (var2864) var3246)
(declare-fun var3246_get/-895792377 (var3246 String) var385)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var385_entrySet/1101202697 (var385) var3062)
(declare-fun var3062_iterator/1911472585 (var3062) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun length/-171891354 (String) Int)
(declare-fun var669-init () var669)
(declare-fun <init>/1756247553 (var669 var279) void)
(declare-const null-var1269 var1269)
(declare-const var2153-EXECUTOR_SERVICE_COMPONENT_KEY String)
(declare-const var279-OK var279)
(declare-const var279-UNKNOWN var279)
(declare-const var2310 var1269) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker 
(assert (not (= var2310 null-var1269)))
(define-const var3672 var1165 (applicationModel/1424178328 var2310)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var875 var179 (getExtensionLoader/-514331157 (cast-from-var1165-to-var1526 var3672) var3246!class)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/store/DataStore;") 
(assert true)
(define-const var93 var2864 (getDefaultExtension/1470219142 var875)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getDefaultExtension()>() 
(define-const var820 var3246 (cast-from-var2864-to-var3246 var93)) ; Statement: r4 = (org.apache.dubbo.common.store.DataStore) $r3 
(define-const var2704 String var2153-EXECUTOR_SERVICE_COMPONENT_KEY) ; Statement: $r5 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY> 
(define-const var845 var385 (var3246_get/-895792377 var820 var2704)) ; Statement: r6 = interfaceinvoke r4.<org.apache.dubbo.common.store.DataStore: java.util.Map get(java.lang.String)>($r5) 
(define-const var3810 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3810)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3810!1 String)
(assert (= var3810!1 ""))
(define-const var2615 var279 var279-OK) ; Statement: r32 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level OK> 
(define-const var3378 var3062 (var385_entrySet/1101202697 var845)) ; Statement: $r8 = interfaceinvoke r6.<java.util.Map: java.util.Set entrySet()>() 
(define-const var2017 Iterator (var3062_iterator/1911472585 var3378)) ; Statement: r9 = interfaceinvoke $r8.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2696 Bool (Iterator_hasNext/-1669924200 var2017)) ; Statement: $z0 = interfaceinvoke r9.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $i0 = virtualinvoke $r7.<java.lang.StringBuilder: int length()>() 
(assert (= (ite var2696 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2246 Int (length/-171891354 var3810!1)) ; Statement: $i0 = virtualinvoke $r7.<java.lang.StringBuilder: int length()>() 
 ; Statement: if $i0 != 0 goto $r34 = new org.apache.dubbo.common.status.Status 
(assert (not (not (= var2246 0)))) ; Negate: Cond: $i0 != 0  
(define-const var3482 var669 var669-init) ; Statement: $r34 = new org.apache.dubbo.common.status.Status 
(define-const var1720 var279 var279-UNKNOWN) ; Statement: $r11 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level UNKNOWN> 
(assert true)
;(assert (<init>/1756247553 var3482 var1720)) ; Statement: specialinvoke $r34.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level)>($r11) 

(declare-const var3482!1 var669)
(declare-const var1720!1 var279)
 ; Statement: goto [?= return $r34] 
(assert true) ; Non Conditional
 ; Statement: return $r34 
(check-sat)
; {applicationModel/1424178328=([org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var1165-to-var1526=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getDefaultExtension/1470219142=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Object), cast-from-var2864-to-var3246=([java.lang.Object], org.apache.dubbo.common.store.DataStore), var3246_get/-895792377=([org.apache.dubbo.common.store.DataStore, java.lang.String], java.util.Map), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var385_entrySet/1101202697=([java.util.Map], java.util.Set), var3062_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), length/-171891354=([java.lang.StringBuilder], int), var669-init=([], org.apache.dubbo.common.status.Status), <init>/1756247553=([org.apache.dubbo.common.status.Status, org.apache.dubbo.common.status.Status$Level], void)}
; {var1269=org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker, var2310=r0, var1165=org.apache.dubbo.rpc.model.ApplicationModel, var3672=$r1, var179=org.apache.dubbo.common.extension.ExtensionLoader, var3246=org.apache.dubbo.common.store.DataStore, var1526=org.apache.dubbo.common.extension.ExtensionAccessor, var875=$r2, var2864=java.lang.Object, var93=$r3, var820=r4, var2153=org.apache.dubbo.common.constants.CommonConstants, var2704=$r5, var385=java.util.Map, var845=r6, var3810=$r7, var279=org.apache.dubbo.common.status.Status$Level, var2615=r32, var3062=java.util.Set, var3378=$r8, var2017=r9, var2696=$z0, var2246=$i0, var669=org.apache.dubbo.common.status.Status, var3482=$r34, var1720=$r11}
; {org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker=var1269, r0=var2310, org.apache.dubbo.rpc.model.ApplicationModel=var1165, $r1=var3672, org.apache.dubbo.common.extension.ExtensionLoader=var179, org.apache.dubbo.common.store.DataStore=var3246, org.apache.dubbo.common.extension.ExtensionAccessor=var1526, $r2=var875, java.lang.Object=var2864, $r3=var93, r4=var820, org.apache.dubbo.common.constants.CommonConstants=var2153, $r5=var2704, java.util.Map=var385, r6=var845, $r7=var3810, org.apache.dubbo.common.status.Status$Level=var279, r32=var2615, java.util.Set=var3062, $r8=var3378, r9=var2017, $z0=var2696, $i0=var2246, org.apache.dubbo.common.status.Status=var669, $r34=var3482, $r11=var1720}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: int length()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: int length()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker;	$r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/store/DataStore;");	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getDefaultExtension()>();	r4 = (org.apache.dubbo.common.store.DataStore) $r3;	$r5 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY>;	r6 = interfaceinvoke r4.<org.apache.dubbo.common.store.DataStore: java.util.Map get(java.lang.String)>($r5);	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	r32 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level OK>;	$r8 = interfaceinvoke r6.<java.util.Map: java.util.Set entrySet()>();	r9 = interfaceinvoke $r8.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r9.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $i0 = virtualinvoke $r7.<java.lang.StringBuilder: int length()>();	$i0 = virtualinvoke $r7.<java.lang.StringBuilder: int length()>();	if $i0 != 0 goto $r34 = new org.apache.dubbo.common.status.Status;	$r34 = new org.apache.dubbo.common.status.Status;	$r11 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level UNKNOWN>;	specialinvoke $r34.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level)>($r11);	goto [?= return $r34];	return $r34
;block_num 5