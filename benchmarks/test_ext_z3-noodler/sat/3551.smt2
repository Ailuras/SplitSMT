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

(declare-sort var3511 0)
(declare-sort var2199 0)
(declare-sort var3568 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2199_isEmpty/-813097145 (String) Bool)
(declare-fun var3568-init () var3568)
(declare-fun <init>/875830710 (var3568 String) void)
(declare-const null-String String)
(declare-const var1694 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1694 null-String)))
(declare-const var3849 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3849 null-String)))
(define-const var3870 Bool (var2199_isEmpty/-813097145 var1694)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var3870 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2168 var3568 var3568-init) ; Statement: $r1 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var2168 var3849)) ; Statement: specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>(r2) 

(declare-const var2168!1 var3568)
(declare-const var3849!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var2199_isEmpty/-813097145=([java.lang.String], boolean), var3568-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1694=r0, var3511=null_type, var3849=r2, var2199=org.apache.dubbo.common.utils.StringUtils, var3870=$z0, var3568=java.lang.IllegalArgumentException, var2168=$r1}
; {r0=var1694, null_type=var3511, r2=var3849, org.apache.dubbo.common.utils.StringUtils=var2199, $z0=var3870, java.lang.IllegalArgumentException=var3568, $r1=var2168}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto return;	$r1 = new java.lang.IllegalArgumentException;	specialinvoke $r1.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>(r2);	throw $r1
;block_num 2