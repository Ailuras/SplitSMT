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

(declare-sort var2581 0)
(declare-sort var3552 0)
(declare-sort var2100 0)
(declare-sort var2204 0)
(declare-sort var2666 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun interfaceClass/1800549272 (var2581) ClassObject)
(declare-fun getGeneric/-2144873936 (var3552) String)
(declare-fun cast-from-var2581-to-var3552 (var2581) var3552)
(declare-fun var2100_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun getInterfaceClassLoader/1827033563 (var2666) var2204)
(declare-fun cast-from-var2581-to-var2666 (var2581) var2666)
(declare-fun interfaceName/2049477907 (var2666) String)
(declare-fun var2581_determineInterfaceClass/1880354061 (String String) ClassObject)
(declare-const null-var2581 var2581)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2204 var2204)
(declare-const var3838 var2581) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfigBase 
(assert (not (= var3838 null-var2581)))
(define-const var2541 ClassObject (interfaceClass/1800549272 var3838)) ; Statement: $r1 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass> 
 ; Statement: if $r1 == null goto r11 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGeneric()>() 
(assert (= var2541 null-ClassObject)) ; Cond: $r1 == null 
(assert true)
(define-const var3000 String (getGeneric/-2144873936 (cast-from-var2581-to-var3552 var3838))) ; Statement: r11 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGeneric()>() 
(define-const var507 Bool (var2100_isBlank/-523695098 (cast-from-String-to-String var3000))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r11) 
 ; Statement: if $z0 == 0 goto $r12 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.ClassLoader getInterfaceClassLoader()>() 
(assert (= (ite var507 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1861 var2204 (getInterfaceClassLoader/1827033563 (cast-from-var2581-to-var2666 var3838))) ; Statement: $r12 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.ClassLoader getInterfaceClassLoader()>() 
 ; Statement: if $r12 == null goto $r2 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName> 
(assert (= var1861 null-var2204)) ; Cond: $r12 == null 
(define-const var2231 String (interfaceName/2049477907 (cast-from-var2581-to-var2666 var3838))) ; Statement: $r2 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName> 
(define-const var565 ClassObject (var2581_determineInterfaceClass/1880354061 var3000 var2231)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class determineInterfaceClass(java.lang.String,java.lang.String)>(r11, $r2) 
(declare-const var3838!1 var2581)
(assert (not (= var3838!1 null-var2581)))
(assert (= (interfaceClass/1800549272 var3838!1) var565)) ; Statement: r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass> = $r3 
(assert true) ; Non Conditional
(define-const var2814 ClassObject (interfaceClass/1800549272 var3838!1)) ; Statement: $r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass> 
 ; Statement: return $r4 
(check-sat)
; {interfaceClass/1800549272=([org.apache.dubbo.config.ReferenceConfigBase], java.lang.Class), getGeneric/-2144873936=([org.apache.dubbo.config.AbstractReferenceConfig], java.lang.String), cast-from-var2581-to-var3552=([org.apache.dubbo.config.ReferenceConfigBase], org.apache.dubbo.config.AbstractReferenceConfig), var2100_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), getInterfaceClassLoader/1827033563=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.ClassLoader), cast-from-var2581-to-var2666=([org.apache.dubbo.config.ReferenceConfigBase], org.apache.dubbo.config.AbstractInterfaceConfig), interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), var2581_determineInterfaceClass/1880354061=([java.lang.String, java.lang.String], java.lang.Class)}
; {var2581=org.apache.dubbo.config.ReferenceConfigBase, var3838=r0, var2541=$r1, var3552=org.apache.dubbo.config.AbstractReferenceConfig, var3000=r11, var2100=org.apache.dubbo.common.utils.StringUtils, var507=$z0, var2204=java.lang.ClassLoader, var2666=org.apache.dubbo.config.AbstractInterfaceConfig, var1861=$r12, var2231=$r2, var565=$r3, var2814=$r4}
; {org.apache.dubbo.config.ReferenceConfigBase=var2581, r0=var3838, $r1=var2541, org.apache.dubbo.config.AbstractReferenceConfig=var3552, r11=var3000, org.apache.dubbo.common.utils.StringUtils=var2100, $z0=var507, java.lang.ClassLoader=var2204, org.apache.dubbo.config.AbstractInterfaceConfig=var2666, $r12=var1861, $r2=var2231, $r3=var565, $r4=var2814}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfigBase;	$r1 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass>;	if $r1 == null goto r11 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGeneric()>();	r11 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGeneric()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r11);	if $z0 == 0 goto $r12 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.ClassLoader getInterfaceClassLoader()>();	$r12 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.ClassLoader getInterfaceClassLoader()>();	if $r12 == null goto $r2 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName>;	$r2 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName>;	$r3 = staticinvoke <org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class determineInterfaceClass(java.lang.String,java.lang.String)>(r11, $r2);	r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass> = $r3;	$r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass>;	return $r4
;block_num 5