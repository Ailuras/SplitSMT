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

(declare-sort var146 0)
(declare-sort var3916 0)
(declare-sort var1521 0)
(declare-sort var1642 0)
(declare-sort var811 0)
(declare-sort var1711 0)
(declare-sort var3410 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1711!class ClassObject)
(declare-fun var1521_isDefault/-1009400446 (String) Bool)
(declare-fun getExtensionLoader/1955029040 (var146 ClassObject) var811)
(declare-fun getAdaptiveExtension/-2068350643 (var811) var3410)
(declare-fun cast-from-var3410-to-var1711 (var3410) var1711)
(declare-fun var1711_getInstance/1223779195 (var1711 ClassObject String) var3410)
(declare-const null-var146 var146)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var1642 var1642)
(declare-const null-var3410 var3410)
(declare-const var2722 var146) ; Statement: r34 := @parameter0: org.apache.dubbo.common.extension.ExtensionDirector 
(assert (not (= var2722 null-var146)))
(declare-const var1697 String) ; Statement: r39 := @parameter1: java.lang.String 
(assert (not (= var1697 null-String)))
(declare-const var994 ClassObject) ; Statement: r5 := @parameter2: java.lang.Class 
(assert (not (= var994 null-ClassObject)))
(define-const var2608 Bool (var1521_isDefault/-1009400446 var1697)) ; Statement: z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r39) 
 ; Statement: if z0 == 0 goto $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39) 
(assert (not (= (ite var2608 1 0) 0))) ; Negate: Cond: z0 == 0  
(declare-const var2685 var1642) ; Statement: $r25 := @caughtexception 
(assert (not (= var2685 null-var1642)))
 ; Statement: if z0 != 0 goto $r26 = new java.lang.IllegalStateException 
(assert (not (not (= (ite var2608 1 0) 0)))) ; Negate: Cond: z0 != 0  
(assert true)
(define-const var1737 var811 (getExtensionLoader/1955029040 var2722 var1711!class)) ; Statement: $r35 = virtualinvoke r34.<org.apache.dubbo.common.extension.ExtensionDirector: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/extension/ExtensionInjector;") 
(assert true)
(define-const var3310 var3410 (getAdaptiveExtension/-2068350643 var1737)) ; Statement: $r36 = virtualinvoke $r35.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getAdaptiveExtension()>() 
(define-const var3602 var1711 (cast-from-var3410-to-var1711 var3310)) ; Statement: r37 = (org.apache.dubbo.common.extension.ExtensionInjector) $r36 
(define-const var202 var3410 (var1711_getInstance/1223779195 var3602 var994 var1697)) ; Statement: r38 = interfaceinvoke r37.<org.apache.dubbo.common.extension.ExtensionInjector: java.lang.Object getInstance(java.lang.Class,java.lang.String)>(r5, r39) 
 ; Statement: if r38 == null goto $r26 = new java.lang.IllegalStateException 
(assert (not (= var202 null-var3410))) ; Negate: Cond: r38 == null  
 ; Statement: return r38 
(check-sat)
; {var1521_isDefault/-1009400446=([java.lang.String], boolean), getExtensionLoader/1955029040=([org.apache.dubbo.common.extension.ExtensionDirector, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), getAdaptiveExtension/-2068350643=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Object), cast-from-var3410-to-var1711=([java.lang.Object], org.apache.dubbo.common.extension.ExtensionInjector), var1711_getInstance/1223779195=([org.apache.dubbo.common.extension.ExtensionInjector, java.lang.Class, java.lang.String], java.lang.Object)}
; {var146=org.apache.dubbo.common.extension.ExtensionDirector, var2722=r34, var1697=r39, var3916=null_type, var994=r5, var1521=org.apache.dubbo.common.utils.ConfigUtils, var2608=z0, var1642=java.lang.Exception, var2685=$r25, var811=org.apache.dubbo.common.extension.ExtensionLoader, var1711=org.apache.dubbo.common.extension.ExtensionInjector, var1737=$r35, var3410=java.lang.Object, var3310=$r36, var3602=r37, var202=r38}
; {org.apache.dubbo.common.extension.ExtensionDirector=var146, r34=var2722, r39=var1697, null_type=var3916, r5=var994, org.apache.dubbo.common.utils.ConfigUtils=var1521, z0=var2608, java.lang.Exception=var1642, $r25=var2685, org.apache.dubbo.common.extension.ExtensionLoader=var811, org.apache.dubbo.common.extension.ExtensionInjector=var1711, $r35=var1737, java.lang.Object=var3410, $r36=var3310, r37=var3602, r38=var202}
;seq 
;cnt {}
;stmts r34 := @parameter0: org.apache.dubbo.common.extension.ExtensionDirector;	r39 := @parameter1: java.lang.String;	r5 := @parameter2: java.lang.Class;	z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isDefault(java.lang.String)>(r39);	if z0 == 0 goto $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r39);	$r25 := @caughtexception;	if z0 != 0 goto $r26 = new java.lang.IllegalStateException;	$r35 = virtualinvoke r34.<org.apache.dubbo.common.extension.ExtensionDirector: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/extension/ExtensionInjector;");	$r36 = virtualinvoke $r35.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getAdaptiveExtension()>();	r37 = (org.apache.dubbo.common.extension.ExtensionInjector) $r36;	r38 = interfaceinvoke r37.<org.apache.dubbo.common.extension.ExtensionInjector: java.lang.Object getInstance(java.lang.Class,java.lang.String)>(r5, r39);	if r38 == null goto $r26 = new java.lang.IllegalStateException;	return r38
;block_num 4