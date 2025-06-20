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

(declare-sort var651 0)
(declare-sort var2717 0)
(declare-sort var2360 0)
(declare-sort var3283 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/-625758128 (var651) void)
(declare-fun var2360_isEmpty/-813097145 (String) Bool)
(declare-fun var3283-init () var3283)
(declare-fun <init>/875830710 (var3283 String) void)
(declare-const null-var651 var651)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var231 var651) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var231 null-var651)))
(declare-const var1450 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1450 null-String)))
(declare-const var3085 Bool) ; Statement: z2 := @parameter1: boolean 
(assert (not (= var3085 null-Bool)))
(assert true)
;(assert (checkDestroyed/-625758128 var231)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>() 

(declare-const var231!1 var651)
(define-const var1934 Bool (var2360_isEmpty/-813097145 var1450)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = "true" 
(assert (not (= (ite var1934 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3289 var3283 var3283-init) ; Statement: $r9 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var3289 "Extension name == null")) ; Statement: specialinvoke $r9.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Extension name == null") 

(declare-const var3289!1 var3283)
(declare-const var1474 String)
 ; Statement: throw $r9 
(check-sat)
; {checkDestroyed/-625758128=([org.apache.dubbo.common.extension.ExtensionLoader], void), var2360_isEmpty/-813097145=([java.lang.String], boolean), var3283-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var651=org.apache.dubbo.common.extension.ExtensionLoader, var231=r0, var1450=r1, var2717=null_type, var3085=z2, var2360=org.apache.dubbo.common.utils.StringUtils, var1934=$z0, var3283=java.lang.IllegalArgumentException, var3289=$r9, var1474="Extension name == null"}
; {org.apache.dubbo.common.extension.ExtensionLoader=var651, r0=var231, r1=var1450, null_type=var2717, z2=var3085, org.apache.dubbo.common.utils.StringUtils=var2360, $z0=var1934, java.lang.IllegalArgumentException=var3283, $r9=var3289, "Extension name == null"=var1474}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r1 := @parameter0: java.lang.String;	z2 := @parameter1: boolean;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = "true";	$r9 = new java.lang.IllegalArgumentException;	specialinvoke $r9.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Extension name == null");	throw $r9
;block_num 2