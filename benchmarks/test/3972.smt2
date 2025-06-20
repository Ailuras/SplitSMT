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

(declare-sort var2213 0)
(declare-sort var2564 0)
(declare-sort var2941 0)
(declare-sort var3532 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getExtensionClasses/-1060471564 (var2213) var3532)
(declare-fun cachedDefaultName/-1855590362 (var2213) String)
(declare-fun var2564_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun getExtension/-1809037860 (var2213 String) var2941)
(declare-const null-var2213 var2213)
(declare-const var1843 var2213) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var1843 null-var2213)))
(assert true)
;(assert (getExtensionClasses/-1060471564 var1843)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map getExtensionClasses()>() 

(declare-const var1843!1 var2213)
(define-const var2948 String (cachedDefaultName/-1855590362 var1843!1)) ; Statement: $r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName> 
(define-const var2494 Bool (var2564_isBlank/-523695098 (cast-from-String-to-String var2948))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r1) 
 ; Statement: if $z0 != 0 goto return null 
(assert (not (not (= (ite var2494 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1895 String "true") ; Statement: $r3 = "true" 
(define-const var2992 String (cachedDefaultName/-1855590362 var1843!1)) ; Statement: $r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName> 
(assert true)
(define-const var663 Bool (= var1895 var2992)) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName> 
(assert (= (ite var663 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1784 String (cachedDefaultName/-1855590362 var1843!1)) ; Statement: $r4 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName> 
(assert true)
(define-const var636 var2941 (getExtension/-1809037860 var1843!1 var1784)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>($r4) 
 ; Statement: return $r5 
(check-sat)
; {getExtensionClasses/-1060471564=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.Map), cachedDefaultName/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.String), var2564_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), getExtension/-1809037860=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Object)}
; {var2213=org.apache.dubbo.common.extension.ExtensionLoader, var1843=r0, var2948=$r1, var2564=org.apache.dubbo.common.utils.StringUtils, var2494=$z0, var1895=$r3, var2992=$r2, var663=$z1, var1784=$r4, var2941=java.lang.Object, var636=$r5, var3532=java.util.Map}
; {org.apache.dubbo.common.extension.ExtensionLoader=var2213, r0=var1843, $r1=var2948, org.apache.dubbo.common.utils.StringUtils=var2564, $z0=var2494, $r3=var1895, $r2=var2992, $z1=var663, $r4=var1784, java.lang.Object=var2941, $r5=var636, java.util.Map=var3532}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map getExtensionClasses()>();	$r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r1);	if $z0 != 0 goto return null;	$r3 = "true";	$r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName>;	$z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName>;	$r4 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName>;	$r5 = virtualinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String)>($r4);	return $r5
;block_num 3