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

(declare-sort var3876 0)
(declare-sort var404 0)
(declare-sort var3655 0)
(declare-sort var2905 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/-625758128 (var3876) void)
(declare-fun var3655_isEmpty/-813097145 (String) Bool)
(declare-fun var2905-init () var2905)
(declare-fun <init>/875830710 (var2905 String) void)
(declare-const null-var3876 var3876)
(declare-const null-String String)
(declare-const var3796 var3876) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var3796 null-var3876)))
(declare-const var1847 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1847 null-String)))
(assert true)
;(assert (checkDestroyed/-625758128 var3796)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>() 

(declare-const var3796!1 var3876)
(define-const var3180 Bool (var3655_isEmpty/-813097145 var1847)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.utils.Holder getOrCreateHolder(java.lang.String)>(r1) 
(assert (not (= (ite var3180 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2227 var2905 var2905-init) ; Statement: $r4 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var2227 "Extension name == null")) ; Statement: specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Extension name == null") 

(declare-const var2227!1 var2905)
(declare-const var2464 String)
 ; Statement: throw $r4 
(check-sat)
; {checkDestroyed/-625758128=([org.apache.dubbo.common.extension.ExtensionLoader], void), var3655_isEmpty/-813097145=([java.lang.String], boolean), var2905-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3876=org.apache.dubbo.common.extension.ExtensionLoader, var3796=r0, var1847=r1, var404=null_type, var3655=org.apache.dubbo.common.utils.StringUtils, var3180=$z0, var2905=java.lang.IllegalArgumentException, var2227=$r4, var2464="Extension name == null"}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3876, r0=var3796, r1=var1847, null_type=var404, org.apache.dubbo.common.utils.StringUtils=var3655, $z0=var3180, java.lang.IllegalArgumentException=var2905, $r4=var2227, "Extension name == null"=var2464}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto r2 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.utils.Holder getOrCreateHolder(java.lang.String)>(r1);	$r4 = new java.lang.IllegalArgumentException;	specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Extension name == null");	throw $r4
;block_num 2