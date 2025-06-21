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

(declare-sort var2729 0)
(declare-sort var3527 0)
(declare-sort var1495 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var2729 String String String) String)
(declare-fun var1495_isEmpty/-813097145 (String) Bool)
(declare-const null-var2729 var2729)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1473 var2729) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1473 null-var2729)))
(declare-const var1342 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1342 null-String)))
(declare-const var3406 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3406 null-String)))
(declare-const var1659 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var1659 null-String)))
(declare-const var1635 Int) ; Statement: i1 := @parameter3: int 
(assert (not (= var1635 null-Int)))
(assert true)
(define-const var66 String (getServiceMethodParameter/-1810918120 var1473 var1342 var3406 var1659)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var3600 Bool (var1495_isEmpty/-813097145 var66)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r4) 
(assert (not (= (ite var3600 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return i1 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var1495_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2729=org.apache.dubbo.common.URL, var1473=r0, var1342=r1, var3527=null_type, var3406=r2, var1659=r3, var1635=i1, var66=r4, var1495=org.apache.dubbo.common.utils.StringUtils, var3600=$z0}
; {org.apache.dubbo.common.URL=var2729, r0=var1473, r1=var1342, null_type=var3527, r2=var3406, r3=var1659, i1=var1635, r4=var66, org.apache.dubbo.common.utils.StringUtils=var1495, $z0=var3600}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	i1 := @parameter3: int;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r4);	return i1
;block_num 2