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

(declare-sort var3352 0)
(declare-sort var226 0)
(declare-sort var403 0)
(declare-sort var572 0)
(declare-sort var174 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/-625758128 (var3352) void)
(declare-fun getExtensionClasses/-1060471564 (var3352) var174)
(declare-fun type/-1855590362 (var3352) ClassObject)
(declare-fun isAssignableFrom/-1028998700 (ClassObject ClassObject) Bool)
(declare-fun var403-init () var403)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var572) String)
(declare-fun cast-from-ClassObject-to-var572 (ClassObject) var572)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var403 String) void)
(declare-const null-var3352 var3352)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const var2770 var3352) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var2770 null-var3352)))
(declare-const var2129 String) ; Statement: r12 := @parameter0: java.lang.String 
(assert (not (= var2129 null-String)))
(declare-const var2240 ClassObject) ; Statement: r1 := @parameter1: java.lang.Class 
(assert (not (= var2240 null-ClassObject)))
(assert true)
;(assert (checkDestroyed/-625758128 var2770)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>() 

(declare-const var2770!1 var3352)
(assert true)
;(assert (getExtensionClasses/-1060471564 var2770!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map getExtensionClasses()>() 

(declare-const var2770!2 var3352)
(define-const var3437 ClassObject (type/-1855590362 var2770!2)) ; Statement: $r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var3043 Bool (isAssignableFrom/-1028998700 var3437 var2240)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r1) 
 ; Statement: if $z0 != 0 goto $z1 = virtualinvoke r1.<java.lang.Class: boolean isInterface()>() 
(assert (not (not (= (ite var3043 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1624 var403 var403-init) ; Statement: $r43 = new java.lang.IllegalStateException 
(define-const var1781 String String-init) ; Statement: $r44 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1781)) ; Statement: specialinvoke $r44.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1781!1 String)
(assert (= var1781!1 ""))
(assert true)
(define-const var2099 String (append/672562846 var1781!1 "Input type ")) ; Statement: $r45 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Input type ") 
(declare-const var1781!2 String)
(assert (= var1781!2 (str.++ var1781!1 "Input type ")))
(assert true)
(define-const var3622 String (append/-1031950772 var2099 (cast-from-ClassObject-to-var572 var2240))) ; Statement: $r46 = virtualinvoke $r45.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var2099!1 String)
(assert (str.prefixof var2099 var2099!1))
(assert true)
(define-const var1266 String (append/672562846 var3622 " doesn\u0027t implement Extension ")) ; Statement: $r48 = virtualinvoke $r46.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" doesn\'t implement Extension ") 
(declare-const var3622!1 String)
(assert (= var3622!1 (str.++ var3622 " doesn\u0027t implement Extension ")))
(define-const var1981 ClassObject (type/-1855590362 var2770!2)) ; Statement: $r47 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var3185 String (append/-1031950772 var1266 (cast-from-ClassObject-to-var572 var1981))) ; Statement: $r49 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r47) 
(declare-const var1266!1 String)
(assert (str.prefixof var1266 var1266!1))
(assert true)
(define-const var222 String (toString/-2075883882 var3185)) ; Statement: $r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var1624 var222)) ; Statement: specialinvoke $r43.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r50) 

(declare-const var1624!1 var403)
(declare-const var222!1 String)
 ; Statement: throw $r43 
(check-sat)
; {checkDestroyed/-625758128=([org.apache.dubbo.common.extension.ExtensionLoader], void), getExtensionClasses/-1060471564=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.Map), type/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Class), isAssignableFrom/-1028998700=([java.lang.Class, java.lang.Class], boolean), var403-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var572=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3352=org.apache.dubbo.common.extension.ExtensionLoader, var2770=r0, var2129=r12, var226=null_type, var2240=r1, var3437=$r2, var3043=$z0, var403=java.lang.IllegalStateException, var1624=$r43, var1781=$r44, var2099=$r45, var572=java.lang.Object, var3622=$r46, var1266=$r48, var1981=$r47, var3185=$r49, var222=$r50, var174=java.util.Map}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3352, r0=var2770, r12=var2129, null_type=var226, r1=var2240, $r2=var3437, $z0=var3043, java.lang.IllegalStateException=var403, $r43=var1624, $r44=var1781, $r45=var2099, java.lang.Object=var572, $r46=var3622, $r48=var1266, $r47=var1981, $r49=var3185, $r50=var222, java.util.Map=var174}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r12 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Class;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>();	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map getExtensionClasses()>();	$r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$z0 = virtualinvoke $r2.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r1);	if $z0 != 0 goto $z1 = virtualinvoke r1.<java.lang.Class: boolean isInterface()>();	$r43 = new java.lang.IllegalStateException;	$r44 = new java.lang.StringBuilder;	specialinvoke $r44.<java.lang.StringBuilder: void <init>()>();	$r45 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Input type ");	$r46 = virtualinvoke $r45.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r48 = virtualinvoke $r46.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" doesn\'t implement Extension ");	$r47 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$r49 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r47);	$r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r43.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r50);	throw $r43
;block_num 2