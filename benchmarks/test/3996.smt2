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

(declare-sort var3756 0)
(declare-sort var2495 0)
(declare-sort var2327 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/-625758128 (var3756) void)
(declare-fun var2327_isEmpty/-813097145 (String) Bool)
(declare-fun getExtensionClass/-712806209 (var3756 String) ClassObject)
(declare-const null-var3756 var3756)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const var2632 var3756) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var2632 null-var3756)))
(declare-const var544 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var544 null-String)))
(assert true)
;(assert (checkDestroyed/-625758128 var2632)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>() 

(declare-const var2632!1 var3756)
(define-const var2996 Bool (var2327_isEmpty/-813097145 var544)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getExtensionClass(java.lang.String)>(r1) 
(assert (= (ite var2996 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3159 ClassObject (getExtensionClass/-712806209 var2632!1 var544)) ; Statement: r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getExtensionClass(java.lang.String)>(r1) 
 ; Statement: if r2 == null goto $z1 = 0 
(assert (= var3159 null-ClassObject)) ; Cond: r2 == null 
(define-const var242 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {checkDestroyed/-625758128=([org.apache.dubbo.common.extension.ExtensionLoader], void), var2327_isEmpty/-813097145=([java.lang.String], boolean), getExtensionClass/-712806209=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], java.lang.Class)}
; {var3756=org.apache.dubbo.common.extension.ExtensionLoader, var2632=r0, var544=r1, var2495=null_type, var2327=org.apache.dubbo.common.utils.StringUtils, var2996=$z0, var3159=r2, var242=$z1}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3756, r0=var2632, r1=var544, null_type=var2495, org.apache.dubbo.common.utils.StringUtils=var2327, $z0=var2996, r2=var3159, $z1=var242}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getExtensionClass(java.lang.String)>(r1);	r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class getExtensionClass(java.lang.String)>(r1);	if r2 == null goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 4