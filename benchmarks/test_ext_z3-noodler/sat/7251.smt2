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

(declare-sort var148 0)
(declare-sort var1412 0)
(declare-sort var2875 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var148 String String) String)
(declare-fun var2875_isEmpty/-813097145 (String) Bool)
(declare-const null-var148 var148)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var746 var148) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var746 null-var148)))
(declare-const var2421 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2421 null-String)))
(declare-const var2886 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2886 null-String)))
(declare-const var3065 Int) ; Statement: c0 := @parameter2: char 
(assert (not (= var3065 null-Int)))
(assert true)
(define-const var897 String (getMethodParameter/2015795402 var746 var2421 var2886)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1476 Bool (var2875_isEmpty/-813097145 var897)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $c1 = virtualinvoke r3.<java.lang.String: char charAt(int)>(0) 
(assert (not (= (ite var1476 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2197 Int var3065) ; Statement: $c1 = c0 
 ; Statement: goto [?= return $c1] 
(assert true) ; Non Conditional
 ; Statement: return $c1 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2875_isEmpty/-813097145=([java.lang.String], boolean)}
; {var148=org.apache.dubbo.common.URL, var746=r0, var2421=r1, var1412=null_type, var2886=r2, var3065=c0, var897=r3, var2875=org.apache.dubbo.common.utils.StringUtils, var1476=$z0, var2197=$c1}
; {org.apache.dubbo.common.URL=var148, r0=var746, r1=var2421, null_type=var1412, r2=var2886, c0=var3065, r3=var897, org.apache.dubbo.common.utils.StringUtils=var2875, $z0=var1476, $c1=var2197}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	c0 := @parameter2: char;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $c1 = virtualinvoke r3.<java.lang.String: char charAt(int)>(0);	$c1 = c0;	goto [?= return $c1];	return $c1
;block_num 3