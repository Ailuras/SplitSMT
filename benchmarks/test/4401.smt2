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

(declare-sort var1497 0)
(declare-sort var1392 0)
(declare-sort var3630 0)
(declare-sort var3636 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3630_isEmpty/-813097145 (String) Bool)
(declare-fun var3636-init () var3636)
(declare-fun <init>/875830710 (var3636 String) void)
(declare-const null-String String)
(declare-const null-var1392 var1392)
(declare-const var3817 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3817 null-String)))
(declare-const var1374 var1392) ; Statement: r1 := @parameter1: java.util.Map 
(assert (not (= var1374 null-var1392)))
(define-const var1933 Bool (var3630_isEmpty/-813097145 var3817)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("://") 
(assert (not (= (ite var1933 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1871 var3636 var3636-init) ; Statement: $r36 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var1871 "Address is not allowed to be empty, please re-enter.")) ; Statement: specialinvoke $r36.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Address is not allowed to be empty, please re-enter.") 

(declare-const var1871!1 var3636)
(declare-const var2494 String)
 ; Statement: throw $r36 
(check-sat)
; {var3630_isEmpty/-813097145=([java.lang.String], boolean), var3636-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3817=r0, var1497=null_type, var1392=java.util.Map, var1374=r1, var3630=org.apache.dubbo.common.utils.StringUtils, var1933=$z0, var3636=java.lang.IllegalArgumentException, var1871=$r36, var2494="Address is not allowed to be empty, please re-enter."}
; {r0=var3817, null_type=var1497, java.util.Map=var1392, r1=var1374, org.apache.dubbo.common.utils.StringUtils=var3630, $z0=var1933, java.lang.IllegalArgumentException=var3636, $r36=var1871, "Address is not allowed to be empty, please re-enter."=var2494}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.util.Map;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z1 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("://");	$r36 = new java.lang.IllegalArgumentException;	specialinvoke $r36.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Address is not allowed to be empty, please re-enter.");	throw $r36
;block_num 2