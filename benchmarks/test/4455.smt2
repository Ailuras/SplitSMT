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

(declare-sort var210 0)
(declare-sort var3512 0)
(declare-sort var2131 0)
(declare-sort var2369 0)
(declare-sort var3258 0)
(declare-sort var2810 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2131_isEmpty/-813097145 (String) Bool)
(declare-fun split/1265909012 (var2369 String) (Array Int String))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2810-init () var2810)
(declare-fun <init>/875830710 (var2810 String) void)
(declare-const null-String String)
(declare-const null-var3512 var3512)
(declare-const var3258-REGISTRY_SPLIT_PATTERN var2369)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3214 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3214 null-String)))
(declare-const var764 var3512) ; Statement: r6 := @parameter1: java.util.Map 
(assert (not (= var764 null-var3512)))
(define-const var3835 Bool (var2131_isEmpty/-813097145 var3214)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern REGISTRY_SPLIT_PATTERN> 
(assert (= (ite var3835 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2108 var2369 var3258-REGISTRY_SPLIT_PATTERN) ; Statement: $r1 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern REGISTRY_SPLIT_PATTERN> 
(assert true)
(define-const var791 (Array Int String) (split/1265909012 var2108 (cast-from-String-to-String var3214))) ; Statement: r2 = virtualinvoke $r1.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>(r0) 
 ; Statement: if r2 == null goto $r3 = new java.lang.IllegalArgumentException 
(assert (= var791 null-__Array__Int__String__)) ; Cond: r2 == null 
(define-const var1656 var2810 var2810-init) ; Statement: $r3 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var1656 "Addresses is not allowed to be empty, please re-enter.")) ; Statement: specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Addresses is not allowed to be empty, please re-enter.") 

(declare-const var1656!1 var2810)
(declare-const var3765 String)
 ; Statement: throw $r3 
(check-sat)
; {var2131_isEmpty/-813097145=([java.lang.String], boolean), split/1265909012=([java.util.regex.Pattern, java.lang.CharSequence], java.lang.String[]), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2810-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3214=r0, var210=null_type, var3512=java.util.Map, var764=r6, var2131=org.apache.dubbo.common.utils.StringUtils, var3835=$z0, var2369=java.util.regex.Pattern, var3258=org.apache.dubbo.common.constants.CommonConstants, var2108=$r1, var791=r2, var2810=java.lang.IllegalArgumentException, var1656=$r3, var3765="Addresses is not allowed to be empty, please re-enter."}
; {r0=var3214, null_type=var210, java.util.Map=var3512, r6=var764, org.apache.dubbo.common.utils.StringUtils=var2131, $z0=var3835, java.util.regex.Pattern=var2369, org.apache.dubbo.common.constants.CommonConstants=var3258, $r1=var2108, r2=var791, java.lang.IllegalArgumentException=var2810, $r3=var1656, "Addresses is not allowed to be empty, please re-enter."=var3765}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r6 := @parameter1: java.util.Map;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern REGISTRY_SPLIT_PATTERN>;	$r1 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern REGISTRY_SPLIT_PATTERN>;	r2 = virtualinvoke $r1.<java.util.regex.Pattern: java.lang.String[] split(java.lang.CharSequence)>(r0);	if r2 == null goto $r3 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.IllegalArgumentException;	specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Addresses is not allowed to be empty, please re-enter.");	throw $r3
;block_num 3