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

(declare-sort var2622 0)
(declare-sort var3502 0)
(declare-sort var624 0)
(declare-sort var3319 0)
(declare-sort var752 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/-625758128 (var2622) void)
(declare-fun var624_isEmpty/-813097145 (String) Bool)
(declare-fun getOrCreateHolder/-443924885 (var2622 String) var3319)
(declare-fun get/1014414220 (var3319) var752)
(declare-const null-var2622 var2622)
(declare-const null-String String)
(declare-const var2138 var2622) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var2138 null-var2622)))
(declare-const var3250 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3250 null-String)))
(assert true)
;(assert (checkDestroyed/-625758128 var2138)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>() 

(declare-const var2138!1 var2622)
(define-const var1071 Bool (var624_isEmpty/-813097145 var3250)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.utils.Holder getOrCreateHolder(java.lang.String)>(r1) 
(assert (= (ite var1071 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var713 var3319 (getOrCreateHolder/-443924885 var2138!1 var3250)) ; Statement: r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.utils.Holder getOrCreateHolder(java.lang.String)>(r1) 
(assert true)
(define-const var3910 var752 (get/1014414220 var713)) ; Statement: $r3 = virtualinvoke r2.<org.apache.dubbo.common.utils.Holder: java.lang.Object get()>() 
 ; Statement: return $r3 
(check-sat)
; {checkDestroyed/-625758128=([org.apache.dubbo.common.extension.ExtensionLoader], void), var624_isEmpty/-813097145=([java.lang.String], boolean), getOrCreateHolder/-443924885=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], org.apache.dubbo.common.utils.Holder), get/1014414220=([org.apache.dubbo.common.utils.Holder], java.lang.Object)}
; {var2622=org.apache.dubbo.common.extension.ExtensionLoader, var2138=r0, var3250=r1, var3502=null_type, var624=org.apache.dubbo.common.utils.StringUtils, var1071=$z0, var3319=org.apache.dubbo.common.utils.Holder, var713=r2, var752=java.lang.Object, var3910=$r3}
; {org.apache.dubbo.common.extension.ExtensionLoader=var2622, r0=var2138, r1=var3250, null_type=var3502, org.apache.dubbo.common.utils.StringUtils=var624, $z0=var1071, org.apache.dubbo.common.utils.Holder=var3319, r2=var713, java.lang.Object=var752, $r3=var3910}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.utils.Holder getOrCreateHolder(java.lang.String)>(r1);	r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.utils.Holder getOrCreateHolder(java.lang.String)>(r1);	$r3 = virtualinvoke r2.<org.apache.dubbo.common.utils.Holder: java.lang.Object get()>();	return $r3
;block_num 2