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

(declare-sort var2494 0)
(declare-sort var3830 0)
(declare-sort var3084 0)
(declare-sort var2571 0)
(declare-sort var3121 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun interfaceClass/1800549272 (var2494) ClassObject)
(declare-fun getGeneric/-2144873936 (var3830) String)
(declare-fun cast-from-var2494-to-var3830 (var2494) var3830)
(declare-fun var3084_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun getInterfaceClassLoader/1827033563 (var3121) var2571)
(declare-fun cast-from-var2494-to-var3121 (var2494) var3121)
(declare-fun interfaceName/2049477907 (var3121) String)
(declare-fun var2494_determineInterfaceClass/-1155778184 (String String var2571) ClassObject)
(declare-const null-var2494 var2494)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2571 var2571)
(declare-const var3941 var2494) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfigBase 
(assert (not (= var3941 null-var2494)))
(define-const var500 ClassObject (interfaceClass/1800549272 var3941)) ; Statement: $r1 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass> 
 ; Statement: if $r1 == null goto r11 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGeneric()>() 
(assert (= var500 null-ClassObject)) ; Cond: $r1 == null 
(assert true)
(define-const var3086 String (getGeneric/-2144873936 (cast-from-var2494-to-var3830 var3941))) ; Statement: r11 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGeneric()>() 
(define-const var2040 Bool (var3084_isBlank/-523695098 (cast-from-String-to-String var3086))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r11) 
 ; Statement: if $z0 == 0 goto $r12 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.ClassLoader getInterfaceClassLoader()>() 
(assert (= (ite var2040 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var346 var2571 (getInterfaceClassLoader/1827033563 (cast-from-var2494-to-var3121 var3941))) ; Statement: $r12 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.ClassLoader getInterfaceClassLoader()>() 
 ; Statement: if $r12 == null goto $r2 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName> 
(assert (not (= var346 null-var2571))) ; Negate: Cond: $r12 == null  
(define-const var3518 String (interfaceName/2049477907 (cast-from-var2494-to-var3121 var3941))) ; Statement: $r5 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName> 
(assert true)
(define-const var2452 var2571 (getInterfaceClassLoader/1827033563 (cast-from-var2494-to-var3121 var3941))) ; Statement: $r6 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.ClassLoader getInterfaceClassLoader()>() 
(define-const var229 ClassObject (var2494_determineInterfaceClass/-1155778184 var3086 var3518 var2452)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class determineInterfaceClass(java.lang.String,java.lang.String,java.lang.ClassLoader)>(r11, $r5, $r6) 
(declare-const var3941!1 var2494)
(assert (not (= var3941!1 null-var2494)))
(assert (= (interfaceClass/1800549272 var3941!1) var229)) ; Statement: r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass> = $r7 
 ; Statement: goto [?= $r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass>] 
(assert true) ; Non Conditional
(define-const var2673 ClassObject (interfaceClass/1800549272 var3941!1)) ; Statement: $r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass> 
 ; Statement: return $r4 
(check-sat)
; {interfaceClass/1800549272=([org.apache.dubbo.config.ReferenceConfigBase], java.lang.Class), getGeneric/-2144873936=([org.apache.dubbo.config.AbstractReferenceConfig], java.lang.String), cast-from-var2494-to-var3830=([org.apache.dubbo.config.ReferenceConfigBase], org.apache.dubbo.config.AbstractReferenceConfig), var3084_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), getInterfaceClassLoader/1827033563=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.ClassLoader), cast-from-var2494-to-var3121=([org.apache.dubbo.config.ReferenceConfigBase], org.apache.dubbo.config.AbstractInterfaceConfig), interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), var2494_determineInterfaceClass/-1155778184=([java.lang.String, java.lang.String, java.lang.ClassLoader], java.lang.Class)}
; {var2494=org.apache.dubbo.config.ReferenceConfigBase, var3941=r0, var500=$r1, var3830=org.apache.dubbo.config.AbstractReferenceConfig, var3086=r11, var3084=org.apache.dubbo.common.utils.StringUtils, var2040=$z0, var2571=java.lang.ClassLoader, var3121=org.apache.dubbo.config.AbstractInterfaceConfig, var346=$r12, var3518=$r5, var2452=$r6, var229=$r7, var2673=$r4}
; {org.apache.dubbo.config.ReferenceConfigBase=var2494, r0=var3941, $r1=var500, org.apache.dubbo.config.AbstractReferenceConfig=var3830, r11=var3086, org.apache.dubbo.common.utils.StringUtils=var3084, $z0=var2040, java.lang.ClassLoader=var2571, org.apache.dubbo.config.AbstractInterfaceConfig=var3121, $r12=var346, $r5=var3518, $r6=var2452, $r7=var229, $r4=var2673}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfigBase;	$r1 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass>;	if $r1 == null goto r11 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGeneric()>();	r11 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGeneric()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r11);	if $z0 == 0 goto $r12 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.ClassLoader getInterfaceClassLoader()>();	$r12 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.ClassLoader getInterfaceClassLoader()>();	if $r12 == null goto $r2 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName>;	$r5 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName>;	$r6 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.ClassLoader getInterfaceClassLoader()>();	$r7 = staticinvoke <org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class determineInterfaceClass(java.lang.String,java.lang.String,java.lang.ClassLoader)>(r11, $r5, $r6);	r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass> = $r7;	goto [?= $r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass>];	$r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.Class interfaceClass>;	return $r4
;block_num 5