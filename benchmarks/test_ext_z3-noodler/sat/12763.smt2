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

(declare-sort var1933 0)
(declare-sort var1340 0)
(declare-sort var2802 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var1933 String String) String)
(declare-fun var2802_isEmpty/-813097145 (String) Bool)
(declare-const null-var1933 var1933)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2534 var1933) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2534 null-var1933)))
(declare-const var300 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var300 null-String)))
(declare-const var740 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var740 null-String)))
(declare-const var1112 Int) ; Statement: s1 := @parameter2: short 
(assert (not (= var1112 null-Int)))
(assert true)
(define-const var1437 String (getServiceParameter/1782298180 var2534 var300 var740)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1500 Bool (var2802_isEmpty/-813097145 var1437)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3) 
(assert (not (= (ite var1500 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return s1 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2802_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1933=org.apache.dubbo.common.URL, var2534=r0, var300=r1, var1340=null_type, var740=r2, var1112=s1, var1437=r3, var2802=org.apache.dubbo.common.utils.StringUtils, var1500=$z0}
; {org.apache.dubbo.common.URL=var1933, r0=var2534, r1=var300, null_type=var1340, r2=var740, s1=var1112, r3=var1437, org.apache.dubbo.common.utils.StringUtils=var2802, $z0=var1500}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	s1 := @parameter2: short;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3);	return s1
;block_num 2