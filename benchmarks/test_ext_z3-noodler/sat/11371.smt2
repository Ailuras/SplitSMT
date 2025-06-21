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

(declare-sort var2407 0)
(declare-sort var3591 0)
(declare-sort var474 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSide/-520240817 (var2407) String)
(declare-fun var474_isEmpty/-813097145 (String) Bool)
(declare-const null-var2407 var2407)
(declare-const null-String String)
(declare-const var3119 var2407) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3119 null-var2407)))
(declare-const var1251 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1251 null-String)))
(assert true)
(define-const var1460 String (getSide/-520240817 var3119)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getSide()>() 
(define-const var3469 Bool (var474_isEmpty/-813097145 var1460)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r1 
(assert (= (ite var3469 1 0) 0)) ; Cond: $z0 == 0 
(define-const var369 String var1460) ; Statement: $r3 = r1 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {getSide/-520240817=([org.apache.dubbo.common.URL], java.lang.String), var474_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2407=org.apache.dubbo.common.URL, var3119=r0, var1251=r2, var3591=null_type, var1460=r1, var474=org.apache.dubbo.common.utils.StringUtils, var3469=$z0, var369=$r3}
; {org.apache.dubbo.common.URL=var2407, r0=var3119, r2=var1251, null_type=var3591, r1=var1460, org.apache.dubbo.common.utils.StringUtils=var474, $z0=var3469, $r3=var369}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getSide()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r1;	$r3 = r1;	return $r3
;block_num 3