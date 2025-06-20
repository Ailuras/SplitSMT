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

(declare-sort var2188 0)
(declare-sort var3504 0)
(declare-sort var2788 0)
(declare-sort var3459 0)
(declare-sort var2301 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/-625758128 (var2188) void)
(declare-fun getExtensionClasses/-1060471564 (var2188) var2301)
(declare-fun type/-1855590362 (var2188) ClassObject)
(declare-fun isAssignableFrom/-1028998700 (ClassObject ClassObject) Bool)
(declare-fun var2788-init () var2788)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3459) String)
(declare-fun cast-from-ClassObject-to-var3459 (ClassObject) var3459)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var2788 String) void)
(declare-const null-var2188 var2188)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const var3455 var2188) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var3455 null-var2188)))
(declare-const var3260 String) ; Statement: r11 := @parameter0: java.lang.String 
(assert (not (= var3260 null-String)))
(declare-const var2794 ClassObject) ; Statement: r1 := @parameter1: java.lang.Class 
(assert (not (= var2794 null-ClassObject)))
(assert true)
;(assert (checkDestroyed/-625758128 var3455)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>() 

(declare-const var3455!1 var2188)
(assert true)
;(assert (getExtensionClasses/-1060471564 var3455!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map getExtensionClasses()>() 

(declare-const var3455!2 var2188)
(define-const var1205 ClassObject (type/-1855590362 var3455!2)) ; Statement: $r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var3691 Bool (isAssignableFrom/-1028998700 var1205 var2794)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r1) 
 ; Statement: if $z0 != 0 goto $z1 = virtualinvoke r1.<java.lang.Class: boolean isInterface()>() 
(assert (not (not (= (ite var3691 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var322 var2788 var2788-init) ; Statement: $r41 = new java.lang.IllegalStateException 
(define-const var3141 String String-init) ; Statement: $r42 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3141)) ; Statement: specialinvoke $r42.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3141!1 String)
(assert (= var3141!1 ""))
(assert true)
(define-const var3296 String (append/672562846 var3141!1 "Input type ")) ; Statement: $r43 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Input type ") 
(declare-const var3141!2 String)
(assert (= var3141!2 (str.++ var3141!1 "Input type ")))
(assert true)
(define-const var1623 String (append/-1031950772 var3296 (cast-from-ClassObject-to-var3459 var2794))) ; Statement: $r44 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var3296!1 String)
(assert (str.prefixof var3296 var3296!1))
(assert true)
(define-const var111 String (append/672562846 var1623 " doesn\u0027t implement the Extension ")) ; Statement: $r46 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" doesn\'t implement the Extension ") 
(declare-const var1623!1 String)
(assert (= var1623!1 (str.++ var1623 " doesn\u0027t implement the Extension ")))
(define-const var2485 ClassObject (type/-1855590362 var3455!2)) ; Statement: $r45 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var1277 String (append/-1031950772 var111 (cast-from-ClassObject-to-var3459 var2485))) ; Statement: $r47 = virtualinvoke $r46.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r45) 
(declare-const var111!1 String)
(assert (str.prefixof var111 var111!1))
(assert true)
(define-const var147 String (toString/-2075883882 var1277)) ; Statement: $r48 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var322 var147)) ; Statement: specialinvoke $r41.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r48) 

(declare-const var322!1 var2788)
(declare-const var147!1 String)
 ; Statement: throw $r41 
(check-sat)
; {checkDestroyed/-625758128=([org.apache.dubbo.common.extension.ExtensionLoader], void), getExtensionClasses/-1060471564=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.Map), type/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Class), isAssignableFrom/-1028998700=([java.lang.Class, java.lang.Class], boolean), var2788-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var3459=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2188=org.apache.dubbo.common.extension.ExtensionLoader, var3455=r0, var3260=r11, var3504=null_type, var2794=r1, var1205=$r2, var3691=$z0, var2788=java.lang.IllegalStateException, var322=$r41, var3141=$r42, var3296=$r43, var3459=java.lang.Object, var1623=$r44, var111=$r46, var2485=$r45, var1277=$r47, var147=$r48, var2301=java.util.Map}
; {org.apache.dubbo.common.extension.ExtensionLoader=var2188, r0=var3455, r11=var3260, null_type=var3504, r1=var2794, $r2=var1205, $z0=var3691, java.lang.IllegalStateException=var2788, $r41=var322, $r42=var3141, $r43=var3296, java.lang.Object=var3459, $r44=var1623, $r46=var111, $r45=var2485, $r47=var1277, $r48=var147, java.util.Map=var2301}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r11 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Class;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>();	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map getExtensionClasses()>();	$r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$z0 = virtualinvoke $r2.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r1);	if $z0 != 0 goto $z1 = virtualinvoke r1.<java.lang.Class: boolean isInterface()>();	$r41 = new java.lang.IllegalStateException;	$r42 = new java.lang.StringBuilder;	specialinvoke $r42.<java.lang.StringBuilder: void <init>()>();	$r43 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Input type ");	$r44 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r46 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" doesn\'t implement the Extension ");	$r45 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$r47 = virtualinvoke $r46.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r45);	$r48 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r41.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r48);	throw $r41
;block_num 2