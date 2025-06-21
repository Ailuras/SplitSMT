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

(declare-sort var3194 0)
(declare-sort var3568 0)
(declare-sort var2889 0)
(declare-sort var2421 0)
(declare-sort var2353 0)
(declare-sort var3976 0)
(declare-sort var1210 0)
(declare-sort var2005 0)
(declare-sort var3419 0)
(declare-sort var131 0)
(declare-sort var402 0)
(declare-sort var1496 0)
(declare-sort var2868 0)
(declare-sort var1800 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2889-init () var2889)
(declare-fun <init>/-808729244 (var2889) void)
(declare-fun getClassLoader/1906772403 (var3194 var3568) var2421)
(declare-fun var3976_getUrl/-275947851 (var3976) var2353)
(declare-fun cast-from-var3568-to-var3976 (var3568) var3976)
(declare-fun getParameter/-1307325648 (var2353 String) String)
(declare-fun var1210_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var3568_getInterface/-1171900879 (var3568) ClassObject)
(declare-fun add/-1525189755 (var2005 var3419) Bool)
(declare-fun cast-from-var2889-to-var2005 (var2889) var2005)
(declare-fun cast-from-ClassObject-to-var3419 (ClassObject) var3419)
(declare-fun var402_asList/1779083644 ((Array Int var3419)) var131)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3419__ ((Array Int ClassObject)) (Array Int var3419))
(declare-fun addAll/-970509887 (var1496 var2868) Bool)
(declare-fun cast-from-var2889-to-var1496 (var2889) var1496)
(declare-fun cast-from-var131-to-var2868 (var131) var2868)
(declare-const null-var3194 var3194)
(declare-const null-var3568 var3568)
(declare-const null-Bool Bool)
(declare-const null-ClassObject ClassObject)
(declare-const var3194-INTERNAL_INTERFACES (Array Int ClassObject))
(declare-const null-var1800 var1800)
(declare-const var2679 var3194) ; Statement: r1 := @this: org.apache.dubbo.rpc.proxy.AbstractProxyFactory 
(assert (not (= var2679 null-var3194)))
(declare-const var2612 var3568) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2612 null-var3568)))
(declare-const var3866 Bool) ; Statement: z1 := @parameter1: boolean 
(assert (not (= var3866 null-Bool)))
(define-const var1088 var2889 var2889-init) ; Statement: $r0 = new java.util.LinkedHashSet 
(assert true)
;(assert (<init>/-808729244 var1088)) ; Statement: specialinvoke $r0.<java.util.LinkedHashSet: void <init>()>() 

(declare-const var1088!1 var2889)
(assert true)
(define-const var1709 var2421 (getClassLoader/1906772403 var2679 var2612)) ; Statement: r3 = specialinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyFactory: java.lang.ClassLoader getClassLoader(org.apache.dubbo.rpc.Invoker)>(r2) 
(define-const var954 var2353 (var3976_getUrl/-275947851 (cast-from-var3568-to-var3976 var2612))) ; Statement: $r4 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1005 String (getParameter/-1307325648 var954 "interfaces")) ; Statement: r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("interfaces") 
(define-const var549 Bool (var1210_isNotEmpty/-1251449450 var1005)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto r24 = null 
(assert (= (ite var549 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2430 ClassObject null-ClassObject) ; Statement: r24 = null 
 ; Statement: if z1 == 0 goto $r28 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>() 
(assert (= (ite var3866 1 0) 0)) ; Cond: z1 == 0 
(define-const var2034 ClassObject (var3568_getInterface/-1171900879 var2612)) ; Statement: $r28 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>() 
(assert true)
;(assert (add/-1525189755 (cast-from-var2889-to-var2005 var1088!1) (cast-from-ClassObject-to-var3419 var2034))) ; Statement: virtualinvoke $r0.<java.util.LinkedHashSet: boolean add(java.lang.Object)>($r28) 

(declare-const var1088!2 var2889)
(declare-const var2034!1 ClassObject)
(define-const var1135 (Array Int ClassObject) var3194-INTERNAL_INTERFACES) ; Statement: $r29 = <org.apache.dubbo.rpc.proxy.AbstractProxyFactory: java.lang.Class[] INTERNAL_INTERFACES> 
(define-const var331 var131 (var402_asList/1779083644 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3419__ var1135))) ; Statement: $r30 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r29) 
(assert true)
;(assert (addAll/-970509887 (cast-from-var2889-to-var1496 var1088!2) (cast-from-var131-to-var2868 var331))) ; Statement: virtualinvoke $r0.<java.util.LinkedHashSet: boolean addAll(java.util.Collection)>($r30) 

(declare-const var1088!3 var2889)
(declare-const var331!1 var131)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var177 var1800) ; Statement: $r14 := @caughtexception 
(assert (not (= var177 null-var1800)))
 ; Statement: if z1 == 0 goto throw $r14 
(assert (= (ite var3866 1 0) 0)) ; Cond: z1 == 0 
 ; Statement: throw $r14 
(check-sat)
; {var2889-init=([], java.util.LinkedHashSet), <init>/-808729244=([java.util.LinkedHashSet], void), getClassLoader/1906772403=([org.apache.dubbo.rpc.proxy.AbstractProxyFactory, org.apache.dubbo.rpc.Invoker], java.lang.ClassLoader), var3976_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3568-to-var3976=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1210_isNotEmpty/-1251449450=([java.lang.String], boolean), var3568_getInterface/-1171900879=([org.apache.dubbo.rpc.Invoker], java.lang.Class), add/-1525189755=([java.util.HashSet, java.lang.Object], boolean), cast-from-var2889-to-var2005=([java.util.LinkedHashSet], java.util.HashSet), cast-from-ClassObject-to-var3419=([java.lang.Class], java.lang.Object), var402_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3419__=([java.lang.Class[]], java.lang.Object[]), addAll/-970509887=([java.util.AbstractCollection, java.util.Collection], boolean), cast-from-var2889-to-var1496=([java.util.LinkedHashSet], java.util.AbstractCollection), cast-from-var131-to-var2868=([java.util.List], java.util.Collection)}
; {var3194=org.apache.dubbo.rpc.proxy.AbstractProxyFactory, var2679=r1, var3568=org.apache.dubbo.rpc.Invoker, var2612=r2, var3866=z1, var2889=java.util.LinkedHashSet, var1088=$r0, var2421=java.lang.ClassLoader, var1709=r3, var2353=org.apache.dubbo.common.URL, var3976=org.apache.dubbo.common.Node, var954=$r4, var1005=r5, var1210=org.apache.dubbo.common.utils.StringUtils, var549=$z0, var2430=r24, var2034=$r28, var2005=java.util.HashSet, var3419=java.lang.Object, var1135=$r29, var131=java.util.List, var402=java.util.Arrays, var331=$r30, var1496=java.util.AbstractCollection, var2868=java.util.Collection, var1800=java.lang.Throwable, var177=$r14}
; {org.apache.dubbo.rpc.proxy.AbstractProxyFactory=var3194, r1=var2679, org.apache.dubbo.rpc.Invoker=var3568, r2=var2612, z1=var3866, java.util.LinkedHashSet=var2889, $r0=var1088, java.lang.ClassLoader=var2421, r3=var1709, org.apache.dubbo.common.URL=var2353, org.apache.dubbo.common.Node=var3976, $r4=var954, r5=var1005, org.apache.dubbo.common.utils.StringUtils=var1210, $z0=var549, r24=var2430, $r28=var2034, java.util.HashSet=var2005, java.lang.Object=var3419, $r29=var1135, java.util.List=var131, java.util.Arrays=var402, $r30=var331, java.util.AbstractCollection=var1496, java.util.Collection=var2868, java.lang.Throwable=var1800, $r14=var177}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.proxy.AbstractProxyFactory;	r2 := @parameter0: org.apache.dubbo.rpc.Invoker;	z1 := @parameter1: boolean;	$r0 = new java.util.LinkedHashSet;	specialinvoke $r0.<java.util.LinkedHashSet: void <init>()>();	r3 = specialinvoke r1.<org.apache.dubbo.rpc.proxy.AbstractProxyFactory: java.lang.ClassLoader getClassLoader(org.apache.dubbo.rpc.Invoker)>(r2);	$r4 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r5 = virtualinvoke $r4.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("interfaces");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5);	if $z0 == 0 goto r24 = null;	r24 = null;	if z1 == 0 goto $r28 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>();	$r28 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>();	virtualinvoke $r0.<java.util.LinkedHashSet: boolean add(java.lang.Object)>($r28);	$r29 = <org.apache.dubbo.rpc.proxy.AbstractProxyFactory: java.lang.Class[] INTERNAL_INTERFACES>;	$r30 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r29);	virtualinvoke $r0.<java.util.LinkedHashSet: boolean addAll(java.util.Collection)>($r30);	$r14 := @caughtexception;	if z1 == 0 goto throw $r14;	throw $r14
;block_num 5