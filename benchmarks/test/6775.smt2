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

(declare-sort var2231 0)
(declare-sort var3090 0)
(declare-sort var2043 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var2231 String String) String)
(declare-fun var2043_isEmpty/-813097145 (String) Bool)
(declare-const null-var2231 var2231)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1035 var2231) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1035 null-var2231)))
(declare-const var2000 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2000 null-String)))
(declare-const var3956 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3956 null-String)))
(declare-const var1976 Int) ; Statement: l1 := @parameter2: long 
(assert (not (= var1976 null-Int)))
(assert true)
(define-const var3671 String (getMethodParameter/2015795402 var1035 var2000 var3956)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2538 Bool (var2043_isEmpty/-813097145 var3671)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3) 
(assert (not (= (ite var2538 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return l1 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2043_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2231=org.apache.dubbo.common.URL, var1035=r0, var2000=r1, var3090=null_type, var3956=r2, var1976=l1, var3671=r3, var2043=org.apache.dubbo.common.utils.StringUtils, var2538=$z0}
; {org.apache.dubbo.common.URL=var2231, r0=var1035, r1=var2000, null_type=var3090, r2=var3956, l1=var1976, r3=var3671, org.apache.dubbo.common.utils.StringUtils=var2043, $z0=var2538}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	l1 := @parameter2: long;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3);	return l1
;block_num 2