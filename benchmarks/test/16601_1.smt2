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

(declare-sort var1283 0)
(declare-sort var2289 0)
(declare-sort var523 0)
(declare-sort var3669 0)
(declare-sort var2717 0)
(declare-sort var790 0)
(declare-sort var2080 0)
(declare-sort var3661 0)
(declare-sort var3430 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2080!class ClassObject)
(declare-fun getParameter/-1307325648 (var1283 String) String)
(declare-fun var2289_isEmpty/-813097145 (String) Bool)
(declare-fun getScopeModel/-1957927771 (var1283) var523)
(declare-fun var2717_getFrameworkModel/2009891585 (var523) var3669)
(declare-fun getExtensionLoader/-514331157 (var3661 ClassObject) var790)
(declare-fun cast-from-var3669-to-var3661 (var3669) var3661)
(declare-fun hasExtension/-1450549355 (var790 String) Bool)
(declare-fun getExtension/-1809037860 (var790 String) var3430)
(declare-fun cast-from-var3430-to-var2080 (var3430) var2080)
(declare-const null-var1283 var1283)
(declare-const var1005 var1283) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1005 null-var1283)))
(assert true)
(define-const var2161 String (getParameter/-1307325648 var1005 "codec")) ; Statement: r15 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("codec") 
(define-const var2280 Bool (var2289_isEmpty/-813097145 var2161)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r15) 
 ; Statement: if $z0 == 0 goto $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(assert (= (ite var2280 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3065 var523 (getScopeModel/-1957927771 var1005)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(define-const var2367 var3669 (var2717_getFrameworkModel/2009891585 var3065)) ; Statement: $r14 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.FrameworkModel getFrameworkModel(org.apache.dubbo.rpc.model.ScopeModel)>($r1) 
(assert true)
(define-const var1233 var790 (getExtensionLoader/-514331157 (cast-from-var3669-to-var3661 var2367) var2080!class)) ; Statement: $r2 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;") 
(assert true)
(define-const var2254 Bool (hasExtension/-1450549355 var1233 var2161)) ; Statement: $z1 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r15) 
 ; Statement: if $z1 == 0 goto $r3 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec;") 
(assert (not (= (ite var2254 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var3729 var790 (getExtensionLoader/-514331157 (cast-from-var3669-to-var3661 var2367) var2080!class)) ; Statement: $r11 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;") 
(assert true)
(define-const var2595 var3430 (getExtension/-1809037860 var3729 var2161)) ; Statement: $r12 = virtualinvoke $r11.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r15) 
(define-const var291 var2080 (cast-from-var3430-to-var2080 var2595)) ; Statement: $r13 = (org.apache.dubbo.remoting.Codec2) $r12 
 ; Statement: return $r13 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2289_isEmpty/-813097145=([java.lang.String], boolean), getScopeModel/-1957927771=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ScopeModel), var2717_getFrameworkModel/2009891585=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.rpc.model.FrameworkModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var3669-to-var3661=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.common.extension.ExtensionAccessor), hasExtension/-1450549355=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], boolean), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var3430-to-var2080=([java.lang.Object], org.apache.dubbo.remoting.Codec2)}
; {var1283=org.apache.dubbo.common.URL, var1005=r0, var2161=r15, var2289=org.apache.dubbo.common.utils.StringUtils, var2280=$z0, var523=org.apache.dubbo.rpc.model.ScopeModel, var3065=$r1, var3669=org.apache.dubbo.rpc.model.FrameworkModel, var2717=org.apache.dubbo.rpc.model.ScopeModelUtil, var2367=$r14, var790=org.apache.dubbo.common.extension.ExtensionLoader, var2080=org.apache.dubbo.remoting.Codec2, var3661=org.apache.dubbo.common.extension.ExtensionAccessor, var1233=$r2, var2254=$z1, var3729=$r11, var3430=java.lang.Object, var2595=$r12, var291=$r13}
; {org.apache.dubbo.common.URL=var1283, r0=var1005, r15=var2161, org.apache.dubbo.common.utils.StringUtils=var2289, $z0=var2280, org.apache.dubbo.rpc.model.ScopeModel=var523, $r1=var3065, org.apache.dubbo.rpc.model.FrameworkModel=var3669, org.apache.dubbo.rpc.model.ScopeModelUtil=var2717, $r14=var2367, org.apache.dubbo.common.extension.ExtensionLoader=var790, org.apache.dubbo.remoting.Codec2=var2080, org.apache.dubbo.common.extension.ExtensionAccessor=var3661, $r2=var1233, $z1=var2254, $r11=var3729, java.lang.Object=var3430, $r12=var2595, $r13=var291}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r15 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("codec");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r15);	if $z0 == 0 goto $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	$r14 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.FrameworkModel getFrameworkModel(org.apache.dubbo.rpc.model.ScopeModel)>($r1);	$r2 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;");	$z1 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r15);	if $z1 == 0 goto $r3 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec;");	$r11 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;");	$r12 = virtualinvoke $r11.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r15);	$r13 = (org.apache.dubbo.remoting.Codec2) $r12;	return $r13
;block_num 3