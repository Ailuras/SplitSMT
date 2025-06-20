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

(declare-sort var1959 0)
(declare-sort var3909 0)
(declare-sort var97 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var1959 String String) String)
(declare-fun var97_isEmpty/-813097145 (String) Bool)
(declare-const null-var1959 var1959)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3285 var1959) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3285 null-var1959)))
(declare-const var608 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var608 null-String)))
(declare-const var1229 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1229 null-String)))
(declare-const var2512 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var2512 null-Int)))
(assert true)
(define-const var351 String (getMethodParameter/2015795402 var3285 var608 var1229)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var680 Bool (var97_isEmpty/-813097145 var351)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3) 
(assert (not (= (ite var680 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return i1 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var97_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1959=org.apache.dubbo.common.URL, var3285=r0, var608=r1, var3909=null_type, var1229=r2, var2512=i1, var351=r3, var97=org.apache.dubbo.common.utils.StringUtils, var680=$z0}
; {org.apache.dubbo.common.URL=var1959, r0=var3285, r1=var608, null_type=var3909, r2=var1229, i1=var2512, r3=var351, org.apache.dubbo.common.utils.StringUtils=var97, $z0=var680}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	i1 := @parameter2: int;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3);	return i1
;block_num 2