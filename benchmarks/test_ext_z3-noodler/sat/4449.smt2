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

(declare-sort var1427 0)
(declare-sort var993 0)
(declare-sort var991 0)
(declare-sort var1410 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var991_isEmpty/-813097145 (String) Bool)
(declare-fun var1410-init () var1410)
(declare-fun <init>/875830710 (var1410 String) void)
(declare-const null-String String)
(declare-const null-var993 var993)
(declare-const var2168 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2168 null-String)))
(declare-const var1482 var993) ; Statement: r6 := @parameter1: java.util.Map 
(assert (not (= var1482 null-var993)))
(define-const var2338 Bool (var991_isEmpty/-813097145 var2168)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern REGISTRY_SPLIT_PATTERN> 
(assert (not (= (ite var2338 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3445 var1410 var1410-init) ; Statement: $r8 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var3445 "Address is not allowed to be empty, please re-enter.")) ; Statement: specialinvoke $r8.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Address is not allowed to be empty, please re-enter.") 

(declare-const var3445!1 var1410)
(declare-const var2080 String)
 ; Statement: throw $r8 
(check-sat)
; {var991_isEmpty/-813097145=([java.lang.String], boolean), var1410-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2168=r0, var1427=null_type, var993=java.util.Map, var1482=r6, var991=org.apache.dubbo.common.utils.StringUtils, var2338=$z0, var1410=java.lang.IllegalArgumentException, var3445=$r8, var2080="Address is not allowed to be empty, please re-enter."}
; {r0=var2168, null_type=var1427, java.util.Map=var993, r6=var1482, org.apache.dubbo.common.utils.StringUtils=var991, $z0=var2338, java.lang.IllegalArgumentException=var1410, $r8=var3445, "Address is not allowed to be empty, please re-enter."=var2080}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r6 := @parameter1: java.util.Map;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern REGISTRY_SPLIT_PATTERN>;	$r8 = new java.lang.IllegalArgumentException;	specialinvoke $r8.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Address is not allowed to be empty, please re-enter.");	throw $r8
;block_num 2