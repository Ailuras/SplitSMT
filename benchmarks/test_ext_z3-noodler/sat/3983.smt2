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

(declare-sort var2173 0)
(declare-sort var1737 0)
(declare-sort var2348 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/-625758128 (var2173) void)
(declare-fun var2348_isEmpty/-813097145 (String) Bool)
(declare-fun getExtensionClass/-712806209 (var2173 String) ClassObject)
(declare-const null-var2173 var2173)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const var978 var2173) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var978 null-var2173)))
(declare-const var645 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var645 null-String)))
(assert true)
;(assert (checkDestroyed/-625758128 var978)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>() 

(declare-const var978!1 var2173)
(define-const var2037 Bool (var2348_isEmpty/-813097145 var645)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getExtensionClass(java.lang.String)>(r1) 
(assert (= (ite var2037 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2952 ClassObject (getExtensionClass/-712806209 var978!1 var645)) ; Statement: r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getExtensionClass(java.lang.String)>(r1) 
 ; Statement: if r2 == null goto $z1 = 0 
(assert (not (= var2952 null-ClassObject))) ; Negate: Cond: r2 == null  
(define-const var3027 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= return $z1] 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {checkDestroyed/-625758128=([org.apache.dubbo.common.extension.ExtensionLoader], void), var2348_isEmpty/-813097145=([java.lang.String], boolean), getExtensionClass/-712806209=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Class)}
; {var2173=org.apache.dubbo.common.extension.ExtensionLoader, var978=r0, var645=r1, var1737=null_type, var2348=org.apache.dubbo.common.utils.StringUtils, var2037=$z0, var2952=r2, var3027=$z1}
; {org.apache.dubbo.common.extension.ExtensionLoader=var2173, r0=var978, r1=var645, null_type=var1737, org.apache.dubbo.common.utils.StringUtils=var2348, $z0=var2037, r2=var2952, $z1=var3027}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getExtensionClass(java.lang.String)>(r1);	r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getExtensionClass(java.lang.String)>(r1);	if r2 == null goto $z1 = 0;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 4