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

(declare-sort var700 0)
(declare-sort var1861 0)
(declare-sort var3728 0)
(declare-sort var3696 0)
(declare-sort var2607 0)
(declare-sort var1818 0)
(declare-sort var1171 0)
(declare-sort var3676 0)
(declare-sort var3402 0)
(declare-sort var48 0)
(declare-sort var155 0)
(declare-sort var1538 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun url/-514244350 (var700) var3728)
(declare-fun getServiceInterface/-1311863806 (var3728) String)
(declare-fun var3696_forName/-1763490630 (String) ClassObject)
(declare-fun var2607_isDefault/-1009400446 (String) Bool)
(declare-fun var1818_get/1088891777 (var1818 var1171) var1171)
(declare-fun cast-from-String-to-var1171 (String) var1171)
(declare-fun cast-from-var1171-to-var3676 (var1171) var3676)
(declare-fun getOrDefaultApplicationModel/-1374397043 (var3728) var3402)
(declare-fun getExtensionDirector/-217148012 (var155) var48)
(declare-fun cast-from-var3402-to-var155 (var3402) var155)
(declare-fun var700_getMockObject/-27321039 (var48 String ClassObject) var1171)
(declare-fun proxyFactory/-514244350 (var700) var1538)
(declare-fun var1538_getInvoker/1065608682 (var1538 var1171 ClassObject var3728) var3676)
(declare-fun var1818_size/-1594421051 (var1818) Int)
(declare-const null-var700 var700)
(declare-const null-String String)
(declare-const var700-MOCK_MAP var1818)
(declare-const null-var3676 var3676)
(declare-const var2695 var700) ; Statement: r0 := @this: org.apache.dubbo.rpc.support.MockInvoker 
(assert (not (= var2695 null-var700)))
(declare-const var888 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var888 null-String)))
(define-const var657 var3728 (url/-514244350 var2695)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var749 String (getServiceInterface/-1311863806 var657)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var928 ClassObject (var3696_forName/-1763490630 var749)) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2) 
(define-const var1310 Bool (var2607_isDefault/-1009400446 var888)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r20 = r4 
(assert (= (ite var1310 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1990 String var888) ; Statement: $r20 = r4 
(assert true) ; Non Conditional
(define-const var914 var1818 var700-MOCK_MAP) ; Statement: $r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP> 
(define-const var1935 var1171 (var1818_get/1088891777 var914 (cast-from-String-to-var1171 var1990))) ; Statement: $r6 = interfaceinvoke $r5.<java.util.Map: java.lang.Object get(java.lang.Object)>($r20) 
(define-const var1790 var3676 (cast-from-var1171-to-var3676 var1935)) ; Statement: $r19 = (org.apache.dubbo.rpc.Invoker) $r6 
 ; Statement: if $r19 == null goto $r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(assert (= var1790 null-var3676)) ; Cond: $r19 == null 
(define-const var43 var3728 (url/-514244350 var2695)) ; Statement: $r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var249 var3402 (getOrDefaultApplicationModel/-1374397043 var43)) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>() 
(assert true)
(define-const var1773 var48 (getExtensionDirector/-217148012 (cast-from-var3402-to-var155 var249))) ; Statement: $r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionDirector getExtensionDirector()>() 
(define-const var3706 var1171 (var700_getMockObject/-27321039 var1773 var888 var928)) ; Statement: r10 = staticinvoke <org.apache.dubbo.rpc.support.MockInvoker: java.lang.Object getMockObject(org.apache.dubbo.common.extension.ExtensionDirector,java.lang.String,java.lang.Class)>($r9, r4, r3) 
(define-const var2715 var1538 (proxyFactory/-514244350 var2695)) ; Statement: $r12 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.rpc.ProxyFactory proxyFactory> 
(define-const var1049 var3728 (url/-514244350 var2695)) ; Statement: $r11 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url> 
(define-const var1272 var3676 (var1538_getInvoker/1065608682 var2715 var3706 var928 var1049)) ; Statement: r21 = interfaceinvoke $r12.<org.apache.dubbo.rpc.ProxyFactory: org.apache.dubbo.rpc.Invoker getInvoker(java.lang.Object,java.lang.Class,org.apache.dubbo.common.URL)>(r10, r3, $r11) 
(define-const var1852 var1818 var700-MOCK_MAP) ; Statement: $r13 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP> 
(define-const var2457 Int (var1818_size/-1594421051 var1852)) ; Statement: $i0 = interfaceinvoke $r13.<java.util.Map: int size()>() 
 ; Statement: if $i0 >= 10000 goto return r21 
(assert (>= var2457 10000)) ; Cond: $i0 >= 10000 
 ; Statement: return r21 
(check-sat)
; {url/-514244350=([org.apache.dubbo.rpc.support.MockInvoker], org.apache.dubbo.common.URL), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), var3696_forName/-1763490630=([java.lang.String], java.lang.Class), var2607_isDefault/-1009400446=([java.lang.String], boolean), var1818_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1171=([java.lang.String], java.lang.Object), cast-from-var1171-to-var3676=([java.lang.Object], org.apache.dubbo.rpc.Invoker), getOrDefaultApplicationModel/-1374397043=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionDirector/-217148012=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.extension.ExtensionDirector), cast-from-var3402-to-var155=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), var700_getMockObject/-27321039=([org.apache.dubbo.common.extension.ExtensionDirector, java.lang.String, java.lang.Class], java.lang.Object), proxyFactory/-514244350=([org.apache.dubbo.rpc.support.MockInvoker], org.apache.dubbo.rpc.ProxyFactory), var1538_getInvoker/1065608682=([org.apache.dubbo.rpc.ProxyFactory, java.lang.Object, java.lang.Class, org.apache.dubbo.common.URL], org.apache.dubbo.rpc.Invoker), var1818_size/-1594421051=([java.util.Map], int)}
; {var700=org.apache.dubbo.rpc.support.MockInvoker, var2695=r0, var888=r4, var1861=null_type, var3728=org.apache.dubbo.common.URL, var657=$r1, var749=$r2, var3696=org.apache.dubbo.common.utils.ReflectUtils, var928=r3, var2607=org.apache.dubbo.common.utils.ConfigUtils, var1310=$z0, var1990=$r20, var1818=java.util.Map, var914=$r5, var1171=java.lang.Object, var1935=$r6, var3676=org.apache.dubbo.rpc.Invoker, var1790=$r19, var43=$r7, var3402=org.apache.dubbo.rpc.model.ApplicationModel, var249=$r8, var48=org.apache.dubbo.common.extension.ExtensionDirector, var155=org.apache.dubbo.rpc.model.ScopeModel, var1773=$r9, var3706=r10, var1538=org.apache.dubbo.rpc.ProxyFactory, var2715=$r12, var1049=$r11, var1272=r21, var1852=$r13, var2457=$i0}
; {org.apache.dubbo.rpc.support.MockInvoker=var700, r0=var2695, r4=var888, null_type=var1861, org.apache.dubbo.common.URL=var3728, $r1=var657, $r2=var749, org.apache.dubbo.common.utils.ReflectUtils=var3696, r3=var928, org.apache.dubbo.common.utils.ConfigUtils=var2607, $z0=var1310, $r20=var1990, java.util.Map=var1818, $r5=var914, java.lang.Object=var1171, $r6=var1935, org.apache.dubbo.rpc.Invoker=var3676, $r19=var1790, $r7=var43, org.apache.dubbo.rpc.model.ApplicationModel=var3402, $r8=var249, org.apache.dubbo.common.extension.ExtensionDirector=var48, org.apache.dubbo.rpc.model.ScopeModel=var155, $r9=var1773, r10=var3706, org.apache.dubbo.rpc.ProxyFactory=var1538, $r12=var2715, $r11=var1049, r21=var1272, $r13=var1852, $i0=var2457}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.support.MockInvoker;	r4 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r4);	if $z0 == 0 goto $r20 = r4;	$r20 = r4;	$r5 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP>;	$r6 = interfaceinvoke $r5.<java.util.Map: java.lang.Object get(java.lang.Object)>($r20);	$r19 = (org.apache.dubbo.rpc.Invoker) $r6;	if $r19 == null goto $r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	$r7 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	$r8 = virtualinvoke $r7.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>();	$r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionDirector getExtensionDirector()>();	r10 = staticinvoke <org.apache.dubbo.rpc.support.MockInvoker: java.lang.Object getMockObject(org.apache.dubbo.common.extension.ExtensionDirector,java.lang.String,java.lang.Class)>($r9, r4, r3);	$r12 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.rpc.ProxyFactory proxyFactory>;	$r11 = r0.<org.apache.dubbo.rpc.support.MockInvoker: org.apache.dubbo.common.URL url>;	r21 = interfaceinvoke $r12.<org.apache.dubbo.rpc.ProxyFactory: org.apache.dubbo.rpc.Invoker getInvoker(java.lang.Object,java.lang.Class,org.apache.dubbo.common.URL)>(r10, r3, $r11);	$r13 = <org.apache.dubbo.rpc.support.MockInvoker: java.util.Map MOCK_MAP>;	$i0 = interfaceinvoke $r13.<java.util.Map: int size()>();	if $i0 >= 10000 goto return r21;	return r21
;block_num 5