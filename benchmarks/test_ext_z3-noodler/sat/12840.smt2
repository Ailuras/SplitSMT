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

(declare-sort var2579 0)
(declare-sort var636 0)
(declare-sort var3573 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var2579 String String) String)
(declare-fun var3573_isEmpty/-813097145 (String) Bool)
(declare-const null-var2579 var2579)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3046 var2579) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3046 null-var2579)))
(declare-const var2196 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2196 null-String)))
(declare-const var530 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var530 null-String)))
(declare-const var2808 Int) ; Statement: c0 := @parameter2: char 
(assert (not (= var2808 null-Int)))
(assert true)
(define-const var3784 String (getServiceParameter/1782298180 var3046 var2196 var530)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2726 Bool (var3573_isEmpty/-813097145 var3784)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $c1 = virtualinvoke r3.<java.lang.String: char charAt(int)>(0) 
(assert (not (= (ite var2726 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1956 Int var2808) ; Statement: $c1 = c0 
 ; Statement: goto [?= return $c1] 
(assert true) ; Non Conditional
 ; Statement: return $c1 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3573_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2579=org.apache.dubbo.common.URL, var3046=r0, var2196=r1, var636=null_type, var530=r2, var2808=c0, var3784=r3, var3573=org.apache.dubbo.common.utils.StringUtils, var2726=$z0, var1956=$c1}
; {org.apache.dubbo.common.URL=var2579, r0=var3046, r1=var2196, null_type=var636, r2=var530, c0=var2808, r3=var3784, org.apache.dubbo.common.utils.StringUtils=var3573, $z0=var2726, $c1=var1956}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	c0 := @parameter2: char;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $c1 = virtualinvoke r3.<java.lang.String: char charAt(int)>(0);	$c1 = c0;	goto [?= return $c1];	return $c1
;block_num 3