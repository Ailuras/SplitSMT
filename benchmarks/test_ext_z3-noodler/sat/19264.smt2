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

(declare-sort var3871 0)
(declare-sort var1488 0)
(declare-sort var2268 0)
(declare-sort var2140 0)
(declare-sort var2714 0)
(declare-sort var1492 0)
(declare-sort var3142 0)
(declare-sort var2576 0)
(declare-sort var2235 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3142!class ClassObject)
(declare-fun getParameter/-1307325648 (var3871 String) String)
(declare-fun var1488_isEmpty/-813097145 (String) Bool)
(declare-fun getScopeModel/-1957927771 (var3871) var2268)
(declare-fun var2714_getFrameworkModel/2009891585 (var2268) var2140)
(declare-fun getExtensionLoader/-514331157 (var2576 ClassObject) var1492)
(declare-fun cast-from-var2140-to-var2576 (var2140) var2576)
(declare-fun hasExtension/-1450549355 (var1492 String) Bool)
(declare-fun getExtension/-1809037860 (var1492 String) var2235)
(declare-fun cast-from-var2235-to-var3142 (var2235) var3142)
(declare-const null-var3871 var3871)
(declare-const var774 var3871) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var774 null-var3871)))
(assert true)
(define-const var1377 String (getParameter/-1307325648 var774 "codec")) ; Statement: r15 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("codec") 
(define-const var2657 Bool (var1488_isEmpty/-813097145 var1377)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r15) 
 ; Statement: if $z0 == 0 goto $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(assert (= (ite var2657 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2690 var2268 (getScopeModel/-1957927771 var774)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(define-const var782 var2140 (var2714_getFrameworkModel/2009891585 var2690)) ; Statement: $r14 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.FrameworkModel getFrameworkModel(org.apache.dubbo.rpc.model.ScopeModel)>($r1) 
(assert true)
(define-const var3026 var1492 (getExtensionLoader/-514331157 (cast-from-var2140-to-var2576 var782) var3142!class)) ; Statement: $r2 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;") 
(assert true)
(define-const var69 Bool (hasExtension/-1450549355 var3026 var1377)) ; Statement: $z1 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r15) 
 ; Statement: if $z1 == 0 goto $r3 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec;") 
(assert (not (= (ite var69 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var1669 var1492 (getExtensionLoader/-514331157 (cast-from-var2140-to-var2576 var782) var3142!class)) ; Statement: $r11 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;") 
(assert true)
(define-const var2247 var2235 (getExtension/-1809037860 var1669 var1377)) ; Statement: $r12 = virtualinvoke $r11.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r15) 
(define-const var156 var3142 (cast-from-var2235-to-var3142 var2247)) ; Statement: $r13 = (org.apache.dubbo.remoting.Codec2) $r12 
 ; Statement: return $r13 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1488_isEmpty/-813097145=([java.lang.String], boolean), getScopeModel/-1957927771=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ScopeModel), var2714_getFrameworkModel/2009891585=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.rpc.model.FrameworkModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var2140-to-var2576=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.common.extension.ExtensionAccessor), hasExtension/-1450549355=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], boolean), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object), cast-from-var2235-to-var3142=([java.lang.Object], org.apache.dubbo.remoting.Codec2)}
; {var3871=org.apache.dubbo.common.URL, var774=r0, var1377=r15, var1488=org.apache.dubbo.common.utils.StringUtils, var2657=$z0, var2268=org.apache.dubbo.rpc.model.ScopeModel, var2690=$r1, var2140=org.apache.dubbo.rpc.model.FrameworkModel, var2714=org.apache.dubbo.rpc.model.ScopeModelUtil, var782=$r14, var1492=org.apache.dubbo.common.extension.ExtensionLoader, var3142=org.apache.dubbo.remoting.Codec2, var2576=org.apache.dubbo.common.extension.ExtensionAccessor, var3026=$r2, var69=$z1, var1669=$r11, var2235=java.lang.Object, var2247=$r12, var156=$r13}
; {org.apache.dubbo.common.URL=var3871, r0=var774, r15=var1377, org.apache.dubbo.common.utils.StringUtils=var1488, $z0=var2657, org.apache.dubbo.rpc.model.ScopeModel=var2268, $r1=var2690, org.apache.dubbo.rpc.model.FrameworkModel=var2140, org.apache.dubbo.rpc.model.ScopeModelUtil=var2714, $r14=var782, org.apache.dubbo.common.extension.ExtensionLoader=var1492, org.apache.dubbo.remoting.Codec2=var3142, org.apache.dubbo.common.extension.ExtensionAccessor=var2576, $r2=var3026, $z1=var69, $r11=var1669, java.lang.Object=var2235, $r12=var2247, $r13=var156}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r15 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("codec");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r15);	if $z0 == 0 goto $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	$r14 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.FrameworkModel getFrameworkModel(org.apache.dubbo.rpc.model.ScopeModel)>($r1);	$r2 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;");	$z1 = virtualinvoke $r2.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>(r15);	if $z1 == 0 goto $r3 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec;");	$r11 = virtualinvoke $r14.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/remoting/Codec2;");	$r12 = virtualinvoke $r11.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>(r15);	$r13 = (org.apache.dubbo.remoting.Codec2) $r12;	return $r13
;block_num 3