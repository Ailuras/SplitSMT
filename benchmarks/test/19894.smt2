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

(declare-sort var1755 0)
(declare-sort var255 0)
(declare-sort var2886 0)
(declare-sort var3660 0)
(declare-sort var904 0)
(declare-sort var2941 0)
(declare-sort var3172 0)
(declare-sort var3877 0)
(declare-sort var3763 0)
(declare-sort var3542 0)
(declare-sort var1120 0)
(declare-sort var861 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun url/-514244350 (var1755) var2886)
(declare-fun getServiceInterface/-1311863806 (var2886) String)
(declare-fun var3660_forName/-1763490630 (String) ClassObject)
(declare-fun var904_isDefault/-1009400446 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2941_get/1088891777 (var2941 var3172) var3172)
(declare-fun cast-from-String-to-var3172 (String) var3172)
(declare-fun cast-from-var3172-to-var3877 (var3172) var3877)
(declare-fun getOrDefaultApplicationModel/-1374397043 (var2886) var3763)
(declare-fun getExtensionDirector/-217148012 (var1120) var3542)
(declare-fun cast-from-var3763-to-var1120 (var3763) var1120)
(declare-fun var1755_getMockObject/-27321039 (var3542 String ClassObject) var3172)
(declare-fun proxyFactory/-514244350 (var1755) var861)
(declare-fun var861_getInvoker/1065608682 (var861 var3172 ClassObject var2886) var3877)
(declare-fun var2941_size/-1594421051 (var2941) Int)
(declare-const null-var1755 var1755)
(declare-const null-String String)
(declare-const var1755-MOCK_MAP var2941)
(declare-const null-var3877 var3877)
(declare-const var1065 var1755) ; Statement: r0 := @this: org.apache.dubbo.rpc.support.MockInvoker 
(assert (not (= var1065 null-var1755)))
(declare-const var1514 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var1514 null-String)))
(define-const var3880 var2886 (url/-514244350 var1065)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var3277 String (getServiceInterface/-1311863806 var3880)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var1746 ClassObject (var3660_forName/-1763490630 var3277)) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2) 
(define-const var2997 Bool (var904_isDefault/-1009400446 var1514)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r20 = r4 
(assert (not (= (ite var2997 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var176 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var176)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var176!1 String)
(assert (= var176!1 ""))
(assert true)
(define-const var1498 String (getName/-1958580599 var1746)) ; Statement: $r16 = virtualinvoke r3.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3122 String (append/672562846 var176!1 var1498)) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16) 
(declare-const var176!2 String)
(assert (= var176!2 (str.++ var176!1 var1498)))
(assert true)
(define-const var2706 String (append/672562846 var3122 "Mock")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Mock") 
(declare-const var3122!1 String)
(assert (= var3122!1 (str.++ var3122 "Mock")))
(assert true)
(define-const var1582 String (toString/-2075883882 var2706)) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= $r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP>] 
(assert true) ; Non Conditional
(define-const var42 var2941 var1755-MOCK_MAP) ; Statement: $r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP> 
(define-const var1773 var3172 (var2941_get/1088891777 var42 (cast-from-String-to-var3172 var1582))) ; Statement: $r6 = interfaceinvoke $r5.<java.util.Map: java.lang.Object get(java.lang.Object)>($r20) 
(define-const var3440 var3877 (cast-from-var3172-to-var3877 var1773)) ; Statement: $r19 = (org.apache.dubbo.rpc.Invoker) $r6 
 ; Statement: if $r19 == null goto $r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(assert (= var3440 null-var3877)) ; Cond: $r19 == null 
(define-const var2555 var2886 (url/-514244350 var1065)) ; Statement: $r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var906 var3763 (getOrDefaultApplicationModel/-1374397043 var2555)) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>() 
(assert true)
(define-const var3871 var3542 (getExtensionDirector/-217148012 (cast-from-var3763-to-var1120 var906))) ; Statement: $r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionDirector getExtensionDirector()>() 
(define-const var1211 var3172 (var1755_getMockObject/-27321039 var3871 var1514 var1746)) ; Statement: r10 = staticinvoke <org.apache.dubbo.rpc.support.MockInvoker: java.lang.Object getMockObject(org.apache.dubbo.common.extension.ExtensionDirector,java.lang.String,java.lang.Class)>($r9, r4, r3) 
(define-const var3947 var861 (proxyFactory/-514244350 var1065)) ; Statement: $r12 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.rpc.ProxyFactory proxyFactory> 
(define-const var251 var2886 (url/-514244350 var1065)) ; Statement: $r11 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(define-const var3015 var3877 (var861_getInvoker/1065608682 var3947 var1211 var1746 var251)) ; Statement: r21 = interfaceinvoke $r12.<org.apache.dubbo.rpc.ProxyFactory: org.apache.dubbo.rpc.Invoker getInvoker(java.lang.Object,java.lang.Class,org.apache.dubbo.common.URL)>(r10, r3, $r11) 
(define-const var3942 var2941 var1755-MOCK_MAP) ; Statement: $r13 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP> 
(define-const var2857 Int (var2941_size/-1594421051 var3942)) ; Statement: $i0 = interfaceinvoke $r13.<java.util.Map: int size()>() 
 ; Statement: if $i0 >= 10000 goto return r21 
(assert (>= var2857 10000)) ; Cond: $i0 >= 10000 
 ; Statement: return r21 
(check-sat)
; {url/-514244350=([org.apache.dubbo.rpc.support.MockInvoker], org.apache.dubbo.common.URL), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), var3660_forName/-1763490630=([java.lang.String], java.lang.Class), var904_isDefault/-1009400446=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2941_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3172=([java.lang.String], java.lang.Object), cast-from-var3172-to-var3877=([java.lang.Object], org.apache.dubbo.rpc.Invoker), getOrDefaultApplicationModel/-1374397043=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionDirector/-217148012=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.extension.ExtensionDirector), cast-from-var3763-to-var1120=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), var1755_getMockObject/-27321039=([org.apache.dubbo.common.extension.ExtensionDirector, java.lang.String, java.lang.Class], java.lang.Object), proxyFactory/-514244350=([org.apache.dubbo.rpc.support.MockInvoker], org.apache.dubbo.rpc.ProxyFactory), var861_getInvoker/1065608682=([org.apache.dubbo.rpc.ProxyFactory, java.lang.Object, java.lang.Class, org.apache.dubbo.common.URL], org.apache.dubbo.rpc.Invoker), var2941_size/-1594421051=([java.util.Map], int)}
; {var1755=org.apache.dubbo.rpc.support.MockInvoker, var1065=r0, var1514=r4, var255=null_type, var2886=org.apache.dubbo.common.URL, var3880=$r1, var3277=$r2, var3660=org.apache.dubbo.common.utils.ReflectUtils, var1746=r3, var904=org.apache.dubbo.common.utils.ConfigUtils, var2997=$z0, var176=$r15, var1498=$r16, var3122=$r17, var2706=$r18, var1582=$r20, var2941=java.util.Map, var42=$r5, var3172=java.lang.Object, var1773=$r6, var3877=org.apache.dubbo.rpc.Invoker, var3440=$r19, var2555=$r7, var3763=org.apache.dubbo.rpc.model.ApplicationModel, var906=$r8, var3542=org.apache.dubbo.common.extension.ExtensionDirector, var1120=org.apache.dubbo.rpc.model.ScopeModel, var3871=$r9, var1211=r10, var861=org.apache.dubbo.rpc.ProxyFactory, var3947=$r12, var251=$r11, var3015=r21, var3942=$r13, var2857=$i0}
; {org.apache.dubbo.rpc.support.MockInvoker=var1755, r0=var1065, r4=var1514, null_type=var255, org.apache.dubbo.common.URL=var2886, $r1=var3880, $r2=var3277, org.apache.dubbo.common.utils.ReflectUtils=var3660, r3=var1746, org.apache.dubbo.common.utils.ConfigUtils=var904, $z0=var2997, $r15=var176, $r16=var1498, $r17=var3122, $r18=var2706, $r20=var1582, java.util.Map=var2941, $r5=var42, java.lang.Object=var3172, $r6=var1773, org.apache.dubbo.rpc.Invoker=var3877, $r19=var3440, $r7=var2555, org.apache.dubbo.rpc.model.ApplicationModel=var3763, $r8=var906, org.apache.dubbo.common.extension.ExtensionDirector=var3542, org.apache.dubbo.rpc.model.ScopeModel=var1120, $r9=var3871, r10=var1211, org.apache.dubbo.rpc.ProxyFactory=var861, $r12=var3947, $r11=var251, r21=var3015, $r13=var3942, $i0=var2857}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.support.MockInvoker;	r4 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r4);	if $z0 == 0 goto $r20 = r4;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke r3.<java.lang.Class: java.lang.String getName()>();	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Mock");	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= $r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP>];	$r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP>;	$r6 = interfaceinvoke $r5.<java.util.Map: java.lang.Object get(java.lang.Object)>($r20);	$r19 = (org.apache.dubbo.rpc.Invoker) $r6;	if $r19 == null goto $r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	$r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	$r8 = virtualinvoke $r7.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>();	$r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionDirector getExtensionDirector()>();	r10 = staticinvoke <org.apache.dubbo.rpc.support.MockInvoker: java.lang.Object getMockObject(org.apache.dubbo.common.extension.ExtensionDirector,java.lang.String,java.lang.Class)>($r9, r4, r3);	$r12 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.rpc.ProxyFactory proxyFactory>;	$r11 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	r21 = interfaceinvoke $r12.<org.apache.dubbo.rpc.ProxyFactory: org.apache.dubbo.rpc.Invoker getInvoker(java.lang.Object,java.lang.Class,org.apache.dubbo.common.URL)>(r10, r3, $r11);	$r13 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP>;	$i0 = interfaceinvoke $r13.<java.util.Map: int size()>();	if $i0 >= 10000 goto return r21;	return r21
;block_num 5