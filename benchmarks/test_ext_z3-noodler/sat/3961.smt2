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

(declare-sort var3458 0)
(declare-sort var779 0)
(declare-sort var1248 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getExtensionClasses/-1060471564 (var3458) var1248)
(declare-fun cachedDefaultName/-1855590362 (var3458) String)
(declare-fun var779_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var3458 var3458)
(declare-const var715 var3458) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var715 null-var3458)))
(assert true)
;(assert (getExtensionClasses/-1060471564 var715)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map getExtensionClasses()>() 

(declare-const var715!1 var3458)
(define-const var2895 String (cachedDefaultName/-1855590362 var715!1)) ; Statement: $r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName> 
(define-const var708 Bool (var779_isBlank/-523695098 (cast-from-String-to-String var2895))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r1) 
 ; Statement: if $z0 != 0 goto return null 
(assert (not (= (ite var708 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return null 
(check-sat)
; {getExtensionClasses/-1060471564=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.Map), cachedDefaultName/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.String), var779_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3458=org.apache.dubbo.common.extension.ExtensionLoader, var715=r0, var2895=$r1, var779=org.apache.dubbo.common.utils.StringUtils, var708=$z0, var1248=java.util.Map}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3458, r0=var715, $r1=var2895, org.apache.dubbo.common.utils.StringUtils=var779, $z0=var708, java.util.Map=var1248}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Map getExtensionClasses()>();	$r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.String cachedDefaultName>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r1);	if $z0 != 0 goto return null;	return null
;block_num 2