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

(declare-sort var1124 0)
(declare-sort var224 0)
(declare-sort var1644 0)
(declare-sort var3803 0)
(declare-sort var3806 0)
(declare-sort var1803 0)
(declare-sort var553 0)
(declare-sort var1101 0)
(declare-sort var3601 0)
(declare-sort var3172 0)
(declare-sort var2741 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3803!class ClassObject)
(declare-fun applicationModel/1424178328 (var1124) var224)
(declare-fun getExtensionLoader/-514331157 (var3806 ClassObject) var1644)
(declare-fun cast-from-var224-to-var3806 (var224) var3806)
(declare-fun getDefaultExtension/1470219142 (var1644) var1803)
(declare-fun cast-from-var1803-to-var3803 (var1803) var3803)
(declare-fun var3803_get/-895792377 (var3803 String) var1101)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1101_entrySet/1101202697 (var1101) var3172)
(declare-fun var3172_iterator/1911472585 (var3172) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun length/-171891354 (String) Int)
(declare-fun var2741-init () var2741)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/294323258 (var2741 var3601 String) void)
(declare-const null-var1124 var1124)
(declare-const var553-EXECUTOR_SERVICE_COMPONENT_KEY String)
(declare-const var3601-OK var3601)
(declare-const var1028 var1124) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker 
(assert (not (= var1028 null-var1124)))
(define-const var864 var224 (applicationModel/1424178328 var1028)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var870 var1644 (getExtensionLoader/-514331157 (cast-from-var224-to-var3806 var864) var3803!class)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/store/DataStore;") 
(assert true)
(define-const var2501 var1803 (getDefaultExtension/1470219142 var870)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getDefaultExtension()>() 
(define-const var2247 var3803 (cast-from-var1803-to-var3803 var2501)) ; Statement: r4 = (org.apache.dubbo.common.store.DataStore) $r3 
(define-const var2256 String var553-EXECUTOR_SERVICE_COMPONENT_KEY) ; Statement: $r5 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY> 
(define-const var964 var1101 (var3803_get/-895792377 var2247 var2256)) ; Statement: r6 = interfaceinvoke r4.<org.apache.dubbo.common.store.DataStore: java.util.Map get(java.lang.String)>($r5) 
(define-const var3197 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3197)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3197!1 String)
(assert (= var3197!1 ""))
(define-const var681 var3601 var3601-OK) ; Statement: r32 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level OK> 
(define-const var3141 var3172 (var1101_entrySet/1101202697 var964)) ; Statement: $r8 = interfaceinvoke r6.<java.util.Map: java.util.Set entrySet()>() 
(define-const var1812 Iterator (var3172_iterator/1911472585 var3141)) ; Statement: r9 = interfaceinvoke $r8.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3960 Bool (Iterator_hasNext/-1669924200 var1812)) ; Statement: $z0 = interfaceinvoke r9.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $i0 = virtualinvoke $r7.<java.lang.StringBuilder: int length()>() 
(assert (= (ite var3960 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3146 Int (length/-171891354 var3197!1)) ; Statement: $i0 = virtualinvoke $r7.<java.lang.StringBuilder: int length()>() 
 ; Statement: if $i0 != 0 goto $r34 = new org.apache.dubbo.common.status.Status 
(assert (not (= var3146 0))) ; Cond: $i0 != 0 
(define-const var1787 var2741 var2741-init) ; Statement: $r34 = new org.apache.dubbo.common.status.Status 
(assert true)
(define-const var1149 String (toString/-2075883882 var3197!1)) ; Statement: $r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/294323258 var1787 var681 var1149)) ; Statement: specialinvoke $r34.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>(r32, $r10) 

(declare-const var1787!1 var2741)
(declare-const var681!1 var3601)
(declare-const var1149!1 String)
(assert true) ; Non Conditional
 ; Statement: return $r34 
(check-sat)
; {applicationModel/1424178328=([org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var224-to-var3806=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getDefaultExtension/1470219142=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Object), cast-from-var1803-to-var3803=([java.lang.Object], org.apache.dubbo.common.store.DataStore), var3803_get/-895792377=([org.apache.dubbo.common.store.DataStore, java.lang.String], java.util.Map), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1101_entrySet/1101202697=([java.util.Map], java.util.Set), var3172_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), length/-171891354=([java.lang.StringBuilder], int), var2741-init=([], org.apache.dubbo.common.status.Status), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/294323258=([org.apache.dubbo.common.status.Status, org.apache.dubbo.common.status.Status$Level, java.lang.String], void)}
; {var1124=org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker, var1028=r0, var224=org.apache.dubbo.rpc.model.ApplicationModel, var864=$r1, var1644=org.apache.dubbo.common.extension.ExtensionLoader, var3803=org.apache.dubbo.common.store.DataStore, var3806=org.apache.dubbo.common.extension.ExtensionAccessor, var870=$r2, var1803=java.lang.Object, var2501=$r3, var2247=r4, var553=org.apache.dubbo.common.constants.CommonConstants, var2256=$r5, var1101=java.util.Map, var964=r6, var3197=$r7, var3601=org.apache.dubbo.common.status.Status$Level, var681=r32, var3172=java.util.Set, var3141=$r8, var1812=r9, var3960=$z0, var3146=$i0, var2741=org.apache.dubbo.common.status.Status, var1787=$r34, var1149=$r10}
; {org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker=var1124, r0=var1028, org.apache.dubbo.rpc.model.ApplicationModel=var224, $r1=var864, org.apache.dubbo.common.extension.ExtensionLoader=var1644, org.apache.dubbo.common.store.DataStore=var3803, org.apache.dubbo.common.extension.ExtensionAccessor=var3806, $r2=var870, java.lang.Object=var1803, $r3=var2501, r4=var2247, org.apache.dubbo.common.constants.CommonConstants=var553, $r5=var2256, java.util.Map=var1101, r6=var964, $r7=var3197, org.apache.dubbo.common.status.Status$Level=var3601, r32=var681, java.util.Set=var3172, $r8=var3141, r9=var1812, $z0=var3960, $i0=var3146, org.apache.dubbo.common.status.Status=var2741, $r34=var1787, $r10=var1149}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: int length()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: int length()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker;	$r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.status.ThreadPoolStatusChecker: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/store/DataStore;");	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getDefaultExtension()>();	r4 = (org.apache.dubbo.common.store.DataStore) $r3;	$r5 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY>;	r6 = interfaceinvoke r4.<org.apache.dubbo.common.store.DataStore: java.util.Map get(java.lang.String)>($r5);	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	r32 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level OK>;	$r8 = interfaceinvoke r6.<java.util.Map: java.util.Set entrySet()>();	r9 = interfaceinvoke $r8.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r9.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $i0 = virtualinvoke $r7.<java.lang.StringBuilder: int length()>();	$i0 = virtualinvoke $r7.<java.lang.StringBuilder: int length()>();	if $i0 != 0 goto $r34 = new org.apache.dubbo.common.status.Status;	$r34 = new org.apache.dubbo.common.status.Status;	$r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r34.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>(r32, $r10);	return $r34
;block_num 5