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

(declare-sort var245 0)
(declare-sort var2607 0)
(declare-sort var2616 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var245 String) String)
(declare-fun var2616_isEmpty/-813097145 (String) Bool)
(declare-const null-var245 var245)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var702 var245) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var702 null-var245)))
(declare-const var337 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var337 null-String)))
(declare-const var3354 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var3354 null-Int)))
(assert true)
(define-const var1774 String (getParameter/-1307325648 var702 var337)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2164 Bool (var2616_isEmpty/-813097145 var1774)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $c1 = virtualinvoke r2.<java.lang.String: char charAt(int)>(0) 
(assert (not (= (ite var2164 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2484 Int var3354) ; Statement: $c1 = c0 
 ; Statement: goto [?= return $c1] 
(assert true) ; Non Conditional
 ; Statement: return $c1 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2616_isEmpty/-813097145=([java.lang.String], boolean)}
; {var245=org.apache.dubbo.common.URL, var702=r0, var337=r1, var2607=null_type, var3354=c0, var1774=r2, var2616=org.apache.dubbo.common.utils.StringUtils, var2164=$z0, var2484=$c1}
; {org.apache.dubbo.common.URL=var245, r0=var702, r1=var337, null_type=var2607, c0=var3354, r2=var1774, org.apache.dubbo.common.utils.StringUtils=var2616, $z0=var2164, $c1=var2484}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	c0 := @parameter1: char;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $c1 = virtualinvoke r2.<java.lang.String: char charAt(int)>(0);	$c1 = c0;	goto [?= return $c1];	return $c1
;block_num 3