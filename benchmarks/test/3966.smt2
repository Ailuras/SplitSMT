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

(declare-sort var2098 0)
(declare-sort var2822 0)
(declare-sort var3958 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getExtensionClasses/-1060471564 (var2098) var3958)
(declare-fun cachedDefaultName/-1855590362 (var2098) String)
(declare-fun var2822_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2098 var2098)
(declare-const var2127 var2098) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var2127 null-var2098)))
(assert true)
;(assert (getExtensionClasses/-1060471564 var2127)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map getExtensionClasses()>() 

(declare-const var2127!1 var2098)
(define-const var3500 String (cachedDefaultName/-1855590362 var2127!1)) ; Statement: $r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName> 
(define-const var763 Bool (var2822_isBlank/-523695098 (cast-from-String-to-String var3500))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r1) 
 ; Statement: if $z0 != 0 goto return null 
(assert (not (not (= (ite var763 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3180 String "true") ; Statement: $r3 = "true" 
(define-const var1325 String (cachedDefaultName/-1855590362 var2127!1)) ; Statement: $r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName> 
(assert true)
(define-const var2371 Bool (= var3180 var1325)) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName> 
(assert (not (= (ite var2371 1 0) 0))) ; Negate: Cond: $z1 == 0  
 ; Statement: return null 
(check-sat)
; {getExtensionClasses/-1060471564=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.Map), cachedDefaultName/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.String), var2822_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2098=org.apache.dubbo.common.extension.ExtensionLoader, var2127=r0, var3500=$r1, var2822=org.apache.dubbo.common.utils.StringUtils, var763=$z0, var3180=$r3, var1325=$r2, var2371=$z1, var3958=java.util.Map}
; {org.apache.dubbo.common.extension.ExtensionLoader=var2098, r0=var2127, $r1=var3500, org.apache.dubbo.common.utils.StringUtils=var2822, $z0=var763, $r3=var3180, $r2=var1325, $z1=var2371, java.util.Map=var3958}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map getExtensionClasses()>();	$r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r1);	if $z0 != 0 goto return null;	$r3 = "true";	$r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName>;	$z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName>;	return null
;block_num 3