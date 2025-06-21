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

(declare-sort var1682 0)
(declare-sort var1965 0)
(declare-sort var3346 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getVersion/189836348 (var1682) String)
(declare-fun var3346_isEmpty/-813097145 (String) Bool)
(declare-const null-var1682 var1682)
(declare-const null-String String)
(declare-const var23 var1682) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var23 null-var1682)))
(declare-const var2539 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2539 null-String)))
(assert true)
(define-const var632 String (getVersion/189836348 var23)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var126 Bool (var3346_isEmpty/-813097145 var632)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r1 
(assert (not (= (ite var126 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3581 String var2539) ; Statement: $r3 = r2 
 ; Statement: goto [?= return $r3] 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), var3346_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1682=org.apache.dubbo.common.URL, var23=r0, var2539=r2, var1965=null_type, var632=r1, var3346=org.apache.dubbo.common.utils.StringUtils, var126=$z0, var3581=$r3}
; {org.apache.dubbo.common.URL=var1682, r0=var23, r2=var2539, null_type=var1965, r1=var632, org.apache.dubbo.common.utils.StringUtils=var3346, $z0=var126, $r3=var3581}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r1;	$r3 = r2;	goto [?= return $r3];	return $r3
;block_num 3