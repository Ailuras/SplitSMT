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

(declare-sort var3638 0)
(declare-sort var3705 0)
(declare-sort var3608 0)
(declare-sort var2403 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/-625758128 (var3638) void)
(declare-fun var3608_isEmpty/-813097145 (String) Bool)
(declare-fun var2403-init () var2403)
(declare-fun <init>/875830710 (var2403 String) void)
(declare-const null-var3638 var3638)
(declare-const null-String String)
(declare-const var1044 var3638) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var1044 null-var3638)))
(declare-const var3069 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3069 null-String)))
(assert true)
;(assert (checkDestroyed/-625758128 var1044)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>() 

(declare-const var1044!1 var3638)
(define-const var2176 Bool (var3608_isEmpty/-813097145 var3069)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getExtensionClass(java.lang.String)>(r1) 
(assert (not (= (ite var2176 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2163 var2403 var2403-init) ; Statement: $r3 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var2163 "Extension name == null")) ; Statement: specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Extension name == null") 

(declare-const var2163!1 var2403)
(declare-const var2966 String)
 ; Statement: throw $r3 
(check-sat)
; {checkDestroyed/-625758128=([org.apache.dubbo.common.extension.ExtensionLoader], void), var3608_isEmpty/-813097145=([java.lang.String], boolean), var2403-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3638=org.apache.dubbo.common.extension.ExtensionLoader, var1044=r0, var3069=r1, var3705=null_type, var3608=org.apache.dubbo.common.utils.StringUtils, var2176=$z0, var2403=java.lang.IllegalArgumentException, var2163=$r3, var2966="Extension name == null"}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3638, r0=var1044, r1=var3069, null_type=var3705, org.apache.dubbo.common.utils.StringUtils=var3608, $z0=var2176, java.lang.IllegalArgumentException=var2403, $r3=var2163, "Extension name == null"=var2966}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getExtensionClass(java.lang.String)>(r1);	$r3 = new java.lang.IllegalArgumentException;	specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Extension name == null");	throw $r3
;block_num 2